#!/bin/sh

runTest() {
    mono --runtime=v4.0 ./packages/NUnit.Runners.2.6.4/tools/nunit-console.exe -noxml -nodots -labels -stoponerror $@
   if [ $? -ne 0 ]
   then
     exit 1
   fi
}

#This is the call that runs the tests and adds tweakable arguments.
#In this case I'm excluding tests I categorized for performance.
runTest $1 -exclude=Performance

exit $?
