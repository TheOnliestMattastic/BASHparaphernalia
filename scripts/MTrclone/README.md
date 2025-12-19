# ☁️ $!MTrclone

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

This repository contains `MTrclone.sh`, a Bash script to mount cloud drives (OneDrive, GoogleDrive, Dropbox) using rclone with automated verification and notifications.

## 🌟 Features

- **Automated Mounting**: Mounts OneDrive, GoogleDrive, and Dropbox in the background.
- **Mount Verification**: Checks mount status using `findmnt` after mounting.
- **Notifications**: Provides cow-themed notifications via `xcowsay` for success/failure states.
- **Error Handling**: Robust error handling with cleanup on exit.
- **Non-Interactive**: Runs fully automated with proper logging.
- **Directory Creation**: Automatically creates mount directories if they don't exist.

## ⚛️ Requirements

- **rclone** installed and configured with remotes named `OneDrive`, `GoogleDrive`, and `Dropbox`.
- Local mount directories must be empty or non-existent (script creates them).
- Required system commands: `findmnt`, `xcowsay`.
- Nobara or Fedora Linux (or compatible system with required tools).

## 🚀 Mounting Up

Clone the repository:

```sh
git clone https://github.com/TheOnliestMattastic/BASHparaphernalia.git
cd BASHparaphernalia/scripts/MTrclone
```

Make the script executable and run:

```sh
chmod +x MTrclone.sh
./MTrclone.sh
```

### Optional: Run at Login

Select this script via System Settings -> Autostart -> Add New (recommended), or create a `.desktop` file in `~/.config/autostart/`:

```ini
[Desktop Entry]
Exec=/path/to/MTrclone.sh
Icon=application-x-shellscript
Name=MTrclone.sh
Type=Application
X-KDE-AutostartScript=true
```

Ensure the script is executable:

```sh
chmod +x MTrclone.sh
```

## 🌠 TODO: Future Features

- [ ] **Configurable Mount Points**: Allow custom mount directories via command-line flags.
- [ ] **Selective Mounting**: Option to mount only specific drives.
- [ ] **Mount Monitoring**: Continuous monitoring with remount on failure.
- [ ] **Logging Levels**: Verbose/debug logging options.
- [ ] **GUI Notifications**: Alternative notification methods (notify-send, etc.).

## 🌌 Contributing

Contributions are welcome! Please open issues for bugs or feature requests, and submit pull requests for code changes.

## 🌕 Notes

- Designed for Nobara/Fedora with rclone; adapt for other distros if needed.
- Requires proper rclone configuration with exact remote names.
- Mount directories default to `/home/mattastic/{DriveName}`.
- Uses `rclone --vfs-cache-mode full` for optimal performance.
- Waits 60 seconds for mounts to establish before verification.

## 🛸 License

This project is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

## 🪐 Recruiter's Note

This script demonstrates practical system automation skills, including background process management, mount verification, and cross-tool integration in Linux environments.

## 👽 Contact

Curious about my projects? Want to collaborate or hire for entry-level IT/support/dev roles? Shoot me an email or connect on GitHub—I reply quickly and love new challenges.

[![Portfolio](https://img.shields.io/badge/Portfolio-Live_Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![Resume](https://img.shields.io/badge/Resume-PDF-bd93f9?style=for-the-badge&logo=adobeacrobatreader&logoColor=white&labelColor=6272a4)](https://raw.githubusercontent.com/theonliestmattastic/theonliestmattastic.github.io/main/assets/docs/resume.pdf)
[![Email](https://img.shields.io/badge/Email-matthew.poole485%40gmail.com-bd93f9?style=for-the-badge&logo=gmail&logoColor=white&labelColor=6272a4)](mailto:matthew.poole485@gmail.com)

> *"Sometimes the questions are complicated and the answers are simple."* — Dr. Seuss
