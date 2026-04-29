#!/bin/bash
# Publish a new guide to eco-escapes-guides.
# Usage: ./publish.sh <audience> <slug> <path-to-html>
#   audience: team | guests | owners | leads
#   slug: kebab-case (e.g. drive-guide, pool-rules)
#   path-to-html: absolute path to the source HTML file
set -e

AUDIENCE="$1"
SLUG="$2"
SRC="$3"

if [ -z "$AUDIENCE" ] || [ -z "$SLUG" ] || [ -z "$SRC" ]; then
  echo "Usage: $0 <audience> <slug> <path-to-html>" >&2
  echo "  audience: team | guests | owners | leads" >&2
  exit 1
fi

case "$AUDIENCE" in
  team|guests|owners|leads) ;;
  *) echo "Error: audience must be one of: team, guests, owners, leads" >&2; exit 1 ;;
esac

if [ ! -f "$SRC" ]; then
  echo "Error: source file not found: $SRC" >&2
  exit 1
fi

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
DEST="$REPO_DIR/$AUDIENCE/$SLUG.html"

cp "$SRC" "$DEST"
echo "Copied to: $DEST"

cd "$REPO_DIR"
git add "$AUDIENCE/$SLUG.html"
git commit -m "add: $AUDIENCE/$SLUG"
git push

echo ""
echo "Published. Live in ~60s at:"
echo "  https://chadharker780-code.github.io/eco-escapes-guides/$AUDIENCE/$SLUG.html"
echo "  (future: https://guides.ecoescape.com/$AUDIENCE/$SLUG)"
