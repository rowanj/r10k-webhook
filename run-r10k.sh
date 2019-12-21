#!/bin/ash

R10K_ARGS=${R10K_ARGS:-deploy environment -v -p}

echo "Running r10k ${R10K_ARGS}"

# webhook forwards to r10k's docker-entrypoint.sh
# use a lockfile to serialise requests
exec flock --timeout 55 run-r10k.lock /docker-entrypoint.sh $R10K_ARGS
