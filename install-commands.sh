#!/bin/sh

if [ $# = 1 ]
then
    installPath="$1"
elif [ $# -gt 1 ]
then
    echo "Please specify only one path"
    exit
else
    installPath="/usr/bin"
fi


echo "Okay to install to $installPath? [y , n]"


while [ true ]
do
    read response

    if [ "$response" = "n" ] || [ "$response" = "N" ]
    then
        exit
    elif [ "$response" != "y" ] && [ "$response" != "Y" ]
    then
        echo "Please enter either y or n"
    else
        break
    fi
done

echo
echo "Installing..."

commands=$(find ./commands -type f -executable)

echo
echo "$commands"

i=0
lines=$(echo "$commands" | wc -l)
while [ $i -lt $lines ]
do
    currentTailAmount=$(echo "$lines - $i" | bc)
    currentCommand="$(echo "$commands" | tail -n $currentTailAmount | head -n 1)"
    
    cp "$currentCommand" "$installPath"

    i=$(echo $i + 1 | bc)
done