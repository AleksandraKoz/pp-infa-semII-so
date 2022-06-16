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
    echo ""
    echo "-file [FILE_PATH]"
    echo "      This option allows user to encode words from file"
    echo ""
    echo "-out [FILE_NAME]"
    echo "      This option allows user to save the result in file under the given name"
    echo ""
    echo "-switch [DOT] [DASH]"
    echo "      This option allows user to change symbols (dots and dashes) to different ones. A script will take two next characters after choosing this option"
    echo ""
}


getwords() {
    words=""
    lines=`cat $file`
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

morse["|"]="|"


main() {
    if [ "$help_option" == true ]; then
        help
    else
        if [ "$read_file" == true ]; then
            getwords
            args=$words
        fi

        for arg in $args; do
            args="${args}$(upper "$arg") $sep"
        done

        for l in $(echo $args | sed -e 's/\(.\)/\1\n/g'); do
            output="${output} ${morse[$l]} "
        done

        if [ $switches == true ]; then
            if [ "$result_name" == true ]; then
                echo $output | tr . "$dot" | tr - "$dash" > $result
                echo "Encoded text succesfully saved in $result"
            else
                echo $output | tr . "$dot" | tr - "$dash"
            fi
        else
            if [ "$result_file" == true ]; then
                echo $output > $result
                echo "Encoded text succesfully saved in $result"
            else
                echo $output
            fi
        fi
    fi
}


# settings
help_option=false
read_file=false
get_file=false
result_file=false
switches=false
dot_check=false
dash_check=false
result_name=false


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
    fi
    if [ "$word" == "-file" ]; then
        read_file=true
        get_file=true
        args=("${args[@]/"-file"}")
    fi

    if [ "$result_file" == true ]; then
        result=$word
        result_file=false
        result_name=true
        args=("${args[@]/"${result}"}")
    fi
    if [ "$word" == "-out" ]; then
        result_file=true
        args=("${args[@]/"-out"}")
    fi

    if [ "$dash_check" == true ]; then
        dash_check=false
        dash=$word
        args=("${args[@]/"${dash}"}")
    fi
    if [ "$dot_check" == true ]; then
        dash_check=true
        dot_check=false
        dot=$word
        args=("${args[@]/"${dot}"}")
    fi
    if [ "$word" == "-switch" ]; then
        switches=true
        dot_check=true
        args=("${args[@]/"-switch"}")
    fi
done


main $args


# echo $output 
# echo "$args"
