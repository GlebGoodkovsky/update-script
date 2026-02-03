# Update Script (US)

A simple versatile Bash script designed to automate system update across Linux distros. Provides a unified interface to update packages, handle AUR dependencies, and perform system cleanup.

---

## Features  
- **Multi-Distro Support:** Dedicated workflows for Arch-based and Ubuntu/Debian-based systems.
- **Sudo Management:** Automatically keeps your `sudo` session alive in the background so you don't have to re-enter your password during long updates.
- **Arch-based Workflow:** 
    - Updates official repositories via `pacman`.
    - Updates AUR packages via `yay` (if installed).
    - Automatically detects and removes orphaned dependencies.
- **Ubuntu-based Workflow:**
    - Updates package lists and upgrades all software via `apt`.
    - Runs `autoremove` to delete unnecessary packages.
    - Runs `autoclean` to clear out the local repository of retrieved package files.

---

## Prerequisites  

### For Arch-based systems:
- `pacman` (standard)
- `yay` (optional, for AUR support)

### For Ubuntu-based systems:
- `apt` (standard)

---

## Installation  

1. **Clone the repository**
```bash
git clone https://github.com/GlebGoodkovsky/update-script.git
cd update-script
```

2. **Make the script executable**
```bash
chmod +x update-script.sh
```
---

## Usage  

Run the script:
```bash
./update-script.sh
```


### Menu Options:
- `1`: **Arch based** — Runs pacman, yay, and orphan cleanup.
- `2`: **Ubuntu based** — Runs apt update, upgrade, autoremove, and autoclean.
- `q`: **Quit** — Exit the script safely.

---

## Warnings and Reminders

### AUR (Arch User Repository)
AUR packages are user-maintained. While this script automates the update process via `yay`, remember:
- AUR packages are not officially supported by Arch Linux.
- Always review PKGBUILDs if you are unsure of a package's source.
- Updates can occasionally require manual intervention.

### System Responsibility
> "It is the *user* who is ultimately responsible for the stability of their own rolling release system." 
> — [Arch Wiki FAQ](https://wiki.archlinux.org/title/Frequently_asked_questions), Section 1.10

---