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

## Step 3 — Regenerate template (fixes duplicate service)

```bash
railway templates create --project <whatsapp-template-source-project-id> --json
```

This opens the template editor. Confirm:

- 4 services only
- backend + dashboard use `Ankitgelda8/whatsapp-business-deploy` repo
- No duplicate service names

## Step 4 — Update marketplace listing

```bash
cd "/Users/ankitgelda/whatsapp railway/whatsapp-business-deploy"

railway templates update whatsapp-business-platform \
  --category Automation \
  --description "AI WhatsApp platform with cab quote bot, campaigns, RAG inbox — auto-wired, 5-min setup" \
  --readme-file TEMPLATE_OVERVIEW.md \
  --image "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/WhatsApp.svg/240px-WhatsApp.svg.png" \
  --json
```

Template ID: `59f8b6da-e733-46cd-a388-efad515a61f4`

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
[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/whatsapp-business-platform?utm_medium=integration&utm_source=button&utm_campaign=whatsapp-business-platform)
```

Remove `referralCode` from the main button — that is affiliate income (separate from template kickbacks). Use referral links only in your personal shares.