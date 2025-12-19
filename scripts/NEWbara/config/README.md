# NEWbara Configuration Files

This directory contains package configuration files for the `NEWbara.sh` installer.

## Files

### dnf-packages.txt
List of packages to install via DNF (Fedora/Nobara package manager).
- One package name per line
- Comments (lines starting with `#`) are ignored
- Whitespace-only lines are ignored

Example:
```
nvtop
neovim
bat
```

### flatpak-packages.txt
List of Flatpak applications to install via Flathub.
- One Flatpak app ID per line
- Comments and whitespace-only lines are ignored
- App IDs use the reverse domain notation (e.g., `org.videolan.VLC`)

Example:
```
org.videolan.VLC
md.obsidian.Obsidian
org.kde.krita
```

## Usage

```bash
# Install DNF packages only
./NEWbara.sh -d config/dnf-packages.txt

# Install Flatpak packages only (user scope)
./NEWbara.sh -f config/flatpak-packages.txt

# Install both DNF and Flatpak packages
./NEWbara.sh -d config/dnf-packages.txt -f config/flatpak-packages.txt

# Install with system-wide Flatpaks
./NEWbara.sh -d config/dnf-packages.txt -f config/flatpak-packages.txt -S

# Dry-run (preview without installing)
./NEWbara.sh -f config/flatpak-packages.txt -n
```

## Creating Custom Configuration Files

1. Create a new `.txt` file in this directory
2. Add package names (one per line)
3. Pass the file path to `NEWbara.sh` using `-d` (DNF) or `-f` (Flatpak)

Example custom configuration:
```bash
# my-dev-tools.txt
nvim
git
python3
nodejs

# Run with custom config
./NEWbara.sh -d config/my-dev-tools.txt
```

## Notes

- At least one configuration file must be provided
- Files must exist and be readable
- The script validates files before attempting installation
- Package names are case-sensitive for DNF and Flatpak app IDs
