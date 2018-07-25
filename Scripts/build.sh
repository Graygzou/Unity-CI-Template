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

# Change this the name of your project. This will be the name of the final executables as well.
project="Unity-CI-Template"

if [ $TRAVIS_OS_NAME == "linux" ]; then	# LINUX build
  echo "travis_fold:start:build_unity_win"
  echo "Attempting to build $project for Windows"
  /opt/Unity/Editor/Unity \
    -batchmode \
    -nographics \
    -silent-crashes \
    -logFile $(pwd)/unity-win.log \
    -projectPath $(pwd) \
    -buildWindowsPlayer "$(pwd)/Build/windows/$project.exe" \
    -quit
  echo "Windows return code: $?"
  echo "travis_fold:end:build_unity_win"

  echo "travis_fold:start:build_unity_osx"
  echo "Attempting to build $project for OS X"
  /opt/Unity/Editor/Unity \
    -batchmode \
    -nographics \
    -force-opengl \
    -silent-crashes \
    -logFile $(pwd)/unity-osx.log \
    -projectPath $(pwd) \
    -buildOSXUniversalPlayer "$(pwd)/Build/osx/$project.app" \
    -quit
  echo "OS X return code: $?"
  echo "travis_fold:end:build_unity_osx"

  echo "travis_fold:start:build_unity_linux"
  echo "Attempting to build $project for Linux"
  /opt/Unity/Editor/Unity \
    -batchmode \
    -nographics \
    -force-opengl \
    -silent-crashes \
    -logFile $(pwd)/unity-linux.log \
    -projectPath $(pwd) \
    -buildLinuxUniversalPlayer "$(pwd)/Build/linux/$project.exe" \
    -quit
  echo "Linux return code: $?"
  echo "travis_fold:end:build_unity_linux"

  echo "travis_fold:start:build_log"
  echo "Logs from linux build"
  cat $(pwd)/unity-linux.log
  echo "travis_fold:end:build_log"
else  # OSX build
  echo "Attempting to build $project for Windows"
  echo "travis_fold:start:build_unity_win"
  /Applications/Unity/Unity.app/Contents/MacOS/Unity \
    -batchmode \
    -nographics \
    -silent-crashes \
    -logFile $(pwd)/unity-win.log \
    -projectPath $(pwd) \
    -buildWindowsPlayer "$(pwd)/Build/windows/$project.exe" \
    -quit
  echo "travis_fold:end:build_unity_win"
  echo "Windows return code: $?"

  echo "Attempting to build $project for OS X"
  echo "travis_fold:start:build_unity_osx"
  /Applications/Unity/Unity.app/Contents/MacOS/Unity \
    -batchmode \
    -nographics \
    -silent-crashes \
    -logFile $(pwd)/unity-osx.log \
    -projectPath $(pwd) \
    -buildOSXUniversalPlayer "$(pwd)/Build/osx/$project.app" \
    -quit
  echo "travis_fold:end:build_unity_osx"
  echo "OS X return code: $?"

  echo "Attempting to build $project for Linux"
  echo "travis_fold:start:build_unity_linux"
  /Applications/Unity/Unity.app/Contents/MacOS/Unity \
    -batchmode \
    -nographics \
    -silent-crashes \
    -logFile $(pwd)/unity-linux.log \
    -projectPath $(pwd) \
    -buildLinuxUniversalPlayer "$(pwd)/Build/linux/$project.exe" \
    -quit
  echo "travis_fold:start:build_unity_linux"
  echo "Linux return code: $?"

  echo "Logs from osx build"
  echo "travis_fold:start:build_log"
  cat $(pwd)/unity-osx.log
  echo "travis_fold:end:build_log"
fi

set +e
