#!/bin/bash
cd "$(dirname "$0")"

echo "=========================================="
echo "    Brewhaus POS macOS Permission Fixer   "
echo "=========================================="
echo ""
echo "This script will fix the 'app is damaged' warning on macOS Sequoia."
echo "Please make sure you have dragged 'Brewhaus POS' into your Applications folder first."
echo ""

# Run the command to remove quarantine from the installed app
if [ -d "/Applications/Brewhaus POS.app" ]; then
    xattr -cr "/Applications/Brewhaus POS.app"
    echo "✔ Success! The permission has been fixed."
    echo "You can now close this window and open Brewhaus POS from your Applications folder."
else
    echo "❌ Error: 'Brewhaus POS' was not found in your /Applications folder."
    echo "Please drag the app from the DMG to your Applications folder first, then run this script again."
fi

echo ""
read -p "Press [Enter] to close this window..."
