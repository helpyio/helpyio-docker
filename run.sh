#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# sleep while postgres is initializing
sleep 10
pg_isready -q -h postgres
ISREADY=$?
while [ "$ISREADY" != 0 ]; do
  pg_isready -q -h postgres
  let ISREADY=$?
  sleep 10
done

if [ ! -f /helpy/run_has_run ]
  then
    rake assets:precompile
    #su rails
    #. /etc/default/unicorn
    #rake db:create
    rake db:migrate
    rake db:seed
    #exit
    #chown -R rails: /home/rails/helpy
    touch /helpy/run_has_run
fi

exec unicorn
