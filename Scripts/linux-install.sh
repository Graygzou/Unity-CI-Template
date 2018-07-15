#! /bin/sh

# Latest Linux Unity details can be found at https://forum.unity3d.com/threads/unity-on-linux-release-notes-and-known-issues.350256/

# Unity used this website to host experimental releases of the Linux Editor
BASE_URL=http://beta.unity3d.com/download
HASH=aea5ecb8f9fd
# We need that version 2017.3.1f1 here
VERSION=2017.3.1f1
FILENAME=UnitySetup-$VERSION

url="$BASE_URL/$HASH/$FILENAME"

# travis_fold helps make the build clear
echo "travis_fold:start:install_unity"
echo 'Installing Unity'
curl -o $FILENAME $url
chmod +x $FILENAME
./$FILENAME --unattended -install-location=/opt/Unity/Editor/Unity
echo "travis_fold:end:install_unity"

# Usefull ?
echo "travis_fold:start:install_missing_dependencies"
echo 'Installing missing dependencies'
sudo apt-get install -f
echo "travis_fold:end:install_missing_dependencies"







# This link changes from time to time. I haven't found a reliable hosted installer package for doing regular
# installs like this. You will probably need to grab a current link from: http://unity3d.com/get-unity/download/archive

download() {
  file=$1
  url="$BASE_URL/$HASH/$package"

  echo "Downloading from $url: "
  curl -o `basename "$package"` "$url"
}

install() {
  package=$1
  download "$package"

  echo "Installing "`basename "$package"`
  sudo installer -dumplog -package `basename "$package"` -target /
}

# See $BASE_URL/$HASH/unity-$VERSION-$PLATFORM.ini for complete list
# of available packages, where PLATFORM is `osx` or `win`

install "MacEditorInstaller/Unity-$VERSION.pkg"
install "MacEditorTargetInstaller/UnitySetup-Windows-Support-for-Editor-$VERSION.pkg"
install "MacEditorTargetInstaller/UnitySetup-Mac-Support-for-Editor-$VERSION.pkg"
install "MacEditorTargetInstaller/UnitySetup-Linux

set +e
