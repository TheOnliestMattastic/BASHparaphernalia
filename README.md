# $!BASHparaphernalia

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./assets/banner-dark.png">
  <source media="(prefers-color-scheme: light)" srcset="./assets/banner-light.png">
  <img alt="Banner" src="./assets/banner-light.png">
</picture>

![Last Commit](https://img.shields.io/github/last-commit/TheOnliestMattastic/BASHparaphernalia?color=bd93f9&style=for-the-badge&labelColor=6272a4)
![Repo Size](https://img.shields.io/github/repo-size/TheOnliestMattastic/BASHparaphernalia?color=bd93f9&style=for-the-badge&labelColor=6272a4)
![Code Size](https://img.shields.io/github/languages/code-size/TheOnliestMattastic/BASHparaphernalia?color=bd93f9&style=for-the-badge&labelColor=6272a4)
![License](https://img.shields.io/badge/License-GPL--3.0-bd93f9?style=for-the-badge&logo=gnu&logoColor=white&labelColor=6272a4)  
[![Live Site](https://img.shields.io/badge/Toolkit-Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/BASHparaphernalia/)
[![Portfolio](https://img.shields.io/badge/Portfolio-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![GitHub](https://img.shields.io/badge/GitHub-Profile-bd93f9?style=for-the-badge&logo=github&logoColor=white&labelColor=6272a4)](https://github.com/theonliestmattastic)

## 🧭 Table of Contents

- [🔭 Overview](#-overview)
- [🗺️ Scripts Included](#️-scripts-included)
  - [🐧 $!NEWbara.sh](#-newbarash)
  - [☁️ $!MTrclone.sh](#️-mountmyclouddrivessh)
  - [🌈 $!LOGme.sh](#-myloginscriptsh)
  - [🤖 $!DONtype.sh](#-dontypesh)
  - [🔤 $!MOOcase.sh](#-changecasesh)
- [🚀 Getting Started](#-getting-started)
- [🌕 Notes](#-notes)
- [🛸 License](#-license)
- [🪐 Recruiter's Note](#-recruiters-note)
- [👽 Contact](#-contact)

## 🔭 Overview

This repository is a collection of Bash scripts I use to automate and streamline my Linux workflow. Each script is self‑contained, documented, and easy to adapt. Think of it as both a personal toolkit and a demonstration of my ability to write practical, maintainable automation.

## 🗺️ Scripts Included

### 🐧 **$!NEWbara.sh**

[![Bash](https://img.shields.io/badge/Shell-Bash-bd93f9?logo=gnu-bash&logoColor=white&style=for-the-badge&labelColor=6272a4)](https://www.gnu.org/software/bash/)
[![DNF](https://img.shields.io/badge/Package-dnf-bd93f9?logo=fedora&logoColor=white&style=for-the-badge&labelColor=6272a4)](https://docs.fedoraproject.org/en-US/quick-docs/dnf/)
[![Flatpak](https://img.shields.io/badge/Flatpak-Installer-bd93f9?logo=flatpak&logoColor=white&style=for-the-badge&labelColor=6272a4)](https://flatpak.org/)

- **Purpose:** Comprehensive system bootstrapper for Nobara/Fedora with multi-package manager support and advanced features.
- **Summary:** A powerful script that installs packages via DNF (system packages) and Flatpak (user/system apps). Supports custom package lists, dry-run mode for safe testing, automatic logging, and smart cleanup of orphaned packages.
- **Key Features:**
  - Multi-package manager support (DNF + Flatpak)
  - Custom package list loading from text files
  - Dry-run mode to preview installations without changes
  - Automatic timestamped logging for troubleshooting
  - User/system Flatpak installation modes
  - Smart cleanup of orphaned packages and runtimes
- **Dependencies:** `dnf`, `flatpak`, `sudo`.
- **Use Case:** Complete system setup automation for fresh Nobara/Fedora installations with advanced configuration options.  

---

### ☁️ **$!MTrclone.sh**

[![Bash](https://img.shields.io/badge/Shell-Bash-bd93f9?logo=gnu-bash&logoColor=white&style=for-the-badge&labelColor=6272a4)](https://www.gnu.org/software/bash/)
[![Rclone](https://img.shields.io/badge/Cloud-rclone-bd93f9?logo=icloud&logoColor=white&style=for-the-badge&labelColor=6272a4)](https://rclone.org/)
[![xcowsay](https://img.shields.io/badge/Fun-xcowsay-bd93f9?style=for-the-badge&labelColor=6272a4)](https://github.com/nickg/xcowsay)

- **Purpose:** Mounts multiple cloud storage accounts locally.  
- **Summary:** Creates directories for OneDrive, Google Drive, and Dropbox, mounts them via `rclone`, verifies with `findmnt`, and reports success/failure with `xcowsay`.  
- **Dependencies:** `rclone`, `xcowsay`.  
- **Use Case:** Automates cloud drive access at login with playful feedback.  

---

### 🌈 **$!LOGme.sh**

[![Bash](https://img.shields.io/badge/Shell-Bash-bd93f9?logo=gnu-bash&logoColor=white&style=for-the-badge&labelColor=6272a4)](https://www.gnu.org/software/bash/)
[![OpenRGB](https://img.shields.io/badge/RGB-OpenRGB-bd93f9?style=for-the-badge&labelColor=6272a4)](https://openrgb.org/)
[![xcowsay](https://img.shields.io/badge/Fun-xcowsay-bd93f9?style=for-the-badge&labelColor=6272a4)](https://github.com/nickg/xcowsay)

- **Purpose:** Enhances login experience with RGB setup and interactive fortune display.
- **Summary:** A robust login script that sets OpenRGB profiles, displays fortunes with cowsay, includes intelligent autostart configuration, and provides comprehensive error handling.
- **Key Features:**
  - Automatic OpenRGB profile loading for consistent RGB lighting
  - Interactive fortune display using cow-themed bubbles
  - Smart autostart detection and setup with user prompts
  - Dependency validation with helpful installation instructions
  - Cross-desktop autostart support (KDE Plasma and GNOME)
  - Graceful error handling that continues execution despite failures
- **Dependencies:** `openrgb`, `xcowsay` (provides xcowfortune).
- **Use Case:** Provides a polished, automated login experience with RGB consistency, entertainment, and smart configuration management.  

---

### 🤖 **$!DONtype.sh**

[![Bash](https://img.shields.io/badge/Shell-Bash-bd93f9?logo=gnu-bash&logoColor=white&style=for-the-badge&labelColor=6272a4)](https://www.gnu.org/software/bash/)
[![xdotool](https://img.shields.io/badge/Automation-xdotool-bd93f9?style=for-the-badge&labelColor=6272a4)](https://github.com/jordansissel/xdotool)

- **Purpose:** Automates in-game keybinding setup for *Schedule I* with enhanced reliability.
- **Summary:** Uses `xdotool` to automatically type and bind teleport locations, inventory management, and utility commands to function keys (F1-F12). Includes dependency validation, progress feedback, and robust error handling for reliable execution.
- **Key Features:**
  - Automated keybinding for teleport locations (motel room, sweatshop, storage unit, etc.)
  - Inventory management commands (clear trash, clear inventory)
  - Balance manipulation commands (change balance)
  - Dependency validation with helpful error messages
  - Real-time progress feedback with countdown timer
  - Error handling and recovery (continues on individual binding failures)
  - Robust execution with cleanup traps and modular code structure
  - Optimized timing for faster setup completion
  - Non-interactive execution for gaming efficiency
- **Dependencies:** `xdotool`.
- **Use Case:** Eliminates manual command typing during gameplay, completing setup in ~20 seconds instead of several minutes of manual input with built-in error recovery and user feedback.

---

### 🌝 **$!MOOcase.sh**

[![Bash](https://img.shields.io/badge/Shell-Bash-bd93f9?logo=gnu-bash&logoColor=white&style=for-the-badge&labelColor=6272a4)](https://www.gnu.org/software/bash/)

- **Purpose:** Batch rename directories and files by converting first character to lowercase.
- **Summary:** A robust utility script that standardizes file and directory naming by converting the first character to lowercase, featuring flexible filtering options, error handling, and optional visual feedback.
- **Key Features:**
  - Case conversion modes (lowercase default, uppercase with `-u` option)
  - Selective processing (directories only with `-d`, files only with `-f`)
  - Custom path targeting with `-p` option (defaults to current directory)
  - Safe renaming (only processes items when new name differs from original)
  - Visual feedback using cowsay/lolcat when available (falls back gracefully)
  - Comprehensive error handling with detailed error messages and logging
  - Verbose output showing all rename operations
  - Non-destructive operations preserving file metadata
- **Dependencies:** None required (uses built-in Bash tools); optional `cowsay` and `lolcat` for enhanced visual feedback.
- **Use Case:** Quickly standardize naming conventions across file collections, perfect for organizing media libraries, codebases, or any directory structure with inconsistent capitalization.

## 🚀 Blasting Off

### Prerequisites

- **Operating System:** Linux distribution (tested on Nobara/Fedora)
- **Shell:** Bash (most Linux distributions include this by default)
- **Permissions:** Ability to run `sudo` for system-level operations

### Installation

1. **Clone the repository:**

   ```sh
   git clone https://github.com/TheOnliestMattastic/BASHparaphernalia.git
   cd BASHparaphernalia
   ```

2. **Make scripts executable:**

   ```sh
   # For all scripts at once
   chmod +x scripts/*/*.sh

   # Or for individual scripts
   chmod +x scripts/NEWbara/NEWbara.sh
   chmod +x scripts/MTrclone/MTrclone.sh
   # ... etc
   ```

3. **Run any script:**

   ```sh
   ./scripts/scriptName/scriptName.sh [options]
   ```

### Script-Specific Setup

Each script includes detailed setup instructions in its header comments. Here are the key requirements:

- **$!NEWbara.sh:** Requires `dnf`, `flatpak`, and `sudo` access
- **$!MTrclone.sh:** Requires `rclone` configured with cloud remotes and `xcowsay`
- **$!LOGme.sh:** Requires `openrgb` and `xcowsay`
- **$!DONtype.sh:** Requires `xdotool` for automation
- **$!MOOcase.sh:** No external dependencies (uses built-in tools)

### Configuration

Most scripts support customization through:

- Command-line options (see `--help` for each script)
- Configuration files (NEWbara.sh supports custom package lists)
- Environment variables
- Direct script editing for personal preferences

## 🌕 Notes

### Compatibility & Customization

- **Personal Setup:** These scripts were written for my personal Nobara workflow, so you may need to adjust paths, package lists, or configurations for your environment.
- **Linux Focus:** Designed primarily for Linux systems with systemd, DNF, and common package managers. May require adaptation for other distributions.
- **Version Dependencies:** Some scripts depend on specific tool versions (e.g., rclone remotes, OpenRGB profiles).

### Script Architecture

- **Self-Contained:** Each script is designed to be standalone with minimal external dependencies.
- **Error Handling:** Scripts include basic error checking and user feedback.
- **Logging:** Most scripts create timestamped log files for troubleshooting.
- **Non-Destructive:** Scripts avoid overwriting existing configurations without confirmation.

### Security Considerations

- **Sudo Usage:** Some scripts require `sudo` access - review what they're doing before running.
- **Network Operations:** Scripts like NEWbara.sh download packages from repositories.
- **File Permissions:** Scripts may create directories and modify file permissions.

### Contributing

- **Welcome Contributions:** Issues, feature requests, and pull requests are encouraged.
- **Fork Friendly:** Feel free to fork and adapt for your own needs.
- **Documentation:** All scripts include comprehensive header documentation.

### Future Development

- **Modular Design:** Scripts are built to be easily extended or modified.
- **Configuration Files:** Moving toward external configuration files for easier customization.
- **Cross-Platform:** Potential for adaptation to other Unix-like systems.  

## 🛸 License

This project is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html).

## 🪐 Recruiter’s Note

This repository serves as a comprehensive portfolio piece demonstrating practical software development and system administration skills. While not a commercial product, it showcases:

### Technical Skills Demonstrated

- **Bash Scripting Expertise:** Advanced shell scripting with error handling, logging, and user interaction
- **Linux System Administration:** Package management (DNF, Flatpak), service configuration, and automation
- **Cross-Tool Integration:** Coordinating multiple utilities (rclone, OpenRGB, xdotool) into cohesive workflows
- **Documentation Practices:** Comprehensive inline documentation, READMEs, and user-friendly interfaces
- **Problem-Solving Approach:** Identifying repetitive tasks and creating automated solutions

### Professional Qualities

- **Self-Directed Learning:** Researching and implementing tools like rclone, OpenRGB, and various package managers
- **Attention to Detail:** Comprehensive error handling, user feedback, and safety checks
- **User Experience Focus:** Creating scripts that are both powerful and easy to use
- **Maintainability:** Clean, commented code that can be easily modified and extended
- **Adaptability:** Scripts designed to work across different configurations and use cases

### Development Process

- **Iterative Improvement:** Scripts evolved from simple solutions to robust, feature-rich tools
- **Testing & Debugging:** Real-world testing leading to improved error handling  
- **User-Centered Design:** Scripts include help systems, validation, and clear success/failure indicators
- **Version Control:** Proper Git usage with meaningful commit messages and repository organization

This toolkit reflects the same methodical, user-focused approach I bring to IT support, system administration, and software development roles.  

## 👽 Contact

Curious about my projects? Want to collaborate or hire for entry-level IT/support/dev roles? Shoot me an email or connect on GitHub—I reply quickly and love new challenges.

[![Portfolio](https://img.shields.io/badge/Portfolio-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![GitHub](https://img.shields.io/badge/GitHub-Profile-bd93f9?style=for-the-badge&logo=github&logoColor=white&labelColor=6272a4)](https://github.com/theonliestmattastic)
[![Email](https://img.shields.io/badge/Email-matthew.poole485%40gmail.com-bd93f9?style=for-the-badge&logo=gmail&logoColor=white&labelColor=6272a4)](mailto:matthew.poole485@gmail.com)

> *“Sometimes the questions are complicated and the answers are simple.”* — Dr. Seuss
