#!/bin/sh

# Print the dotnet version.
echo "travis_fold:start:dotnet_info"
dotnet --info
echo "travis_fold:end:dotnet_info"

# TODO.
echo "travis_fold:start:dotnet_restore"
dotnet restore ./Unity-CI-Template.csproj
echo "travis_fold:end:dotnet_restore"

# Build the project.
echo "travis_fold:start:dotnet_build"
dotnet build ./Unity-CI-Template.csproj
echo "travis_fold:end:dotnet_build"

# Launch test from the project.
echo "travis_fold:start:dotnet_test"
dotnet test ./Unity-CI-Template.csproj
echo "travis_fold:end:dotnet_test"

