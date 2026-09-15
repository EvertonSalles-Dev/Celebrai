#!/bin/sh
# ============================================================================
# Celebrai Web — entrypoint para Render
# Substitui o template do Nginx com as variáveis de ambiente e inicia o Nginx.
# ============================================================================
set -e

# Define os valores padrão se não estiverem definidos
API_UPSTREAM="${API_UPSTREAM:-celebrai-api.onrender.com:3333}"
NGINX_RESOLVER="${NGINX_RESOLVER:-8.8.8.8 1.1.1.1}"

# Substitui as variáveis no template
envsubst < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

# Inicia o Nginx
exec nginx -g 'daemon off;'