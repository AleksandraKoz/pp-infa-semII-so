#!/bin/bash

help() {
    echo "NAME: Morse decoder"
    echo "DESCRIPTION: A script to help user to encode a word or phrase to a morse code. User can get the result in console, but also can save it in result.txt file."
    echo ""
}


upper() {
    echo "$1" | tr [a-z] [A-Z]
}


declare -A morse 
morse["A"]=".-"
morse["B"]="-..."
morse["C"]="-.-."
morse["D"]="-.."
morse["E"]="."
morse["F"]="..-."
morse["G"]="--."
morse["H"]="...."
morse["I"]=".."
morse["J"]=".---"
morse["K"]="-.-"
morse["L"]=".-.."
morse["M"]="--"
morse["N"]="-."
morse["O"]="---"
morse["P"]=".--."
morse["Q"]="--.-"
morse["R"]="--.-"
morse["S"]="..."
morse["T"]="-"
morse["U"]="..-"
morse["V"]="...-"
morse["W"]=".--"
morse["X"]="-..-"
morse["Y"]="-.--"
morse["Z"]="--.."

morse["1"]=".----"
morse["2"]="..---"
morse["3"]="...--"
morse["4"]="....-"
morse["5"]="....."
morse["6"]="-...."
morse["7"]="--..."
morse["8"]="---.."
morse["9"]="----."
morse["0"]="-----"


main() {
    if [ "$help_option" == true ]; then
        help
    else
        for l in $(echo $args | sed -e 's/\(.\)/\1\n/g'); do
        if [ "$l" != "|" ]; then
            output="${output} ${morse[$l]} ";
        else
            output="${output}$sep"
        fi
        done
    fi
}

# settings
help_option=false


sep="|"
args=""
for arg; do
    args="${args} $(upper "$arg") |"
done


if [ "$args" == "" ]; then
        help_option=true
fi


for word in $args; do 
    if [ "$word" == "-H" ]; then
        help_option=true
    fi
    
    
done


main $args


echo "$output"
# echo "$args"