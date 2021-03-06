#! /bin/sh

# -------------------------
# SonarQube scanner 3.2
# -------------------------

# Sonarcloud CLI
echo "travis_fold:start:scanner_cli"
sonar-scanner -Dsonar.projectKey=graygzou:Sonar-UnityBase -Dsonar.sources=../Assets
#sonar-scanner -Dproject.settings=../Sonarcloud/sonar-project.properties
echo "travis_fold:end:scanner_cli"

# --------------------------------
# SonarQube scanner for MSBuild
# --------------------------------

# Pre processing.
echo "travis_fold:start:preprocessing"
dotnet ./packages/MSBuild.SonarQube.Runner.Tool.4.3.0/tools/SonarScanner.MSBuild.exe begin /k:"graygzou:Sonar-UnityBase" /d:sonar.organization="graygzou-github" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.login="${SONAR_TOKEN}"
echo "travis_fold:end:preprocessing"


# Build the project to generate a xml
echo "travis_fold:start:build" 
#- msbuild /t:rebuild /v:diag "${TRAVIS_SOLUTION}"
dotnet msbuild /p:Configuration=Release "${TRAVIS_SOLUTION}" /p:TargetFrameworkVersion="v3.5"
echo "travis_fold:end:build"


# Retrieve the xml from the build.
echo "travis_fold:start:postprocessing"
dotnet ./packages/MSBuild.SonarQube.Runner.Tool.4.3.0/tools/SonarScanner.MSBuild.exe end /d:sonar.login="${SONAR_TOKEN}"
echo "travis_fold:end:postprocessing"
