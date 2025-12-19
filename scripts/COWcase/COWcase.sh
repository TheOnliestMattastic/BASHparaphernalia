#!/usr/bin/env bash
# ==============================================================================
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
#      ▄▄       ▄    ▄▄                                                      ▄▄
#      ██     ▄██▀▀  ██ ▄█████ ▄████▄ ██     ██  ▄▄▄▄  ▄▄▄   ▄▄▄▄ ▄▄▄▄▄      ██
#      ██     ▀███▄  ██ ██     ██  ██ ██ ▄█▄ ██ ██▀▀▀ ██▀██ ███▄▄ ██▄▄       ██
#      ██     ▄▄██▀  ▄▄ ▀█████ ▀████▀  ▀██▀██▀  ▀████ ██▀██ ▄▄██▀ ██▄▄▄      ██
#      ▀▀       ▀                                                            ▀▀
#        ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄ ▄
#        ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀ ▀
#                                    ▄
#            ▄█████  ▄▄▄  ██     ██  ▀          █
#    ▄▀▀▄  █ ██     ██▀██ ██ ▄█▄ ██  ▄▄▄       █
#    ▀   ▀▀  ▀█████ ▀███▀  ▀██▀██▀  ▄ ▄▄▄▄▄   █
#   ▄           ▄ ▀█▀         ▄                        ▄            ▄
# ▄ █  ▄ ▄ █    █    ▄   █ ▄  █   ▄  █  ▄ █  ▄ ▄ ▄ █ ▄ █ ▄ ▄ █  ▄ ▄ █ ▄ ▄   ▄ ▄
# ==============================================================================
# COWcase.sh - Case Converter with Visual Feedback
# ------------------------------------------------------------------------------
# WHAT: Batch renames files/directories by converting first character case
# WHY:  Useful for standardizing naming conventions across projects
# HOW:  Bash parameter expansion; supports recursive, dry-run, logging modes
# NOTE: Make executable: chmod +x COWcase.sh; run: ./COWcase.sh [options]
#
# USAGE:
#   ./COWcase.sh [-d|-f] [-u] [-r] [-n] [-p PATH]
#
# OPTIONS:
#   -d : Process directories only (default mode)
#   -f : Process files only
#   -u : Convert to uppercase (default: lowercase)
#   -r : Enable recursive processing (all subdirectories)
#   -n : Dry-run mode (preview without applying changes)
#   -p [path] : Target directory (default: current directory)
# =============================================================================
# Exit immediately if a command fails.
set -e

# Reports the line number and exit code if an error occurs.
trap 'echo "Error occurred on line $LINENO. Exit code: $?" >&2' ERR

# =============================================================================
# moo() - Fun Message Function
# =============================================================================
# WHAT: Displays messages using cowsay/lolcat with graceful fallback
# WHY:  Provides colorful, fun output while maintaining compatibility
# HOW:  Checks for cowsay/lolcat availability; logs to moo.log
# NOTE: Only outputs in interactive terminals; replace with echo if needed
# =============================================================================
moo() {
  local msg="$1"
  echo "$msg" >>"moo.log"
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

# =============================================================================
# Configuration
# =============================================================================
# WHAT: Initialize default settings for path, mode, case, recursion, dry-run
# WHY:  Establishes baseline behavior; can be overridden by CLI flags
# =============================================================================

DEFAULT_PATH="$PWD"
MODE="dirs"
CASE_MODE="lower"
RECURSIVE=false
DRY_RUN=false

# =============================================================================
# Argument Parsing
# =============================================================================
# WHAT: Parse getopts flags; set configuration based on user input
# WHY:  Enables flexible CLI interface with options for path, mode, case, etc.
# HOW:  Uses getopts loop to process -p, -d, -f, -u, -r, -n flags
# =============================================================================

# Parse the command-line options.
while getopts "p:dfurn" opt; do
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
  # -r: Enable recursive processing.
  r)
    RECURSIVE=true
    ;;
  # -n: Enable dry-run mode.
  n)
    DRY_RUN=true
    ;;
  # Handle invalid options.
  *)
    moo "I am Error: Invalid Option $OPTARG. Use -p for path, -d for dirs, -f for files, -u for uppercase, -r for recursive, or -n for dry-run"
    exit 1
    ;;
  esac
done

# =============================================================================
# Path Validation
# =============================================================================
# WHAT: Verify target path exists and is a directory
# WHY:  Prevents script from running in invalid locations
# =============================================================================

if [ ! -d "$DEFAULT_PATH" ]; then
  moo "I am Error: Path \'$DEFAULT_PATH\' does not exist or is not a directory."
  exit 1
fi

# =============================================================================
# Execution Setup
# =============================================================================
# WHAT: Change to target directory; enable dotglob for hidden files
# WHY:  Ensures renames happen in correct location; includes dotfiles
# =============================================================================

cd "$DEFAULT_PATH" || exit 1
moo "Changed directory to \`$DEFAULT_PATH\`. Starting rename process..."

# Enable dotglob to include hidden files in glob patterns.
shopt -s dotglob

# =============================================================================
# Main Processing Loop - Recursive & Non-Recursive
# =============================================================================
# WHAT: Iterate through items and rename based on mode/case settings
# WHY:  Core logic that performs the actual case conversion
# HOW:  Uses find (recursive) or glob (non-recursive); deepest-first for dirs
# NOTE: Renames only basename; preserves directory structure
# =============================================================================

if [ "$RECURSIVE" = true ]; then
  # Recursive mode: use find with depth-first traversal
  if [ "$MODE" = "dirs" ]; then
    while IFS= read -r item; do
      # Remove leading './' from find output if present.
      item="${item#./}"
      
      # Get the directory name (basename) and its parent directory.
      dir_name=$(basename "$item")
      parent_dir=$(dirname "$item")
      
      # Bash parameter expansion converts the first character based on case mode.
      if [ "$CASE_MODE" = "upper" ]; then
        new_dir_name="${dir_name^}"
      else
        new_dir_name="${dir_name,}"
      fi

      # Rename only if the basename changed.
      if [ "$dir_name" != "$new_dir_name" ]; then
        old_path="$parent_dir/$dir_name"
        new_path="$parent_dir/$new_dir_name"
        if [ "$DRY_RUN" = true ]; then
          msg="[DRY RUN]: would rename '$old_path' -> '$new_path'"
          echo "$msg"
          echo "$msg" >> "moo.log"
        else
          mv -v "$old_path" "$new_path"
        fi
      fi
    done < <(find . -mindepth 1 -type d -printf '%d\t%p\n' | sort -rn | cut -f2-)
  else
    while IFS= read -r item; do
      # Remove leading './' from find output if present.
      item="${item#./}"
      
      # Get the file name (basename) and its parent directory.
      file_name=$(basename "$item")
      parent_dir=$(dirname "$item")
      
      # Bash parameter expansion converts the first character based on case mode.
      if [ "$CASE_MODE" = "upper" ]; then
        new_file_name="${file_name^}"
      else
        new_file_name="${file_name,}"
      fi

      # Rename only if the basename changed.
      if [ "$file_name" != "$new_file_name" ]; then
        old_path="$parent_dir/$file_name"
        new_path="$parent_dir/$new_file_name"
        if [ "$DRY_RUN" = true ]; then
          msg="[DRY RUN]: would rename '$old_path' -> '$new_path'"
          echo "$msg"
          echo "$msg" >> "moo.log"
        else
          mv -v "$old_path" "$new_path"
        fi
      fi
      done < <(find . -mindepth 1 -type f)
  fi
else
  # Non-recursive mode: glob current directory only
  for item in *; do
    # Filter items: only process mode-matching types
    if [ "$MODE" = "dirs" ] && [ -d "$item" ]; then

      # Bash parameter expansion converts the first character based on case mode.
      if [ "$CASE_MODE" = "upper" ]; then
        newname="${item^}"
      else
        newname="${item,}"
      fi

      # Rename the item only if the new name is different.
      if [ "$item" != "$newname" ]; then
        if [ "$DRY_RUN" = true ]; then
          msg="[DRY RUN]: would rename '$item' -> '$newname'"
          echo "$msg"
          echo "$msg" >> "moo.log"
        else
          mv -v "$item" "$newname"
        fi
      fi

    # This is a file and we are in 'files' mode.
    elif [ "$MODE" = "files" ] && [ -f "$item" ]; then

      # Bash parameter expansion converts the first character based on case mode.
      if [ "$CASE_MODE" = "upper" ]; then
        newname="${item^}"
      else
        newname="${item,}"
      fi

      # Rename the item only if the new name is different.
      if [ "$item" != "$newname" ]; then
        if [ "$DRY_RUN" = true ]; then
          msg="[DRY RUN]: would rename '$item' -> '$newname'"
          echo "$msg"
          echo "$msg" >> "moo.log"
        else
          mv -v "$item" "$newname"
        fi
      fi
    fi
  done
fi

# =============================================================================
# Cleanup & Completion
# =============================================================================
# WHAT: Disable dotglob; log completion message
# WHY:  Restores shell state; signals completion to user
# =============================================================================

shopt -u dotglob
moo "All done. Finished renaming items."
