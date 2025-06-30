#!/usr/bin/env bash
set -e
set -o pipefail

# Create configuration file next to gui-linux
CONFIG_FILE="$APP_HOME/config.json"
API_URL="${CONFIG_API_URL:-http://iptogb:port}"
GUI_PORT="${CONFIG_PORT:-5002}"

cat > "$CONFIG_FILE" <<EOF
{
  "api_url": "$API_URL",
  "port": $GUI_PORT
}
EOF

# Run the GUI directly in headless mode
exec > >(tee -a "$APP_HOME/gui.log") 2>&1
exec "$APP_HOME/gui-linux" "$@"
