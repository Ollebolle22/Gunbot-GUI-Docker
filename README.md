# Gunbot GUI Docker

This repository builds a Docker container that downloads and runs the Gunbot GUI.
Port 5002 is exposed and a volume `gunthy-data` is used to persist data.

## Build and run

```bash
docker-compose build
docker-compose up -d
```

The GUI will then be available at http://localhost:5002.

The environment variable `GUNTHY_URL` can be set in `docker-compose.yml` to point
to an alternative download link.

Two further environment variables control the configuration written to
`config.json` next to `gui-linux`:

- `CONFIG_API_URL` sätter API-URL:en (standard `http://iptogb:port`)
- `CONFIG_PORT` sätter portnumret (standard `5002`)

The container installs `xvfb` and `xauth` and runs the GUI via `xvfb-run` so it
works even without a graphical interface.

## Logs

All GUI output is saved to `gui.log` under `/opt/gunthy` inside the container and
is also printed to STDOUT. View it with:

```bash
docker compose logs -f gunthy
```

## Portainer

Vid deployment via Portainer och valet **Repository** måste filen `stack.env`
ligga i repots rot. Filen innehåller standardvariabler och kan redigeras
direkt i Portainer eller med valfri texteditor innan deployment.
