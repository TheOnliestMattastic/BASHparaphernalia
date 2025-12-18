# Changelog

All notable changes to BASHparaphernalia are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.0.0] - 2025-12-18

### ✨ Added

- **Comprehensive script toolkit** — Five production-ready Bash scripts for Linux automation
- **$!NEWbara.sh** — System bootstrapper for Nobara/Fedora
  - Multi-package manager support (DNF + Flatpak)
  - Custom package list loading from text files
  - Dry-run mode for safe testing
  - Automatic timestamped logging
  - Smart cleanup of orphaned packages and runtimes
- **$!MTrclone.sh** — Cloud storage mounting automation
  - Multi-cloud support (OneDrive, Google Drive, Dropbox)
  - Automatic rclone mounting with verification
  - Playful feedback via xcowsay
- **$!LOGme.sh** — Login experience enhancement
  - OpenRGB profile loading for RGB consistency
  - Interactive fortune display with cowsay
  - Smart autostart detection and configuration
  - Cross-desktop support (KDE Plasma, GNOME)
  - Graceful error handling with dependency validation
- **$!DONtype.sh** — In-game keybinding automation (Schedule I)
  - Automated keybinding for teleport locations
  - Inventory management commands
  - Balance manipulation commands
  - Real-time progress feedback with countdown timer
  - Robust error handling and recovery
  - Optimized timing for faster setup
- **$!MOOcase.sh** — Batch file/directory renaming utility
  - Case conversion (lowercase/uppercase)
  - Selective processing (directories only, files only)
  - Custom path targeting
  - Visual feedback with cowsay/lolcat
  - Comprehensive error handling
- **Documentation** — Professional README with script descriptions, dependencies, and setup instructions
- **Web-based toolkit site** — Interactive HTML interface showcasing all scripts with live demos (optional future feature)

### 📚 Documentation

- **Comprehensive README** — Detailed overview, feature descriptions, setup instructions, and usage examples
- **Script-specific headers** — Inline documentation for each script with purpose, usage, and dependency notes
- **Recruiter's note** — Technical skills and professional qualities demonstrated
- **Version control** — Proper Git repository with meaningful commit history

### 🛠️ Code Quality

- **Error handling** — Comprehensive error checking and user feedback
- **Logging** — Timestamped logs for troubleshooting
- **User experience** — Help systems, validation, and clear success/failure indicators
- **Non-destructive operations** — Safe defaults with confirmation prompts
- **Modularity** — Self-contained scripts with minimal external dependencies

### 🌐 Infrastructure

- **CI/CD ready** — Structure supports automated testing
- **License** — GNU General Public License v3.0
- **Portfolio-friendly** — Documented for technical review and demonstration

## [0.1.0] - Original Scripts

### ✨ Features (Early)

- **Initial script collection** — Personal automation tools for Linux workflow
- **Basic functionality** — Working versions of each script with minimal documentation
- **Iterative improvement** — Scripts evolved based on personal use and feedback

---

## Future Roadmap

- [ ] **Additional scripts** — Expand toolkit with more automation tools
- [ ] **Configuration management** — External config files for easier customization
- [ ] **Cross-platform support** — Adaptation for other Unix-like systems (macOS, WSL)
- [ ] **Web interface** — Interactive toolkit site with script demonstrations
- [ ] **Package manager** — Simplified installation and distribution
- [ ] **Testing framework** — Automated tests for script validation
