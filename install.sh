#!/bin/bash
# ==============================================================================
# SAIF Activity Lab CLI Installer
# Web: https://ridloabelian.github.io
# ==============================================================================
set -e

# Terminal Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

echo -e "${CYAN}${BOLD}====================================================${NC}"
echo -e "${CYAN}${BOLD}          SAIF Activity Lab CLI Installer           ${NC}"
echo -e "${CYAN}${BOLD}====================================================${NC}"
echo -e ""

# Detect OS
OS="$(uname -s)"
ARCH="$(uname -m)"

BINARY_URL=""

if [ "$OS" = "Darwin" ]; then
    echo -e "System detected: ${GREEN}${BOLD}macOS ($ARCH)${NC}"
    BINARY_URL="https://ridloabelian.github.io/bin/saif-mac"
elif [ "$OS" = "Linux" ]; then
    echo -e "System detected: ${GREEN}${BOLD}Linux ($ARCH)${NC}"
    if [ "$ARCH" = "x86_64" ]; then
        BINARY_URL="https://ridloabelian.github.io/bin/saif-linux"
    else
        echo -e "${RED}${BOLD}Error: Architecture $ARCH is currently not supported for Linux prebuilt binaries.${NC}"
        echo -e "Please install using Cargo: ${CYAN}cargo install saif${NC}"
        exit 1
    fi
else
    echo -e "${RED}${BOLD}Error: Unsupported operating system: $OS.${NC}"
    exit 1
fi

# Determine target directory
# We prefer /usr/local/bin, but if it doesn't exist, we fall back to /usr/bin or a directory in PATH.
TARGET_DIR="/usr/local/bin"
if [ ! -d "$TARGET_DIR" ]; then
    # Fallback to home bin if /usr/local/bin doesn't exist
    TARGET_DIR="$HOME/.local/bin"
    mkdir -p "$TARGET_DIR"
    
    # Check if target dir is in PATH
    if [[ ":$PATH:" != *":$TARGET_DIR:"* ]]; then
        echo -e "${BLUE}Notice: $TARGET_DIR is not in your PATH. You might need to add it to your shell configuration.${NC}"
    fi
fi

TARGET_PATH="$TARGET_DIR/saif"

echo -e "Downloading binary from: ${BLUE}${BOLD}$BINARY_URL${NC}..."

# Create a secure temporary file
TEMP_FILE=$(mktemp)

# Download using curl or wget
if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$BINARY_URL" -o "$TEMP_FILE"
elif command -v wget >/dev/null 2>&1; then
    wget -qO "$TEMP_FILE" "$BINARY_URL"
else
    echo -e "${RED}${BOLD}Error: Neither curl nor wget was found on your system. Please install one of them and try again.${NC}"
    rm -f "$TEMP_FILE"
    exit 1
fi

# Make temporary file executable
chmod +x "$TEMP_FILE"

# Install binary to target path
echo -e "Installing to: ${GREEN}${BOLD}$TARGET_PATH${NC} (may require sudo)..."

if [ -w "$TARGET_DIR" ]; then
    mv -f "$TEMP_FILE" "$TARGET_PATH"
else
    # Require sudo if writing to directory is not permitted
    sudo mv -f "$TEMP_FILE" "$TARGET_PATH"
    sudo chmod +x "$TARGET_PATH"
fi

echo -e ""
echo -e "${GREEN}${BOLD}✓ SAIF has been successfully installed!${NC}"
echo -e "Type ${CYAN}${BOLD}saif${NC} in your terminal to start looking incredibly busy."
echo -e ""
