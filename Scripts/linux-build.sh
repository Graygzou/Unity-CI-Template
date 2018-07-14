#! /bin/sh

# Change this the name of your project. This will be the name of the final executables as well.
project="Unity-CI-Template"

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

echo "Attempting to build $project for OS X"
/opt/Unity/Editor/Unity \
  -batchmode \
  -nographics \
  -silent-crashes \
  -logFile $(pwd)/unity-osx.log \
  -projectPath $(pwd) \
  -buildOSXUniversalPlayer "$(pwd)/Build/osx/$project.app" \
  -quit
echo "OS X return code: $?"

echo "Attempting to build $project for Linux"
/opt/Unity/Editor/Unity \
  -batchmode \
  -nographics \
  -silent-crashes \
  -logFile $(pwd)/unity-linux.log \
  -projectPath $(pwd) \
  -buildLinuxUniversalPlayer "$(pwd)/Build/linux/$project.exe" \
  -quit
echo "Linux return code: $?"

echo 'Logs from build'
cat $(pwd)/unity-linux.log

set +e
