# Devil-link

Devil-link is a phishing and information-stealing tool that creates a fake video chat website to trick victims into sharing sensitive device data, location, and webcam access.  

## Features
- **Fake Video Chat Page (index.html)**  
  Collects:
  - Device GPS location  
  - Battery status and charging state  
  - Clipboard content  
  - Screen resolution, CPU threads, RAM size  
  - User Agent, platform, language, and referrer  
  - Network information (connection type, downlink)  
  - Webcam snapshots (saved as PNG images)  

- **Data Collection**  
  - `sunni.php`: Saves sensitive information (IP, location, device info, clipboard, etc.) into `sensitiveinfo.txt`.  
  - `post.php`: Captures and stores webcam images from the victim's camera.  

- **Server Runner**  
  - `run.sh`: Launches a PHP server on a user-specified port and offers two modes:
    - Local Test: Accessible only on localhost for testing
    - Cloudflare Tunnel: Public access via Cloudflare's random URL (e.g., https://random-name.trycloudflare.com)

## Files
- `index.html` → Main phishing page.  
- `post.php` → Handles webcam snapshots.  
- `sunni.php` → Logs victim device and network information.  
- `run.sh` → Bash script for starting and tunneling the server.  

## Usage
1. Place all files in the same directory.  
2. Run the server with:  
   ```bash
   bash run.sh
   ```

Disclaimer

This project is for educational and research purposes only.
The author is not responsible for any misuse of this tool.
Use it only in controlled environments with explicit permission.











