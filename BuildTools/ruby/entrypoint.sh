#!/usr/bin/env bash
set -eo pipefail

# Install gems only if something is missing or out of sync.
# No-op (fast) when the image/volume already satisfies Gemfile.lock.
bundle check || bundle install

# Run db migrations
rails db:migrate

# launches container command
exec "$@"
