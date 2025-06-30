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

- `CONFIG_API_URL` sets the API URL (defaults to `http://iptogb:port`)
- `CONFIG_PORT` sets the port number (defaults to `5002`)

The entrypoint script rewrites `config.json` at startup using these values.

The container runs the GUI directly in headless mode, so no virtual display is
required.

## Logs

All GUI output is saved to `gui.log` under `/opt/gunthy` inside the container and
is also printed to STDOUT. View it with:

```bash
docker compose logs -f gunthy
```

## Portainer

When deploying via Portainer with the **Repository** option, the `stack.env` file
must reside in the repository root. The file contains default variables and can
be edited directly in Portainer or with any text editor before deployment.
