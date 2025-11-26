# 🐧 $!NEWbara

![banner](assets/banner.png)
![License](https://img.shields.io/badge/License-GPL--3.0-bd93f9?style=for-the-badge&logo=gnu&logoColor=white&labelColor=6272a4)
[![Live Site](https://img.shields.io/badge/Toolkit-Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/BASHparaphernalia/)
[![Portfolio](https://img.shields.io/badge/Portfolio-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![GitHub](https://img.shields.io/badge/GitHub-Profile-bd93f9?style=for-the-badge&logo=github&logoColor=white&labelColor=6272a4)](https://github.com/theonliestmattastic)

## 🔭 Overview

This repository contains `NEWbara.sh`, a Bash script designed to bootstrap a fresh Nobara/Fedora system with a curated set of packages and applications. It supports DNF, Flatpak, and Snap installations, with options for custom package lists and system-wide Flatpak installations.

## 🌟 Features

- **Multi-Package Manager Support**: Installs via DNF (system packages), Flatpak (user/system apps), and Snap (universal packages).
- **Custom Package Lists**: Load packages from text files for DNF, Flatpak, and Snap.
- **System/User Flatpak Modes**: Choose between user-specific or system-wide Flatpak installations.
- **Dry Run Mode**: Preview installations without making changes.
- **Automatic Logging**: Logs all output to a timestamped file.
- **Non-Interactive**: Runs fully automated with fallback error handling.
- **Cleanup**: Removes orphaned packages post-installation.

## ⚛️ Requirements

- Nobara or Fedora Linux (minimum version 42 for compatibility).
- `sudo` access for DNF and Snap installations.
- Flatpak and Snap package managers installed (script will verify).

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

For custom packages, create text files (one package per line) and use flags:

```sh
echo -e "htop\nvim" > my_dnfs.txt
./NEWbara.sh -d my_dnfs.txt
```

See `./NEWbara.sh --help` for full options.

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

- Designed for Nobara/Fedora (minimum version 42); tweak for other distros.
- Requires `sudo` for DNF/Snap installs; run as regular user.
- Flatpaks default to user mode (recommended by Nobara wiki).
- Logs are saved as `NEWbara_YYYYMMDD_HHMMSS.log`.

## 🛸 License

This project is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html).

## 🪐 Recruiter’s Note

This script demonstrates practical automation skills, including argument parsing, error handling, and cross-tool integration in Linux environments.

## 👽 Contact  

Curious about my projects? Want to collaborate or hire for entry-level IT/support/dev roles? Shoot me an email or connect on GitHub—I reply quickly and love new challenges.  

[![Portfolio](https://img.shields.io/badge/Portfolio-Live_Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![Resume](https://img.shields.io/badge/Resume-PDF-bd93f9?style=for-the-badge&logo=adobeacrobatreader&logoColor=white&labelColor=6272a4)](https://raw.githubusercontent.com/theonliestmattastic/theonliestmattastic.github.io/main/assets/docs/resume.pdf)
[![Email](https://img.shields.io/badge/Email-matthew.poole485%40gmail.com-bd93f9?style=for-the-badge&logo=gmail&logoColor=white&labelColor=6272a4)](mailto:matthew.poole485@gmail.com)  

> *“Sometimes the questions are complicated and the answers are simple.”* — Dr. Seuss  
