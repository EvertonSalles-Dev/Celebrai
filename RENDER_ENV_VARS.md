# Variáveis de ambiente para deploy no Render

## Banco de dados PostgreSQL
1. No Render Dashboard, crie um **Managed PostgreSQL** (plano Starter ou superior)
2. Copie a URL de conexão (ex: `postgresql://user:password@host:port/dbname`)
3. Cole na variável `DATABASE_URL` do serviço **celebrai-api**

## Segredos de autenticação
Gere valores fortes com:
```bash
node -e "console.log(require('crypto').randomBytes(48).toString('base64url'))"
```

Defina essas variáveis no serviço **celebrai-api**:
- `JWT_ACCESS_SECRET` (mín. 16 caracteres)
- `JWT_REFRESH_SECRET` (mín. 16 caracteres)
- `INVITATION_TOKEN_SECRET` (mín. 16 caracteres)
- `SEED_SUPER_ADMIN_PASSWORD` (mín. 8 caracteres)

## Super Admin (seed)
- `SEED_SUPER_ADMIN_EMAIL`: email do super admin (padrão: super@celebrai.app)

## URLs
- `APP_URL`: URL pública do frontend (ex: https://celebrai.app)
- `API_URL`: URL pública da API (ex: https://celebrai-api.onrender.com)
- `CORS_ORIGINS`: lista separada por vírgula das origens permitidas

## E-mail (opcional)
- `MAIL_DRIVER`: `smtp` ou `disabled`
- `SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, `SMTP_PASS`: configurações do SMTP

## WhatsApp (opcional)
- `WHATSAPP_DRIVER`: `cloud_api` ou `disabled`
- `WHATSAPP_PHONE_NUMBER_ID`, `WHATSAPP_ACCESS_TOKEN`: credenciais da Meta

## Google Maps (opcional)
- `GOOGLE_MAPS_API_KEY`: API key para mapas