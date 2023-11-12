 #!/bin/bash

main_options=("Fix My Eyes Deceive" "Move My Eyes Deceive to Applications" "Check My Eyes Deceive" "Exit")
selected_option=0

highlight="\e[30;107m"
reset="\e[0m"

bold=$(tput bold)
reset2=$(tput sgr0)


# Regular text color
default_color="\e[0m"

# Colors
black="\e[30m"
red="\e[31m"
green="\e[32m"
yellow="\e[33m"
blue="\e[34m"
purple="\e[35m"
cyan="\e[36m"
white="\e[37m"

# Bold text color
bold_black="\e[1;30m"
bold_red="\e[1;31m"
bold_green="\e[1;32m"
bold_yellow="\e[1;33m"
bold_blue="\e[1;34m"
bold_purple="\e[1;35m"
bold_cyan="\e[1;36m"
bold_white="\e[1;37m"



tp() {
    clear

    columns=$(tput cols)
    center_x=$(( (columns - ${#1}) / 2 ))
    printf "\033[7;49m%*s%s%*s\033[m\n" "$center_x" "" "$1" "$((columns - center_x - ${#1}))"
}

center() {
    # Get the width of the terminal
    columns=$(tput cols)

    # Calculate the center position
    center=$(( (columns - ${#1}) / 2 ))

    # Use ANSI escape codes to center the text
    printf "%${center}s%s%*s\n" "" "$1" "$((columns - center - ${#1}))"
}

centerG() {
    # Get the width of the terminal
    columns=$(tput cols)

    # Calculate the center position
    center=$(( (columns - ${#1}) / 2 ))

    # Use ANSI escape codes to set the text color to gray
    printf "\033[90m%${center}s%s%*s\033[0m\n" "" "$1" "$((columns - center - ${#1}))"
}


# Function to generate a random character from the set of printable ASCII characters
generate_random_char() {
  cat /dev/urandom | LC_CTYPE=C tr -dc '[:print:]' | head -c 1
}

# Function to generate random text with a specified length
generate_random_text() {
  local length=$1
  local random_text=""

  for ((i = 1; i <= length; i++)); do
    random_text="${random_text}$(generate_random_char)"
  done

  echo "$random_text"
}



submenu() {
    local sub_var_name=$1
    shift 
    local sub_options=("$@")
    sub_options+=("Back")
    local sub_selected_option=0


    while true; do
        clear

        for ((i=0; i<${#sub_options[@]}; i++)); do
            if [ $i -eq $sub_selected_option ]; then
                printf "${highlight}%-$(tput cols)s${reset}\n" "${sub_options[i]}"
            else
                echo "${sub_options[i]}"
            fi
        done

        IFS= read -rsn 1 key

        case "$key" in
            $'\e')  
                read -rsn 2 key 
                case "$key" in
                    $'[A')  
                        sub_selected_option=$(( (sub_selected_option - 1 + ${#sub_options[@]}) % ${#sub_options[@]} ))
                        ;;
                    $'[B')  
                        sub_selected_option=$(( (sub_selected_option + 1) % ${#sub_options[@]} ))
                        ;;
                esac
                ;;
            $'')
                case "${sub_options[sub_selected_option]}" in
                    "Back")
                        return
                        ;;
                    *)
                        # Assign the selected option to the variable name provided
                        eval "$sub_var_name='${sub_options[sub_selected_option]}'"
                        return
                        ;;
                esac
                ;;
        esac
    done
}

verbose() {
    printf "${bold_yellow}<Verbose>: ${default_color}${yellow}$1${default_color}\n"
}

info() {
    printf "${bold_cyan}<Info>: ${default_color}${cyan}$1${default_color}\n"
}

error() {
    printf "${bold_red}<Error>: ${default_color}${red}$1${default_color}\n"
}

success() {
    printf "${bold_green}<Success>: ${default_color}${green}$1${default_color}\n"
}

while true; do
    clear

    tp "medFix Loader"

    echo "\n"
    center "Welcome to MedFix!"
    centerG "By NotHansCYDIa"
    echo ""
    centerG "Navigate via up and down arrows"
    centerG "Hit Enter/Return to proceed"
    echo "\n"


    for ((i=0; i<${#main_options[@]}; i++)); do
        if [ $i -eq $selected_option ]; then
            printf "${highlight}%-$(tput cols)s${reset}\n" "${main_options[i]}"
        else
            echo "${main_options[i]}"
        fi
    done

    IFS= read -rsn 1 key

    case "$key" in
        $'\e')  
            read -rsn 2 key 
            case "$key" in
                $'[A')  
                    selected_option=$(( (selected_option - 1 + ${#main_options[@]}) % ${#main_options[@]} ))
                    ;;
                $'[B')  
                    selected_option=$(( (selected_option + 1) % ${#main_options[@]} ))
                    ;;
            esac
            ;;
        $'')
            case "${main_options[selected_option]}" in
                "Fix My Eyes Deceive")
                    
                    osascript -e 'display alert "Heads up!" message "Please aceept if it asks for permission, this is for finding the application." '
                    clear
                    echo "${bold}#============================"
                    echo "#"
                    echo "# medFix Bootstrap"
                    echo "# nothanscydia  :  design inspired by palera1n"
                    echo "#"
                    echo "#============================${reset2}"
                    info "Starting medFind Bootstrap"
                    verbose "Finding \"my-eyes-deceive.app\" with directory \"/\""
                    dir=$(find / -type d -name "my-eyes-deceive.app" -maxdepth 6 2>/dev/null | head -n 1)

                    if [ "$dir" ]; then
                        info "Directory found: $dir"
                        if [ echo $dir | grep -q "/System/Volumes/Data" ]; then
                            verbose "Alias of directory \"/\" is \"/System/Volumes/Data\""
                        fi
                    else
                        error "my-eyes-deceive cannot be found"
                        exit 0
                    fi

                    if [ "$(uname -m)" = "x86_64" ]; then
                        info "$(uname -s)  :  intel64Bit"
                    elif [ "$(uname -m)" = "arm64" ]; then
                        info "$(uname -s)  :  appleSilicon"
                    else
                        error "Your mac doesn't support with my eyes deceive."
                        exit 0
                    fi

                    verbose "Starting medFix Bootstrap"

                    cd $dir/Contents/MacOS
                    if file 'my eyes deceive' | grep -q "executable"; then

                        chmod +x 'my eyes deceive'
                        osascript -e 'display alert "Fixed!" message "My Eyes Deceive has been fixed! Now you can run the game without running the command again."'
                    else
                        error "Unable to fix my-eyes-deceive.app, please go to nouhidev's server and follow Method 2."
                        
                    fi
                    read -n 1 -p "Enter any key to go proceed"






                    exit 0
                    ;;
                "Check My Eyes Deceive")

                    osascript -e 'display alert "Heads up!" message "Please aceept if it asks for permission, this is for finding the application." '
                    clear
                    echo "${bold}#============================"
                    echo "#"
                    echo "# medFix Bootstrap"
                    echo "# nothanscydia  :  design inspired by palera1n"
                    echo "#"
                    echo "#============================${reset2}"
                    info "Starting medFind Bootstrap"
                    verbose "Finding \"my-eyes-deceive.app\" with directory \"/\""
                    dir=$(find / -type d -name "my-eyes-deceive.app" -maxdepth 6 2>/dev/null | head -n 1)

                    if [ "$dir" ]; then
                        info "Directory found: $dir"
                        if [ -d "/System/Volumes/Data" ]; then
                            verbose "Alias of directory \"/\" is \"/System/Volumes/Data\""
                        fi
                    else
                        error "my-eyes-deceive cannot be found"
                        exit 0
                    fi
                    success "My Eyes Deceive was found at: $dir"
                    read -n 1 -p "Enter any key to go proceed"


                    ;;
                "Move My Eyes Deceive to Applications")

                    osascript -e 'display alert "Heads up!" message "Please aceept if it asks for permission, this is for finding the application." '
                    clear
                    echo "${bold}#============================"
                    echo "#"
                    echo "# medFix Bootstrap"
                    echo "# nothanscydia  :  design inspired by palera1n"
                    echo "#"
                    echo "#============================${reset2}"
                    info "Starting medFind Bootstrap"
                    verbose "Finding \"my-eyes-deceive.app\" with directory \"/\""
                    dir=$(find / -type d -name "my-eyes-deceive.app" -maxdepth 6 2>/dev/null | head -n 1)

                    if [ "$dir" ]; then
                        info "Directory found: $dir"
                        if [ -d "/System/Volumes/Data" ]; then
                            verbose "Alias of directory \"/\" is \"/System/Volumes/Data\""
                        fi
                    else
                        error "my-eyes-deceive cannot be found"
                        exit 0
                    fi

                    verbose "Moving my-eyes-deceive to applications"
                    mv $dir /Applications
                    success "Moved game to Applications!"
                    read -n 1 -p "Enter any key to go proceed"


                    ;;
                "Exit")
                    clear
                    exit 0
                    ;;
            esac
            ;;
    esac
done
