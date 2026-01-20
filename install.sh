#!/bin/bash

# Get the absolute path of the current directory
APP_DIR="$(pwd)"
ICON_PATH="$APP_DIR/public/icon.png"

echo "Installing USB Camera App..."

# Create a proper icon if it doesn't exist (using a generic one or download logic)
# For now we rely on the system icon 'camera-web' in the desktop file, 
# or we could try to download one if we had internet.
# Let's stick to the system icon for reliability.

# Generate the .desktop file with dynamic paths
cat > UsbCamera.desktop << EOL
[Desktop Entry]
Version=1.0
Name=USB Phone Cam
Comment=Use Android Phone as OBS Webcam
Exec=$APP_DIR/launch.sh
Icon=camera-web
Terminal=false
Type=Application
Categories=Video;Utility;
EOL

# Make scripts executable
chmod +x launch.sh
chmod +x start_usb.sh
chmod +x UsbCamera.desktop

# Install to user applications directory
mkdir -p ~/.local/share/applications
cp UsbCamera.desktop ~/.local/share/applications/

echo "✅ App Installed!"
echo "You can now find 'USB Phone Cam' in your System Menu."
echo "Or you can stick the 'UsbCamera.desktop' file on your desktop."
