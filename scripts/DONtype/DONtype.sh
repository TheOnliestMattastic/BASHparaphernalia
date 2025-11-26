#!/usr/bin/env bash
# =============================================================================
#    ██████ ▄▄ ▄▄ ▄▄▄▄▄   ▄████▄ ▄▄  ▄▄ ▄▄    ▄▄ ▄▄▄▄▄  ▄▄▄▄ ▄▄▄▄▄▄
#      ██   ██▄██ ██▄▄    ██  ██ ███▄██ ██    ██ ██▄▄  ███▄▄   ██
#      ██   ██ ██ ██▄▄▄   ▀████▀ ██ ▀██ ██▄▄▄ ██ ██▄▄▄ ▄▄██▀   ██
#
#    ▄   ██▄  ▄██ ▄████▄ ██████ ██████ ▄▄▄   ▄▄▄▄ ▄▄▄▄▄▄ ▄▄  ▄▄▄▄
#     ▀▄ ██ ▀▀ ██ ██▄▄██   ██     ██  ██▀██ ███▄▄   ██   ██ ██▀▀▀
#    ▄▀  ██    ██ ██  ██   ██     ██  ██▀██ ▄▄██▀   ██   ██ ▀████
#
#                            presents,
#      ▄    ▄▄
#    ▄██▀▀  ██ ████▄  ▄████▄ ███  ██ ▄▄▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄  ▄▄▄▄▄
#    ▀███▄  ██ ██  ██ ██  ██ ██ ▀▄██   ██   ▀███▀ ██▄█▀ ██▄▄
#    ▄▄██▀  ▄▄ ████▀  ▀████▀ ██   ██   ██     █   ██    ██▄▄▄
#      ▀
# Automatically binds common in-game commands to function keys for Schedule I
# =============================================================================
# This script automates binding in-game commands to function keys.
# Run it, switch to your game, and it will handle the setup for you.
#
# How to use this script:
# 1. Ensure you have xdotool installed: `sudo dnf install xdotool`
# 2. Make this script executable: `chmod +x DONtype.sh`
# 3. Run this script, then quickly switch to the game window within 5 seconds.
# 4. Do not touch the keyboard or mouse while the script is running.
#
# Pro tip:
# - Create a desktop shortcut or alias to run this script quickly.
#
# Note:
# - This script takes about 30 seconds. Ensure your character is in a safe
#   location to avoid interruptions from NPCs.
# =============================================================================

set -euo pipefail

# This ensures the script exits cleanly if interrupted.
cleanup() {
    echo "Script interrupted or completed. Exiting."
}
trap cleanup EXIT

# This function checks if `xdotool` is installed, which is required for the
# script to type commands.
check_dependencies() {
    local missing_deps=()

    if ! command -v xdotool &> /dev/null; then
        missing_deps+=("xdotool")
    fi

    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo "Error: Missing required dependencies: ${missing_deps[*]}"
        echo "Install with: sudo dnf install ${missing_deps[*]}"
        exit 1
    fi
}

# This function binds a command to a specified function key by typing it into
# the game.
bind_command() {
    local key="$1"
    local command="$2"

    echo "Binding $key to: $command"

    if ! xdotool type --delay 100 "$command"; then
        echo "Error: Failed to type command for $key"
        return 1
    fi

    sleep 0.5

    if ! xdotool key Enter; then
        echo "Error: Failed to press Enter for $key"
        return 1
    fi

    sleep 0.5
}

# This is the main function that orchestrates the keybinding process.
main() {
    echo "DONtype: Setting up keybindings for Schedule I..."
    echo "Switch to the game window now. Starting in 5 seconds..."

    # 5-second countdown to allow you to switch to the game window.
    for i in {5..1}; do
        echo "$i..."
        sleep 1
    done

    echo "Starting keybinding setup..."

    # This is the list of keybindings to be set up. Each key is mapped to a
    # specific in-game command.
    declare -A bindings=(
        ["f1"]="~bind f1 teleport motelroom"      # F1: Teleport to the Motel Room
        ["f2"]="~bind f2 teleport sweatshop"     # F2: Teleport to the Sweatshop
        ["f3"]="~bind f3 teleport storageunit"   # F3: Teleport to the Storage Unit
        ["f4"]="~bind f4 teleport bungalow"      # F4: Teleport to the Bungalow
        ["f5"]="~bind f5 teleport barn"           # F5: Teleport to the Barn
        ["f6"]="~bind f6 teleport docks"         # F6: Teleport to the Docks
        ["f7"]="~bind f7 teleport laundromat"    # F7: Teleport to the Laundromat
        ["f8"]="~bind f8 teleport postoffice"    # F8: Teleport to the Post Office
        ["f9"]="~bind f9 teleport church"         # F9: Teleport to the Church
        ["f10"]="~bind f10 changebalance 1000" # F10: Add $1000 to your balance
        ["f11"]="~bind f11 cleartrash"         # F11: Clear out the trash
        ["f12"]="~bind f12 clearinventory"     # F12: Clear your inventory
    )

    local failed_bindings=()

    # This loop iterates through the keybindings and applies them.
    for key in "${!bindings[@]}"; do
        if ! bind_command "$key" "${bindings[$key]}"; then
            failed_bindings+=("$key")
        fi
    done

    # This checks if all bindings were successful and reports any failures.
    if [ ${#failed_bindings[@]} -eq 0 ]; then
        echo "All keybindings set successfully!"
    else
        echo "Warning: Failed to bind the following keys: ${failed_bindings[*]}"
        echo "You may need to retry or check for interruptions."
    fi

    echo "Setup complete. Enjoy your game!"
}

# Check for dependencies before running the main function.
check_dependencies

# Run the main function.
main
