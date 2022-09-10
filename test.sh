#!/bin/bash

cd ~/

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash;


## Identify SHELL and echo configs accordingly.
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    echo "It's ZSH"
    if ! grep -q 'eval "$(pyenv init -)"' .zshrc; then
        echo "There were not path in the ~/.zshrc file, so I'll add."
        printf '\n### PYENV CONFIGURATION\nexport PYENV_ROOT="$HOME/.pyenv"\nexport PATH="$PYENV_ROOT/bin:$PATH"\neval "$(pyenv init --path)"\neval "$(pyenv init -)"\neval "$(pyenv virtualenv-init -)"\n' >> ~/.zshrc
    fi
fi

if [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    echo "It's BASH"
    if ! grep -q 'eval "$(pyenv init -)"' .zshrc; then
        echo "There were not path in the ~/.bashrc file, so I'll add."
        printf '\n### PYENV CONFIGURATION\nexport PATH="$HOME/.pyenv/bin:$PATH"\neval "$(pyenv init -)"\neval "$(pyenv virtualenv-init -)"\n' >> ~/.bashrc
    fi
fi

## Install dependencies for python versions
sudo apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \ libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \ libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

exec $SHELL