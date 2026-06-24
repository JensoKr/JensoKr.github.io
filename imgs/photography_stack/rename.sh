#!/bin/bash
# Two-pass safe rename for the photo stack.
#   Pass 1: every *.avif → dummy_NNN.avif  (collision-free intermediate)
#   Pass 2: every dummy_NNN.avif → NNN.avif (final names)
# Effect: photos numbered 001…NNN in alphabetical order of the originals.

set -e
cd "$(cd "$(dirname "$0")" && pwd)" || exit 1
shopt -s nullglob

EXT="avif"

# ---- Pass 1 ----
echo "Pass 1 — renaming to dummy_NNN.${EXT} …"
counter=1
for file in *."$EXT"; do
  [ -f "$file" ] || continue
  new_name=$(printf "dummy_%03d.%s" "$counter" "$EXT")
  if [ "$file" != "$new_name" ]; then
    echo "  $file -> $new_name"
    mv "$file" "$new_name"
  fi
  ((counter++))
done

echo ""

# ---- Pass 2 ----
echo "Pass 2 — renaming dummy_NNN.${EXT} -> NNN.${EXT} …"
counter=1
for file in dummy_*."$EXT"; do
  [ -f "$file" ] || continue
  new_name=$(printf "%03d.%s" "$counter" "$EXT")
  echo "  $file -> $new_name"
  mv "$file" "$new_name"
  ((counter++))
done

echo ""
echo "Done. $((counter - 1)) file(s) renamed."

# ---- Write img_count manifest ----
# Plain-text file consumed by js/main.js so the gallery can pick its
# random selection without having to probe the folder over HTTP.
COUNT=$(ls -1 *."$EXT" 2>/dev/null | wc -l | tr -d ' ')
echo "$COUNT" > img_count
echo "Wrote img_count: $COUNT"
