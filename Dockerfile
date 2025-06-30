# ---------- build stage ----------
FROM debian:bookworm-slim AS builder

ARG GUNTHY_URL=https://gunthy.org/downloads/beta/gui-linux.zip
WORKDIR /opt

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl unzip ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    curl -L "$GUNTHY_URL" -o gui.zip && \
    unzip gui.zip && \
    rm gui.zip && \
    chmod +x gui-linux

# ---------- final image ----------
FROM debian:bookworm-slim

# Electron dependencies (plus libgbm1 & libnotify4 required by some Gunthy builds)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libgtk-3-0 libnss3 libxss1 libatk1.0-0 \
        libxkbcommon0 libdrm2 libasound2 xvfb xauth \
        libgbm1 libnotify4 && \
    rm -rf /var/lib/apt/lists/*

ENV APP_HOME=/opt/gunthy
COPY --from=builder /opt/gui-linux $APP_HOME/gui-linux
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh   # make it executable in the image

RUN useradd -ms /bin/bash gunthy && chown -R gunthy:gunthy $APP_HOME
USER gunthy

WORKDIR $APP_HOME
EXPOSE 5002

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
