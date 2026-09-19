#!/bin/bash
set -e

echo "=========================================="
echo " Starting Flutter Web Build for Vercel   "
echo "=========================================="

FLUTTER_CHANNEL="stable"
FLUTTER_DIR="$HOME/flutter"

# Clone Flutter SDK if not already present in build cache
if [ ! -d "$FLUTTER_DIR" ]; then
  echo "Installing Flutter SDK ($FLUTTER_CHANNEL)..."
  git clone https://github.com/flutter/flutter.git -b $FLUTTER_CHANNEL --depth 1 "$FLUTTER_DIR"
else
  echo "Using existing Flutter SDK at $FLUTTER_DIR"
fi

# Add Flutter to PATH
export PATH="$FLUTTER_DIR/bin:$PATH"

# Configure Git safe directory
git config --global --add safe.directory "$FLUTTER_DIR" || true
git config --global --add safe.directory "$(pwd)" || true

# Disable analytics for cleaner CI logs
flutter config --no-analytics

echo "Flutter version:"
flutter --version

echo "Fetching dependencies..."
flutter pub get

echo "Compiling Flutter Web application..."
flutter build web --release

echo "=========================================="
echo " Build successful! Output in build/web     "
echo "=========================================="