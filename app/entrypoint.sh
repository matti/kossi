#!/usr/bin/env sh
set -euo pipefail

chisel server --port ${PORT:-8080} --backend=http://127.0.0.1:1234 &

(
  while true; do
    k0s token create --role=worker --wait >/var/lib/k0s/pki/worker && break
    sleep 1
  done
  echo /var/lib/k0s/pki/worker created

  exec ran -bind-ip 127.0.0.1 -port 1234 -root=/var/lib/k0s/pki
) &


(
  exec k0s server
#) >/dev/null 2>&1 &
) &

wait $!
