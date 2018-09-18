#! /bin/sh

#############################################################################
#
# Copyright 2018 Graygzou
#
# This file is part of Unity-CI-Template.
#
# Unity-CI-Template is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Unity-CI-Templatae is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Unity-CI-Template.  If not, see <https://www.gnu.org/licenses/>.
#
############################################################################

# LINUX BUILD:
#---------------------------------------------------------------------------
# Unity used this website to host experimental releases of the Linux Editor
# Latest Linux Unity details can be found at https://forum.unity3d.com/threads/unity-on-linux-release-notes-and-known-issues.350256/

# OSX BUILD:
#---------------------------------------------------------------------------
# This link changes from time to time. I haven't found a reliable hosted installer package for doing regular
# installs like this. You will probably need to grab a current link from: http://unity3d.com/get-unity/download/archive
# See $BASE_URL/$HASH/unity-$VERSION-$PLATFORM.ini for complete list of available packages, where PLATFORM is `osx` or `win`

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


if [ "$TRAVIS_OS_NAME" = "linux" ]; then	# LINUX build
     BASE_URL=http://beta.unity3d.com/download
     # HASH=aea5ecb8f9fd+
     HASH=88f43da96871
     # We need that version 2017.3.1f1 here
     # VERSION=2017.3.1f1
     VERSION=2018.2.5f1
     FILENAME=UnitySetup-$VERSION
     # Final url
     url="$BASE_URL/$HASH/./$FILENAME"

     # Install dependencies (see linux's topics in Unity forum)
     echo "travis_fold:start:install_needed_dependencies"
     echo 'Installing needed dependencies'
     sudo apt-get install libgtk2.0-0
     sudo apt-get install libsoup2.4-1
     sudo apt-get install libarchive13
     sudo apt-get install libpng12
     sudo apt-get install libgconf-2-4
     echo "travis_fold:end:install_needed_dependencies"

     # Installation
     echo "travis_fold:start:install_unity"
     echo "Installing Unity"
     echo "Downloading from $url: "
     curl -o "$FILENAME" "$url"
     chmod +x $FILENAME
     # Launch --install-location command
     yes | ./$FILENAME --unattended --install-location=/opt/Unity
     echo "travis_fold:end:install_unity"

     # Make unity executable
     echo "travis_fold:start:postprocessing_install_unity"
     echo "Postprocessing install Unity"
     sudo chmod +x /opt/Unity/Editor/Unity
     echo "travis_fold:end:postprocessing_install_unity"

     # Print the Unity license
     echo "travis_fold:start:print_license"
     echo "Print Unity license"
     /opt/Unity/Editor/Unity \
     	-batchmode \ 
     	-returnlicense \
     	-logfile \
	-quit
     echo "travis_fold:end:print_license"
else # OSX build
     BASE_URL=http://netstorage.unity3d.com/unity	 # Unity used this website to host Unity archive
     # We need that version 2017.3.1f1 here
     HASH=fc1d3344e6ea
     VERSION=2017.3.1f1

     # Installation of Unity
     echo "travis_fold:start:install_unity"
     echo "Installing Unity"
     install "MacEditorInstaller/Unity-$VERSION.pkg"
     install "MacEditorTargetInstaller/UnitySetup-Windows-Support-for-Editor-$VERSION.pkg"
     install "MacEditorTargetInstaller/UnitySetup-Mac-Support-for-Editor-$VERSION.pkg"
     install "MacEditorTargetInstaller/UnitySetup-Linux-Support-for-Editor-$VERSION.pkg"
     echo "travis_fold:end:install_unity"

     # Print the Unity license
     echo "travis_fold:start:print_license"
     echo "Print Unity license"
     /Applications/Unity/Unity.app/Contents/MacOS/Unity \
     	-quit \
     	-batchmode \ 
     	-returnlicense \
     	-logfile
     echo "travis_fold:end:print_license"

fi
