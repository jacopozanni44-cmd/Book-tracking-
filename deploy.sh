#!/bin/sh
# Build the GitHub Pages site: live app from main at the root, the dev branch under /preview/.
# Usage: ./deploy.sh [outdir]   (then push outdir as gh-pages)
set -e
OUT=${1:-/tmp/site}
rm -rf "$OUT" && mkdir -p "$OUT/preview"
git archive main | tar -x -C "$OUT"
for f in index.html sw.js manifest.webmanifest icon-192.png icon-512.png data.json; do git show dev:$f > "$OUT/preview/$f"; done
sed -i 's#"start_url":"./"#"start_url":"./","id":"preview"#; s#"name": *"The Codex Club"#"name":"Codex Club Preview"#' "$OUT/preview/manifest.webmanifest"
touch "$OUT/.nojekyll"
