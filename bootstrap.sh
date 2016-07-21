#!/usr/bin/env bash

set -e

ANSIBLE_CONFIGURATION_DIRECTORY="$HOME/.ansible-mac-setup"

# Download and install Command Line Tools with a checking heuristic
if [[ $(/usr/bin/gcc 2>&1) =~ "no developer tools were found" ]] || [[ ! -x /usr/bin/gcc ]]; then
    echo "Info   | Install   | xcode"
    xcode-select --install
fi

# Download and install Homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
    echo "Info   | Install   | homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Info   | Update   | brew"
	brew update
fi

# Modify the PATH
export PATH=/usr/local/bin:$PATH

# Download and install git
if [[ ! -x /usr/local/bin/git ]]; then
    echo "Info   | Install   | git"
    brew install git
fi

# Download and install Ansible
if [[ ! -x /usr/local/bin/ansible ]]; then
    brew install ansible
fi

# Clone down the Ansible repo
if [[ ! -d $ANSIBLE_CONFIGURATION_DIRECTORY ]]; then
    git clone https://github.com/syzygypl/mac-setup $ANSIBLE_CONFIGURATION_DIRECTORY
fi

cd $ANSIBLE_CONFIGURATION_DIRECTORY
git pull
ansible-playbook main.yml -u $(whoami) --ask-sudo-pass

read -p "Do You wish to configure macOS now ? [yN] " configureMacOS
if [[ $configureMacOS == 'y' ]]; then
    ./macos-setup.sh
fi
