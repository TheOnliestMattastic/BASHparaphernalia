# 🌈 $!LOGme

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./assets/banner-dark.png">
  <source media="(prefers-color-scheme: light)" srcset="./assets/banner-light.png">
  <img alt="Banner" src="./assets/banner-light.png">
</picture>

![License](https://img.shields.io/badge/License-GPL--3.0-bd93f9?style=for-the-badge&logo=gnu&logoColor=white&labelColor=6272a4)
[![Live Site](https://img.shields.io/badge/Toolkit-Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/BASHparaphernalia/)
[![Portfolio](https://img.shields.io/badge/Portfolio-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![GitHub](https://img.shields.io/badge/GitHub-Profile-bd93f9?style=for-the-badge&logo=github&logoColor=white&labelColor=6272a4)](https://github.com/theonliestmattastic)

## 🔭 Overview

This repository contains `LOGme.sh`, a Bash script that enhances your login experience by setting up RGB lighting and displaying a fun fortune message. It includes intelligent autostart configuration and comprehensive error handling.

## 🌟 Features

- **RGB Profile Management**: Automatically loads your preferred OpenRGB profile for consistent lighting
- **Interactive Fortune Display**: Shows a random fortune message in a cow-themed bubble using xcowsay
- **Smart Autostart Setup**: Detects if already configured and prompts for setup only when needed
- **Dependency Validation**: Checks for required tools and provides helpful installation instructions
- **Robust Error Handling**: Continues execution even if individual components fail, with detailed error reporting
- **User-Friendly Prompts**: Interactive setup for autostart configuration with clear yes/no prompts
- **Cross-Desktop Support**: Works with both KDE Plasma and GNOME autostart mechanisms

## ⚛️ Requirements

- Linux system with X11 (for OpenRGB and xcowsay compatibility)
- `openrgb` installed and configured with a profile named `Home`
- `xcowsay` package (provides `xcowfortune` command)
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
1. Check for required dependencies
2. Prompt to set up autostart (if not already configured)
3. Set your OpenRGB profile to "Home"
4. Display a fortune message in a cow bubble

### Autostart Configuration

The script automatically detects existing autostart configurations and only prompts for setup when needed. If you choose to enable autostart, it creates a `.desktop` file in `~/.config/autostart/` for cross-desktop compatibility.

## 🌠 TODO: Future Features

- [ ] **Custom RGB Profiles**: Allow selection from multiple saved OpenRGB profiles
- [ ] **Multiple Fortune Sources**: Support for different fortune databases or custom messages
- [ ] **Weather Integration**: Display current weather information alongside fortune
- [ ] **System Status Display**: Show system information (uptime, disk usage, etc.)
- [ ] **Music Player Integration**: Display current playing track information
- [ ] **Customizable Timing**: Allow users to set display duration for messages

## 🌌 Contributing

Contributions welcome! Report issues or suggest improvements via GitHub.

## 🌕 Notes

- The script requires OpenRGB to be properly configured with a profile named "Home"
- If OpenRGB fails, the script continues and still shows the fortune message
- Autostart setup works on both KDE Plasma (autostart-scripts) and GNOME (.desktop files)
- The fortune display uses xcowsay for visual appeal but falls back gracefully if unavailable
- All operations are logged with clear error messages for troubleshooting

## 🛸 License

This project is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html).

## 🪐 Recruiter's Note

Demonstrates practical system automation with user interaction, dependency management, cross-platform compatibility, and graceful error handling for desktop environment integration.

## 👽 Contact

[![Portfolio](https://img.shields.io/badge/Portfolio-Live_Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![Resume](https://img.shields.io/badge/Resume-PDF-bd93f9?style=for-the-badge&logo=adobeacrobatreader&logoColor=white&labelColor=6272a4)](https://raw.githubusercontent.com/theonliestmattastic/theonliestmattastic.github.io/main/assets/docs/resume.pdf)
[![Email](https://img.shields.io/badge/Email-matthew.poole485%40gmail.com-bd93f9?style=for-the-badge&logo=gmail&logoColor=white&labelColor=6272a4)](mailto:matthew.poole485@gmail.com)

> *"Sometimes the questions are complicated and the answers are simple."* — Dr. Seuss
