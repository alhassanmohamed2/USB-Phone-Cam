#!/bin/bash

# Directory where the project is located
PROJECT_DIR="/home/alhassan/cameraUsb"
cd "$PROJECT_DIR"

# 1. Cleanup old processes
pkill -f "python server.py"

# 2. Start ADB (Log to file, don't show output)
./start_usb.sh > usb_debug.log 2>&1

# 3. Start Server (Background)
./venv/bin/python server.py > server.log 2>&1 &
SERVER_PID=$!

# Wait for server to warm up
sleep 2

# 4. Open Browser in "App Mode" (No bars)
# User requested Chrome specifically (Firefox often fails H.264 WebCodecs on Linux)
if command -v google-chrome &> /dev/null; then
    google-chrome --app=http://localhost:3000/receiver.html
elif command -v google-chrome-stable &> /dev/null; then
    google-chrome-stable --app=http://localhost:3000/receiver.html
elif command -v chromium-browser &> /dev/null; then
    chromium-browser --app=http://localhost:3000/receiver.html
elif command -v chromium &> /dev/null; then
    chromium --app=http://localhost:3000/receiver.html
else
    echo "❌ Error: Google Chrome or Chromium not found!"
    echo "Please install Chrome for H.264 WebCodecs support."
    exit 1
fi

# Optional: Cleanup when browser closes? 
# Usually hard to track "App Mode" close, so we leave server running.
