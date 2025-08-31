#!/bin/bash

while true; do
    echo "[1] serveo.net"
    echo "[2] localhost.run"
    read -p "Enter number: " num

    if [ "$num" == "1" ]; then
        php -S 0.0.0.0:8080 >/dev/null 2>&1 &
        ssh -R 80:0.0.0.0:8080 serveo.net
        break
    elif [ "$num" == "2" ]; then
        php -S 0.0.0.0:8080 >/dev/null 2>&1 &
        ssh -R 80:localhost:8080 nokey@localhost.run
        break
    else
        echo "Invalid number. Please enter 1 or 2."
    fi
done





