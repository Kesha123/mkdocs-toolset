#!/usr/bin/env bash
set -euo pipefail

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "error: not a git repository" >&2
  exit 1
fi

latest="$(git tag --list | sort -V | tail -n 1)"

if [ -z "$latest" ]; then
  echo "0.0.0"
  exit 0
fi

today="$(date +%Y.%m.%d)"

if [ "$latest" != "$today" ] && [[ "$latest" != "$today".* ]]; then
  echo "$today"
  exit 0
fi

case "$latest" in
  "$today")
    echo "$today.2"
    ;;
  "$today".*)
    suffix="${latest#"$today".}"
    echo "$today.$((suffix + 1))"
    ;;
esac
