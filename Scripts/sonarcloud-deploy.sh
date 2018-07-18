#! /bin/sh

# -----------------------
# SonarQube scanner
# -----------------------

# Pre processing.
echo "travis_fold:start:preprocessing"
mono ./packages/MSBuild.SonarQube.Runner.Tool.4.3.0/tools/SonarScanner.MSBuild.exe begin /k:"graygzou:Sonar-UnityBase" /d:sonar.organization="graygzou-github" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.login="${SONAR_TOKEN}"
echo "travis_fold:end:preprocessing"


# Build the project to generate a xml
echo "travis_fold:start:build" 
#- msbuild /t:rebuild /v:diag "${TRAVIS_SOLUTION}"
msbuild /p:Configuration=Release "${TRAVIS_SOLUTION}" /p:TargetFrameworkVersion="v3.5"
echo "travis_fold:end:build"


# Retrieve the xml from the build.
echo "travis_fold:start:postprocessing"
mono ./packages/MSBuild.SonarQube.Runner.Tool.4.3.0/tools/SonarScanner.MSBuild.exe end /d:sonar.login="${SONAR_TOKEN}"
echo "travis_fold:end:postprocessing"
