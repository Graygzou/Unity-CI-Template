#! /bin/sh

# Latest Linux Unity details can be found at https://forum.unity3d.com/threads/unity-on-linux-release-notes-and-known-issues.350256/

# Unity used this website to host experimental releases of the Linux Editor
BASE_URL=http://beta.unity3d.com/download
HASH=aea5ecb8f9fd
# We need that version 2017.3.1f1 here
VERSION=2017.3.1f1
FILENAME=UnitySetup-$VERSION

url="$BASE_URL/$HASH/./$FILENAME"

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
echo "Downloading from $url: "
curl -o "$FILENAME" "$url"
chmod +x $FILENAME
echo "travis_fold:end:preprocessing_install_unity"

# Launch --download-location command
#echo "travis_fold:start:download_unity"
#echo "Download Unity"
#yes | ./$FILENAME --unattended --verbose --download-location=./test --install-location=./UnityTest1
#echo "travis_fold:end:download_unity"

# Launch --install-location command
echo "travis_fold:start:install_unity"
echo "Installing Unity"
yes | ./$FILENAME --unattended --install-location=/opt/Unity
echo "travis_fold:end:install_unity"

echo "travis_fold:start:postprocessing_install_unity"
echo "Postprocessing install Unity"
sudo chmod +x /opt/Unity/Editor/Unity
echo "travis_fold:end:postprocessing_install_unity"
# ----------------------------------------------------------------------
