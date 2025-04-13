#!/bin/bash

# Function to display choices
select_option() {
  PS3="Select a build option: "
  select choice in "$@"; do
    if [ -n "$choice" ]; then
      echo "$choice"
      break
    else
      echo "Invalid choice. Please try again."
    fi
  done
}

# Show build options
echo "Choose the type of build you want:"
BUILD_OPTIONS=("Build APK" "Build AAB" "Build iOS")
build_choice=$(select_option "${BUILD_OPTIONS[@]}")

# Execute corresponding build command
case $build_choice in
  "Build APK")
    echo "🔧 Building Android APK..."
    flutter build apk --release --no-tree-shake-icons
    ;;
  "Build AAB")
    echo "🔧 Building Android AppBundle (AAB)..."
    flutter build appbundle --release --no-tree-shake-icons
    ;;
  "Build iOS")
    echo "🔧 Building iOS..."
    flutter build ios --release
    ;;
  *)
    echo "❌ Invalid option selected."
    exit 1
    ;;
esac