#!/bin/bash

# Get script directory
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
cd "$SCRIPT_DIR" || exit 1

cleanup() {
    echo "Exiting... killing background processes."
    pkill -P $$
    if [ -n "$PORT" ]; then
        fuser -k "$PORT"/tcp >/dev/null 2>&1
    fi
    pkill -f cloudflared >/dev/null 2>&1
    exit 0
}

trap cleanup SIGINT SIGTERM EXIT

# Get port from user and check if it's in use
while true; do
    read -p "Enter port number: " PORT
    
    # Check if input is empty
    if [ -z "$PORT" ]; then
        echo "Error: Port number cannot be empty. Please enter a valid port number."
        continue
    fi
    
    # Check if port is a valid number
    if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
        echo "Error: Port number must contain only digits. Please enter a valid port number."
        continue
    fi
    
    # Check if port is in valid range (1-65535)
    if [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
        echo "Error: Port number must be between 1 and 65535. Please enter a valid port number."
        continue
    fi
    
    # Check if port is in use
    if lsof -i :"$PORT" >/dev/null 2>&1; then
        echo "Port $PORT is already in use."
        while true; do
            read -p "Do you want to close it and use this port? (yes/no): " close_choice
            if [ "$close_choice" == "yes" ]; then
                fuser -k "$PORT"/tcp >/dev/null 2>&1
                echo "Port $PORT is now free."
                break
            elif [ "$close_choice" == "no" ]; then
                break 2
            else
                echo "Please answer yes or no."
            fi
        done
    else
        echo "Port $PORT is available."
        break
    fi
done

# Start PHP server
echo "Starting PHP server on port $PORT..."
php -S 0.0.0.0:"$PORT" >/dev/null 2>&1 &

while true; do
    echo "[1] Local Test (Localhost only)"
    echo "[2] Cloudflare Tunnel (Public)"
    read -p "Enter number: " num

    if [ "$num" == "1" ]; then
        echo "Local test mode - Access at: http://localhost:$PORT"
        echo "Press Ctrl+C to exit"
        while true; do
            sleep 1
        done
        break
    elif [ "$num" == "2" ]; then
        # Check if cloudflared is installed
        if ! command -v cloudflared &> /dev/null; then
            echo "cloudflared is not installed. Please install it first."
            echo "Visit: https://github.com/cloudflare/cloudflared"
            cleanup
            exit 1
        fi
        cloudflared tunnel --url http://localhost:"$PORT"
        break
    else
        echo "Invalid number. Please enter 1 or 2."
    fi
done








