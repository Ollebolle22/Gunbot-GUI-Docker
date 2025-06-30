#!/usr/bin/env bash
set -e

# Skapa konfigurationsfil bredvid gui-linux
CONFIG_FILE="$APP_HOME/config.json"
API_URL="${CONFIG_API_URL:-http://iptogb:port}"
GUI_PORT="${CONFIG_PORT:-5002}"

cat > "$CONFIG_FILE" <<EOF
{
  "api_url": "$API_URL",
  "port": $GUI_PORT
}
EOF

# Kör GUI:t i ett huvudlöst X-fönster
exec xvfb-run --auto-servernum --server-num=1 "$APP_HOME/gui-linux" "$@" 2>&1 | tee -a "$APP_HOME/gui.log"
