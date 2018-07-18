#! /bin/sh

# Change this the name of your project. This will be the name of the final executables as well.
project="Unity-CI-Template"

echo "Attempting to build $project for Windows"
echo "travis_fold:start:build_unity_win"
./opt/Unity/Editor/Unity \
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
/opt/Unity/Editor/Unity \
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
/opt/Unity/Editor/Unity \
  -batchmode \
  -nographics \
  -silent-crashes \
  -logFile $(pwd)/unity-linux.log \
  -projectPath $(pwd) \
  -buildLinuxUniversalPlayer "$(pwd)/Build/linux/$project.exe" \
  -quit
echo "travis_fold:start:build_unity_linux"
echo "Linux return code: $?"

echo 'Logs from linux build'
echo "travis_fold:start:build_log"
cat $(pwd)/unity-linux.log
echo "travis_fold:end:build_log"

set +e
