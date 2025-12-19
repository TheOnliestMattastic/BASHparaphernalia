# Changelog

All notable changes to BASHparaphernalia are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.1.0] - 2025-12-19

### ✨ Added

- **COWcase.sh refactor & expansion** — Major upgrade to batch file/directory case converter
  - New **JUSTcase.sh** lightweight alternative (lean, fast, zero dependencies)
  - Recursive processing mode (`-r` flag) for entire directory trees
  - Dry-run/preview mode (`-n` flag) to preview changes before applying
  - Improved performance using Bash parameter expansion (`${var^}` / `${var,}`)
  - Deepest-first directory traversal to avoid path conflicts
  - Enhanced logging in dry-run mode with stdout + file output
- **Comprehensive SOP comments** — Both scripts now follow WHAT/WHY/HOW/NOTE pattern
  - COWcase.sh: Full section headers for all major functions
  - JUSTcase.sh: Lean comments optimized for minimal overhead
- **Updated HTML documentation** — New `cowcase.html` documentation page
  - Both COWcase.sh and JUSTcase.sh usage documentation
  - Updated command-line options with new flags
  - Practical examples showcasing recursive and dry-run features
  - Implementation details explaining design choices

### 🔄 Changed

- **MOOcase.sh → COWcase.sh** — Project/directory name change
  - Better naming convention clarity (COWcase for feature-rich, JUSTcase for lean)
  - Updated all file paths and GitHub links
- **Refactored case conversion method**
  - Replaced `sed` regex with Bash parameter expansion (faster, cleaner)
  - Maintains feature parity with original implementation
- **License upgrade** — Changed from GNU GPLv3.0 to Creative Commons Attribution-ShareAlike 4.0
  - Aligns with rest of bashParaphernalia project
  - Updated README badge and LICENSE file
- **COWcase.sh script header** — Updated to reflect all new flags and capabilities
  - Removed outdated MOOcase references
  - Added documentation for `-r` (recursive) and `-n` (dry-run) flags

### 📚 Documentation

- **README.md completely rewritten**
  - Added JUSTcase.sh as dedicated alternative with feature comparison
  - Split usage section into COWcase.sh and JUSTcase.sh subsections
  - Updated feature lists showing shared vs. script-specific capabilities
  - Added implementation notes explaining design trade-offs
  - Enhanced recruiter's note with advanced Bash techniques demonstrated
- **DEVLOG.md created** — Detailed development log tracking all 5 refactoring chunks
- **HTML documentation updated** — cowcase.html page with comprehensive examples

### 🛠️ Code Quality

- **Standardized comments** — All major functions follow SOP (WHAT/WHY/HOW/NOTE)
- **Improved robustness** — Deepest-first directory processing prevents path conflicts
- **Better performance** — JUSTcase.sh optimized for speed; COWcase.sh maintains UX
- **Enhanced dry-run** — Preview changes safely before committing

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
- **$!COWcase.sh** — Batch file/directory renaming utility (refactored in v1.1.0)
  - Case conversion (lowercase/uppercase)
  - Selective processing (directories only, files only)
  - Custom path targeting
  - Visual feedback with cowsay/lolcat
  - Comprehensive error handling
  - Recursive directory tree processing
  - Dry-run preview mode
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
- **License** — Creative Commons Attribution-ShareAlike 4.0 (updated in v1.1.0)
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
