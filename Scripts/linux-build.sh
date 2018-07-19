#! /bin/sh

# Change this the name of your project. This will be the name of the final executables as well.
project="Unity-CI-Template"

echo "travis_fold:start:debug"
echo "debug"
ls -l /opt
find / -name "*[U|u]nity*"
find / -name "*[E|e]ditor*"
echo "travis_fold:end:debug"

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
echo "travis_fold:end:build_unity_win"
echo "Windows return code: $?"

echo "travis_fold:start:build_unity_osx"
echo "Attempting to build $project for OS X"
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

echo "travis_fold:start:build_unity_linux"
echo "Attempting to build $project for Linux"
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

echo "travis_fold:start:build_log"
echo "Logs from linux build"
cat $(pwd)/unity-linux.log
echo "travis_fold:end:build_log"

set +e
