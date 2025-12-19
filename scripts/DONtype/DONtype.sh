#!/usr/bin/env bash
# ==============================================================================
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
# ==============================================================================
# WHAT: Automatically bind in-game commands to function keys for Schedule I
# WHY:  Eliminate repetitive manual key-binding setup in-game
# HOW:  Use xdotool to type binding commands with controlled timing and delays
# NOTE: Requires 5-second wait to switch to game; take ~30s total; ensure safe location
# ==============================================================================
set -euo pipefail

# ==============================================================================
# Cleanup Handler
# ------------------------------------------------------------------------------
# WHAT: Gracefully handle script interruption or completion
# HOW:  Trap EXIT signal and display completion message
# ==============================================================================
cleanup() {
  echo "Script interrupted or completed. Exiting."
}
trap cleanup EXIT

# ==============================================================================
# Dependency Checking
# ------------------------------------------------------------------------------
# WHAT: Verify xdotool is installed before proceeding
# HOW:  Check for command availability, report missing deps with install instructions
# ==============================================================================
check_dependencies() {
  local missing_deps=()

  if ! command -v xdotool &>/dev/null; then
    missing_deps+=("xdotool")
  fi

  if [ ${#missing_deps[@]} -ne 0 ]; then
    echo "Error: Missing required dependencies: ${missing_deps[*]}"
    echo "Install with: sudo dnf install ${missing_deps[*]}"
    exit 1
  fi
}

# ==============================================================================
# Command Binding
# ------------------------------------------------------------------------------
# WHAT: Type a binding command into the game and confirm with Enter keypress
# WHY:  Automate manual repetitive in-game command entry with consistent timing
# HOW:  Use xdotool to type command string, pause, press Enter, pause for game processing
# ==============================================================================
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

# ==============================================================================
# Main Execution
# ------------------------------------------------------------------------------
# WHAT: Orchestrate full keybinding setup workflow
# WHY:  Centralize all initialization and binding logic
# HOW:  Countdown to game window, declare bindings, apply each, report results
# ==============================================================================
main() {
  echo "DONtype: Setting up keybindings for Schedule I..."
  echo "Switch to the game window now. Starting in 5 seconds..."

  # Countdown to allow user to switch to game window
  for i in {5..1}; do
    echo "$i..."
    sleep 1
  done

  echo "Starting keybinding setup..."

  # Declare associative array of function key bindings
  declare -A bindings=(
    ["f1"]="~bind f1 teleport motelroom"   # F1: Teleport to the Motel Room
    ["f2"]="~bind f2 teleport sweatshop"   # F2: Teleport to the Sweatshop
    ["f3"]="~bind f3 teleport storageunit" # F3: Teleport to the Storage Unit
    ["f4"]="~bind f4 teleport bungalow"    # F4: Teleport to the Bungalow
    ["f5"]="~bind f5 teleport barn"        # F5: Teleport to the Barn
    ["f6"]="~bind f6 teleport docks"       # F6: Teleport to the Docks
    ["f7"]="~bind f7 teleport laundromat"  # F7: Teleport to the Laundromat
    ["f8"]="~bind f8 teleport postoffice"  # F8: Teleport to the Post Office
    ["f9"]="~bind f9 teleport church"      # F9: Teleport to the Church
    ["f10"]="~bind f10 changebalance 1000" # F10: Add $1000 to your balance
    ["f11"]="~bind f11 cleartrash"         # F11: Clear out the trash
    ["f12"]="~bind f12 clearinventory"     # F12: Clear your inventory
  )

  local failed_bindings=()

  # Iterate through bindings and apply each one, tracking failures
  for key in "${!bindings[@]}"; do
    if ! bind_command "$key" "${bindings[$key]}"; then
      failed_bindings+=("$key")
    fi
  done

  # Report success or failures
  if [ ${#failed_bindings[@]} -eq 0 ]; then
    echo "All keybindings set successfully!"
  else
    echo "Warning: Failed to bind the following keys: ${failed_bindings[*]}"
    echo "You may need to retry or check for interruptions."
  fi

  echo "Setup complete. Enjoy your game!"
}

check_dependencies
main
