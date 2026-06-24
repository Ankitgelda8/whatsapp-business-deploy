# WhatsApp Business Automation Platform

> Deploy in one click on Railway — WhatsApp CRM, AI campaigns, RAG smart replies, and **Auto Quote Bot** for cab & car rental (Google Maps + PDF rate card).

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/ai-whatsapp-automated-business-platform?utm_medium=integration&utm_source=button&utm_campaign=whatsapp-business-platform)

---

## 🎬 35-Second Demo — Auto Quote Bot (cab rental)

Full WhatsApp flow: **Hi → pickup → destination → vehicle → quote → BOOK → FAQ**

[![Watch on YouTube Shorts](https://img.youtube.com/vi/rQkfJ3N8zoc/maxresdefault.jpg)](https://www.youtube.com/shorts/rQkfJ3N8zoc)

**Watch:** [YouTube Shorts](https://www.youtube.com/shorts/rQkfJ3N8zoc)

**Setup for your car rental company:** WhatsApp / Call **+919175623369**

---

## One-click deploy

Click the **Deploy on Railway** button above.

| Variable | What to enter |
|---|---|
| `ADMIN_EMAIL` | Email you use to log in to the dashboard |

**Auto-generated (no input needed):** `JWT_SECRET`, `ADMIN_PASSWORD`, `DATABASE_URL`, `REDIS_URL`, `PUBLIC_URL`, `VITE_API_URL`

After deploy, find your auto-generated `ADMIN_PASSWORD` in Railway → **backend** service → **Variables** tab.

### Optional — AI, email fallback & quote bot

| Variable | What to enter |
|---|---|
| `GROK_API_KEY` | [console.x.ai](https://console.x.ai) — Grok-3 text, RAG smart replies, quote bot |
| `OPENAI_API_KEY` | [platform.openai.com](https://platform.openai.com/api-keys) — GPT-4o-mini, embeddings (optional) |
| `RESEND_API_KEY` | [resend.com](https://resend.com) — email when WhatsApp delivery fails |
| `GOOGLE_MAPS_API_KEY` | Google Maps — Geocoding + Distance Matrix (for Auto Quote Bot) |
| `BUSINESS_PHONE` | Owner phone for quote-bot handoff e.g. `+919175623369` |
| `BUSINESS_CONTACT_NAME` | Name shown in quote-bot messages |
| `MESSAGE_RETENTION_DAYS` | Days to keep messages (default `15`, `0` = off) |

You can add or change these any time in **Settings** inside the app — no redeploy needed.

---

## After deploy

1. Open the **dashboard** service **Public URL** in Railway
2. Log in with `ADMIN_EMAIL` / `ADMIN_PASSWORD`
3. **Settings** → connect Twilio (Account SID, Auth Token, WhatsApp number)
4. Set webhook in Twilio: `https://your-backend.up.railway.app/webhook/twilio`
5. *(Optional)* **Settings → AI** → add Grok / OpenAI keys
6. *(Cab rental)* **Knowledge Base** → upload rate-card PDF → enable **Auto Quote Bot**

No terminal. No code. No env editing required for day-to-day use.

---

## Features

### Core platform
- ✨ **AI template generation** — describe your offer; Grok or GPT-4o writes the message + image
- 🖼️ **AI image generation** — Grok Imagine or DALL-E 3 for promo images
- 📊 **Dashboard** — stats, campaigns, recent activity
- 👥 **Contacts CRM** — CSV import, tags, notes, opt-in/out
- 📢 **Broadcast campaigns** — bulk WhatsApp with templates + delivery sync
- 📋 **Templates** — `{{variables}}`, images, CTA buttons
- 💬 **Inbox** — two-way chat, search, quick reply
- 📈 **Analytics** — delivery rates, campaign trends
- 🚨 **Failure logs** — campaign + Twilio delivery failures
- 🗑️ **Message retention** — auto-cleanup (configurable days)
- ⚙️ **In-app Twilio setup** — guided wizard
- 🔒 **JWT auth** — secure admin login

### 🧪 Beta (on by default — toggle in Settings)

| Feature | What it does |
|---|---|
| **RAG smart replies** | AI answers from your Knowledge Base (TXT/CSV/PDF) |
| **Knowledge Base** | Upload docs; chunked in Postgres, survives redeploy |
| **Campaign scheduler** | Send campaigns at a future date/time (BullMQ) |
| **Email fallback** | Resend email when WhatsApp delivery fails |
| **Multi-language** | Language on contacts, templates, campaigns |
| **Delivery sync** | Pull live Twilio status (sent/delivered/read/failed) |

### 🚗 Auto Quote Bot *(cab / rental only — off by default)*

Category-gated: contractors, retail, etc. keep simple FAQ replies.

**One question per WhatsApp message:**

1. Hi → pickup only → destination separately
2. Vehicle → passengers → one-way / round trip
3. Departure → return date → pickup time
4. Summary → customer replies **YES**
5. **Google Maps** distance + suspicious-route check
6. **RAG** reads fare rules from uploaded **PDF rate card**
7. Instant quote — base fare, round trip, driver halt, toll notes
8. **BOOK** → booking captured
9. Post-quote FAQ from PDF; else **owner phone** handoff

**Turn on:** Settings → Auto Quote Bot → category **Cab Rental** → Google Maps key → upload PDF in Knowledge Base.

Upload your own cab rate-card **PDF** in Knowledge Base (vehicle fares, driver halt, toll rules, cancellation policy).

| Toggle | Default |
|---|---|
| Campaign Scheduler | ✅ On |
| Email/SMS Fallback | ✅ On |
| Multi-language | ✅ On |
| RAG Smart Replies | ✅ On |
| **Auto Quote Bot** | ❌ Off |

---

## Architecture

Pre-built container images are pulled automatically when you deploy on Railway.

| Service | Role |
|---|---|
| **Postgres** | Contacts, messages, campaigns, knowledge chunks |
| **Redis** | Queue + rate limiting |
| **backend** | Node.js / Express / Prisma / webhooks |
| **dashboard** | React + Vite SPA (nginx) |

---

## Twilio pricing

WhatsApp via Twilio is roughly **$0.005–$0.05 per message** by country and type. Trial includes ~$15 credit.

[twilio.com/whatsapp/pricing](https://www.twilio.com/en-us/whatsapp/pricing)

---

## Template maintainers

- **Republish / fix duplicate services:** [REPUBLISH_TEMPLATE.md](REPUBLISH_TEMPLATE.md)
- **Marketplace overview copy:** [TEMPLATE_OVERVIEW.md](TEMPLATE_OVERVIEW.md)

## Support

- **Questions & deploy help:** [open an issue](https://github.com/Ankitgelda8/whatsapp-business-deploy/issues) in this repo
- **Railway template queue:** [Station thread](https://station.railway.com/all-templates/c7cb76af-5e22-40b3-8d90-4c9a05cbd8f1)
- **Setup for cab rental:** WhatsApp / Call **+919175623369**