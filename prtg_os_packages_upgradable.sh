#!/bin/bash

# Version 1.1 - Count upgradable packages (Ubuntu + RHEL/CentOS/Oracle Linux)
# Output: only the number

# Detect OS
if grep -qi "ubuntu\|debian" /etc/os-release; then
    OS="ubuntu"
elif grep -qi "rhel\|centos\|almalinux\|rocky\|oracle\|ol" /etc/os-release; then
    OS="redhat"
else
    exit 1
fi

# Initialize update count
UPDATE_COUNT=0

if [ "$OS" = "ubuntu" ]; then
    apt update -qq >/dev/null 2>&1
    UPDATE_COUNT=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." | wc -l)
else
    if command -v dnf >/dev/null 2>&1; then
        UPDATE_COUNT=$(dnf check-update -q 2>/dev/null | grep -E "^\S" | wc -l)
    else
        UPDATE_COUNT=$(yum check-update -q 2>/dev/null | grep -E "^\S" | wc -l)
    fi
fi

echo "$UPDATE_COUNT"
