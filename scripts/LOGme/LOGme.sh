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
#      ▄    ▄▄                                             ▄ ▄ ▄ ▄
#    ▄██▀▀  ██ ██     ▄████▄  ▄████  ▄▄   ▄▄ ▄▄▄▄▄    ▄▄▄▄ ▀ ▀ ▀ ▀ ▄▄
#    ▀███▄  ██ ██     ██  ██ ██  ▄▄▄ ██▀▄▀██ ██▄▄    ██▀▀▀ ▄▄▄ ▄▄▄ ██
#    ▄▄██▀  ▄▄ ██████ ▀████▀  ▀███▀  ██   ██ ██▄▄▄   ▀████ ▄▄▄▄▄ ▄▄█▀
#      ▀
#                  A script to run when I... well, login
# =============================================================================
# Prerequisites:
# - OpenRGB installed and configured with a profile named `Home`
# - xcowsay installed (for the cow greeting)
#
# How to use this script:
# 1. Place this script in your login scripts directory
#    (e.g., ~/.config/autostart-scripts/),
#    or configure system settings to run this script at login
# 2. Make the script executable: chmod +x LOGme.sh
# =============================================================================

set -euo pipefail

# Trap to handle errors gracefully
trap 'echo "Error: Script failed on line $LINENO. Command: $BASH_COMMAND" >&2' ERR

# Function to check if required commands are available
check_dependencies() {
    local missing_deps=()

    if ! command -v openrgb &> /dev/null; then
        missing_deps+=("openrgb")
    fi

    if ! command -v xcowfortune &> /dev/null; then
        missing_deps+=("xcowfortune (from xcowsay package)")
    fi

    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo "Error: Missing required dependencies: ${missing_deps[*]}" >&2
        echo "Install with: sudo dnf install ${missing_deps[*]}" >&2
        exit 1
    fi
}

# Function to check if script is already set up for autostart
is_autostart_configured() {
    local script_path="$(realpath "$0")"

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

# Function to set up autostart
setup_autostart() {
    local script_path="$(realpath "$0")"
    local autostart_dir="$HOME/.config/autostart"
    local desktop_file="$autostart_dir/LOGme.desktop"

    # Create autostart directory if it doesn't exist
    mkdir -p "$autostart_dir"

    # Create .desktop file
    cat > "$desktop_file" << EOF
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

# Function to prompt for autostart setup
prompt_autostart_setup() {
    if is_autostart_configured; then
        echo "Script is already configured for autostart."
        return
    fi

    echo "Would you like to set up this script to run automatically at login? (y/N)"
    read -r response

    case "$response" in
        [Yy]|[Yy][Ee][Ss])
            setup_autostart
            ;;
        *)
            echo "Autostart setup skipped."
            ;;
    esac
}

# Main execution
main() {
    echo "Welcome! Setting up your login environment..."

    # Check dependencies
    check_dependencies

    # Prompt for autostart setup if not already configured
    prompt_autostart_setup

    # Set OpenRGB profile
    echo "Setting OpenRGB profile to 'Home'..."
    if ! openrgb -p Home; then
        echo "Warning: Failed to set OpenRGB profile. Continuing..." >&2
    fi

    # Show fortune with cow
    echo "Displaying login fortune..."
    if ! xcowfortune --time=0 --release; then
        echo "Warning: Failed to display fortune. Continuing..." >&2
    fi

    echo "Login setup complete!"
}

# Run main function
main
