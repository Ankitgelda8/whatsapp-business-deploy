#!/bin/sh
# Inject backend API URL at container start. Only touch config.js + index.html fallback.
# Never sed-replace .js bundles — that corrupts runtime placeholder checks in client.ts.

set -e

PLACEHOLDER="VITE_API_URL_PLACEHOLDER"

is_invalid_api_url() {
  [ -z "$1" ] || echo "$1" | grep -qiE 'localhost|\$\{\{|https:///'
}

RAW="${VITE_API_URL:-}"

if is_invalid_api_url "$RAW"; then
  _backend_host="${RAILWAY_SERVICE_BACKEND_URL:-${RAILWAY_SERVICE_WHATSAPP_BUSINESS_DEPLOY_URL:-}}"
  if [ -n "$_backend_host" ]; then
    case "$_backend_host" in
      http://*|https://*) _backend_base="$_backend_host" ;;
      *) _backend_base="https://$_backend_host" ;;
    esac
  else
    _backend_base=""
  fi

  for candidate in "${BACKEND_PUBLIC_URL:-}" "${API_URL:-}" "$_backend_base"; do
    if ! is_invalid_api_url "$candidate"; then
      RAW="$candidate"
      break
    fi
  done
  unset _backend_host _backend_base
fi

if is_invalid_api_url "$RAW"; then
  echo "❌ VITE_API_URL must be set to your backend public URL (not localhost)."
  echo "   Example: https://whatsapp-business-deploy-production.up.railway.app/api/v1"
  echo "   On Railway: set VITE_API_URL=https://\${{whatsapp-business-deploy.RAILWAY_PUBLIC_DOMAIN}}/api/v1"
  exit 1
fi

case "$RAW" in
  */api/v1) ACTUAL="$RAW" ;;
  */api/v1/) ACTUAL="${RAW%/}" ;;
  *) ACTUAL="${RAW%/}/api/v1" ;;
esac

echo "🔧 Injecting API URL: ${ACTUAL}"

escape_sed() {
  printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'
}

ESCAPED_PLACEHOLDER="$(escape_sed "$PLACEHOLDER")"
ESCAPED_ACTUAL="$(escape_sed "$ACTUAL")"

cat > /usr/share/nginx/html/config.js <<EOF
window.__RUNTIME_CONFIG__={API_URL:"${ACTUAL}"};
EOF

if [ -f /usr/share/nginx/html/index.html ]; then
  sed -i "s|${ESCAPED_PLACEHOLDER}|${ESCAPED_ACTUAL}|g" /usr/share/nginx/html/index.html
fi

echo "✅ Done. Starting nginx..."

NGINX_PORT="${PORT:-80}"
sed -i "s/listen 80;/listen ${NGINX_PORT};/" /etc/nginx/conf.d/default.conf
echo "🌐 nginx listening on port ${NGINX_PORT}"

exec nginx -g "daemon off;"