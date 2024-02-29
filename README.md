<h1 align="center">trollsshrd.sh<h1>

<p align="center">Script to install TrollStore via SSHRD</p>


# Requirements
- Needs a checkm8 vulnerable iOS device on iOS 15.x or 16.x (`A8` - `A11`) with Tips app installed

- **USB-A** cables are recommended to use, USB-C may have issues with getting into DFU mode.

- A computer running **Linux Mint** or **Ubuntu** with installed 
    - libimobiledevice (usbmuxd, iproxy), libusbmuxd-tools for ubuntu
    - sshpass
    - unzip
    - curl
    - wget
    - git

# Tested on

- iPhone 7 and Linux Mint works
- iPhone 7 and Ubuntu works
- iPhone 7 and old toshiba laptop on Arch Linux with hyprland dont work
- iPhone 7 and chromebook on Arch Linux with dwm dont work "read-only system" in ssh

# Usage

`git clone https://github.com/mr00k3/trollsshrd.git && cd trollsshrd` then `sudo ./trollsshrd.sh`

# Credits
- [verygenericname](https://github.com/verygenericname) for SSHRD_Script
- [opa334](https://github.com/opa334) for TrollStore and Dopamine
- [mullerdavid](https://www.reddit.com/r/jailbreak/comments/18ftdhr/trollstore_with_sshrd/) for inspiration