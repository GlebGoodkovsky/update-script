#!/bin/bash

set -e

echo
echo "    █████  █████  █████████ "
echo "   ░░███  ░░███  ███░░░░░███"
echo "    ░███   ░███ ░███    ░░░ "
echo "    ░███   ░███ ░░█████████ "
echo "    ░███   ░███  ░░░░░░░░███"
echo "    ░███   ░███  ███    ░███"
echo "    ░░████████  ░░█████████ "
echo "     ░░░░░░░░    ░░░░░░░░░  "
echo
echo "      Update Script (US)"
echo
echo "Select your system:"
echo "1) Arch based (binaries only)"
echo "2) Arch based (with AUR compiling)"
echo "3) Ubuntu based"
echo "q) Quit"
echo

read -rp "Enter choice: " choice

# Handle quit first
if [[ "$choice" == "q" || "$choice" == "Q" ]]; then
    echo "Exiting."
    exit 0
fi

# Only ask for sudo if updating
sudo -v

# Keep sudo alive while the script runs
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

update_arch_binary() {
    echo "[1/2] Updating official repositories (binaries only)..."
    sudo pacman -Syu
    
    echo "[2/2] Removing orphans..."
    orphans=$(pacman -Qtdq)
    [[ -n "$orphans" ]] && sudo pacman -Rns $orphans
}

update_arch_full() {
    echo "[1/3] Full system update via yay..."
    yay -Syu
    
    echo "[2/3] Flatpak..."
    command -v flatpak >/dev/null 2>&1 && flatpak update -y
    
    echo "[3/3] Orphans..."
    orphans=$(pacman -Qtdq)
    [[ -n "$orphans" ]] && sudo pacman -Rns $orphans
}

update_ubuntu() {
    echo "[1/4] Updating package lists and upgrading packages..."
    sudo apt update && sudo apt upgrade -y

    echo "[2/4] Updating Flatpak apps..."
    if command -v flatpak >/dev/null 2>&1; then
        flatpak update -y
    else
        echo "Flatpak not installed — skipping."
    fi

    echo "[3/4] Removing unused packages..."
    sudo apt autoremove -y

    echo "[4/4] Cleaning package cache..."
    sudo apt autoclean -y
}

case "$choice" in
    1) update_arch_binary ;;
    2) update_arch_full ;;
    3) update_ubuntu ;;
    *) echo "Invalid"; exit 1 ;;
esac

echo
echo "✅ System fully updated."
