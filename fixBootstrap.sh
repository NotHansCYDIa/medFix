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
