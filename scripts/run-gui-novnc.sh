#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RUNDIR="/tmp/comp4322-novnc"
mkdir -p "$RUNDIR"

# Stop old processes from previous runs if pidfiles still exist.
for p in java x11vnc websockify fluxbox Xvfb; do
  if [[ -f "$RUNDIR/$p.pid" ]]; then
    kill "$(cat "$RUNDIR/$p.pid")" 2>/dev/null || true
    rm -f "$RUNDIR/$p.pid"
  fi
done

X_DISPLAY=":1"

Xvfb "$X_DISPLAY" -screen 0 1440x900x24 -nolisten tcp -ac >"$RUNDIR/xvfb.log" 2>&1 &
echo $! >"$RUNDIR/Xvfb.pid"

# Wait until the virtual display socket exists before attaching services.
for _ in $(seq 1 20); do
  [[ -S /tmp/.X11-unix/X1 ]] && break
  sleep 0.2
done

DISPLAY="$X_DISPLAY" fluxbox >"$RUNDIR/fluxbox.log" 2>&1 &
echo $! >"$RUNDIR/fluxbox.pid"

x11vnc -display "$X_DISPLAY" -forever -shared -nopw -rfbport 5901 >"$RUNDIR/x11vnc.log" 2>&1 &
echo $! >"$RUNDIR/x11vnc.pid"

websockify --web=/usr/share/novnc/ 6080 localhost:5901 >"$RUNDIR/websockify.log" 2>&1 &
echo $! >"$RUNDIR/websockify.pid"

cd "$ROOT_DIR/src"
DISPLAY="$X_DISPLAY" java -cp . LSRComputeGUI >"$RUNDIR/java.log" 2>&1 &
echo $! >"$RUNDIR/java.pid"

echo "noVNC is starting. Open: http://127.0.0.1:6080/vnc.html"
echo "Display: $X_DISPLAY"
echo "Logs: $RUNDIR"
echo "PIDs: $RUNDIR/*.pid"
