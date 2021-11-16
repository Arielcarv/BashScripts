#!/bin/bash

# A script to help the user select among the python versions installed in the system through pyenv.

declare -A DictionaryOfVersions

cd ~/.pyenv/versions/

## Dictionary builder
DictionaryOfVersions[1]='system'
echo "Available Versions:"
echo "1 - 3.8.10"
count=2

for dic in */;
do
	echo "$count - ${dic///}"
    DictionaryOfVersions[$count]=${dic///}
	((count++))
done

echo "Which version do you want?";
read choice

## Version Selector
for ((i = 0; i < $count; i++)); do
    # echo "quanto que ta: ${i}"
    if [[ $choice = $i ]]; then
        finalChoice=${DictionaryOfVersions[$i]}
        pyenv global $finalChoice
        echo "Version changed to: ${finalChoice}"
        eval "$(pyenv init --path)"
        break
    elif [ $choice -ge ${count} ]; then
        ((limit=$count-1))
        echo "That's not a valid number. Choose [1-${limit}]!"
        echo "Which version do you want?";
        read choice
        i=0
    fi
done
