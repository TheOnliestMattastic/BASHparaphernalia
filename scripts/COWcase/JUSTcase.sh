#!/usr/bin/env bash
# =============================================================================
# JUSTcase.sh - Lightweight Case Converter
# =============================================================================
# WHAT: Minimal, fast batch case converter for file/directory names
# WHY:  Strips UX layers of COWcase for maximum speed and independence
# HOW:  Bash parameter expansion; optional dry-run; recursive support
# NOTE: No logging/cowsay; clean output; dry-run preview before commit
# =============================================================================

set -e
trap 'echo "Error occurred on line $LINENO. Exit code: $?" >&2' ERR

# =============================================================================
# Configuration
# =============================================================================
# WHAT: Initialize default settings for path, mode, case, dry-run, recursion
# WHY:  Establishes baseline behavior; overridable via CLI flags
# =============================================================================

DEFAULT_PATH="$PWD"
MODE="dirs"
CASE_MODE="lower"
DRY_RUN=false
RECURSIVE=false

# =============================================================================
# Argument Parsing
# =============================================================================
# WHAT: Parse getopts flags; set configuration based on user input
# WHY:  Enables flexible CLI with minimal code overhead
# HOW:  Uses getopts loop to process -p, -d, -f, -u, -n, -r flags
# =============================================================================

while getopts "p:dfunr" opt; do
  case $opt in
  p) DEFAULT_PATH="$OPTARG" ;;
  d) MODE="dirs" ;;
  f) MODE="files" ;;
  u) CASE_MODE="upper" ;;
  n) DRY_RUN=true ;;
  r) RECURSIVE=true ;;
  *)
    echo "Usage: $0 [-p path] [-d|-f] [-u] [-n] [-r]"
    exit 1
    ;;
  esac
done

cd "$DEFAULT_PATH" || exit 1

# Enable dotglob to catch hidden files like .bashrc
shopt -s dotglob

# =============================================================================
# Main Processing Loop - Recursive & Non-Recursive
# =============================================================================
# WHAT: Iterate through items and rename based on mode/case settings
# WHY:  Core logic that performs case conversion with minimal overhead
# HOW:  Uses find (recursive) or glob (non-recursive); deepest-first for dirs
# NOTE: Renames only basename; optional dry-run preview available
# =============================================================================

# Process items based on recursion setting.
if [ "$RECURSIVE" = true ]; then
  # Use find for recursive processing; filter by type.
  if [ "$MODE" = "dirs" ]; then
    # Process directories from deepest to shallowest to avoid path conflicts.
    while IFS= read -r item; do
      item="${item#./}"
      dir_name=$(basename "$item")
      parent_dir=$(dirname "$item")
      
      if [[ "$CASE_MODE" == "upper" ]]; then
        new_dir_name="${dir_name^}"
      else
        new_dir_name="${dir_name,}"
      fi
      
      if [[ "$dir_name" != "$new_dir_name" ]]; then
        old_path="$parent_dir/$dir_name"
        new_path="$parent_dir/$new_dir_name"
        if [ "$DRY_RUN" = true ]; then
          echo "[DRY RUN]: would rename '$old_path' -> '$new_path'"
        else
          mv -v "$old_path" "$new_path"
        fi
      fi
    done < <(find . -mindepth 1 -type d -printf '%d\t%p\n' | sort -rn | cut -f2-)
  else
    while IFS= read -r item; do
      item="${item#./}"
      file_name=$(basename "$item")
      parent_dir=$(dirname "$item")
      
      if [[ "$CASE_MODE" == "upper" ]]; then
        new_file_name="${file_name^}"
      else
        new_file_name="${file_name,}"
      fi
      
      if [[ "$file_name" != "$new_file_name" ]]; then
        old_path="$parent_dir/$file_name"
        new_path="$parent_dir/$new_file_name"
        if [ "$DRY_RUN" = true ]; then
          echo "[DRY RUN]: would rename '$old_path' -> '$new_path'"
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
    [[ "$MODE" == "dirs" && ! -d "$item" ]] && continue
    [[ "$MODE" == "files" && ! -f "$item" ]] && continue

    # ${var^}  = Uppercase first char
    # ${var,}  = Lowercase first char
    if [[ "$CASE_MODE" == "upper" ]]; then
      newname="${item^}"
    else
      newname="${item,}"
    fi

    # Only act if there is actually a change to be made
    if [[ "$item" != "$newname" ]]; then
      if [ "$DRY_RUN" = true ]; then
        echo "[DRY RUN]: would rename '$item' -> '$newname'"
      else
        mv -v "$item" "$newname"
      fi
    fi
  done
fi

# =============================================================================
# Cleanup & Completion
# =============================================================================
# WHAT: Disable dotglob; signal completion
# WHY:  Restores shell state; minimal user feedback
# =============================================================================

shopt -u dotglob
echo "Done."
