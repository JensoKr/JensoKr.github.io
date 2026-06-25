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

# ---- Write metadata.{json,js} (EXIF for lightbox captions) ----
# Two outputs from the same data:
#   metadata.json  → loaded via fetch() on http:// / GitHub Pages
#   metadata.js    → loaded via <script> tag — also works on file://
#                    where fetch is blocked as cross-origin.
# Requires exiftool. If not installed, the gallery falls back to the
# simple "NN / NNN" counter caption.
if command -v exiftool >/dev/null 2>&1; then
  echo "Extracting EXIF → metadata.{json,js} …"
  EXIF_JSON=$(exiftool -json -q -Model -LensModel -ISO -Aperture \
              -ExposureTime -FocalLength *."$EXT" 2>/dev/null)
  if [ -n "$EXIF_JSON" ]; then
    echo "$EXIF_JSON" > metadata.json
    {
      echo "window.__galleryMetadata ="
      echo "$EXIF_JSON"
      echo ";"
    } > metadata.js
    echo "Wrote metadata.json + metadata.js"
  else
    echo "(exiftool returned no data — skipping)"
  fi
else
  echo "(exiftool not installed — skipping metadata files)"
fi
