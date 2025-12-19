# 🐧 $!NEWbara 

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./assets/banner-dark.png">
  <source media="(prefers-color-scheme: light)" srcset="./assets/banner-light.png">
  <img alt="Banner" src="./assets/banner-light.png">
</picture>

![License](https://img.shields.io/badge/License-CC%20BY--SA%204.0-bd93f9?style=for-the-badge&logo=creativecommons&logoColor=white&labelColor=6272a4)
[![Live Site](https://img.shields.io/badge/Toolkit-Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/BASHparaphernalia/)
[![Portfolio](https://img.shields.io/badge/Portfolio-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![GitHub](https://img.shields.io/badge/GitHub-Profile-bd93f9?style=for-the-badge&logo=github&logoColor=white&labelColor=6272a4)](https://github.com/theonliestmattastic)

## 🔭 Overview

This repository contains `NEWbara.sh`, a Bash script designed to bootstrap a fresh Nobara/Fedora system with a curated set of packages and applications. It supports DNF and Flatpak installations, with options for custom package lists and system-wide Flatpak installations.

## 🌟 Features

- **Multi-Package Manager Support**: Installs via DNF (system packages) and Flatpak (applications).
- **Custom Package Lists**: Load packages from text files for DNF and Flatpak.
- **Mandatory Configuration Files**: Requires at least one package file (-d or -f) to run.
- **System/User Flatpak Modes**: Choose between user-specific or system-wide Flatpak installations.
- **Visual Feedback**: Automatic cowsay and lolcat formatting for engaging user feedback.
- **Dry Run Mode**: Preview installations without making changes.
- **Automatic Logging**: Logs all output to a timestamped file.
- **Non-Interactive**: Runs fully automated with comprehensive error handling.
- **Cleanup**: Removes orphaned packages post-installation.

## ⚛️ Requirements

- Nobara or Fedora Linux (minimum version 42 for compatibility).
- `sudo` access for DNF installations.
- DNF and Flatpak package managers (script will verify and auto-install cowsay/lolcat).

## 🚀 Blasting Off

Clone the repository:

```sh
git clone https://github.com/TheOnliestMattastic/BASHparaphernalia.git
cd BASHparaphernalia/scripts/NEWbara
```

Make the script executable and run:

```sh
chmod +x NEWbara.sh
./NEWbara.sh
```

Provide at least one package configuration file:

```sh
# Install from default DNF packages
./NEWbara.sh -d config/dnf-packages.txt

# Install from default Flatpak packages
./NEWbara.sh -f config/flatpak-packages.txt

# Install both with system-wide Flatpaks
./NEWbara.sh -d config/dnf-packages.txt -f config/flatpak-packages.txt -S

# Preview without installing
./NEWbara.sh -f config/flatpak-packages.txt -n
```

See `./NEWbara.sh --help` for full options and configuration file details.

## 🌠 TODO: Future Features

- [ ] **Verbose Mode (-v)**: Enable detailed output for debugging.
- [ ] **Post-Installation Summary**: Display counts of installed/failed/skipped packages.
- [ ] **Retry Mechanism**: Automatically retry failed installs (configurable attempts).
- [ ] **File Validation**: Check custom files for existence, readability, and valid entries.
- [ ] **Configuration File Support**: Use an INI file for default settings and packages.
- [ ] **Update-Only Mode (-u)**: Only update existing packages, skip fresh installs.
- [ ] **Minimal Impact Mode**: Skip cleanup or optional steps for quick runs.

## 🌌 Contributing

Contributions are welcome! Please open issues for bugs or feature requests, and submit pull requests for code changes.

## 🌕 Notes

- **Distribution Compatibility**: Designed for Nobara/Fedora (minimum version 42); adjust command syntax for other distros.
- **Sudo Requirement**: Requires `sudo` access for DNF installations; run the script as a regular user (not root).
- **Configuration Files**: At least one package file (-d or -f) must be provided; the script will exit with an error if none are specified.
- **Flatpak Scope**: Flatpaks default to user mode (recommended by Nobara wiki); use the `-S` flag for system-wide installations.
- **Visual Feedback Tools**: `cowsay` and `lolcat` are automatically installed early in the script to ensure consistent visual feedback throughout execution. If you don't want to keep these tools after running the script, you can safely uninstall them:
  ```sh
  sudo dnf remove cowsay lolcat
  ```
- **Dry-Run Safety**: Use the `-n` flag to preview all installations without making any changes or running the cleanup process.
- **Logging**: All output is logged to timestamped files in the format `NEWbara_YYYYMMDD_HHMMSS.log`.
- **Custom Configurations**: See `config/README.md` for details on creating and using custom package configuration files.

## 🛸 License

This project is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

## 🪐 Recruiter’s Note

This script demonstrates practical automation skills, including argument parsing, error handling, and cross-tool integration in Linux environments.

## 👽 Contact  

Curious about my projects? Want to collaborate or hire for entry-level IT/support/dev roles? Shoot me an email or connect on GitHub—I reply quickly and love new challenges.  

[![Portfolio](https://img.shields.io/badge/Portfolio-Live_Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![Resume](https://img.shields.io/badge/Resume-PDF-bd93f9?style=for-the-badge&logo=adobeacrobatreader&logoColor=white&labelColor=6272a4)](https://raw.githubusercontent.com/theonliestmattastic/theonliestmattastic.github.io/main/assets/docs/resume.pdf)
[![Email](https://img.shields.io/badge/Email-matthew.poole485%40gmail.com-bd93f9?style=for-the-badge&logo=gmail&logoColor=white&labelColor=6272a4)](mailto:matthew.poole485@gmail.com)  

> *“Sometimes the questions are complicated and the answers are simple.”* — Dr. Seuss  
