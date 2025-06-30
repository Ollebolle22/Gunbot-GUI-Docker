#!/usr/bin/env bash
set -e
# Kör GUI:t i ett headless X-fönster
exec xvfb-run --auto-servernum --server-num=1 "$APP_HOME/gui-linux" "$@"
