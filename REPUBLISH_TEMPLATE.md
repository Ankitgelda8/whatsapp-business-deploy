# Fix & Republish Railway Template

Your template has a **duplicate GitHub service** (`whatsapp-business-deploy` + `whatsapp-business-deploy-7i7a`). That confuses deployers and hurts completion rate. Fix it once, then earnings scale with active usage.

## Step 1 — Push updated config

```bash
cd "/Users/ankitgelda/whatsapp railway/whatsapp-business-deploy"
git add railway.json TEMPLATE_OVERVIEW.md REPUBLISH_TEMPLATE.md README.md
git commit -m "fix: clean 4-service template, auto-wired URLs, marketplace overview"
git push origin main
```

## Step 2 — Deploy a clean reference project

```bash
# New empty project for template source
railway init --name whatsapp-template-source

# Deploy your published template into it (validates the user experience)
railway deploy -t whatsapp-business-platform \
  -v "ADMIN_EMAIL=template-test@example.com"
```

Wait until you have **exactly 4 services**:

- Postgres
- Redis
- backend
- dashboard

**Delete** any extra/duplicate services if they appear.

### Attach volumes (required for production)

In Railway dashboard → each service:

| Service | Mount path |
|---------|------------|
| Postgres | `/var/lib/postgresql/data` |
| Redis | `/data` |
| backend | `/app/uploads` |

### Generate public domains

- **backend** → Generate Domain
- **dashboard** → Generate Domain

Verify: open dashboard URL → login works → backend `/health` returns OK.

## Step 3 — Done: clean template published

The broken template (`whatsapp-business-platform` with duplicate services) was **unpublished**.

**New clean template (4 services, volumes, auto-wired URLs):**

| Field | Value |
|-------|-------|
| URL | https://railway.com/deploy/whatsapp-template--1 |
| Template ID | `c7cb76af-5e22-40b3-8d90-4c9a05cbd8f1` |
| Source project | `whatsapp-template-clean` (`39bd2686-f1c9-47a3-b357-613f488b151a`) |
| Editor | https://railway.com/workspace/templates/c7cb76af-5e22-40b3-8d90-4c9a05cbd8f1 |

Services: **Postgres, Redis, backend, dashboard** — no duplicates.

## Step 4 — Update marketplace listing (already applied)

```bash
railway templates update whatsapp-template--1 \
  --category Automation \
  --description "AI WhatsApp CRM + cab quote bot. Auto-wired. 5-min Twilio setup." \
  --readme-file TEMPLATE_OVERVIEW.md \
  --image "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/WhatsApp.svg/240px-WhatsApp.svg.png" \
  --json
```

## Step 5 — Enable cash kickbacks

1. Go to [railway.com/account](https://railway.com/account) → **Earnings**
2. Turn **off** `Direct Deposit to Railway Credits` if you want cash
3. Complete Stripe Connect onboarding
4. Withdraw in $100+ increments

## Step 6 — Answer Template Queue

[station.railway.com/my-template-queue](https://station.railway.com/my-template-queue)

Every answered question = higher deploy success = more 24/7 usage = more kickbacks.

## Verify deploy button

```markdown
[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/whatsapp-template--1?utm_medium=integration&utm_source=button&utm_campaign=whatsapp-business-platform)
```

Remove `referralCode` from the main button — that is affiliate income (separate from template kickbacks). Use referral links only in your personal shares.