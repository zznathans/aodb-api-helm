#!/bin/sh
# Called by semantic-release's exec plugin (see .releaserc.json) with the
# next version as $1. Keeps charts/aodb-api/Chart.yaml's version/appVersion
# in lockstep with the GitHub release tag - chart-releaser packages and
# tags GitHub releases using Chart.yaml's version field, so without this
# every release after the first collides on the same unchanged tag.
set -eu

version="$1"
chart_file="charts/aodb-api/Chart.yaml"

sed -i \
  -e "s/^appVersion: .*/appVersion: ${version}/" \
  -e "s/^version: .*/version: ${version}/" \
  "$chart_file"
