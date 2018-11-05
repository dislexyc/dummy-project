#/bin/bash

#get current version of installed firefox app
currentVersion=$CURRENT_FIREFOX_VERSION

if [[ "$currentVersion" == *"$1"* ]]; then
  echo 'Firefox' "$1" 'present locally. Activating it.'
  /opt/firefox/$1/firefox/firefox
  else
    # if it isn't we need to check if we have it locally
    mkdir -p /tmp/usefirefox
    mkdir -p /opt/firefox
    if [ -e "/opt/firefox/$1" ]; then
      echo 'Firefox' "$1" 'present locally. Activating it.'
     /opt/firefox/$1/firefox/firefox
      echo 'Firefox' "$1" 'has been activated.'
      export CURRENT_FIREFOX_VERSION="$1"
    else
      echo 'Firefox' "$1" 'isnt found locally. Downloading from "https://ftp.mozilla.org/pub/firefox/releases/'
      var1=`wget https://ftp.mozilla.org/pub/firefox/releases/$1/linux-x86_64/en-US/firefox-$1.tar.bz2 -q --show-progress -P /tmp/usefirefox`
      if [ $? -ne 0 ]; then #file doesnt exist / version doesnt exist
        echo "Specified version doesn't exist"
      else
        mkdir /opt/firefox/$1
        tar xjf /tmp/usefirefox/firefox-$1.tar.bz2 -C /opt/firefox/$1
       rm /tmp/usefirefox/firefox-$1.tar.bz2
        echo 'installed Firefox version' "$1" 'to /opt/firefox/'"$1"
                echo "Cleaning up."
                /opt/firefox/$1/firefox/firefox
                echo Firefox "$1" has been activated.
        #bonus works when sourcing the script
        export CURRENT_FIREFOX_VERSION="$1"
        fi
    fi
fi
