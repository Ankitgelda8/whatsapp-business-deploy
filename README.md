# WhatsApp Business Automation Platform

> Complete WhatsApp Business automation — AI-powered template generation, bulk campaigns, contacts CRM, two-way inbox, and analytics. Powered by **Twilio WhatsApp API** + **Grok / OpenAI**.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/Ankitgelda8/whatsapp-business-deploy)

---

## One-click deploy

Click the button above. Railway will ask you for **3 required values**:

| Variable | What to enter |
|---|---|
| `JWT_SECRET` | Any long random string — e.g. `openssl rand -hex 32` in a terminal, or just type 50 random characters |
| `ADMIN_EMAIL` | The email you'll use to log in to the dashboard |
| `ADMIN_PASSWORD` | A strong password for your dashboard |

Everything else (Postgres URL, Redis URL, dashboard API URL) is wired automatically.

**Optional — AI template generation:**

| Variable | What to enter |
|---|---|
| `GROK_API_KEY` | Your xAI Grok API key from [console.x.ai](https://console.x.ai) — enables Grok-3-mini text + image generation |
| `OPENAI_API_KEY` | Your OpenAI API key from [platform.openai.com/api-keys](https://platform.openai.com/api-keys) — enables GPT-4o-mini + DALL-E 3 |

You can also add/change these keys any time from **Settings → AI Settings** inside the app — no redeploy needed.

---

## After deploy

1. Open the **dashboard URL** Railway gives you (the `dashboard` service → Public URL)
2. Log in with `ADMIN_EMAIL` / `ADMIN_PASSWORD`
3. Go to **Settings** → follow the in-app wizard to connect Twilio:
   - Step 1: Create a free Twilio account
   - Step 2: Enable WhatsApp sandbox for testing
   - Step 3: Enter your Account SID + Auth Token + WhatsApp number
   - Step 4: Test the connection
   - Step 5: Go live with your own business number (reach any customer)
4. *(Optional)* Go to **Settings → AI Settings** → add your Grok or OpenAI key
5. Go to **Templates → ⚡ AI Generate** → describe your message → AI writes + images it instantly

No terminal. No code. No environment variable editing.

---

## Features

- ✨ **AI Template Generation** — describe your offer in plain English, Grok or GPT-4o writes the WhatsApp message and generates a product image automatically
- 🖼️ **AI Image Generation** — Grok Imagine (grok-imagine-image-quality) or DALL-E 3 creates matching product/promo images
- 📊 **Dashboard** — message stats, campaign performance, recent activity
- 👥 **Contacts CRM** — import CSV, tags, notes, opt-in/out tracking
- 📢 **Broadcast campaigns** — schedule bulk WhatsApp messages with templates
- 📋 **Templates** — reusable message templates with `{{variable}}` substitution, image support, CTA buttons
- 💬 **Inbox** — two-way messaging, conversation history, auto-creates contacts from incoming messages
- 📈 **Analytics** — delivery rates, open rates, campaign trends
- ⚙️ **In-app Twilio setup** — no env editing, complete guided wizard
- 🔒 **Secure** — JWT auth, bcrypt passwords, admin-only access

---

## Architecture

This template pulls **pre-built Docker images** from GitHub Container Registry:

```
ghcr.io/ankitgelda8/whatsapp-business-platform/backend:latest
ghcr.io/ankitgelda8/whatsapp-business-platform/dashboard:latest
```

Services deployed by Railway:
- **Postgres** — stores contacts, messages, campaigns, settings
- **Redis** — message queue and rate limiting
- **backend** — Node.js / Express API + Prisma ORM
- **dashboard** — React + Vite SPA served by nginx

---

## Twilio pricing

WhatsApp messaging via Twilio costs approximately **$0.005–$0.05 per message** depending on country and message type. A free trial account includes $15 credit.

See [twilio.com/whatsapp/pricing](https://www.twilio.com/en-us/whatsapp/pricing) for current rates.

---

## Support

For issues or questions, open an issue in this repository.
