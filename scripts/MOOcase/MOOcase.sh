#!/usr/bin/env bash
#        ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄▄
#      ▄▄                                                                    ▄▄
#      ██   ██████ ▄▄ ▄▄ ▄▄▄▄▄   ▄████▄ ▄▄  ▄▄ ▄▄    ▄▄ ▄▄▄▄▄  ▄▄▄▄ ▄▄▄▄▄▄   ██
#      ██     ██   ██▄██ ██▄▄    ██  ██ ███▄██ ██    ██ ██▄▄  ███▄▄   ██     ██
#      ██     ██   ██ ██ ██▄▄▄   ▀████▀ ██ ▀██ ██▄▄▄ ██ ██▄▄▄ ▄▄██▀   ██     ██
#      ▀▀                                                                    ▀▀
#      ▄▄                                                                    ▄▄
#      ██   ▄   ██▄  ▄██ ▄████▄ ██████ ██████ ▄▄▄   ▄▄▄▄ ▄▄▄▄▄▄ ▄▄  ▄▄▄▄     ██
#      ██    ▀▄ ██ ▀▀ ██ ██▄▄██   ██     ██  ██▀██ ███▄▄   ██   ██ ██▀▀▀     ██
#      ██   ▄▀  ██    ██ ██  ██   ██     ██  ██▀██ ▄▄██▀   ██   ██ ▀████     ██
#      ▀▀                                                                    ▀▀
#                                   presents,
#      ▄▄     ▄    ▄▄                                                        ▄▄
#      ██   ▄██▀▀  ██ ██▄  ▄██ ▄████▄ ▄████▄  ▄▄▄▄  ▄▄▄   ▄▄▄▄ ▄▄▄▄▄         ██
#      ██   ▀███▄  ██ ██ ▀▀ ██ ██  ██ ██  ██ ██▀▀▀ ██▀██ ███▄▄ ██▄▄          ██
#      ██   ▄▄██▀  ▄▄ ██    ██ ▀████▀ ▀████▀ ▀████ ██▀██ ▄▄██▀ ██▄▄▄         ██
#      ▀▀     ▀                                                              ▀▀
#        ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄
#        ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀
#                                    ▄
#            ▄█████  ▄▄▄  ██     ██  ▀          █
#    ▄▀▀▄  █ ██     ██▀██ ██ ▄█▄ ██  ▄▄▄       █
#    ▀   ▀▀  ▀█████ ▀███▀  ▀██▀██▀  ▄ ▄▄▄▄▄   █
#               ▄ ▀█▀         ▄
#               █             █
#     rename first char of each dir or file with upper or lower case
# --------------------------------------------------------------------------
# GOAL: Changes the first letter of file or directory names to upper or lowercase.
# --------------------------------------------------------------------------
# HOW TO USE:
# 1. Make it runnable: chmod +x MOOcase.sh
# 2. Run it: ./MOOcase [options] [path]
#
#    OPTIONS:
#       -d : Only change directories (default).
#       -f : Only change files.
#       -u : Convert to uppercase (default is lowercase).
#       -p [path] : Set the target path. Defaults to the current directory.
# --------------------------------------------------------------------------

# Exit immediately if a command fails.
set -e

# Reports the line number and exit code if an error occurs.
trap 'echo "Error occurred on line $LINENO. Exit code: $?" >&2' ERR

# --- Fun Message Function ---
# This function displays messages using `cowsay` and `lolcat` if installed.
# If not, it prints a plain message.
# You can remove this function and replace `moo` with `echo` if you prefer.
moo() {
local msg="$1"
echo "$msg" >> "moo.log"
if [ -t 1 ]; then
if command -v cowsay >/dev/null 2>&1 && command -v lolcat >/dev/null 2>&1; then
  echo "$msg" | cowsay -r | lolcat
elif command -v lolcat >/dev/null 2>&1; then
  echo "$msg" | lolcat
elif command -v cowsay >/dev/null 2>&1; then
  echo "$msg" | cowsay -r
else
  echo "$msg"
		fi
	fi
}

# --- Configuration ---

# Set the default path to the current directory.
DEFAULT_PATH="$PWD"

# Set the default mode to directories.
MODE="dirs"

# Set the default case conversion to lowercase.
CASE_MODE="lower"

# --- Argument Parsing ---

# Parse the command-line options.
while getopts "p:d:f:u" opt; do
  case $opt in
  # -p: Set the path.
  p)
    DEFAULT_PATH="$OPTARG"
    ;;
  # -d: Set the mode to directories.
  d)
    MODE="dirs"
    ;;
  # -f: Set the mode to files.
  f)
    MODE="files"
    ;;
  # -u: Set the case mode to uppercase.
  u)
    CASE_MODE="upper"
    ;;
  # Handle invalid options.
  *)
    moo "I am Error: Invalid Option $OPTARG. Use -p for path, -d for dirs, -f for files, or -u for uppercase"
    exit 1
    ;;
  esac
done

# --- Path Validation ---

# Check if the specified path exists and is a directory.
if [ ! -d "$DEFAULT_PATH" ]; then
  moo "I am Error: Path \'$DEFAULT_PATH\' does not exist or is not a directory."
  exit 1
fi

# --- Execution ---

# Change to the specified directory.
cd "$DEFAULT_PATH" || exit 1
moo "Changed directory to \`$DEFAULT_PATH\`. Starting rename process..."

# --- Main Loop ---

# Loop through each item in the directory.
for item in *; do

  # Check if the item should be renamed based on the selected mode.
  if [ "$MODE" = "dirs" ] && [ -d "$item" ]; then

    # `sed` converts the first character based on case mode.
    if [ "$CASE_MODE" = "upper" ]; then
      newname=$(echo "$item" | sed -E 's/^(.)/\U\1/')
    else
      newname=$(echo "$item" | sed -E 's/^(.)/\L\1/')
    fi

    # Rename the item only if the new name is different.
    [ "$item" != "$newname" ] && mv -v "$item" "$newname"

  # This is a file and we are in 'files' mode.
  elif [ "$MODE" = "files" ] && [ -f "$item" ]; then

    # `sed` converts the first character based on case mode.
    if [ "$CASE_MODE" = "upper" ]; then
      newname=$(echo "$item" | sed -E 's/^(.)/\U\1/')
    else
      newname=$(echo "$item" | sed -E 's/^(.)/\L\1/')
    fi

    # Rename the item only if the new name is different.
    [ "$item" != "$newname" ] && mv -v "$item" "$newname"
  fi
done

moo "All done. Finished renaming items."
