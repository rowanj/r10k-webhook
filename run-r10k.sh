#!/bin/ash

R10K_ARGS=${R10K_ARGS:-deploy environment -v -p}

echo "Running r10k ${R10K_ARGS}"

# webhook forwards to r10k's docker-entrypoint.sh
exec /docker-entrypoint.sh $R10K_ARGS
