#!/bin/bash

# Update package index
apt update -qq >/dev/null 2>&1

# Count the number of packages that can be upgraded
count=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." | wc -l)

echo "$count"
