#!/bin/bash
items=("Start Fix" "Move Game to Applications" "Check If Game Exists" "Exit")

clear
while true; do
    clear
    echo "Welcome to MedFix (My Eyes Deceive Fix)"
    echo "Select an options"
    
    select item in "${items[@]}"; do
        if [ "$REPLY" -ge 1 ] && [ "$REPLY" -le ${#items[@]} ]; then
            selected_item="${items[$REPLY - 1]}"
            if [ "$selected_item" == "Exit" ]; then
                clear
                exit
            elif [ "$selected_item" == "Start Fix" ]; then
                echo "Please click \"Allow\" when it asks for permission, hit enter/return to proceed..."
                read
                clear
                app=$(find / -maxdepth 6 -name "my-eyes-deceive.app")
                if [ -z "$app" ]; then
                    clear
                    echo "App not found, please install my eyes deceive."
                    exit
                else
                     clear
                     echo "#====================="
                     echo "# medFix v1.0.0"
                     echo "# nothanscydia - macOS"
                     echo "# "
                     echo "#====================="
                     cd $app/Contents/MacOS/
                     chmod +x 'my eyes deceive'
                     osascript -e "display alert \"Installation Complete!\" message \"My Eyes Deceive has been fixed, now you can open the app without re-entering the same command.\""
                     read -p "Press enter/return to play the game."
                     ./'my eyes deceive'
                fi
            elif [ "$selected_item" == "Move Game to Applications" ]; then
                echo "Please click \"Allow\" when it asks for permission, hit enter/return to proceed..."
                read
                clear
                app=$(find / -maxdepth 6 -name "my-eyes-deceive.app")
                if [ -z "$app" ]; then
                    clear
                    echo "App not found, please install my eyes deceive."
                    exit
                else
                     clear
                     echo "#====================="
                     echo "# medFix v1.0.0"
                     echo "# nothanscydia - macOS"
                     echo "# "
                     echo "#====================="
                     mv "$app" "/Applications"
                     osascript -e "display alert \"Moved In!\" message \"My Eyes Deceive has moved in to a new home, it's the Applications folder! The game should be located at the Games folder in Launchpad.\""
                fi
            elif [ "$selected_item" == "Check If Game Exists" ]; then
                echo "Please click \"Allow\" when it asks for permission, hit enter/return to proceed..."
                read
                clear
                app=$(find / -maxdepth 6 -name "my-eyes-deceive.app")
                if [ -z "$app" ]; then
                    clear
                    echo "App not found, please install my eyes deceive."
                    exit
                else
                     clear
                     osascript -e "display alert \"Checked!\" message \"My Eyes Deceive exists!\""
                fi
            fi
        else
            echo "Invalid selection. Please choose a valid item."
        fi
        break
    done
done
