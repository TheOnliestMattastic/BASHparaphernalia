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
#      ▄    ▄▄                                             ▄ ▄ ▄ ▄
#    ▄██▀▀  ██ ██     ▄████▄  ▄████  ▄▄   ▄▄ ▄▄▄▄▄    ▄▄▄▄ ▀ ▀ ▀ ▀ ▄▄
#    ▀███▄  ██ ██     ██  ██ ██  ▄▄▄ ██▀▄▀██ ██▄▄    ██▀▀▀ ▄▄▄ ▄▄▄ ██
#    ▄▄██▀  ▄▄ ██████ ▀████▀  ▀███▀  ██   ██ ██▄▄▄   ▀████ ▄▄▄▄▄ ▄▄█▀
#      ▀
#                  A script to run when I... well, login
# ==============================================================================
# WHAT: Initialize login environment with RGB control, terminal display, and autostart config
# WHY:  Centralize login setup and provide visual feedback during system initialization
# HOW:  Check dependencies, configure autostart, launch wezterm with RGB/fortune/cbonsai
# NOTE: Requires OpenRGB configured with 'Home' profile, wezterm and related tools installed
# ==============================================================================
set -euo pipefail

# ==============================================================================
# Error Handling
# ------------------------------------------------------------------------------
# WHAT: Catch and report runtime errors with context
# HOW:  Trap ERR signals and display line number and command that failed
# ==============================================================================
trap 'echo "Error: Script failed on line $LINENO. Command: $BASH_COMMAND" >&2' ERR

# ==============================================================================
# Dependency Checking
# ------------------------------------------------------------------------------
# WHAT: Verify all required tools are installed before proceeding
# HOW:  Check for each command with -v flag, collect missing ones
# ==============================================================================
check_dependencies() {
  local missing_deps=()

  if ! command -v openrgb &>/dev/null; then
    missing_deps+=("openrgb")
  fi

  if ! command -v wezterm &>/dev/null; then
    missing_deps+=("wezterm")
  fi

  if ! command -v fortune &>/dev/null; then
    missing_deps+=("fortune")
  fi

  if ! command -v cowsay &>/dev/null; then
    missing_deps+=("cowsay")
  fi

  if ! command -v bat &>/dev/null; then
    missing_deps+=("bat")
  fi

  if ! command -v cbonsai &>/dev/null; then
    missing_deps+=("cbonsai")
  fi

  if [ ${#missing_deps[@]} -ne 0 ]; then
    echo "Error: Missing required dependencies: ${missing_deps[*]}" >&2
    echo "Install with: sudo dnf install ${missing_deps[*]}" >&2
    exit 1
  fi
}

# ==============================================================================
# Autostart Configuration Check
# ------------------------------------------------------------------------------
# WHAT: Determine if autostart .desktop file has already been created
# HOW:  Check for .desktop file in ~/.config/autostart directory
# ==============================================================================
is_autostart_configured() {
  local script_path
  script_path="$(realpath "$0")"

  # Check KDE Plasma autostart-scripts directory
  if [ -f "$HOME/.config/autostart/$(basename "$script_path")" ]; then
    return 0
  fi

  # Check XDG autostart directory for .desktop files
  if [ -f "$HOME/.config/autostart/LOGme.desktop" ]; then
    return 0
  fi

  return 1
}

# ==============================================================================
# Autostart Setup
# ------------------------------------------------------------------------------
# WHAT: Create .desktop file for systemwide autostart on login
# HOW:  Write desktop entry to ~/.config/autostart/LOGme.desktop
# ==============================================================================
setup_autostart() {
  local script_path
  script_path="$(realpath "$0")"
  local autostart_dir="$HOME/.config/autostart"
  local desktop_file="$autostart_dir/LOGme.desktop"

  mkdir -p "$autostart_dir"

  cat >"$desktop_file" <<EOF
[Desktop Entry]
Type=Application
Name=LOGme
Exec=$script_path
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF

  echo "Autostart configured! Created: $desktop_file"
}

# ==============================================================================
# Autostart Setup Prompt
# ------------------------------------------------------------------------------
# WHAT: Interactively ask user if they want to configure autostart
# WHY:  Non-intrusive way to set up login behavior
# HOW:  Check if already configured, then prompt and call setup if approved
# ==============================================================================
prompt_autostart_setup() {
  if is_autostart_configured; then
    echo "Script is already configured for autostart."
    return
  fi

  echo "Would you like to set up this script to run automatically at login? (y/N)"
  read -r response

  case "$response" in
  [Yy] | [Yy][Ee][Ss])
    setup_autostart
    ;;
  *)
    echo "Autostart setup skipped."
    ;;
  esac
}

# ==============================================================================
# Main Execution
# ------------------------------------------------------------------------------
# WHAT: Orchestrate login initialization workflow
# WHY:  Centralize all startup tasks in logical sequence
# HOW:  Check dependencies, prompt autostart setup, launch wezterm with commands
# ==============================================================================
main() {
  echo "Welcome! Setting up your login environment..."

  check_dependencies
  prompt_autostart_setup

  # Configure terminal commands for split pane layout
  local right_pane_cmd='fortune | cowsay -r | bat -pp -l c; /home/mattastic/Projects/BashParaphernalia/scripts/MTrclone/MTrclone.sh; exec bash'
  local left_pane_cmd='openrgb -p Home; cbonsai -li; exec bash'

  echo "Launching login terminal..."
  if ! wezterm start -- bash -c "wezterm cli split-pane --right -- bash -c \"${right_pane_cmd}\"; ${left_pane_cmd}"; then
    echo "Warning: Failed to launch wezterm. Continuing..." >&2
  fi

  echo "Login setup complete!"
}

main
