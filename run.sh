#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# sleep while postgres is initializing
sleep 5
pg_isready -q -h postgres
ISREADY=$?
while [ "$ISREADY" != 0 ]; do
  pg_isready -q -h postgres
  let ISREADY=$?
  sleep 5
done

HAS_RUN=$([ -f /helpy/run_has_run ]; echo $?)
if [ "$HAS_RUN" != 0 ]
  then
    rake assets:precompile
    #su rails
    #. /etc/default/unicorn
    #rake db:create
    rake db:migrate
    rake db:seed || echo "db is already seeded"
    #exit
    #chown -R rails: /home/rails/helpy
    touch /helpy/run_has_run
fi

exec bundle exec unicorn -E production -c config/unicorn.rb
