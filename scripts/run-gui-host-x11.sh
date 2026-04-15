#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR/src"

if [[ -z "${DISPLAY:-}" ]]; then
  echo "DISPLAY is not set."
  echo "Start the container with X11 forwarding and set DISPLAY, then retry."
  exit 1
fi

if [[ ! -S /tmp/.X11-unix/X${DISPLAY#:} ]]; then
  echo "No X11 socket found for DISPLAY=$DISPLAY inside container."
  echo "Expected socket: /tmp/.X11-unix/X${DISPLAY#:}"
  echo "Reopen the container using .devcontainer/devcontainer.json settings."
  exit 1
fi

echo "Launching GUI on DISPLAY=$DISPLAY"
exec java -cp . LSRComputeGUI
