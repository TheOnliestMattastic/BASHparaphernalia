# $!DONtype

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

This script automates the setup of in-game keybindings for *Schedule I*, an indie game on Steam. It uses `xdotool` to simulate keyboard input, binding common teleport locations and utility commands to function keys (F1-F12), eliminating the need for manual typing during gameplay.

## 🌟 Features

- **Automated Keybinding**: Binds teleport commands to F1-F9 for quick access to locations like motel room, sweatshop, storage unit, etc.
- **Utility Commands**: Assigns balance manipulation and inventory management to F10-F12.
- **Dependency Validation**: Automatically checks for required tools (xdotool) before execution with helpful error messages.
- **Error Handling & Recovery**: Continues with remaining bindings if one fails, providing detailed error reporting at completion.
- **Progress Feedback**: Real-time countdown timer and binding progress messages for user awareness.
- **Robust Execution**: Comprehensive error handling with cleanup on interruption and undefined variable prevention.
- **Non-Interactive Execution**: Runs automatically after a 5-second countdown, allowing time to switch to the game window.
- **Optimized Timing**: Fine-tuned delays between commands for reliable execution without unnecessary waits.
- **Gaming Efficiency**: Completes setup in ~20 seconds instead of several minutes of manual input.

## ⚛️ Requirements

- Linux system with X11 (for `xdotool` compatibility).
- `xdotool` installed (`sudo dnf install xdotool` on Fedora/Nobara).

## 🚀 Blasting Off

Clone the repository:

```sh
git clone https://github.com/TheOnliestMattastic/BASHparaphernalia.git
cd BASHparaphernalia/scripts/DONtype
```

Make executable and run:

```sh
chmod +x DONtype.sh
./DONtype.sh
```

Switch to the game window within 5 seconds.

## 🔧 Keybindings Set

- **F1**: `~bind f1 teleport motelroom`
- **F2**: `~bind f2 teleport sweatshop`
- **F3**: `~bind f3 teleport storageunit`
- **F4**: `~bind f4 teleport bungalow`
- **F5**: `~bind f5 teleport barn`
- **F6**: `~bind f6 teleport docks`
- **F7**: `~bind f7 teleport laundromat`
- **F8**: `~bind f8 teleport postoffice`
- **F9**: `~bind f9 teleport church`
- **F10**: `~bind f10 changebalance 1000` (Increase bank balance by 1000)
- **F11**: `~bind f11 cleartrash`
- **F12**: `~bind f12 clearinventory`

## 🌌 Contributing

Contributions are welcome! Report issues or suggest improvements via GitHub.

## 🌕 Notes

- The script automatically validates dependencies and provides clear error messages if xdotool is missing.
- Progress feedback includes a countdown timer and binding status messages for better user experience.
- If individual bindings fail (due to interruptions), the script continues with remaining ones and reports failures at the end.
- Ensure the game window is active before the script starts typing.
- NPCs may interrupt if they interact during execution; run in a safe area.
- Bindings are easily customizable by editing the associative array in the script.

## 🛸 License

This project is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

## 🪐 Recruiter's Note

Demonstrates advanced automation scripting with robust error handling, dependency validation, progress feedback, and modular code structure for reliable desktop tool integration and gaming productivity.

## 👽 Contact

Curious about my projects? Want to collaborate or hire for entry-level IT/support/dev roles? Shoot me an email or connect on GitHub—I reply quickly and love new challenges.

[![Portfolio](https://img.shields.io/badge/Portfolio-Live_Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![Resume](https://img.shields.io/badge/Resume-PDF-bd93f9?style=for-the-badge&logo=adobeacrobatreader&logoColor=white&labelColor=6272a4)](https://raw.githubusercontent.com/theonliestmattastic/theonliestmattastic.github.io/main/assets/docs/resume.pdf)
[![Email](https://img.shields.io/badge/Email-matthew.poole485%40gmail.com-bd93f9?style=for-the-badge&logo=gmail&logoColor=white&labelColor=6272a4)](mailto:matthew.poole485@gmail.com)

> *"Sometimes the questions are complicated and the answers are simple."* — Dr. Seuss
