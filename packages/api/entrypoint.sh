#!/bin/sh
# ============================================================================
# Celebrai API — entrypoint para Render
# Aplica as migrations e inicia o servidor.
# ============================================================================
set -e

echo "[entrypoint] Aplicando migrations do Prisma..."
npx prisma migrate deploy

echo "[entrypoint] Iniciando servidor..."
exec node dist/server.js