# --------- bygg-steg ----------
FROM debian:bookworm-slim AS builder

ARG GUNTHY_URL=https://gunthy.org/downloads/beta/gui-linux.zip
WORKDIR /opt

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl unzip ca-certificates && \
    curl -L "$GUNTHY_URL" -o gui.zip && \
    unzip gui.zip && \
    rm gui.zip && \
    chmod +x gui-linux

# --------- slut-image ----------
FROM debian:bookworm-slim

# Baspaket som Electron/Chromium gnäller efter
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libgtk-3-0 libnss3 libxss1 libatk1.0-0 \
        libxkbcommon0 libdrm2 libasound2 xvfb && \
    rm -rf /var/lib/apt/lists/*

ENV APP_HOME=/opt/gunthy
COPY --from=builder /opt/gui-linux $APP_HOME/gui-linux
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN useradd -ms /bin/bash gunthy && \
    chown -R gunthy:gunthy $APP_HOME
USER gunthy

WORKDIR $APP_HOME
EXPOSE 5002            # Gunthy-GUI:s webserver

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
