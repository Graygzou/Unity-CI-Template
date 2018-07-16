#! /bin/sh

# This file is based on an example by SebastianJay. See the original example here:
#	https://github.com/SebastianJay/unity-ci-test/

project="Unity-CI-Template"
filename="unit-test-results.xml"

ls -l ./Assets/

# Run the editor unit tests.
echo "Running editor unit tests for $project"
/Applications/Unity/Unity.app/Contents/MacOS/Unity \
	-batchmode \
	-nographics \
	-projectPath $(pwd) \
	-editorTestsResultFile $(pwd)/$filename \
	-runEditorTests
	
# - quit should not be there since runEditorTests does it already..

results=$?

# Print results of
if [ $results -ne 0 ]
then
	echo "------------------------"
  echo "Failed unit tests."
	echo "------------------------"
else
	echo "------------------------"
  echo "All tests passed!"
	echo "------------------------"
fi

# Print the Unity results.
echo "Unity test logs"
echo ""
cat $(pwd)/$filename
echo ""

# Convert the Unity test in NUnit Test with xmlskarlet.
#echo "Converting file in NUnit xml format..."
#xml tr $(pwd)/Scripts/fix-unity-test-results.xslt $(pwd)/$filename > $(pwd)/nunit-test-results.xml

# Print NUnit results.
#echo "NUnit test logs"
#echo ""
#cat $(pwd)/nunit-test-results.xml
#echo ""

# Execute tests with OpenCover BUT OpenCover is only supported on Windows OS..
#echo "--------------------------------------------------"
#echo "Execute test now with OpenCover"
#echo "--------------------------------------------------"
#mono ./packages/OpenCover.4.6.519/tools/OpenCover.Console.exe \
#	-target:$(pwd)/testrunner/NUnit.ConsoleRunner.3.8.0/tools/nunit3-console.exe \
#	-targetargs:$(pwd)/Assets/Library/ScriptAssemblies/Assembly-CSharp.dll \
#	-register:user \
#	-output:opencover.xml

echo ""
#echo "Unity test logs v1.0"
#mono ./packages/JetBrains.dotCover.CommandLineTools.2018.1.1/tools/dotCover.exe analyse AppCoverageReport1.xml

# Print the Unity results.
#cho "XXXX v1.0 test logs"
#echo ""
#cat $(pwd)/AppCoverageReport1.xml
#echo ""

# Xunit
#mono ./packages/xunit.runner.console.2.3.1/tools/net452/xunit.console.exe ./Library/ScriptAssemblies/Assembly-CSharp.dll

#
#echo "Unity test logs v2.0"
#mono ./packages/JetBrains.dotCover.CommandLineTools.2018.1.1/tools/dotCover.exe analyse \
#	TargetExecutable="$(pwd)/testrunner/NUnit.ConsoleRunner.3.8.0/tools/nunit3-console.exe" \
#	TargetArguments="$(pwd)/Library/ScriptAssemblies/*.dll" \
#	Output="AppCoverageReport.xml" \
#	ReportType="XML"


# Print the Unity results.
#echo "XXXX v2.0 test logs"
#echo ""
#cat $(pwd)/AppCoverageReport.xml
#echo ""



# SonarQube ?

echo "--------------------------------------------------"
echo "Sending data coverage to third party software"
echo "--------------------------------------------------"

#Test for coveralls
echo ""
echo "Sending data to Coveralls..."
mono ./coveralls/coveralls.io.1.4.2/tools/coveralls.net.exe -d --opencover "$(pwd)/$filename" -r $COVERALLS_REPO_TOKEN

# Test for codecov
echo "Sending data to Codecov..."
curl -s https://codecov.io/bash > codecov
chmod +x codecov
# NUnit v3.0
./codecov -f $(pwd)/$filename -t 2ff3d741-5b36-4314-9537-8581706ed054
