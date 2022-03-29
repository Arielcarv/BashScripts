#!/bin/bash

cd ~/

## Download and install Pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash;

## Identify SHELL type and configure accordingly
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    echo "\n\n\033[32m------------ It's ZSH ------------\033[0m\n\n"
    if grep -q 'eval "$(pyenv init -)"' .zshrc; then
        echo "\n\n\033[1;33mThere were not a PATH in the ~/.zshrc file, so I'll add.\033[0m\n\n"
        # echo -e '\n### PYENV CONFIGURATION\nexport PYENV_ROOT="$HOME/.pyenv"\nexport PATH="$PYENV_ROOT/bin:$PATH"\neval "$(pyenv init --path)"' >> ~/.zprofile
        echo -e '\n### PYENV CONFIGURATION\nexport PYENV_ROOT="$HOME/.pyenv"\nexport PATH="$PYENV_ROOT/bin:$PATH"\neval "$(pyenv init --path)"\neval "$(pyenv init -)"\neval "$(pyenv virtualenv-init -)"\n' >> ~/.zshrc
    fi
fi

if [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    echo -e "\n\n\033[32m--------- It's BASH ---------\033[0m\n\n"
    if ! grep -q 'eval "$(pyenv init -)"' .bashrc; then
        echo -e "\n\n\033[1;33mThere were not a PATH in the ~/.bashrc file, so I'll add.\033[0m\n\n"
        # sed -Ei -e '/^([^#]|$)/ {a \ export PYENV_ROOT="$HOME/.pyenv" a \ export PATH="$PYENV_ROOT/bin:$PATH" a \' -e ':a' -e '$!{n;ba};}' ~/.profile
        # printf '\n\n### PYENV CONFIGURATION\neval "$(pyenv init --path)"' >> ~/.profile
        echo -e '\n\n### PYENV CONFIGURATION\nexport PATH="$HOME/.pyenv/bin:$PATH"\neval "$(pyenv init -)"\neval "$(pyenv virtualenv-init -)"\neval "$(pyenv init --path)"' >> ~/.bashrc
    fi
fi

## Install dependencies for python versions
SUDO=''
if [ "$EUID" -ne 0 ]; then
	SUDO='sudo'
fi

$SUDO apt update -qq; 
$SUDO apt install -qq -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev


## Final message
echo -e '\n\n\033[0;36m Log-out/Log-in for the changes to take action! \033[0m\n'

exec $SHELL
