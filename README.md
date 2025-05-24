# Linux Administrative Menu

Created by Ved Patel

---

## Overview

This project contains two Bash scripts designed to provide a simple system administration menu with common user management tasks, enhanced by a customizable banner display.

- `system_menu.sh` — A menu-driven script to perform administrative functions such as listing users, managing user accounts, and creating welcome messages.
- `banner.sh` — A utility script to print customizable text banners in the terminal, used by `system_menu.sh` to display headers and titles.

---

## Features

### system_menu.sh
- Displays a user-friendly menu for system administration tasks.
- Options include:
  - Printing a list of regular users on the system.
  - Listing all user groups.
  - Adding new users.
  - Creating a welcome file in a user's home directory.
  - Setting account expiration dates.
  - Deleting users safely with confirmation.
  - Logging all administrative actions with timestamps in `useradmin.log`.
- Requires administrator privileges (`sudo`) for user management commands.
- Uses the `banner.sh` script to show attractive headers.

### banner.sh
- Prints banners around provided text with configurable:
  - Width (default terminal width)
  - Padding (space above and below text)
  - Border character (default `-`, customizable)
  - Option to print just centered text without borders
- Supports command-line options:
  - `-wNum` — Set banner width.
  - `-pNum` — Set vertical padding.
  - `-c[CHAR]` — Set border character (default `*` if no character given).
  - `-n` — Print centered text only, no border.
  - `-h` — Display help and usage instructions.

---

## Usage

### Running the System Menu

```bash
chmod +x system_menu.sh banner.sh
./system_menu.sh
```

| Option | Description                                      |
|--------|------------------------------------------------|
| **P**  | Print a list of regular users.                  |
| **L**  | List all user groups.                            |
| **A**  | Add a new user (requires sudo).                  |
| **C**  | Create a welcome file in your home directory.   |
| **S**  | Set an expiration date on a user account (requires sudo). |
| **D**  | Delete a user from the system (requires sudo and confirmation). |
| **Q**  | Quit the menu.                                   |

---

## Running the Banner Script Directly

You can also use the `banner.sh` script independently to print custom banners. Examples:

```bash
./banner.sh "Your Text Here"
./banner.sh -w50 -p1 -c# "Custom Banner"
./banner.sh -n "Centered Text Only"
./banner.sh -h   # Display help information
```

# Requirements

- Linux/Unix environment with Bash shell.
- `sudo` privileges for user management commands.
- Terminal emulator supporting ANSI escape codes (for colors, if extended).
- Scripts have been tested on Bash version 4+.

---

# Logs

All user administration changes made through `system_menu.sh` are logged with timestamps in the file `useradmin.log` located in the same directory.

---

# Notes

- The scripts assume user and group IDs starting from 1000 as regular users/groups.
- Error handling is basic; ensure to run with appropriate permissions.
- Designed for educational and simple system management tasks.

---

# Author

Ved Patel

---

# License

This project is open for personal use and educational purposes. Modify as needed.

---
