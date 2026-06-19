#!/usr/bin/env bash
# Download self-hosted webfonts for GDPR compliance.
# Source: Fontsource (MIT-licensed npm mirror of Google Fonts), served from jsDelivr.
# Run once from anywhere — the script cd's into its own directory.

set -e
cd "$(dirname "$0")"

FS="https://cdn.jsdelivr.net/npm"

echo "Downloading Inter..."
for w in 300 400 500 600; do
  curl -fsSL -o "inter-${w}.woff2" \
    "$FS/@fontsource/inter@5.1.0/files/inter-latin-${w}-normal.woff2"
done

echo "Downloading Instrument Serif..."
curl -fsSL -o "instrument-serif-400.woff2" \
  "$FS/@fontsource/instrument-serif@5.1.0/files/instrument-serif-latin-400-normal.woff2"
curl -fsSL -o "instrument-serif-400-italic.woff2" \
  "$FS/@fontsource/instrument-serif@5.1.0/files/instrument-serif-latin-400-italic.woff2"

echo "Downloading JetBrains Mono..."
for w in 400 500; do
  curl -fsSL -o "jetbrains-mono-${w}.woff2" \
    "$FS/@fontsource/jetbrains-mono@5.1.0/files/jetbrains-mono-latin-${w}-normal.woff2"
done

echo ""
echo "Done. Files now in styles/fonts/:"
ls -1 *.woff2
