# Gunbot GUI Docker

Detta repo bygger en Dockercontainer som laddar ner och kör Gunbot GUI.
Port 5002 exponeras och en volym `gunthy-data` används för att spara data.

## Bygg och kör

```bash
docker-compose build
docker-compose up -d
```

GUI:t nås sedan på http://localhost:5002.

Miljövariabeln `GUNTHY_URL` kan sättas i `docker-compose.yml` för att peka
på en alternativ nedladdningslänk.

Containern installerar `xvfb` och `xauth` och kör GUI:t via `xvfb-run` så det
fungerar även utan grafiskt gränssnitt.
