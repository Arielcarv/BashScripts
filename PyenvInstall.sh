#!/bin/bash

cd ~/

## Download and install Pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash;

## Identify SHELL type and configure accordingly
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    echo "It's ZSH"
    if grep -q 'eval "$(pyenv init -)"' .zshrc; then
        echo "There were not a PATH in the ~/.zshrc file, so I'll add."
        printf '\n### PYENV CONFIGURATION\nexport PYENV_ROOT="$HOME/.pyenv"\nexport PATH="$PYENV_ROOT/bin:$PATH"\neval "$(pyenv init --path)"' >> ~/.zprofile
        printf '\n### PYENV CONFIGURATION\neval "$(pyenv init -)"\neval "$(pyenv virtualenv-init -)"\n' >> ~/.zshrc
    fi
fi

if [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    echo "\n\nIt's BASH"
    if ! grep -q 'eval "$(pyenv init -)"' .bashrc; then
        echo "\n\nThere were not a PATH in the ~/.bashrc file, so I'll add."
        sed -Ei -e '/^([^#]|$)/ {a \ export PYENV_ROOT="$HOME/.pyenv" a \ export PATH="$PYENV_ROOT/bin:$PATH" a \' -e ':a' -e '$!{n;ba};}' ~/.profile
        printf '\n\n### PYENV CONFIGURATION\neval "$(pyenv init --path)"' >> ~/.profile
        printf '\n\n### PYENV CONFIGURATION\nexport PATH="$HOME/.pyenv/bin:$PATH"\neval "$(pyenv init -)"\neval "$(pyenv virtualenv-init -)"\n' >> ~/.bashrc
    fi
fi

## Install dependencies for python versions
sudo apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \ libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \ libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

## Final message
printf '\n\n Log-out/Log-in for the changes to take action! \n'

# exec $SHELL