#!/usr/bin/env bash

# Android Kernel Build Script

# Setup colour for the script
blue='\033[0;34m'
yellow='\033[0;33m'
white='\033[0m'
red='\033[0;31m'
green='\e[0;32m'
magenta='\033[1;35m'
lgreen='\e[92m'
cyan='\033[0;36m'
purple='\033[0;35m'
pink='\033[38;5;206m'
orange_yellow='\033[38;5;214m'
greenish_yellow='\033[38;5;190m'
blink_red='\033[05;31m'
blink_green='\033[1;32;5m'
blink_yellow='\033[1;33;5m'
reset='\e[0m'

##------------------------------------------------------##

# Function to show an informational message
msg() {
    echo -e "\e[1;32m$*\e[0m"
}

err() {
    echo -e "\e[1;41m$*\e[0m"
    exit 1
}

##------------------------------------------------------##

# Timeout
function countdown() {
    for ((i = $1; i > 0; i--)); do
        echo "Countdown: $i"
        sleep 1
    done
}

##------------------------------------------------------##

# Get Linux distro and version
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

echo $OS $VER

##------------------------------------------------------##

# Check if is Legendary!
if [[ "$OS" == *"Tumbleweed"* ]]; then
    echo -e "${magenta} << You are LEGENDARY! >> ${white}"
else
    echo -e "${lgreen} << May the force be with you! >> ${reset}"
fi

##------------------------------------------------------##

# Check if a good linux is being used
if [[ "$OS" == *"SUSE"* ]] || [[ "$OS" == *"Regata"* ]] || [[ "$OS" == *"Fedora"* ]] || [[ "$OS" == *"Nobara"* ]] || [[ "$OS" == *"Ultramarine"* ]] || [[ "$OS" == *"Rocky"* ]] || [[ "$OS" == *"Arch"* ]]; then
    echo -e "${cyan} << Congratulations! You are using a decent Linux >> ${white}"
else
    echo -e "${red} << Danger detected! You are using MEME linux. Get out of this garbage as soon as possible >> ${white}"
fi

##------------------------------------------------------##

# Setup the build environment if OS is openSUSE
AKHILNARANG="environment"
msg $green "|| Clone & Build environment ||" $white
if [[ "$OS" == *"SUSE"* ]] || [[ "$OS" == *"Regata"* ]]; then
    echo -e "${blue} << Environment to openSUSE >> ${white}"
    # Check if $DIR exists or not
    if [[ ! -d "$AKHILNARANG" ]]; then
        echo -e "$yellow $AKHILNARANG not found, downloading... $white"
        git clone --depth=1 https://github.com/TogoFire/scripts -b akh ${AKHILNARANG}
        cd "${AKHILNARANG}" && bash setup/opensuse.sh
        cd ..
    else
        echo -e "$yellow $AKHILNARANG found, skipping step $white"
    fi
fi

# Setup the build environment if OS is Fedora
if [[ "$OS" == *"Fedora"* ]] || [[ "$OS" == *"Nobara"* ]] || [[ "$OS" == *"Ultramarine"* ]] || [[ "$OS" == *"Rocky"* ]]; then
    echo -e "${blue} << Environment to Fedora >> ${white}"
    # Check if $DIR exists or not
    if [[ ! -d "$AKHILNARANG" ]]; then
        echo -e "$yellow $AKHILNARANG not found, downloading... $white"
        git clone --depth=1 https://github.com/TogoFire/scripts -b akh ${AKHILNARANG}
        cd "${AKHILNARANG}" && bash setup/fedora.sh
        cd ..
    else
        echo -e "$yellow $AKHILNARANG found, skipping step $white"
    fi
fi

# Setup the build environment if OS is Arch
if [[ "$OS" == *"Arch"* ]] || [[ "$OS" == *"Manjaro"* ]] || [[ "$OS" == *"Endeavour"* ]] || [[ "$OS" == *"Garuda"* ]]; then
    echo -e "${blue} << Environment to Arch >> ${white}"
    # Check if $DIR exists or not
    if [[ ! -d "$AKHILNARANG" ]]; then
        echo -e "$yellow $AKHILNARANG not found, downloading... $white"
        git clone --depth=1 https://github.com/akhilnarang/scripts ${AKHILNARANG}
        cd "${AKHILNARANG}" && bash setup/arch-manjaro.sh
        cd ..
    else
        echo -e "$yellow $AKHILNARANG found, skipping step $white"
    fi
fi

# Setup the build environment if OS is MEME
if [[ "$OS" == *"Ubuntu"* ]] || [[ "$OS" == *"Mint"* ]] || [[ "$OS" == *"Debian"* ]] || [[ "$OS" == *"Pop"* ]] || [[ "$OS" == *"Zorin"* ]] || [[ "$OS" == *"Elementary"* ]] || [[ "$OS" == *"Mx"* ]] || [[ "$OS" == *"antiX"* ]] || [[ "$OS" == *"Sparky"* ]] || [[ "$OS" == *"Parrot"* ]] || [[ "$OS" == *"Deepin"* ]] || [[ "$OS" == *"Kali"* ]] || [[ "$OS" == *"KDE"* ]] || [[ "$OS" == *"Lite"* ]]; then
    echo -e "${pink} << Environment to MEME Linux >> ${white}"
    # Check if $DIR exists or not
    if [[ ! -d "$AKHILNARANG" ]]; then
        echo -e "$yellow $AKHILNARANG not found, downloading... $white"
        git clone --depth=1 https://github.com/TogoFire/scripts -b akh ${AKHILNARANG}
        cd "${AKHILNARANG}" && bash setup/android_build_env.sh
        cd ..
    else
        echo -e "$yellow $AKHILNARANG found, skipping step $white"
    fi
fi

##------------------------------------------------------##

# Clone AnyKernel3
ANYKERNEL3_VERSION="AnyKernel3"
msg $green "|| Cloning AnyKernel3 ||" $white

# Check if AnyKernel directory exists
if [[ ! -d "$ANYKERNEL3_VERSION" ]]; then
    echo -e "$yellow $ANYKERNEL3_VERSION not found, downloading... $white"
    
# Display options and accept choice from user
echo -e "${magenta}\n👉 Choose AnyKernel version: ${white}"
echo -e "${blue}1. Panda"
echo "2. NetHunter"
echo "3. NetErnels"
echo "4. KernelSU"
echo "5. GCC"
echo "6. McQuaid"
echo "7. Onion"
echo "8. Thor"
echo "9. Biogenesis"
echo -e "10. Mystique\n${white}"
read -t 5 -p "Enter your choice [1-10]: " choice || {
    echo -e "$cyan Timeout of 5 seconds reached. No input received. $white"
    echo -e "$lgreen Ak3 choice to 1. $white"
    choice=4
    }

    case $choice in
        1)
            git clone --depth=1 https://github.com/TogoFire/AnyKernel3 -b Panda "${ANYKERNEL3_VERSION}"
            ;;
        2)
            git clone --depth=1 https://github.com/TogoFire/AnyKernel3 -b Panda-Nethunter "${ANYKERNEL3_VERSION}"
            ;;
        3)
            git clone --depth=1 https://github.com/TogoFire/AnyKernel3 -b NetErnels "${ANYKERNEL3_VERSION}"
            ;;
        4)
            git clone --depth=1 https://github.com/TogoFire/AnyKernel3 -b Panda-KSU "${ANYKERNEL3_VERSION}"            
            ;;
        5)
            git clone --depth=1 https://github.com/TogoFire/AnyKernel3 -b Panda-GCC "${ANYKERNEL3_VERSION}"
            ;;
        6)
            git clone --depth=1 https://github.com/TogoFire/AnyKernel3 -b McQuaid "${ANYKERNEL3_VERSION}"
            ;;
        7)
            git clone --depth=1 https://github.com/TogoFire/AnyKernel3 -b Onion "${ANYKERNEL3_VERSION}"
            ;;
        8)
            git clone --depth=1 https://github.com/TogoFire/AnyKernel3 -b Thor "${ANYKERNEL3_VERSION}"
            ;;
        9)
            git clone --depth=1 https://github.com/TogoFire/AnyKernel3 -b Biogenesis "${ANYKERNEL3_VERSION}"
            ;;
        10)
            git clone --depth=1 https://github.com/TogoFire/AnyKernel3 -b Mystique "${ANYKERNEL3_VERSION}"
            ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
    
else
    echo -e "$yellow $ANYKERNEL3_VERSION found, skipping step $white"   
fi

    # Check which AnyKernel version is currently being used
    cd $ANYKERNEL3_VERSION
    
    # Get the current branch name, indicated by an asterisk (*), and extract the version number
    CURRENT_VERSION=$(git branch -a | grep '*' | awk '{print $2}' | sed 's/^[[:alpha:]]\///')
    
    if [[ -n "$CURRENT_VERSION" ]]; then
        ANYK_VERSION="$CURRENT_VERSION"
        echo -e "$greenish_yellow Currently being used Anykernel version: $ANYK_VERSION $white"
    else
        echo -e "$red Could not detect AnyKernel version! $white"
        exit 1
    fi
    cd ..

##------------------------------------------------------##

# KernelSU
# Check if AK3 is KSU version to build KernelSU
if [[ "$ANYK_VERSION" == *"KSU"* ]]; then
    sed -i 's/# CONFIG_KSU is not set/CONFIG_KSU=y/' arch/arm64/configs/daisy_defconfig
    echo -e "$cyan KernelSU option selected and enabled to be built! $white"
fi

##------------------------------------------------------##

# Nethunter | NetErnels | KSU
# Check if AK3 is Nethunter version to build Kali Nethunter
if [[ "$ANYK_VERSION" == *"Nethunter"* ]] || [[ "$ANYK_VERSION" == *"Nethunter"* ]]; then
    sed -i 's/# CONFIG_KSU is not set/CONFIG_KSU=y/' arch/arm64/configs/daisy_defconfig
    sed -i 's/# CONFIG_NETHUNTER_SUPPORT is not set/CONFIG_NETHUNTER_SUPPORT=y/' arch/arm64/configs/daisy_defconfig
    echo -e "$cyan Nethunter & KSU option selected and enabled to be built! $white"
fi

##------------------------------------------------------##

# Clean-up
echo -e "${orange_yellow} Clean-up ${white}"
rm -rf error.log
rm -rf changelog/*
rm -rf ./*.tar.gz

##------------------------------------------------------##

# Create a filename for our changelog in a changelog directory
CHANGELOG_DIR="changelog"
CHANGELOG_FILE="$CHANGELOG_DIR/kernel-changelog.txt"

# Check if the changelog directory exists, and create it if it doesn't
if [ ! -d "$CHANGELOG_DIR" ]; then
  mkdir "$CHANGELOG_DIR"
fi

# Use git log to get the most recent kernel commits
git log -n 350 --pretty=format:"%h - %s (%an)" > $CHANGELOG_FILE

# Print the location of the changelog file
echo -e "${purple} Changelog saved to $CHANGELOG_FILE ${white}"

# Add commit names to the changelog file
sed -i -e "s/^/- /" $CHANGELOG_FILE

##------------------------------------------------------##

# Calculate how long compiling compiling the kernel took
BUILD_START=$(date +"%s")
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))

##------------------------------------------------------##

# This script will ask you if you want to compile with GCC or Clang.
echo -e "${magenta}\n👊 Checking which compiler was chosen ${white}"
echo "1. Clang"
echo "2. GCC"
#read -t 4 -p "Enter your choice [1-2]: " choice || {
#  echo -e "$cyan Timeout of 4 seconds reached. No input received. $white"
#}

if [[ $GCC_VERSION =~ "gcc-eva" ]]; then
  choice=2
else
  choice=1
fi

if [[ $choice == 2 ]]; then
  echo -e "$cyan You have chosen to use GCC. $white"
else
  echo -e "$cyan You have chosen to use Clang. $white"
fi

##------------------------------------------------------##

# Targets | export
export CROSS_COMPILE_ARM32=arm-linux-gnueabihf-
       CROSS_COMPILE=aarch64-linux-gnu-

##------------------------------------------------------##

# Targets | Makefile
echo -e "$yellow \n ^=^q^i Do you want to Targets to .config? [Y/n] $white"
    read -t 15 -p "$(tput setaf 171) Enter your answer: " response || {
    echo -e "$cyan Timeout of 15 seconds reached. No input received. $white"
    }

if [[ $response =~ ^[Yy]$ ]]; then

make -j6 O=out ARCH=arm64 SUBARCH=arm64 CC=clang-17 daisy_defconfig


else
  echo -e "$lgreen .config to makefile  was not Targets. $white"
fi

##------------------------------------------------------##

# Change to ship menuconfig
echo -e "$yellow \n ^=^q^i Do you want to change to .config? [Y/n] $white"
    read -t 15 -p "$(tput setaf 171) Enter your answer: " response || {
    echo -e "$cyan Timeout of 15 seconds reached. No input received. $white"
    }

if [[ $response =~ ^[Yy]$ ]]; then

make -j6 O=out ARCH=arm64 SUBARCH=arm64 CC=clang-17 menuconfig


else
  echo -e "$lgreen .config to menuconfig was not change. $white"
fi

##------------------------------------------------------##

# Save new .config to main
echo -e "$yellow \n ^=^q^i Do you want to save to .config? [Y/n] $white"
    read -t 15 -p "$(tput setaf 171) Enter your answer: " response || {
    echo -e "$cyan Timeout of 15 seconds reached. No input received. $white"
    }

if [[ $response =~ ^[Yy]$ ]]; then

cp -r out/.config arch/arm64/configs/RedMarsh_defconfig

else
echo -e "$lgreen .config to arch/arm64/configs/ directory was not moved. $white"
fi

##------------------------------------------------------##
#Build Start

make -j6 O=out ARCH=arm64 SUBARCH=arm64 CC=clang-17


##------------------------------------------------------##

# Zip up the kernel
zip_kernelimage() {
    rm -rf "$(pwd)"/AnyKernel3/Image.gz-dtb
    cp "$(pwd)"/out/arch/arm64/boot/Image.gz-dtb AnyKernel3
    rm -rf "$(pwd)"/AnyKernel3/*.zip
    BUILD_TIME=$(date +"%d%m%Y-%H%M")
    cd AnyKernel3 || exit
    zip -r9 "${ANYK_VERSION}"-U"${RELEASE}"-"${BUILD_TIME}".zip ./*
    cd ..
}

##------------------------------------------------------##

# Get MD5SUM and SHASUM of the zipped kernel
Hash() {
    SHA=$(shasum "$(pwd)"/AnyKernel3/${ANYK_VERSION}-U"${RELEASE}"-"${BUILD_TIME}".zip | cut -f 1 -d '/')
    MD5=$(md5sum "$(pwd)"/AnyKernel3/${ANYK_VERSION}-U"${RELEASE}"-"${BUILD_TIME}".zip | cut -f 1 -d '/')
}

##------------------------------------------------------##

msg $green "|| Zipping into a flashable zip ||" $white
FILE="$(pwd)/out/arch/arm64/boot/Image.gz-dtb"
if [ -f "$FILE" ]; then
    zip_kernelimage
    Hash
    echo -e "$green << Build completed in $(($Diff /60)) minutes and $(($Diff % 60)) seconds >> \n $white"
    echo -e "The kernel has successfully been compiled and can be found in $(pwd)/AnyKernel3/${greenish_yellow}${ANYK_VERSION}-r${RELEASE}-${BUILD_TIME}.zip $white"
    echo -e "$greenish_yellow  MD5 Checksum : $MD5 $white"
    echo -e "$greenish_yellow SHA1 Checksum : $SHA $white"
    rm -rf error.log
    read -r -p "Press enter to continue"
    msg $blink_green "|| Enjoy! ^^ ||" $white
    
    # Upload to mega
    # Asks the user if they want to upload the file
    echo -e "$yellow \n👉 Do you want to upload the file to megaupload? (y/n) $white"
    read -t 15 -p "$(tput setaf 171) Enter your answer: " answer || {
    echo -e "$cyan Timeout of 15 seconds reached. No input received. $white"
    echo -e "$lgreen Setting choice to n. $white"
    answer=n
    }

    if [[ $answer == "y" ]]; then
    # Asks the user for their email and password
    echo -e "$blue Enter your email address: $white"
    read -p "$(tput setaf 171) Email: " email
    echo -e "$blue Enter your password: $white"
    read -s -p "$(tput setaf 171) Password: " password

    # Uploads the file
    megaput $(pwd)/AnyKernel3/${ANYK_VERSION}-U${RELEASE}-${BUILD_TIME}.zip -u $email -p $password
    countdown 3
    echo -e "$reset 👍 $white"
    fi

else
    echo -e "$red << Failed to compile the kernel in $(($Diff / 60)) minutes and $(($Diff % 60)) seconds >> \n $white"
    cat error.log | curl -F 'file=@error.log' https://bin.cyberknight777.dev
    echo -e "$blink_red << Check up to find the error >> $white"
    read -r -p "Press enter to continue"
    msg $blink_green "|| Good luck!  ||" $white
fi

##------------------------------------------------------##

# Check gcc log
if [[ $GCC_VERSION =~ "gcc-eva" ]]; then
    echo -e "$cyan \nGCC log: $white"
    cat out/error.log | curl -F 'file=@out/error.log' https://bin.cyberknight777.dev
fi

##------------------------------------------------------##

# Nuke Ak3
echo -e "$yellow \n👉 Do you want to remove the AnyKernel3 directory? [Y/n] $white"
    read -t 5 -p "$(tput setaf 171) Enter your answer: " response || {
    echo -e "$cyan Timeout of 5 seconds reached. No input received. $white"
    }

if [[ $response =~ ^[Yy]$ ]]; then
    rm -rf AnyKernel3
else
    echo -e "$lgreen AnyKernel3 directory was not removed. $white"
fi

##------------------------------------------------------##

# Save to config
echo -e "$yellow \n👉 Do you want to save to .config? [Y/n] $white"
    read -t 15 -p "$(tput setaf 171) Enter your answer: " response || {
    echo -e "$cyan Timeout of 15 seconds reached. No input received. $white"
    }

if [[ $response =~ ^[Yy]$ ]]; then

    cp -r out/.config arch/arm64/configs/sakura_defconfig
else
  echo -e "$lgreen .config to arch/arm64/configs/ directory was not moved. $white"
fi

##------------------------------------------------------##
