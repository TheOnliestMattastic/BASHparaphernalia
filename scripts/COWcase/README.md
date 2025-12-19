# 🌝 COWcase & JUSTcase

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./assets/banner-dark.png">
  <source media="(prefers-color-scheme: light)" srcset="./assets/banner-light.png">
  <img alt="Banner" src="./assets/banner-light.png">
</picture>

![License](https://img.shields.io/badge/License-CC--BY--SA--4.0-bd93f9?style=for-the-badge&logo=creative-commons&logoColor=white&labelColor=6272a4)
[![Live Site](https://img.shields.io/badge/Toolkit-Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/BASHparaphernalia/)
[![Portfolio](https://img.shields.io/badge/Portfolio-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![GitHub](https://img.shields.io/badge/GitHub-Profile-bd93f9?style=for-the-badge&logo=github&logoColor=white&labelColor=6272a4)](https://github.com/theonliestmattastic)

## 🔭 Overview

Two Bash scripts for batch case conversion of file and directory names:

- **COWcase.sh**: Feature-rich with logging, visual feedback, and comprehensive error handling
- **JUSTcase.sh**: Lean, fast alternative that strips UX layers for speed and independence

Both support recursive processing, dry-run previews, and flexible case conversion modes.

## 🌟 Features

### Both Scripts
- **Case Conversion**: Convert first character to lowercase (default) or uppercase (-u)
- **Selective Processing**: Process files (-f) or directories (-d) independently
- **Recursive Mode**: Process entire directory trees (-r)
- **Dry-Run Preview**: Preview changes before applying (-n)
- **Path Targeting**: Specify any directory with -p (defaults to current)
- **Safe Renaming**: Only renames when new name differs from original

### COWcase.sh Only
- **Visual Feedback**: Colorful output with cowsay/lolcat when available
- **Comprehensive Logging**: Records all operations to moo.log
- **Fun UX**: Interactive terminal experience with friendly messages

## ⚛️ Requirements

- Linux system with Bash 4.0+
- `mv` command (standard on all Linux distributions)
- Optional: `cowsay` and `lolcat` for COWcase.sh visual feedback

## 🚀 Blasting Off

Clone the repository:

```sh
git clone https://github.com/TheOnliestMattastic/BASHparaphernalia.git
cd BASHparaphernalia/scripts/COWcase
```

Make executable:

```sh
chmod +x COWcase.sh JUSTcase.sh
```

## 📋 Usage

### COWcase.sh (Feature-Rich)

```sh
./COWcase.sh [OPTIONS]
```

**Options:**
- `-d`: Process only directories (default)
- `-f`: Process only files
- `-u`: Convert to uppercase (default: lowercase)
- `-r`: Enable recursive processing
- `-n`: Dry-run mode (preview only)
- `-p [path]`: Target directory (defaults to current)

**Examples:**

```sh
# Rename all directories in current folder to lowercase
./COWcase.sh -d

# Recursively rename all files to lowercase
./COWcase.sh -f -r

# Preview uppercase rename without applying
./COWcase.sh -f -u -n

# Uppercase all dirs in /tmp/test recursively
./COWcase.sh -d -u -r -p /tmp/test

# Rename all files in /home/user/docs to lowercase
./COWcase.sh -f -p /home/user/docs
```

### JUSTcase.sh (Lightweight)

```sh
./JUSTcase.sh [OPTIONS]
```

**Options:**
- `-d`: Process only directories (default)
- `-f`: Process only files
- `-u`: Convert to uppercase (default: lowercase)
- `-r`: Enable recursive processing
- `-n`: Dry-run mode (preview only)
- `-p [path]`: Target directory (defaults to current)

**Examples:**

```sh
# Rename all files in current directory to lowercase
./JUSTcase.sh -f

# Recursively rename all directories to uppercase
./JUSTcase.sh -d -u -r

# Dry-run preview for recursive rename
./JUSTcase.sh -r -n -p /tmp/test

# Rename files in /home/user/docs to uppercase
./JUSTcase.sh -f -u -p /home/user/docs
```

## 🌠 TODO: Future Features

- [ ] **Pattern Matching**: Support regex patterns to target specific files
- [ ] **Undo Functionality**: Ability to revert renaming operations
- [ ] **Configuration File**: Load renaming rules from external config files
- [ ] **Batch Logging**: Summarize all changes in a single report file

## 🌌 Contributing

Contributions welcome! Report issues or suggest improvements via GitHub.

## 🌕 Notes

### Implementation Details
- Uses Bash parameter expansion `${var^}` and `${var,}` for fast case conversion
- Recursive mode processes directories deepest-first to avoid path conflicts
- Only the first character of each name is converted (rest unchanged)
- Items already matching target case are skipped
- Dry-run mode uses process substitution to safely preview changes

### COWcase.sh
- Visual feedback (cowsay/lolcat) only appears in interactive terminals
- All operations logged to `moo.log` in the working directory
- Gracefully falls back to plain text if tools unavailable

### JUSTcase.sh
- No logging or external dependencies
- Minimal output for scripting integration
- Clean stdout/stderr for piping to other tools
- Faster execution due to reduced UX overhead

## 🛸 License

This project is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International](http://creativecommons.org/licenses/by-sa/4.0/) license.

## 🪐 Recruiter's Note

Demonstrates advanced Bash techniques including:
- Parameter expansion for efficient string manipulation
- Getopts flag parsing for flexible CLI interfaces
- Process substitution and recursive directory traversal
- Graceful dependency fallbacks and error handling
- Modular design patterns (feature-rich vs. lightweight variants)
- Design trade-offs between UX and performance

## 👽 Contact

[![Portfolio](https://img.shields.io/badge/Portfolio-Live_Site-bd93f9?style=for-the-badge&logo=githubpages&logoColor=white&labelColor=6272a4)](https://theonliestmattastic.github.io/)
[![Resume](https://img.shields.io/badge/Resume-PDF-bd93f9?style=for-the-badge&logo=adobeacrobatreader&logoColor=white&labelColor=6272a4)](https://raw.githubusercontent.com/theonliestmattastic/theonliestmattastic.github.io/main/assets/docs/resume.pdf)
[![Email](https://img.shields.io/badge/Email-matthew.poole485%40gmail.com-bd93f9?style=for-the-badge&logo=gmail&logoColor=white&labelColor=6272a4)](mailto:matthew.poole485@gmail.com)

> *"Sometimes the questions are complicated and the answers are simple."* — Dr. Seuss
