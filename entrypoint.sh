#!/usr/bin/env bash
set -e
# Skriv konfiguration baserat på miljövariabler
cat > "$APP_HOME/config.json" <<EOF
{
  "api_url": "${API_URL:-http://iptogb:port}",
  "port": ${GUI_PORT:-5002}
}
EOF

# Kör GUI:t i ett headless X-fönster
exec xvfb-run --auto-servernum --server-num=1 "$APP_HOME/gui-linux" "$@"
