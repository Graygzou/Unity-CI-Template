#! /bin/sh

# Latest Linux Unity details can be found at https://forum.unity3d.com/threads/unity-on-linux-release-notes-and-known-issues.350256/

# Unity used this website to host experimental releases of the Linux Editor
BASE_URL=http://beta.unity3d.com/download
HASH=aea5ecb8f9fd
# We need that version 2017.3.1f1 here
VERSION=2017.3.1f1
FILENAME=UnitySetup-$VERSION

url="$BASE_URL/$HASH/$FILENAME"

#-------------------------------------------------------------
# travis_fold helps make the build clear
echo "travis_fold:start:install_needed_dependencies"
echo 'Installing needed dependencies'
sudo apt-get install libgtk2.0-0
sudo apt-get install libsoup2.4-1
sudo apt-get install libarchive13
sudo apt-get install libpng12
sudo apt-get install libgconf-2-4
echo "travis_fold:end:install_needed_dependencies"

# Setup before install
echo "travis_fold:start:preprocessing_install_unity"
echo "Preprocessing install Unity"
curl -o $FILENAME $url
chmod +x $FILENAME
echo "travis_fold:end:preprocessing_install_unity"

# Launch --help command
echo "travis_fold:start:help_unity"
echo "Help command Unity"
curl -o $FILENAME $url
chmod +x $FILENAME
./$FILENAME --help
echo "travis_fold:end:help_unity"

# Launch --download-location command
echo "travis_fold:start:download_unity"
echo "Download Unity"
./$FILENAME --download-location=./test
echo "travis_fold:end:download_unity"

# Launch --install-location command
echo "travis_fold:start:install_unity"
echo "Installing Unity"
./$FILENAME --unattended --install-location=/opt/Unity/Editor/Unity
echo "travis_fold:end:install_unity"
# ----------------------------------------------------------------------
