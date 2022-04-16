#!/bin/bash

set -eo pipefail

export FLASK_APP=superset

echo "Starting up Superset gunicorn server"
gunicorn \
      -w 10 \
      -k gevent \
      --timeout 300 \
      -b  0.0.0.0:8088 \
      --log-level info \
      "superset.app:create_app()"
