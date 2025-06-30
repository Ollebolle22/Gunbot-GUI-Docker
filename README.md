# Gunbot GUI Docker

This repository contains everything you need to build and run the Gunbot GUI in a standalone Docker container. 
It downloads the GUI binary, installs minimal dependencies, and serves it on port 5002.

## 🔽 What gets downloaded?
- **GUI binary** from the URL defined by the build-arg `GUNTHY_URL`  
Default:  https://gunthy.org/downloads/beta/gui-linux.zip
(Override by passing a different URL to Docker Compose or in your `.env`.)

## 🧰 What gets installed?

1. **Builder stage** (`debian:bookworm-slim`):  
 - `curl`, `unzip`, `ca-certificates`  
 - Downloads & unzips the GUI into `/opt`, makes `gui-linux` executable

2. **Final image** (`debian:bookworm-slim`):  
 - Electron runtime deps:  
   ```
   libgtk-3-0, libnss3, libxss1, libatk1.0-0,
   libxkbcommon0, libdrm2, libasound2,
   libgbm1, libnotify4
   ```
 - Sets `APP_HOME=/opt/gunthy`  
 - Copies the `gui-linux` binary and `entrypoint.sh`  
 - Creates a non-root user `gunthy` and chowns `$APP_HOME`  
 - Exposes port **5002**

## 🚀 How to deploy

### Option A – Docker Compose

1. Clone & enter repo:
git clone https://github.com/Ollebolle22/Gunbot-GUI-Docker.git
cd Gunbot-GUI-Docker
./gunthy-gui

2. (Optional) Create a .env alongside docker-compose.yml:

GUNTHY_URL=https://gunthy.org/downloads/beta/gui-linux.zip
CONFIG_API_URL=http://YOUR_GUNBOT_HOST:5000
CONFIG_PORT=5002

3. Build & start:
docker-compose up -d --build

Option B – Portainer
In Portainer, Add stack → Git repository → paste this repo URL.

Under Environment variables, set:

* GUNTHY_URL

* CONFIG_API_URL

* CONFIG_PORT

Deploy.


⚙️ Configuration
Variable	Description	Default
GUNTHY_URL	URL to the GUI ZIP archive	https://gunthy.org/downloads/beta/gui-linux.zip
CONFIG_API_URL	URL of your Gunbot core API (must be running elsewhere)	http://iptogb:port
CONFIG_PORT	Port that this GUI listens on	5002



📄 Entrypoint
The entrypoint.sh script does the following:

Generates a JSON config at $APP_HOME/config.json:
{
  "apiUrl": "<CONFIG_API_URL>",
  "port": <CONFIG_PORT>
}
Appends all output to $APP_HOME/gui.log.

Executes the GUI binary:

exec $APP_HOME/gui-linux "$@"
