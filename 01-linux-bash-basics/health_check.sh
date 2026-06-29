#!/bin/bash

THRESHOLD=80
DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

echo "Disk usage check:"
if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
  echo "WARNING: Disk usage is ${DISK_USAGE}%, exceeds threshold of ${THRESHOLD}%"
else
  echo "OK: Disk usage is ${DISK_USAGE}%"
fi

echo ""
echo "Memory usage:"
vm_stat

echo ""
echo "Top 5 processes by CPU:"
ps aux | sort -rk 3 | head -6

echo "Disk usage:"
df -h
echo "Memory usage:"
vm_stat
echo "Top 5 processes by CPU:"
ps aux | sort -rk 3 | head -6
