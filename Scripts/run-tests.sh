#! /bin/sh

# This file is based on an example by SebastianJay. See the original example here:
#	https://github.com/SebastianJay/unity-ci-test/
set -euo pipefail

project="Brain-Control"
filename="unit-test-results.xml"

# Run the editor unit tests.
echo "Running editor unit tests for $project"
/Applications/Unity/Unity.app/Contents/MacOS/Unity \
	-batchmode \
	-nographics \
	-silent-crashes \
	-projectPath $(pwd) \
	-editorTestsResultFile $(pwd)/$filename \
	-testFilter $(pwd)/Assets/Library/ScriptAssemblies/Assembly-CSharp.dll \
	-runEditorTests

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

echo "--------------------------------------------------"
echo "Sending data coverage to third party software"
echo "--------------------------------------------------"

#Test for coveralls
echo ""
echo "Sending data to Coveralls..."
mono ./coveralls/coveralls.io.1.0.0/tools/coveralls.net.exe -d --opencover "$(pwd)/$filename" -r $COVERALLS_REPO_TOKEN

# Test for codecov
echo "Sending data to Codecov..."
curl -s https://codecov.io/bash > codecov
chmod +x codecov
# NUnit v3.0
./codecov -f $(pwd)/$filename -t 2ff3d741-5b36-4314-9537-8581706ed054

set +e
