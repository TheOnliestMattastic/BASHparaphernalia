#!/usr/bin/env bash
# =============================================================================
#    ██████ ▄▄ ▄▄ ▄▄▄▄▄   ▄████▄ ▄▄  ▄▄ ▄▄    ▄▄ ▄▄▄▄▄  ▄▄▄▄ ▄▄▄▄▄▄
#      ██   ██▄██ ██▄▄    ██  ██ ███▄██ ██    ██ ██▄▄  ███▄▄   ██
#      ██   ██ ██ ██▄▄▄   ▀████▀ ██ ▀██ ██▄▄▄ ██ ██▄▄▄ ▄▄██▀   ██
#
#    ▄   ██▄  ▄██ ▄████▄ ██████ ██████ ▄████▄ ▄█████ ██████ ██ ▄█████
#     ▀▄ ██ ▀▀ ██ ██▄▄██   ██     ██   ██▄▄██ ▀▀▀▄▄▄   ██   ██ ██
#    ▄▀  ██    ██ ██  ██   ██     ██   ██  ██ █████▀   ██   ██ ▀█████
#
#                           presents,
#   ▄    ▄▄                                                      ▄
# ▄██▀▀  ██ ███  ██ ██████ ██     ██ ▄▄▄▄   ▄▄▄  ▄▄▄▄   ▄▄▄    ▄█▀  ▄▄▄    ▄
# ▀███▄  ██ ██ ▀▄██ ██▄▄   ██ ▄█▄ ██ ██▄██ ██▀██ ██▄█▄ ██▀██   ██  ██▀██    ▀▄
# ▄▄██▀  ▄▄ ██   ██ ██▄▄▄▄  ▀██▀██▀  ██▄█▀ ██▀██ ██ ██ ██▀██   ▀█▄ ▀███▀   ▄▀
#   ▀                                                            ▀
#          A single-shot installer for my personal Nobara system
# =============================================================================
# Prerequisites:
# - MUST RUN AS REGULAR USER (NOT SUDO/ROOT) TO USE THE `--user` FLATPAK FLAG
# - You will still be prompted for your password for dnf installs
# - This script is licensed under the GNU General Public License v3.0
#
# How to use this script:
# 1. (Optional) Edit the package lists below or provide files with -d, -f, -s flags.
# 2. Make the script executable: chmod +x ./NEWbara.sh
# 3. Run the script: ./NEWbara.sh [-d dnf_packages.txt] [-f flatpak_packages.txt] 
# =============================================================================

# --- Script safety net ---
# Stop the script immediately if any command fails and trap for error handling
set -e
trap 'echo "Error occurred at line $LINENO"' ERR

# --- Dependency Check ---
# Before we start, let's make sure you have all the necessary tools.
# This loop checks for dnf, flatpak, , and sudo.
for cmd in dnf flatpak sudo; do
   if ! command -v "$cmd" >/dev/null 2>&1; then
      echo "Error: $cmd not found. Please install it."
      exit 1
   fi
done

# --- Help Functions ---
# Need a quick reminder of how to use this script? This function is for you.
short_help() {
   echo "Usage: $0 [-f flatpak_file.txt] [-d dnf_file.txt] [-S] [-n] [-h|--help]"
   echo "Options:"
   echo "  -f FILE     Load Flatpak packages from FILE"
   echo "  -d FILE     Load DNF packages from FILE"
   echo "  -S          Install Flatpaks system-wide"
   echo "  -n          Dry run (preview actions)"
   echo "  -h          Show this reference sheet"
   echo "  --help      Show detailed help"
}

# For when you need more than just a quick reminder.
print_help() {
   cat <<EOF
NAME
    NEWbara.sh - Install packages via DNF, Flatpak, and Snap

SYNOPSIS
    ./NEWbara.sh [OPTIONS]

DESCRIPTION
    This script installs a curated set of packages for Nobara systems using DNF, Flatpak, and Snap.
    Flatpaks are installed user-specific by default (as recommended by the Nobara project wiki: https://wiki.nobara-project.org/Flatpak_Installation); use -S for system-wide.
    It can also load custom package lists from text files.

OPTIONS
    -d FILE     Load DNF packages from FILE (one package per line).
    -f FILE     Load Flatpak packages from FILE (one app ID per line).
    -S          Install Flatpaks system-wide (default is user-specific).
    -n          Dry run: preview actions without making changes.
    -h          Display short reference sheet.
    --help      Display this detailed help message and exit.

EXAMPLES
    ./NEWbara.sh
	Install default packages (user Flatpaks).

    ./NEWbara.sh -S
	Install default packages with system-wide Flatpaks.

    ./NEWbara.sh -f my_flatpaks.txt
	Install default DNF/Snap packages and custom user Flatpaks from my_flatpaks.txt.

    ./NEWbara.sh -d custom_dnf.txt -s custom_snaps.txt -S
	Install custom DNF/Snap packages and default system-wide Flatpaks.

    ./NEWbara.sh -n
	Preview default installations without making changes.

FILES
    Package files should contain one package/app per line, e.g.:
	org.videolan.VLC
	htop

AUTHOR
    Generated for personal use.

EOF
}

# --- Command-Line Options ---
# Setting up the variables we'll use to store your choices.
flatpak_file=""
snap_file=""
dnf_file=""
system_flatpak=false
dry_run=false
# Create a log file with a timestamp to keep track of what happens.
log_file="NEWbara_$(date +%Y%m%d_%H%M%S).log"

# If you ask for help, we'll show it and then stop.
if [[ $1 == "--help" ]]; then
   print_help
   exit 0
fi

# This loop goes through the options you provide when you run the script.
while getopts "f:s:d:hSn" opt; do
   case $opt in
   f) flatpak_file="$OPTARG" ;; # Use a custom list of Flatpaks
   d) dnf_file="$OPTARG" ;;     # Use a custom list of DNF packages
   S) system_flatpak=true ;;    # Install Flatpaks for all users
   n) dry_run=true ;;           # Just show what would be done, don't actually do it
   h)
      short_help
      exit 0
      ;; # Show the quick help
   *)
      echo "Usage: $0 [-f flatpak_file.txt] [-d dnf_file.txt] [-S] [-n] [-h|--help]" >&2
      exit 1
      ;; # If you use an unknown option
   esac
done

# --- Logging Setup ---
# This line sends command output to both the screen and the log file.
exec > >(tee \"$log_file\") 2>&1

# ---------------------------- CONFIGURATION -------------------------------
# --- DNF Packages ---
# This is your shopping list for dnf. Add or remove packages here.
DNF_PKGS=(
   lolcat
   cowsay
   rclone
   syncthing
   shfmt
   shellcheck
   nodejs-bash-language-server 
   nvtop
   htop
   cbonsai
   piper
   tealdeer
   psutils
   toilet
   figlet
   xcowsay
   xdotool
   neovim
   love
   bat
)

# --- Flatpak Packages ---
# Same as above, but for Flatpaks. Use the full app ID.
FLAT_PKGS=(
   "md.obsidian.Obsidian"
   "com.super_productivity.SuperProductivity"
   "io.github.nokse22.asciidraw"
   "org.videolan.VLC"
   "org.kde.krita"
   "org.godotengine.Godot"
   "org.libretro.RetroArch"
   "eu.betterbird.Betterbird"
   "org.bleachbit.BleachBit"
   "org.keepassxc.KeePassXC"
   "com.spotify.Client"
)

# --- Loading Custom Package Lists ---
# If you provided a file for dnf packages, we'll use that instead of the list above.
if [ -n "$dnf_file" ]; then
   mapfile -t DNF_PKGS <"$dnf_file"
fi
# Same for Flatpaks.
if [ -n "$flatpak_file" ]; then
   mapfile -t FLAT_PKGS <"$flatpak_file"
fi

# ------------------------ END OF CONFIGURATION ----------------------------
# --- Fun Message Function ---
# It checks if you have cowsay and lolcat installed and uses them if you do.
moo() {
   local msg="$1"
   # Log plain message
   echo "$msg" >>"$log_file"
   # Fun output to terminal
   if command -v cowsay >/dev/null 2>&1 && command -v lolcat >/dev/null 2>&1; then
      echo "$msg" | cowsay -r | lolcat >/dev/tty # bypass stdout pipe to preserve colors in terminal
   elif command -v lolcat >/dev/null 2>&1; then
      echo "$msg" | lolcat >/dev/tty # bypass stdout pipe to preserve colors in terminal
   elif command -v cowsay >/dev/null 2>&1; then
      echo "$msg" | cowsay -r >/dev/tty # bypass stdout pipe
   else
      echo "$msg" >/dev/tty
   fi
}

# --- Sudo Check ---
# We need sudo to install some things. Let's make sure it's available.
if ! command -v sudo >/dev/null 2>&1; then
   moo "sudo not found. Please install sudo."
   exit 1
fi

# --- DNF Package Installation ---
# Time to install the dnf packages from your list.
for pkg in "${DNF_PKGS[@]}"; do
   moo "Installing dnf package: $pkg..."
   if [ "$dry_run" = true ]; then
      moo "[DRY RUN] Would run: sudo dnf --assumeyes --quiet install $pkg"
   else
      # This is where the magic happens for dnf.
      sudo dnf --assumeyes --quiet install "$pkg"
   fi
done

moo "DNF packages installed!"

# --- Flatpak Setup ---
# We need to make sure the Flathub repository is set up for the user.
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# --- Flatpak Installation ---
# Now, let's install the Flatpaks from your list.
for pkg in "${FLAT_PKGS[@]}"; do
   moo "Installing flatpak: $pkg..."
   if [ "$dry_run" = true ]; then
      if [ "$system_flatpak" = true ]; then
         moo "[DRY RUN] Would run: flatpak install --assumeyes flathub $pkg"
      else
         moo "[DRY RUN] Would run: flatpak install --user --assumeyes flathub $pkg"
      fi
   else
      if [ "$system_flatpak" = true ]; then
         # Installing for all users.
         flatpak install --system --assumeyes flathub "$pkg" || echo "Warning: Issue with $pkg (possibly already installed), continuing..."
      else
         # Installing just for you.
         flatpak install --user --assumeyes flathub "$pkg" || echo "Warning: Issue with $pkg (possibly already installed), continuing..."
      fi
   fi
done

moo "Flatpaks installed!"

# --- Snap Package Installation ---
# Finally, the Snap packages.
for pkg in "${SNAP_PKGS[@]}"; do
   moo "Installing snap package: $pkg..."
   if [ "$dry_run" = true ]; then
      moo "[DRY RUN] Would run: sudo snap install $pkg"
   else
      # Installing the snap.
      sudo snap install "$pkg"
   fi
done

moo "Snap packages installed. Installation complete!"

# --- Cleanup ---
# Let's tidy up a bit.
moo "Starting cleanup process..."

# Remove unused Flatpak runtimes.
moo "Removing orphaned flatpak runtimes and extensions..."
if [ "$system_flatpak" = true ]; then
   flatpak uninstall --assumeyes --unused
else
   flatpak uninstall --user --assumeyes --unused
fi

moo "Orphaned flatpak runtimes and extensions removed"

# Remove disabled Snap packages.
moo "Removing orphaned snap packages..."
for orphan in $(snap list --all | awk '$6 == "disabled" {print $1}'); do
   snap remove --purge --yes "$orphan"
done

moo "Orphaned snap packages removed"

# Remove dnf packages that are no longer needed.
moo "Removing orphaned dnf packages..."
sudo dnf autoremove --assumeyes --quiet

moo "Orphaned dnf packages removed. Cleanup successful!"

moo "All tasks completed! Enjoy your setup!"
