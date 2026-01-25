#!/bin/bash

# Get the absolute path of the current directory
APP_DIR="$(pwd)"

echo "Installing USB Camera App..."

# 1. Create Python Virtual Environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating Python virtual environment..."
    python3 -m venv venv
    if [ $? -ne 0 ]; then
        echo "❌ Failed to create venv. Please install python3-venv:"
        echo "   sudo apt install python3-venv   (Debian/Ubuntu)"
        echo "   sudo xbps-install python3       (Void Linux)"
        exit 1
    fi
fi

# 2. Install Python dependencies
echo "Installing Python dependencies..."
./venv/bin/pip install -r requirements.txt
if [ $? -ne 0 ]; then
    echo "❌ Failed to install dependencies."
    exit 1
fi

# 3. Generate the .desktop file with dynamic paths
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

# 4. Make scripts executable
chmod +x launch.sh
chmod +x start_usb.sh
chmod +x UsbCamera.desktop

# 5. Install to user applications directory
mkdir -p ~/.local/share/applications
cp UsbCamera.desktop ~/.local/share/applications/

echo "✅ App Installed!"
echo "You can now find 'USB Phone Cam' in your System Menu."
echo "Or you can stick the 'UsbCamera.desktop' file on your desktop."

