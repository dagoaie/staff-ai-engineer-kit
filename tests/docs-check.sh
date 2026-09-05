#!/usr/bin/env bash
# Checks local Markdown links. External links are intentionally not fetched.
set -euo pipefail

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

missing_links="$({
  rg -n '\]\(([^:)#]+\.md)' README.md catalog playbook | perl -ne '
    if (/^([^:]+):\d+:.*\]\(([^)#]+\.md)/) {
      $path = $2;
      next if $path =~ m!^https?://!;
      $base = $1;
      $base =~ s!/[^/]+$!!;
      $base = "." if $base eq $1;
      $target = "$base/$path";
      $target =~ s!//+!/!g;
      print "missing $target\n" unless -f $target;
    }
  '
} || true)"

if [[ -n "$missing_links" ]]; then
  printf '%s\n' "$missing_links" >&2
  exit 1
fi

printf '✓ Enlaces Markdown locales válidos.\n'

if command -v markdownlint-cli2 >/dev/null 2>&1; then
  markdownlint-cli2 "README.md" "catalog/**/*.md" "playbook/**/*.md"
fi

if command -v lychee >/dev/null 2>&1; then
  lychee README.md 'catalog/**/*.md' 'playbook/**/*.md'
fi
