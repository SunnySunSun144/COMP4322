#!/usr/bin/env bash
set -euo pipefail

RUNDIR="/tmp/comp4322-novnc"

if [[ ! -d "$RUNDIR" ]]; then
  echo "No noVNC runtime directory found."
  exit 0
fi

for p in java websockify x11vnc fluxbox Xvfb; do
  if [[ -f "$RUNDIR/$p.pid" ]]; then
    kill "$(cat "$RUNDIR/$p.pid")" 2>/dev/null || true
    rm -f "$RUNDIR/$p.pid"
  fi
done

echo "Stopped noVNC GUI stack."
