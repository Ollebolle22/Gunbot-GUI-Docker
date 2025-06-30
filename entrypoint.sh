#!/usr/bin/env bash
set -e

# Starta ett virtuellt X och kör GUI:t i samma display
exec xvfb-run --auto-servernum --server-num=1 \
     "$APP_HOME/gui-linux" "$@"
