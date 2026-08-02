# aodb-api-helm

Helm chart for [`aodb-api`](https://github.com/zznathans/aodb-api), a
self-hosted replacement for the `cidb.bebot.link` item-search API that
BeBot's `!items` command relies on.

Deploys a single-instance FastAPI Deployment + Service, plus a
mariadb-operator-managed `MariaDB` CR to back it (or point it at an
external database by setting `aodbApi.mariadb.enabled: false` and
providing connection details via `extraObjects`). No Ingress is included —
this chart is meant to sit behind a shared Cloudflare Tunnel (or any other
externally-managed exposure), reached only via its in-cluster `Service`.

See `charts/aodb-api/values.yaml` for the full set of configurable values.

## Development

```
helm repo add mariadb-operator https://mariadb-operator.github.io/mariadb-operator
helm dependency build charts/aodb-api
helm lint charts/aodb-api --strict --set aodbApi.db.password=placeholder
helm unittest charts/aodb-api
```

Published via chart-releaser to this repo's `gh-pages` branch on every
GitHub Release; consumed from `zznathans/charts` (ArgoCD) as a normal
dependency, the same way `bebot-helm` is.
