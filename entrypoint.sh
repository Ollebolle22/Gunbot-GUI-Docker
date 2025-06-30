#!/usr/bin/env bash
set -e
# Run the GUI in a headless X window
exec xvfb-run --auto-servernum --server-num=1 "$APP_HOME/gui-linux" "$@"
