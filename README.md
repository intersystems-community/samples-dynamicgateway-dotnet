# InterSystems Samples - Dynamic .NET Gateway

## Refactored %Net.Remote.DotNet.Test

Previously, .NET samples were distributed with InterSystems IRIS Kits under ./dev/dotnet/samples. All samples were removed
from kits and many of the previous samples were not refactored to make them consistent with new features in InterSystems
IRIS.

This project includes samples from %Net.Remote.DotNet.Test. The original source used the old .NET Gateway which has been
replaced by External DotNet Server and Dynamic Gateway. The focus of this project is not running this project (it 
should run) but rather to demonstrate how code that used the old .NET Gateway can be refactored to use the new 
External .NET Server with Dynamic Gateway connections.

## Running the Sample Code

Import the objectscript file included in this project, objectscript/Dynamic.DotNet.cls.

```shell
USER>d $system.OBJ.Load("<path to project>/objectscript/Dynamic.cls", "ckr",,1)
```

Then, class *samples.intersystems.gateway.Dynamic.DotNet* implements two methods that demonstrate various capabilities:
* Test
* TestArrays

Both take a single argument that is the path to the dll (or exe) file. This project includes a dll that can be used (\bin\Release\net6.0\NetRemoteSamples.dll). Running the samples from the command line, as follows, will produce the given output:

```
USER>do ##class(samples.intersystems.gateway.Dynamic.DotNet).Test("<path to project>\NetRemoteSamples\bin\Release\net6.0\NetRemoteSamples.dll")

setNextClass returned: 0
Next class on: 2023-12-05 00:00:00

Name: Smith,John
ID: 27
SSN: 976-01-6712

Static method execute: Success

Static set/get: 89

Biology grade changed to 3.1
Student has completed the following 3 classes:
  French 3.75
  Biology 3.1
  Spanish 2.75

Highest grade: 3.75
Now taking: Calculus, Chemistry, English Comp

English Comp Grade: 2.5

Student has completed the following 6 classes:
  Chemistry 3.92
  French 3.75
  Biology 3.1
  Spanish 2.75
  Calculus 3.5
  English Comp 2.5

Highest grade now: 3.92
Student's favorite sports are: 
  Basketball
  Tennis
  Running
  Swimming

Student's address: 
  Memorial Drive
  San Diego, CA 20098

Change address
Student's new address is: 
  456 Del Monte
  Boston, MA 40480
```

```
USER>do ##class(samples.intersystems.gateway.Dynamic.DotNet).TestArrays("<path to project>\NetRemoteSamples\bin\Release\net6.0\NetRemoteSamples.dll")
String 1 : test string one
String 2 : test string two
String 3 : test string three
String 4 : test string four

Address 1:
One Memorial Drive
Cambridge, MA 02142

Address 2:
4555 Santa Cruz Ave
San Diego, CA 92109

Byte array test:
Global binary stream
This byte stream has been filled in by .NET
```

