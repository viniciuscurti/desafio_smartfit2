#!/bin/bash
set -e

if [ ! -f /rails/tmp/db_setup.txt ]; then
  bundle exec rake db:create
  bundle exec rake db:migrate
  bundle exec rake db:seed
  touch /rails/tmp/db_setup.txt
fi

exec "$@"
