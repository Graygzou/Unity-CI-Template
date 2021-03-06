#! /bin/sh
# Script used to install packages / libraries used later.
#
nuget restore Unity-CI-Template.sln


### Unity dll (Maybe useless)
nuget install Unity3D.DLLs -Version 1.0.1 -OutputDirectory UnityDLL -Verbosity quiet

### .NETFramework
nuget install Microsoft.NETCore.Targets.NETFramework -Version 4.6.0 -outputDirectory packages

nuget install Microsoft.NET.Test.Sdk -Version 15.8.0 -outputDirectory packages

### The NUnit unit testing tool.
nuget install NUnit.Runners -Version 2.6.4 -OutputDirectory packages -Verbosity quiet
nuget install NUnit.Runners -Version 3.8.0 -OutputDirectory testrunner -Verbosity quiet

### (Windows OSs only - no Mono) OpenCover captures the NUnit testing results and produces the coverage report in .XML format
nuget install OpenCover -Version 4.6.519 -OutputDirectory packages -Verbosity quiet

### Produces the HTML report based upon OpenCover's Results (.XML)
nuget install ReportGenerator -Version 2.4.5.0 -OutputDirectory packages -Verbosity quiet

### SonarQube (SonarCloud) analysis tool
nuget install MSBuild.SonarQube.Runner.Tool -Version 4.3.0 -OutputDirectory packages -Verbosity quiet

### Others imports for code coverage
nuget install coveralls.io -Version 1.4.2 -OutputDirectory coveralls -Verbosity quiet
nuget install JetBrains.dotCover.CommandLineTools -Version 2018.1.1 -OutputDirectory packages -Verbosity quiet
nuget install NUnit3TestAdapter -Version 3.10.0
nuget install xunit.runner.console -Version 2.3.1 -OutputDirectory packages
