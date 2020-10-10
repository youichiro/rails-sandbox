#!/bin/bash
set -e

# pidファイルを削除してサーバを再起動する
rm -f /rails/tmp/pids/server.pid

exec "$@"
