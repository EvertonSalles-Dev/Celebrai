# ============================================================================
# Celebrai Web — build estático + Nginx
# ============================================================================

# ---------------------------------------------------------------------------
# Estágio 1 — build do bundle
# ---------------------------------------------------------------------------
FROM node:20-alpine AS build

WORKDIR /app

COPY package.json package-lock.json* ./
COPY packages/web/package.json ./packages/web/

RUN npm ci --ignore-scripts --workspace @celebrai/web --include-workspace-root

COPY packages/web ./packages/web
WORKDIR /app/packages/web

# A URL da API é embutida no bundle em tempo de build.
ARG VITE_API_URL=""
ENV VITE_API_URL=$VITE_API_URL

RUN npx tsc --noEmit && npx vite build

# ---------------------------------------------------------------------------
# Estágio 2 — Nginx servindo os arquivos estáticos
# ---------------------------------------------------------------------------
FROM nginx:1.27-alpine AS runtime

# Instala envsubst para substituir variáveis no template
RUN apk add --no-cache bash

# Configuração própria: SPA fallback, cache de assets, gzip e headers de segurança.
# Usamos o template para permitir configuração dinâmica via variáveis de ambiente.
COPY packages/web/nginx.conf.template /etc/nginx/conf.d/default.conf.template
COPY packages/web/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY --from=build /app/packages/web/dist /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://127.0.0.1/ >/dev/null 2>&1 || exit 1

ENTRYPOINT ["/entrypoint.sh"]
