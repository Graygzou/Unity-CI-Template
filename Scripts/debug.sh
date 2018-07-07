#!/bin/sh

# 3
echo ""
echo "======== Test 2 ==========="
cd packages/
ls -l -R

# Do a trick to print the content of doc
#ls ./Assets/Library/ScriptAssemblies/ > files.txt
#cat $(cat files.txt) > output
