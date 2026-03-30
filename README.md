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
  - `post.php`: Captures and stores webcam images from the victim’s camera.  

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

1. Enter the port number you want to use (e.g., 8080).
   · If the port is busy, the script will ask if you want to close the existing service.
2. Choose a mode:
   · [1] Local Test → Access only on localhost (http://localhost:PORT)
   · [2] Cloudflare Tunnel → Public access with Cloudflare random URL
3. If you choose Cloudflare, make sure cloudflared is installed:
   ```bash
   # On macOS
   brew install cloudflared
   
   # On Linux
   wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
   chmod +x cloudflared-linux-amd64
   sudo mv cloudflared-linux-amd64 /usr/local/bin/cloudflared
   ```
4. Share the generated link with the target (Cloudflare mode only).
5. Collected data will be saved in:
   · sensitiveinfo.txt (device and location info)
   · cam<date>.png (webcam snapshots)

Disclaimer

This project is for educational and research purposes only.
The author is not responsible for any misuse of this tool.
Use it only in controlled environments with explicit permission.

```
