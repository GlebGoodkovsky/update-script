# Update Script (US)

A simple versatile Bash script designed to automate system updates across Linux distros. Provides a unified interface with two Arch modes (fast vs full) and Ubuntu support.

---

## Features  
- **Multi-Distro Support:** Two Arch modes + Ubuntu/Debian workflows
- **Sudo Management:** Automatically keeps your `sudo` session alive during long updates
- **Arch (binaries only):**
  - `pacman -Syu` + orphan cleanup (fast, no compiling)
- **Arch (full compile):**
  - `yay -Syu` + Flatpak + orphans (complete system refresh)
- **Ubuntu-based Workflow:**
  - Updates package lists and upgrades via `apt`
  - Removes unused packages with `autoremove`
  - Cleans package cache with `autoclean`

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
- `1`: **Arch (binaries only)** — `pacman -Syu` + orphan cleanup (fast, no compiling)
- `2`: **Arch (with AUR compiling)** — `yay -Syu` + Flatpak + orphan cleanup (full system)
- `3`: **Ubuntu based** — `apt update/upgrade + autoremove + autoclean`
- `q`: **Quit** — Exit safely

---

## Warnings and Reminders

### AUR Compiling (Option 2 only)
**Expect high CPU usage:** AUR packages compile from source:
- Large packages (browsers, IDEs) can take 1-2+ hours
- Normal for rolling releases after library upgrades
- Use Option 1 daily, Option 2 weekly/monthly

### AUR (Arch User Repository)
AUR packages are user-maintained. While this script automates the update process via `yay`, remember:
- AUR packages are not officially supported by Arch Linux.
- Always review PKGBUILDs if you are unsure of a package's source.
- Updates can occasionally require manual intervention.

### System Responsibility
> "It is the *user* who is ultimately responsible for the stability of their own rolling release system." 
> — [Arch Wiki FAQ](https://wiki.archlinux.org/title/Frequently_asked_questions), Section 1.10

---
