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

The container installs `xvfb` and `xauth` and runs the GUI via `xvfb-run` so it
works even without a graphical interface.
