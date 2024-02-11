#!/bin/bash

while !</dev/tcp/db/5432
do
  echo "Wrapper: DB is not ready. Sleeping for 1 second..."; sleep 1
done

echo "Wrapper: Waiting for another 5 seconds..."; sleep 5

rake db:prepare

exec rails server -b 0.0.0.0
