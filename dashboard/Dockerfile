FROM ghcr.io/ankitgelda8/whatsapp-business-platform/dashboard:latest

# Override entrypoint so broken template VITE_API_URL (https:///) falls back to
# RAILWAY_SERVICE_WHATSAPP_BUSINESS_DEPLOY_URL when backend isn't named "backend".
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]