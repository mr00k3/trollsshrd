<h1 align="center">trollsshrd.sh<h1>

<p align="center">Script to install TrollStore via SSHRD</p>


# Requirements
- Needs a checkm8 vulnerable iOS device on iOS 15.x or 16.x (`A8` - `A11`) with Tips app installed

- **USB-A** cables are recommended to use, USB-C may have issues with getting into DFU mode.

- A computer running **Linux Mint** or **Ubuntu** or even **Arch Linux** with installed 
    - libimobiledevice (usbmuxd, iproxy), libusbmuxd-tools for ubuntu
    - sshpass
    - unzip
    - curl
    - wget
    - git
    - libxml2 (only for arch) 

# Tested on

- iPhone 7 and Arch Linux on T480 works
- iPhone 7 and Linux Mint works
- iPhone 7 and Ubuntu works
- iPhone 7 and Old Toshiba laptop on Arch Linux dont work
- iPhone 7 and Chromebook on Arch Linux dont work getting "read-only system" error in ssh

# Usage

## Ubuntu
`git clone https://github.com/mr00k3/trollsshrd.git && cd trollsshrd` then `sudo ./trollsshrd.sh`

## Arch Linux
run `sudo ln -s /usr/lib/libxml2.so /usr/lib/libxml2.so.2` then 
`git clone https://github.com/mr00k3/trollsshrd.git && cd trollsshrd` then `sudo ./trollsshrd.sh`

# Credits
- [verygenericname](https://github.com/verygenericname) for SSHRD_Script
- [opa334](https://github.com/opa334) for TrollStore and Dopamine
- [mullerdavid](https://www.reddit.com/r/jailbreak/comments/18ftdhr/trollstore_with_sshrd/) for code and inspiration