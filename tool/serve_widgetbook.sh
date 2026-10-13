#!/usr/bin/env bash
# Builds Widgetbook for web (release) and serves it on http://localhost:8080
# in the background. No hot reload: rerun this after every change.
#
#   tool/serve_widgetbook.sh            # port 8080
#   PORT=9000 tool/serve_widgetbook.sh
set -euo pipefail

PORT="${PORT:-8080}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WEB="$ROOT/widgetbook/build/web"
LOG="$ROOT/widgetbook/build/serve.log"

# Stop whatever is serving the port. LISTEN only: never touch clients
# (browsers) that are connected to it.
pids="$(lsof -ti "tcp:$PORT" -sTCP:LISTEN || true)"
if [ -n "$pids" ]; then
  echo "Stopping server on port $PORT (pid $pids)"
  kill $pids
  sleep 1
fi

echo "Building Widgetbook (release)…"
(cd "$ROOT/widgetbook" && flutter build web --release)

nohup python3 -m http.server "$PORT" --bind localhost --directory "$WEB" \
  >"$LOG" 2>&1 &

for _ in $(seq 1 20); do
  if curl -sf -o /dev/null "http://localhost:$PORT/"; then
    echo "Widgetbook: http://localhost:$PORT (log: $LOG)"
    exit 0
  fi
  sleep 0.5
done
echo "Server didn't start on port $PORT, see $LOG" >&2
exit 1
