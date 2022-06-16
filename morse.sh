#!/bin/bash


help() {
    echo "NAME: Morse encoder"
    echo "DESCRIPTION: A script that helps user to encode a word or phrase to a morse code. User can get the result in console, but also can save it in result.txt file."
    echo ""

    echo ""
    echo "Sample execution:"
    echo "bash morse.sh word1 word2 word3 ..."
    echo ""
    echo "Avaliable options:"
    echo "-h"
    echo "      Help info"
    echo "-file [FILE_PATH]"
    echo "      This option allows user to encode words from file"
    echo ""
}


getwords() {
    words=""
    lines=`cat data.txt`
    for line in $lines; do
        words="${words}${line} "
    done
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

morse[|]="|"


main() {
    if [ "$help_option" == true ]; then
        help
    else
        if [ "$read_file" == true ]; then
            getwords
            args=$words
            # echo "read_file checker ==========="
            # echo "$words"
            # echo "$args"
            # echo "read_file checker ==========="
        fi

        for arg in $args; do
            args="${args}$(upper "$arg") $sep"
        done

        for l in $(echo $args | sed -e 's/\(.\)/\1\n/g'); do
            output="${output} ${morse[$l]} "
        done

    fi
}

# settings
help_option=false
read_file=false
get_file=false


sep=" | "
args=""
for arg; do
    args="${args} $arg"
done


if [ "$args" == "" ]; then
        help_option=true
fi


for word in $args; do 
    if [ "$word" == "-h" ]; then
        help_option=true
    fi    
    if [ "$get_file" == true ]; then
        file=$word
        get_file=false
        getwords
    fi
    if [ "$word" == "-file" ]; then
        read_file=true
        get_file=true
        args=("${args[@]/"-file"}")
    fi    
done


main $args

echo $output 
# echo "$args"
