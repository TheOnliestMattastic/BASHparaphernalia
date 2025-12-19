# 🌈 $!LOGme

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

This repository contains `LOGme.sh`, a Bash script that enhances your login experience by launching an interactive terminal with RGB lighting control, fortune messages, system visualization, and a log of other startup tasks. It includes intelligent autostart configuration and comprehensive error handling.

## 🌟 Features

- **Terminal-Based Display**: Launches wezterm with a split-pane layout for visual feedback and logging
- **RGB Profile Management**: Sets your OpenRGB profile to "Home" within the terminal for ambient lighting control
- **Fortune Display**: Shows random fortune messages rendered through cowsay with syntax highlighting via bat
- **System Visualization**: Displays cbonsai (bonsai tree animation) in the left pane during initialization
- **Task Logging**: Runs additional startup scripts (MTrclone.sh) with visible output for troubleshooting
- **Smart Autostart Setup**: Detects if already configured and prompts for setup only when needed
- **Dependency Validation**: Checks for required tools and provides helpful installation instructions
- **Robust Error Handling**: Continues execution gracefully if components fail, with detailed error reporting
- **User-Friendly Prompts**: Interactive setup for autostart configuration with clear yes/no prompts
- **Cross-Desktop Support**: Works with both KDE Plasma and GNOME autostart mechanisms

## ⚛️ Requirements

- Linux system with X11 support
- `wezterm` - GPU-accelerated terminal emulator
- `openrgb` - installed and configured with a profile named `Home`
- `fortune` - random quote/message generator
- `cowsay` - ASCII art cow message display
- `bat` - syntax-highlighted cat alternative
- `cbonsai` - bonsai tree visualization tool
- Bash shell (standard on most Linux distributions)

## 🚀 Blasting Off

Clone the repository:

```sh
git clone https://github.com/TheOnliestMattastic/BASHparaphernalia.git
cd BASHparaphernalia/scripts/LOGme
```

Make executable and run:

```sh
chmod +x LOGme.sh
./LOGme.sh
```

The script will:
1. Check for all required dependencies
2. Prompt to set up autostart (if not already configured)
3. Launch wezterm with a split-pane layout:
   - **Left pane**: Runs OpenRGB profile setup, then displays cbonsai visualization
   - **Right pane**: Displays a random fortune piped through cowsay and highlighted with bat, then runs MTrclone.sh for additional startup tasks
4. Both panes remain interactive for further commands

### Autostart Configuration

The script automatically detects existing autostart configurations and only prompts for setup when needed. If you choose to enable autostart, it creates a `.desktop` file in `~/.config/autostart/` for cross-desktop compatibility.

## 🌌 Contributing

Contributions are welcome! Report issues or suggest improvements via GitHub.

## 🌕 Notes

- The script requires OpenRGB to be properly configured with a profile named "Home"
- If OpenRGB fails within the terminal, the script continues and still shows the fortune message
- Autostart setup works on both KDE Plasma and GNOME (.desktop files)
- The wezterm terminal remains interactive after initialization, allowing further commands
- All terminal operations log output, providing visibility into startup processes
- Clear error messages are displayed during dependency checks for troubleshooting
- The script uses hardcoded paths for MTrclone.sh; adjust the script if your path differs

## 🛸 License

This project is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

## 🪐 Recruiter's Note

Demonstrates practical system automation with terminal orchestration, split-pane layout management, complex shell command chaining, dependency management, cross-platform compatibility, and graceful error handling. Shows proficiency in user-facing scripting, system integration, and attention to user experience details.

## 👽 Contact

[![Portfolio](https://img.shields.io/badge/Portfolio-Live_Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![Resume](https://img.shields.io/badge/Resume-PDF-bd93f9?style=for-the-badge&logo=adobeacrobatreader&logoColor=white&labelColor=6272a4)](https://raw.githubusercontent.com/theonliestmattastic/theonliestmattastic.github.io/main/assets/docs/resume.pdf)
[![Email](https://img.shields.io/badge/Email-matthew.poole485%40gmail.com-bd93f9?style=for-the-badge&logo=gmail&logoColor=white&labelColor=6272a4)](mailto:matthew.poole485@gmail.com)

> *"Sometimes the questions are complicated and the answers are simple."* — Dr. Seuss
