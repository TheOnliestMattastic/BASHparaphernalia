#!/usr/bin/env bash
# ==============================================================================
#      ██████ ▄▄ ▄▄ ▄▄▄▄▄   ▄████▄ ▄▄  ▄▄ ▄▄    ▄▄ ▄▄▄▄▄  ▄▄▄▄ ▄▄▄▄▄▄
#        ██   ██▄██ ██▄▄    ██  ██ ███▄██ ██    ██ ██▄▄  ███▄▄   ██
#        ██   ██ ██ ██▄▄▄   ▀████▀ ██ ▀██ ██▄▄▄ ██ ██▄▄▄ ▄▄██▀   ██
#
#      ▄   ██▄  ▄██ ▄████▄ ██████ ██████ ▄▄▄   ▄▄▄▄ ▄▄▄▄▄▄ ▄▄  ▄▄▄▄
#       ▀▄ ██ ▀▀ ██ ██▄▄██   ██     ██  ██▀██ ███▄▄   ██   ██ ██▀▀▀
#      ▄▀  ██    ██ ██  ██   ██     ██  ██▀██ ▄▄██▀   ██   ██ ▀████
#
#                              presents,
#        ▄    ▄▄
#      ▄██▀▀  ██ ██▄  ▄██ ██████ ▄▄▄▄   ▄▄▄▄ ▄▄     ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄
#      ▀███▄  ██ ██ ▀▀ ██   ██   ██▄█▄ ██▀▀▀ ██    ██▀██ ███▄██ ██▄▄
#      ▄▄██▀  ▄▄ ██    ██   ██ ▄ ██ ██ ▀████ ██▄▄▄ ▀███▀ ██ ▀██ ██▄▄▄
#        ▀
#
#          ▄    ▄ ▄ ▄           ▄              ▄
#        █ ▀ █  ▄███▄   ▄     █ ▀ ▄▄   ▄     █ ▀     ▄▀▄ █   █     ▄
#       █ ▄▄▄ █ ▄▀█▀▄ ▄▀ ▀▄  █    ██ ▄▀ ▀▄  █ ▄▀▀▄  █ ▀ █ ▄   █  ▄▀ ▀▄
#      █   ▄   █  ▄         █   ▄▄█▀       █  ▀   ▀▀   █ ▀▄▀   █
#         ▀      ▀
# ==============================================================================
# WHAT: Mount cloud storage services (OneDrive, GoogleDrive, Dropbox) via rclone
# WHY:  Provide unified access to multiple cloud providers with automatic mounting
# HOW:  Use rclone with VFS cache to mount remotes, verify with findmnt, report status
# NOTE: Requires rclone configured with named remotes; mount directories must exist/be empty
# ==============================================================================
set -eu

# ==============================================================================
# Dependency Checking
# ------------------------------------------------------------------------------
# WHAT: Verify rclone, findmnt, and cowsay are installed
# HOW:  Check command availability and exit with error if missing
# ==============================================================================
command -v rclone >/dev/null 2>&1 || {
  echo "Error: rclone is not installed."
  exit 1
}
command -v findmnt >/dev/null 2>&1 || {
  echo "Error: findmnt is not installed."
  exit 1
}
command -v cowsay >/dev/null 2>&1 || {
  echo "Error: cowsay is not installed."
  exit 1
}

# ==============================================================================
# Cleanup Handler
# ------------------------------------------------------------------------------
# WHAT: Kill background rclone processes on exit or error
# WHY:  Prevent zombie processes and ensure clean shutdown
# HOW:  Trap ERR signal and terminate stored process IDs
# ==============================================================================
cleanup() {
  [ -n "$ONEDRIVE_PID" ] && kill "$ONEDRIVE_PID" 2>/dev/null || true
  [ -n "$GOOGLEDRIVE_PID" ] && kill "$GOOGLEDRIVE_PID" 2>/dev/null || true
  [ -n "$DROPBOX_PID" ] && kill "$DROPBOX_PID" 2>/dev/null || true
}
trap cleanup ERR

# ==============================================================================
# Mount Point Configuration
# ------------------------------------------------------------------------------
# WHAT: Define local directories where cloud services will be mounted
# HOW:  Create mount point paths and ensure directories exist
# ==============================================================================
ONEDRIVE="/home/mattastic/OneDrive"
GOOGLEDRIVE="/home/mattastic/GoogleDrive"
DROPBOX="/home/mattastic/Dropbox"

mkdir -p "$ONEDRIVE" "$GOOGLEDRIVE" "$DROPBOX"

# ==============================================================================
# Cloud Service Mounting
# ------------------------------------------------------------------------------
# WHAT: Launch rclone mount processes for each cloud storage service
# WHY:  Provide concurrent access to multiple remote services
# HOW:  Run rclone in background with VFS cache, capture process IDs for cleanup
# ==============================================================================
rclone --vfs-cache-mode full mount OneDrive: "$ONEDRIVE" &
ONEDRIVE_PID=$!
rclone --vfs-cache-mode full mount GoogleDrive: "$GOOGLEDRIVE" &
GOOGLEDRIVE_PID=$!
rclone --vfs-cache-mode full mount Dropbox: "$DROPBOX" &
DROPBOX_PID=$!

sleep 45s

# ==============================================================================
# Mount Verification
# ------------------------------------------------------------------------------
# WHAT: Verify successful mount and track any failures
# HOW:  Use findmnt to check for mounted filesystems, collect failures
# ==============================================================================
failures=()

! findmnt -M "$ONEDRIVE" && failures+=("OneDrive")
! findmnt -M "$GOOGLEDRIVE" && failures+=("GoogleDrive")
! findmnt -M "$DROPBOX" && failures+=("Dropbox")

# ==============================================================================
# Status Notification
# ------------------------------------------------------------------------------
# WHAT: Display mount results with appropriate cowsay message
# HOW:  Check failure count and display corresponding success/error message
# ==============================================================================
if [ ${#failures[@]} -eq 0 ]; then
  cowsay -r "Mooooooo!: OneDrive, GoogleDrive, and Dropbox successfully mounted!" | bat -pp -l c &
elif [ ${#failures[@]} -eq 1 ]; then
  cowsay -r --time=0 --release "I am Error: ${failures[0]} failed to connect!" | bat -pp -l c &
elif [ ${#failures[@]} -eq 2 ]; then
  cowsay -r --time=0 --release "I am Error: ${failures[0]} and ${failures[1]} failed to connect!" | bat -pp -l c &
else
  cowsay -r --time=0 --release "I am Error: All drives failed to connect!" | bat -pp -l c &
fi
