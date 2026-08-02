# aodb-api-helm

Helm chart for [`aodb-api`](https://github.com/zznathans/aodb-api), a
self-hosted replacement for the `cidb.bebot.link` item-search API that
BeBot's `!items` command relies on.

Deploys a single-instance FastAPI Deployment + Service. No database, no
Ingress: the item dump is downloaded fresh into memory from a public HTTPS
URL (`aodbApi.dumpUrl`) on every pod start, and the Service is meant to sit
behind an externally-managed Cloudflare Tunnel (or similar) rather than a
chart-owned Ingress.

See `charts/aodb-api/values.yaml` for the full set of configurable values.

## Development

```
helm lint charts/aodb-api --strict --set aodbApi.dumpUrl=https://example.invalid/dump.xml.zip
helm unittest charts/aodb-api
```

Published via chart-releaser to this repo's `gh-pages` branch on every
GitHub Release; deployed via ArgoCD from this organization's internal
GitOps repo as a normal chart dependency, the same way `bebot-helm` is.
