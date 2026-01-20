#!/bin/bash

# Port to forward
PORT=3000

echo "Checking for connected Android devices..."
devices=$(adb devices | grep -w "device")

if [ -z "$devices" ]; then
    echo "❌ No device connected or authorized."
    echo "   Please connect your Android phone via USB and enable USB Debugging."
    echo "   Ensure 'adb' is installed and in your PATH."
    exit 1
else
    echo "✅ Device found!"
fi

echo "Running ADB reverse on port $PORT..."
adb reverse tcp:$PORT tcp:$PORT

if [ $? -eq 0 ]; then
    echo "✅ ADB reverse successful."
    echo "   You can now access the app on your phone at http://localhost:$PORT/sender.html"
else
    echo "❌ ADB reverse failed."
fi
