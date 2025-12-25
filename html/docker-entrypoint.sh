#!/bin/sh
envsubst '${BACKEND_URL}' < /usr/share/nginx/html/index.html > /usr/share/nginx/html/index.tmp.html
mv /usr/share/nginx/html/index.tmp.html /usr/share/nginx/html/index.html
exec "$@"