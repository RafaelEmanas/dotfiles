#!/bin/bash

# Fetch the latest RStudio version tag from GitHub
LATEST=$(curl -s https://api.github.com/repos/rstudio/rstudio/tags | grep -o '"name": "v[^"]*"' | head -1 | sed 's/"name": "v//;s/"//')

if [ -z "$LATEST" ]; then
    echo "Failed to fetch latest version"
    exit 1
fi

# Convert version format: 2025.09.2+418 -> 2025.09.2-418
VERSION=$(echo "$LATEST" | tr '+' '-')
RPM="rstudio-${VERSION}-x86_64.rpm"
URL="https://download1.rstudio.org/electron/rhel9/x86_64/${RPM}"

echo "Downloading RStudio $VERSION..."
curl -LO "$URL" && sudo dnf install "./${RPM}" && rm "${RPM}"
