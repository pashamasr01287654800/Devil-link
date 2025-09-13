#!/bin/bash

cleanup() {
    echo "Exiting... killing background processes."
    # kill php and ssh started by this script
    pkill -P $$
    # make sure port 8080 is free
    fuser -k 8080/tcp >/dev/null 2>&1
    exit 0
}

trap cleanup SIGINT SIGTERM EXIT

while true; do
    echo "[1] serveo.net"
    echo "[2] localhost.run"
    read -p "Enter number: " num

    if [ "$num" == "1" ]; then
        fuser -k 8080/tcp >/dev/null 2>&1
        php -S 0.0.0.0:8080 >/dev/null 2>&1 &
        ssh -R 80:0.0.0.0:8080 serveo.net
        break
    elif [ "$num" == "2" ]; then
        fuser -k 8080/tcp >/dev/null 2>&1
        php -S 0.0.0.0:8080 >/dev/null 2>&1 &
        ssh -R 80:localhost:8080 nokey@localhost.run
        break
    else
        echo "Invalid number. Please enter 1 or 2."
    fi
done
