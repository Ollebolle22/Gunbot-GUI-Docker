#!/usr/bin/env bash
set -e
exec xvfb-run --auto-servernum --server-num=1 "$APP_HOME/gui-linux"
