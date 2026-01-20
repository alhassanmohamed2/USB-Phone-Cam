# USB Phone Cam 📱➡️💻

Turn your Android phone into a high-performance, low-latency USB Webcam for OBS or Desktop.
Uses **WebCodecs (H.264)** for hardware-accelerated streaming, providing near-native performance (~0 latency) over a standard USB cable.

## Features
- 🚀 **Zero Latency**: Uses USB tethering (`adb reverse`), not Wi-Fi.
- ⚡ **Hardware Acceleration**: Uses H.264 / WebCodecs API for smooth 720p/1080p.
- 📸 **High Quality**: Adjustable resolution (480p, 720p, 1080p) and bitrate.
- 🔄 **Orientation Support**: Works in both Portrait and Landscape.
- 🔌 **OBS Ready**: Clean "Receiver" page designed specifically for OBS Browser Source.
- 🐧 **Linux Native**: Includes a desktop launcher and installer.

## Prerequisites
- **Android Phone** with "USB Debugging" enabled.
- **Micro-USB / Type-C Cable**.
- **Python 3.8+** installed.
- **Google Chrome** (or Chromium) installed on Desktop.
- **ADB** (`android-tools`) installed.

## Installation (Linux)

1. **Clone the repo:**
   ```bash
   git clone https://github.com/alhassanmohamed2/USB-Phone-Cam.git
   cd USB-Phone-Cam
   ```

2. **Run the Installer:**
   This will install dependencies, create a Virtual Environment, and add a shortcut to your Application Menu.
   ```bash
   ./install.sh
   # Note: You might need to install 'python3-venv' and 'adb' first if you don't have them.
   # sudo apt install python3-venv android-tools-adb
   ```

3. **Install Python Deps manually (if installer fails):**
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

## Usage

1. **Connect your Phone** via USB.
2. Open **"USB Phone Cam"** from your App Menu (or run `./launch.sh`).
3. On your **Phone**:
   - Open Chrome and go to `http://localhost:3000/sender.html`
   - (Or just check the notification bar if you have ADB forwarding)
   - Click **Start Camera**.
4. On your **PC**:
   - The app window will open showing the stream.
   - For **OBS**: Add a "Browser Source", set URL to `http://localhost:3000/receiver.html`, set Width/Height to 1280x720, and check "Control Audio via OBS".

## Troubleshooting
- **"Decoder Error"**: Ensure you are using Chrome/Chromium. Firefox implementation of WebCodecs H.264 is incomplete on Linux.
- **"Device Not Found"**: Make sure USB Debugging is ON and you accepted the prompt on your phone.

## License
MIT
