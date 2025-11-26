# 🌝 $!MOOcase

![banner](assets/banner.png)
![License](https://img.shields.io/badge/License-GPL--3.0-bd93f9?style=for-the-badge&logo=gnu&logoColor=white&labelColor=6272a4)
[![Live Site](https://img.shields.io/badge/Toolkit-Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/BASHparaphernalia/)
[![Portfolio](https://img.shields.io/badge/Portfolio-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![GitHub](https://img.shields.io/badge/GitHub-Profile-bd93f9?style=for-the-badge&logo=github&logoColor=white&labelColor=6272a4)](https://github.com/theonliestmattastic)

## 🔭 Overview

This repository contains `MOOcase.sh`, a Bash script to rename files and directories by converting their first character to lowercase. It provides flexible options for batch renaming operations in specified directories.

## 🌟 Features

- **Case Conversion Modes**: Convert first character to lowercase (default) or uppercase (-u option)
- **Selective Processing**: Choose to rename only files (-f) or only directories (-d)
- **Path Specification**: Target any directory with the -p option (defaults to current directory)
- **Safe Renaming**: Only renames items when the new name differs from the original
- **Visual Feedback**: Uses cowsay and lolcat for colorful, fun progress messages when available
- **Error Handling**: Comprehensive error checking with detailed error messages
- **Logging**: Maintains a log file of all operations performed
- **Non-Destructive**: Preserves file contents and metadata during renaming

## ⚛️ Requirements

- Linux system with Bash shell
- `sed` and `mv` commands (standard on most Linux distributions)
- Optional: `cowsay` and `lolcat` for enhanced visual feedback

## 🚀 Blasting Off

Clone the repository:

```sh
git clone https://github.com/TheOnliestMattastic/BASHparaphernalia.git
cd BASHparaphernalia/scripts/MOOcase
```

Make executable and run:

```sh
chmod +x MOOcase.sh
./MOOcase.sh [options] [path]
```

### Options

- `-d`: Process only directories (default mode)
- `-f`: Process only files
- `-u`: Convert first character to uppercase (default is lowercase)
- `-p [path]`: Specify target directory (defaults to current directory)

### Examples

```sh
# Rename all directories in current folder to start with lowercase
./MOOcase.sh -d

# Rename all files in /home/user/documents to start with lowercase
./MOOcase.sh -f -p /home/user/documents

# Rename only files in current directory to start with uppercase
./MOOcase.sh -f -u

# Rename all directories in /tmp/test to start with uppercase
./MOOcase.sh -d -u -p /tmp/test
```

## 🌠 TODO: Future Features

- [ ] **Case Options**: Add support for uppercase conversion or title case
- [ ] **Recursive Processing**: Option to process subdirectories recursively
- [ ] **Pattern Matching**: Support for regex patterns to target specific files
- [ ] **Dry Run Mode**: Preview changes before applying them
- [ ] **Undo Functionality**: Ability to revert renaming operations
- [ ] **Configuration File**: Load renaming rules from external config files

## 🌌 Contributing

Contributions welcome! Report issues or suggest improvements via GitHub.

## 🌕 Notes

- The script uses `sed` with extended regex for case conversion
- Visual feedback (cowsay/lolcat) only appears in interactive terminals
- All operations are logged to `moo.log` in the script directory
- Only the first character of each item name is converted to lowercase
- Items that already start with lowercase letters are left unchanged

## 🛸 License

This project is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html).

## 🪐 Recruiter's Note

Demonstrates file system manipulation, command-line argument parsing, error handling, and optional dependency management for robust Linux automation scripts.

## 👽 Contact

[![Portfolio](https://img.shields.io/badge/Portfolio-Live_Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![Resume](https://img.shields.io/badge/Resume-PDF-bd93f9?style=for-the-badge&logo=adobeacrobatreader&logoColor=white&labelColor=6272a4)](https://raw.githubusercontent.com/theonliestmattastic/theonliestmattastic.github.io/main/assets/docs/resume.pdf)
[![Email](https://img.shields.io/badge/Email-matthew.poole485%40gmail.com-bd93f9?style=for-the-badge&logo=gmail&logoColor=white&labelColor=6272a4)](mailto:matthew.poole485@gmail.com)

> *"Sometimes the questions are complicated and the answers are simple."* — Dr. Seuss
