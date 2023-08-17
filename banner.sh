#!/bin/bash
# Ved Patel

function help {
    echo "Usage: banner [OPTION]... STRING"
    echo 
    echo "You can use the following options: "
    echo "-wNum: It will set the width of the banner (default width is the terminal width)"
    echo "-pNum: It will set the space above and below the text"
    echo "-c[CHAR]: It will set the border of the banner to perticular character (without any character it will use asterisks)"
    echo "-n: It will only print the centered text without printing any banner"
    echo
    echo "Replace the STRING with the text to create a banner of that text" 
    echo
    echo "If you just type a text you will have a banner of that text"
    echo
    echo "Created by: Ved Patel"
    exit 0
}

width=$COLUMNS
width=$(tput cols)
padding=0
border_char="-"
text_color="regular"
border_color="default"

#To print the simple banner with default width of the terminal
function simple_banner {
    width=$(tput cols)
    Text=$@
    text_length=${#Text}
    Space1=$(( ($width-$text_length)/2 ))
    Space2=$(( $width-$Space1-$text_length ))

    #banner's first line 
    echo -n '+'
    for (( i = 0 ; i<($width-2) ; i++ ))
    do 
        echo -n "-"
    done
    echo '+'

    #banner's second line 
    echo -n '|'
    for (( n = 0 ; n<($Space1-1); n++ ))
    do
        echo -n  " " 
    done
    echo -n $Text
    for (( n = 0 ; n<($Space2-1) ; n++ ))
    do
        echo -n  " "
    done
    echo '|'

    #banner's last line 
    echo -n '+'
    for (( i = 0 ; i<($width-2) ; i++ ))
    do 
        echo -n "-"
    done
    echo '+'
}

#Printing the customize banner 
function custom_banner {
    #whenever user write "-" then this loop will activate 
    while [[ ${1:0:1} == '-' ]]; do  
        
    #cases for user input like -w -p -c -n -h 
    case "$1" in
        -w*) 
            width=${1:2}
            shift
            ;;
        -p*)
            padding=${1:2}
            shift
            ;;
        -c*)
            if [[ "$1" == "-c" ]]; then
                set -f
                border_char='*'
            else
                border_char="${1:2}"
            fi
            shift
            ;;
        -n*)
            border_char=" "
            shift
            ;;
        --text-colour=*)
                text_color="${1#*=}"
                shift
                ;;
        --border-colour=*)
                border_color="${1#*=}"
                shift
                ;;
        -h | --h*)    
            help
            ;;
        *)
            echo "Usage: banner [OPTION]... STRING"
            echo "Try 'banner -help' for more information."
            exit 0
            ;;
        esac
    done 

    

    pad_space=$(( $width-2 ))
    text=$@
    text_length=${#text}
    first_space=$(( ($width-$text_length)/2 ))
    second_space=$(( $width-$first_space-$text_length ))

    # TO print the top line of the banner 
    for (( i=0; i<($width-1); i++ ))
    do
        echo -n $border_char
    done 
    echo $border_char


    # For padding 
    for (( i=0; i<$padding; i++ ))
    do
        echo -n $border_char
        for (( j=0; j<$pad_space; j++ ))
        do
            echo -n " "
        done
        echo $border_char
    done
        
    #For printing the text line with space
    echo -n $border_char
    for (( i=0; i<($first_space-1); i++ ))
    do  
        echo -n " "
    done
    echo -n $text
    for (( i=0; i<($second_space-1); i++ ))
    do  
        echo -n " "
    done
    echo $border_char

    # For padding under the text of the banner 
    for (( i=0; i<$padding; i++ ))
    do
        echo -n $border_char
        for (( j=0; j<$pad_space; j++ ))
        do
            echo -n " "
        done
        echo $border_char
    done

    #Printing the last line of the banner 
    for (( i=0; i<($width-1); i++ ))
    do
        echo -n $border_char
    done 
    echo $border_char
}


# If the user input the "-" it will print custom banner and if not then it will print simple banner 
if [[ ${1:0:1} == '-' ]]; then
    custom_banner "$@"
else
    simple_banner "$@"
fi
