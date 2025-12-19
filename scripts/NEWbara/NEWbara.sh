#!/usr/bin/env bash
# ==============================================================================
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
# ==============================================================================
# WHAT: Single-shot installer for DNF and Flatpak packages on Nobara
# WHY:  Automate personal system setup with customizable package lists
# HOW:  Parse command-line options, load packages, install via package managers with verification
# NOTE: Must run as regular user (not root/sudo) for --user Flatpak flag; password prompt expected
# ==============================================================================
set -e
trap 'echo "Error occurred at line $LINENO"' ERR

# ==============================================================================
# Dependency Checking
# ------------------------------------------------------------------------------
# WHAT: Verify required package managers are installed
# HOW:  Check for dnf, flatpak, and sudo availability
# ==============================================================================
for cmd in dnf flatpak sudo; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: $cmd not found. Please install it."
    exit 1
  fi
done

# ==============================================================================
# Visual Feedback Dependencies
# ------------------------------------------------------------------------------
# WHAT: Ensure cowsay and lolcat are available for the moo function
# HOW:  Install via DNF if not already present on system
# NOTE: These must be available before any other packages install for moo to work
# ==============================================================================
for tool in cowsay lolcat; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "Installing $tool for visual feedback..."
    sudo dnf --assumeyes --quiet install "$tool"
  fi
done

# ==============================================================================
# Help Functions
# ------------------------------------------------------------------------------
# WHAT: Display usage information for the script
# HOW:  Provide short reference and detailed help messages
# ==============================================================================
short_help() {
  echo "Usage: $0 -f flatpak_file.txt | -d dnf_file.txt [-S] [-n] [-h|--help]"
  echo "Options:"
  echo "  -f FILE     Load Flatpak packages from FILE (required, or -d)"
  echo "  -d FILE     Load DNF packages from FILE (required, or -f)"
  echo "  -S          Install Flatpaks system-wide"
  echo "  -n          Dry run (preview actions)"
  echo "  -h          Show this reference sheet"
  echo "  --help      Show detailed help"
}

print_help() {
  cat <<EOF
NAME
     NEWbara.sh - Install packages via DNF and Flatpak

SYNOPSIS
     ./NEWbara.sh (-d dnf_file.txt | -f flatpak_file.txt) [OPTIONS]

DESCRIPTION
     This script installs packages for Nobara systems using DNF and Flatpak package managers.
     At least one package configuration file must be provided (-d or -f).
     Flatpaks are installed user-specific by default (as recommended by the Nobara project wiki:
     https://wiki.nobara-project.org/Flatpak_Installation); use -S for system-wide.

OPTIONS
     -d FILE     Load DNF packages from FILE (one package per line; required or -f).
     -f FILE     Load Flatpak packages from FILE (one app ID per line; required or -d).
     -S          Install Flatpaks system-wide (default is user-specific).
     -n          Dry run: preview actions without making changes.
     -h          Display short reference sheet.
     --help      Display this detailed help message and exit.

EXAMPLES
     ./NEWbara.sh -d config/dnf-packages.txt
 	Install DNF packages from file.

     ./NEWbara.sh -f config/flatpak-packages.txt
 	Install Flatpak packages from file.

     ./NEWbara.sh -d config/dnf-packages.txt -f config/flatpak-packages.txt -S
 	Install both DNF and system-wide Flatpak packages.

     ./NEWbara.sh -f config/flatpak-packages.txt -n
 	Preview Flatpak installation without making changes.

FILES
     Package files should contain one package/app ID per line:
         htop
         lolcat
     
     Flatpak app IDs:
         org.videolan.VLC
         md.obsidian.Obsidian

AUTHOR
     Generated for personal use.

EOF
}

# ==============================================================================
# Command-Line Options
# ------------------------------------------------------------------------------
# WHAT: Parse and process user-provided command-line arguments
# HOW:  Use getopts to handle flags for files, dry-run, and flatpak scope
# NOTE: Requires at least one package file (-d or -f) to proceed
# ==============================================================================
flatpak_file=""
dnf_file=""
system_flatpak=false
dry_run=false
log_file="NEWbara_$(date +%Y%m%d_%H%M%S).log"

if [[ $1 == "--help" ]]; then
  print_help
  exit 0
fi

while getopts "f:d:hSn" opt; do
  case $opt in
  f) flatpak_file="$OPTARG" ;;
  d) dnf_file="$OPTARG" ;;
  S) system_flatpak=true ;;
  n) dry_run=true ;;
  h)
    short_help
    exit 0
    ;;
  *)
    echo "Usage: $0 -f flatpak_file.txt | -d dnf_file.txt [-S] [-n] [-h|--help]" >&2
    exit 1
    ;;
  esac
done

# ==============================================================================
# Validate Required Arguments
# ------------------------------------------------------------------------------
# WHAT: Ensure at least one package configuration file was provided
# HOW:  Check if both variables are empty; exit with error if so
# ==============================================================================
if [ -z "$dnf_file" ] && [ -z "$flatpak_file" ]; then
  echo "Error: At least one package file must be provided (-d or -f)" >&2
  short_help
  exit 1
fi

# ==============================================================================
# Logging Setup
# ------------------------------------------------------------------------------
# WHAT: Redirect output to both terminal and log file
# HOW:  Use tee to duplicate stdout/stderr streams
# ==============================================================================
exec > >(tee \"$log_file\") 2>&1

# ==============================================================================
# Package List Loading from Configuration Files
# ------------------------------------------------------------------------------
# WHAT: Load package lists from provided configuration files
# HOW:  Use mapfile to read package names from text files (one per line)
# NOTE: Arrays remain empty if file not provided; script validates files exist
# ==============================================================================
DNF_PKGS=()
FLAT_PKGS=()

if [ -n "$dnf_file" ]; then
  if [ ! -f "$dnf_file" ]; then
    echo "Error: DNF package file not found: $dnf_file" >&2
    exit 1
  fi
  mapfile -t DNF_PKGS <"$dnf_file"
fi

if [ -n "$flatpak_file" ]; then
  if [ ! -f "$flatpak_file" ]; then
    echo "Error: Flatpak package file not found: $flatpak_file" >&2
    exit 1
  fi
  mapfile -t FLAT_PKGS <"$flatpak_file"
fi

# ==============================================================================
# Message Display Function
# ------------------------------------------------------------------------------
# WHAT: Display messages with colorful cowsay and lolcat formatting
# WHY:  Provide visual feedback to user while maintaining log file output
# HOW:  Pipe message through cowsay and lolcat; guaranteed available via early install
# ==============================================================================
moo() {
  local msg="$1"
  echo "$msg" >>"$log_file"
  echo "$msg" | cowsay -r | lolcat >/dev/tty
}

# ==============================================================================
# Sudo Verification
# ------------------------------------------------------------------------------
# WHAT: Ensure sudo is available before package installation
# HOW:  Check for sudo command and exit if missing
# ==============================================================================
if ! command -v sudo >/dev/null 2>&1; then
  moo "sudo not found. Please install sudo."
  exit 1
fi

# ==============================================================================
# DNF Package Installation
# ------------------------------------------------------------------------------
# WHAT: Install all DNF packages from the configured list
# HOW:  Iterate through package list, simulate in dry-run, execute otherwise
# NOTE: Skips DNF installation if no DNF file was provided
# ==============================================================================
if [ ${#DNF_PKGS[@]} -gt 0 ]; then
  for pkg in "${DNF_PKGS[@]}"; do
    moo "Installing dnf package: $pkg..."
    if [ "$dry_run" = true ]; then
      moo "[DRY RUN] Would run: sudo dnf --assumeyes --quiet install $pkg"
    else
      sudo dnf --assumeyes --quiet install "$pkg"
    fi
  done
  moo "DNF packages installed!"
fi

# ==============================================================================
# Flatpak Repository Setup & Installation
# ------------------------------------------------------------------------------
# WHAT: Configure Flathub and install Flatpak applications from file
# HOW:  Add Flathub remote if needed, then iterate through package list
# NOTE: Skips Flatpak installation if no Flatpak file was provided
# ==============================================================================
if [ ${#FLAT_PKGS[@]} -gt 0 ]; then
  flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

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
        flatpak install --system --assumeyes flathub "$pkg" || echo "Warning: Issue with $pkg (possibly already installed), continuing..."
      else
        flatpak install --user --assumeyes flathub "$pkg" || echo "Warning: Issue with $pkg (possibly already installed), continuing..."
      fi
    fi
  done

  moo "Flatpaks installed!"
fi

# ==============================================================================
# System Cleanup
# ------------------------------------------------------------------------------
# WHAT: Remove unused package manager runtimes and orphaned packages
# WHY:  Reclaim disk space and maintain system cleanliness
# HOW:  Use package manager cleanup commands for installed packages
# NOTE: Cleanup only runs if at least one package manager was used and not in dry-run mode
# ==============================================================================
if [ "$dry_run" = false ]; then
  moo "Starting cleanup process..."

  if [ ${#FLAT_PKGS[@]} -gt 0 ]; then
    moo "Removing orphaned flatpak runtimes and extensions..."
    if [ "$system_flatpak" = true ]; then
      flatpak uninstall --assumeyes --unused
    else
      flatpak uninstall --user --assumeyes --unused
    fi
    moo "Orphaned flatpak runtimes and extensions removed"
  fi

  if [ ${#DNF_PKGS[@]} -gt 0 ]; then
    moo "Removing orphaned dnf packages..."
    sudo dnf autoremove --assumeyes --quiet
    moo "Orphaned dnf packages removed."
  fi

  moo "Cleanup successful! All tasks completed!"
else
  moo "[DRY RUN] Skipping cleanup process"
fi
