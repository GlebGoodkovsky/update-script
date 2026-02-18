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
echo "1) Arch based"
echo "2) Ubuntu based"
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

update_arch() {
    echo "[1/4] Updating official repositories..."
    sudo pacman -Syu --noconfirm

    echo "[2/4] Updating AUR packages via yay..."
    if command -v yay >/dev/null 2>&1; then
        yay -Sua --noconfirm
    else
        echo "yay not installed — skipping AUR updates."
    fi

    echo "[3/4] Updating Flatpak apps..."
    if command -v flatpak >/dev/null 2>&1; then
        flatpak update -y
    else
        echo "Flatpak not installed — skipping."
    fi

    echo "[4/4] Removing orphaned packages..."
    orphans=$(pacman -Qtdq)
    if [[ -n "$orphans" ]]; then
        sudo pacman -Rns $orphans --noconfirm
    else
        echo "Nothing to clean."
    fi
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
    1)
        echo "Running Arch update..."
        update_arch
        ;;
    2)
        echo "Running Ubuntu / Pop!_OS update..."
        update_ubuntu
        ;;
    *)
        echo "Invalid option."
        exit 1
        ;;
esac

echo
echo "✅ System fully updated."
