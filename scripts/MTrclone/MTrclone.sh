#!/usr/bin/env bash
# =============================================================================
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
#          A script to mount my cloud drives via rclone
# =============================================================================
# Prerequisites:
# - RCLONE MUST BE INSTALLED AND CONFIGURED WITH REMOTES NAMED `OneDrive`,
#   `GoogleDrive`, AND `Dropbox`
# - Local mount directories must be empty or non-existent
#
# How to use this script:
# 1. Make the script executable: chmod +x MTrclone.sh
# 2. Run the script: ./MTrclone.sh
# Pro tip:
# - You may want to set this script to run at login for convenience by placing
#   it in your login scripts directory (e.g., ~/.config/autostart-scripts/) or
#   configuring system settings to run this script at login.
# =============================================================================
set -eu
# Reminder: set -eu means exit on any error (e) and undefined variables (u).
# Helps catch mistakes early!

# Check for required commands
command -v rclone >/dev/null 2>&1 || { echo "Error: rclone is not installed."; exit 1; }
command -v findmnt >/dev/null 2>&1 || { echo "Error: findmnt is not installed."; exit 1; }
command -v cowsay >/dev/null 2>&1 || { echo "Error: cowsay is not installed."; exit 1; }

# Cleanup function to kill background rclone processes on exit
# Reminder: Trap on ERR ensures background rclone processes are killed
# if anything fails - prevents zombie processes!
cleanup() {
    [ -n "$ONEDRIVE_PID" ] && kill "$ONEDRIVE_PID" 2>/dev/null || true
    [ -n "$GOOGLEDRIVE_PID" ] && kill "$GOOGLEDRIVE_PID" 2>/dev/null || true
    [ -n "$DROPBOX_PID" ] && kill "$DROPBOX_PID" 2>/dev/null || true
}
trap cleanup ERR

# Define mount directories
ONEDRIVE="/home/mattastic/OneDrive"
GOOGLEDRIVE="/home/mattastic/GoogleDrive"
DROPBOX="/home/mattastic/Dropbox"

# Safely create directories with `mkdir -p` if they don't exist
mkdir -p "$ONEDRIVE"
mkdir -p "$GOOGLEDRIVE"
mkdir -p "$DROPBOX"

# Mount directories using rclone
# Reminder: & runs commands in background so script doesn't wait - $! captures process ID for cleanup!
rclone --vfs-cache-mode full mount OneDrive: "$ONEDRIVE" &
ONEDRIVE_PID=$!
rclone --vfs-cache-mode full mount GoogleDrive: "$GOOGLEDRIVE" &
GOOGLEDRIVE_PID=$!
rclone --vfs-cache-mode full mount Dropbox: "$DROPBOX" &
DROPBOX_PID=$!

# Wait for mounts to establish
sleep 45s

# Create array and track failures
failures=()

# Reminder: ! findmnt checks if mount exists - if not, add to failures list
! findmnt -M "$ONEDRIVE" && failures+=("OneDrive")
! findmnt -M "$GOOGLEDRIVE" && failures+=("GoogleDrive")
! findmnt -M "$DROPBOX" && failures+=("Dropbox")

# Reminder: Conditional notifications tell you exactly what worked or failed - check the cow messages!
if [ ${#failures[@]} -eq 0 ]; then
	cowsay -r "Mooooooo!: OneDrive, GoogleDrive, and Dropbox successfully mounted!" | bat -pp -l c &
elif [ ${#failures[@]} -eq 1 ]; then
	cowsay -r --time=0 --release "I am Error: ${failures[0]} failed to connect!" | bat -pp -l c &
elif [ ${#failures[@]} -eq 2 ]; then
	cowsay -r --time=0 --release "I am Error: ${failures[0]} and ${failures[1]} failed to connect!" | bat -pp -l c &
else
	cowsay -r --time=0 --release "I am Error: All drives failed to connect!" | bat -pp -l c &
fi
