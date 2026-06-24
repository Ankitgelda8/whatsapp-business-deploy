# Deploy and Host WhatsApp Business Platform on Railway

Self-hosted AI WhatsApp platform for cab rental, fleet owners, and small businesses. Send campaigns, manage a two-way inbox, run RAG smart replies from your PDF rate card, and automate fare quotes with Google Maps — all from a React dashboard. **No manual URL wiring:** Postgres, Redis, backend API URL, and dashboard are connected automatically.

**Demo:** [YouTube — Auto Quote Bot in 35 seconds](https://www.youtube.com/shorts/rQkfJ3N8zoc)

## About Hosting WhatsApp Business Platform

This template deploys four services: **Postgres**, **Redis**, **backend** (Node.js API + Twilio webhooks), and **dashboard** (React UI). Secrets (`JWT_SECRET`, `ADMIN_PASSWORD`) are auto-generated. You only need to set your **admin email** at deploy time — everything else can be configured in-app.

Twilio credentials, Grok/OpenAI keys, and Google Maps are optional at deploy and can be added later in **Settings** without redeploying.

**Estimated Railway cost:** ~$12–20/month for a 24/7 production stack (Postgres + Redis + 2 app services).

## 5-Minute Setup (Day 1 Success)

1. Click **Deploy** → enter your `ADMIN_EMAIL` → wait for all 4 services to go green
2. Open the **dashboard** public URL (not backend)
3. Log in with `ADMIN_EMAIL` + auto-generated password (check backend **Variables** tab for `ADMIN_PASSWORD`, or reset in Settings)
4. Go to **Settings** → **Twilio Setup Wizard** → connect sandbox (free $15 credit)
5. Copy webhook URL → paste in Twilio Console → send a test WhatsApp message

**You do NOT need to manually set `VITE_API_URL`** — it is wired to your backend automatically.

### Cab / rental quote bot (optional)

1. **Knowledge Base** → upload your rate-card PDF
2. **Settings** → enable **Auto Quote Bot** → category **Cab Rental**
3. Add `GOOGLE_MAPS_API_KEY` in Settings
4. Customer messages on WhatsApp → guided quote → instant fare → BOOK

## Common Use Cases

- **Cab & bus rental quotes** — automated fare quotes from PDF rate cards + Google Maps
- **Bulk WhatsApp campaigns** — broadcast to contact lists with delivery tracking
- **AI customer support** — RAG replies from uploaded FAQs and product catalogs
- **Two-way inbox** — read and reply to every WhatsApp message from a web dashboard
- **Multi-language replies** — Hindi, Marathi, Tamil, Gujarati, Telugu, and more

## Dependencies for WhatsApp Business Platform Hosting

- **Postgres** — contacts, messages, campaigns, knowledge base (included)
- **Redis** — campaign scheduler queue (included)
- **Twilio** — WhatsApp API ([free trial](https://www.twilio.com/try-twilio))
- **Optional:** xAI Grok, OpenAI, Resend, Google Maps API

### Deployment Dependencies

- [Twilio WhatsApp Sandbox](https://www.twilio.com/docs/whatsapp/sandbox)
- [Twilio WhatsApp Senders (go live)](https://console.twilio.com/us1/develop/sms/senders/whatsapp-senders)
- [GitHub — starter docs & support](https://github.com/Ankitgelda8/whatsapp-business-deploy)
- [Railway Template Kickbacks](https://docs.railway.com/templates/kickbacks)

### Implementation Details

**Services (exactly 4 — no duplicates):**

| Service | Role | Public? |
|---------|------|---------|
| Postgres | Database | No (private network) |
| Redis | Job queue | No (private network) |
| backend | API + `/webhook/twilio` | Yes |
| dashboard | Admin UI | Yes |

**Auto-configured variables:**

```env
DATABASE_URL=${{Postgres.DATABASE_URL}}
REDIS_URL=${{Redis.REDIS_URL}}
JWT_SECRET=${{secret(...)}}          # auto-generated
ADMIN_PASSWORD=${{secret(...)}}      # auto-generated
PUBLIC_URL=https://${{RAILWAY_PUBLIC_DOMAIN}}
VITE_API_URL=https://${{backend.RAILWAY_PUBLIC_DOMAIN}}/api/v1
```

**Webhook URL for Twilio:**

```
https://YOUR-BACKEND-DOMAIN/webhook/twilio
```

**Recommended volumes (attach in template):**

- Postgres → `/var/lib/postgresql/data`
- Redis → `/data`
- backend → `/app/uploads` (knowledge base files)

## Why Deploy WhatsApp Business Platform on Railway?

Railway is a singular platform to deploy your full infrastructure stack. This template gives you a production WhatsApp automation backend in one click — database, queue, API, and dashboard pre-wired — so you can focus on your business, not DevOps.

**Need help?** [Open a GitHub issue](https://github.com/Ankitgelda8/whatsapp-business-deploy/issues) or ask on [Railway Station](https://station.railway.com/all-templates/c7cb76af-5e22-40b3-8d90-4c9a05cbd8f1).