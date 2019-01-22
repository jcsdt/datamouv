#!/bin/bash
# Docker entrypoint script.

# Wait until Postgres is ready
while ! pg_isready -q -h postgres -p 5432 -U postgres
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

./bin/scrapper migrate
./bin/scrapper foreground
