/// <h3>
/// External .NET Server Samples (Dynamic Gateway)
/// </h3>
/// <p>
/// This class demonstrates how to use Dynamic .NET Gateway, also known as the External .NET Server
/// </p>
Class samples.intersystems.gateway.Dynamic.DotNet [ Abstract ]
{

/// This shows how to use the Dynamic .NET Gateway with ObjectScript. There is no setup necessary, other than to
/// make certain that the default External .NET Server is properly configured and runs (use the SMP to check)
/// This test will automatically start the %DotNetServer if it is not already on.
/// Pass in the path to the DLL containing the sample .NET code
ClassMethod Test(dllPath As %RawString) [ Final ]
{
    // load the DLL into the .NET external language server and instantiate object
    set gateway = $SYSTEM.external.getDotNetGateway()
    do gateway.addToPath(dllPath)
    set student = gateway.new("Samples.InterSystems.Gateway.Student", 29, "976-01-6712")

    // get, set Date
    write !,"setNextClass returned: ",student.SetNextClass($ZDATETIME($HOROLOG,3),"White Hall",3.0,0)
    write !,"Next class on: ",student.NextClassDate,!,!

    // set a String
    do student.MySetName("John","Smith")
    // set an int
    set student.StudentID = 27

    write "Name: ",student.Name,!
    write "ID: ",student.StudentID,!
    write "SSN: ",student.SSN,!,!

    // static method example
    write "Static method execute: ", gateway.invoke("Samples.InterSystems.Gateway.Student","MyStaticMethod"),!,!
    do gateway.setProperty("Samples.InterSystems.Gateway.Student", "StaticProperty", 89)
    write "Static set/get: " _ gateway.getProperty("Samples.InterSystems.Gateway.Student", "StaticProperty"),!!

    // use Hashtable
    set grades = gateway.new("System.Collections.Hashtable")
    do grades.Add("Biology","3.8")
    do grades.%set("Biology", "3.1")
    write "Biology grade changed to 3.1",!
    do grades.Add("French","3.75")
    do grades.Add("Spanish","2.75")
    set student.Grades = grades

    set grades = student.Grades
    if $ISOBJECT(grades) {
        write "Student has completed the following ",grades.Count," classes:",!
        set it = grades.GetEnumerator()
        while (it.MoveNext()) {
            set entry = it.Current.%CastAs("System.Collections.DictionaryEntry")
            set key = entry.Key
            set val = entry.Value
            write "  ",key," ",val,!
        }
    } else {
        write !, "myGetGrades() bug returned a null oref"
    }
    write !,"Highest grade: ", student.MyGetHighestGrade()

    write !,"Now taking: Calculus, Chemistry, English Comp",!,!
    do student.SetGrade("Calculus",3.5)
    do student.SetGrade("Chemistry",3.92)
    do student.SetGrade("English Comp",2.5)
    write "English Comp Grade: ",student.GetGrade("English Comp"),!

    set grades = student.Grades
    write !,"Student has completed the following ",grades.Count," classes:",!
    set it = grades.Keys.GetEnumerator()
    while (it.MoveNext()) {
        set key = it.Current
        set value = grades.%get(key)
        write "  ",key," ",value,!
    }
    write !,"Highest grade now: "
    write $NUMBER($DECIMAL(student.MyGetHighestGrade()),2)

    // set/get a list of strings
    set sports = gateway.new("System.Collections.ArrayList")
    do sports.Add("Basketball")
    do sports.Add("Tennis")
    do sports.Add("Running")
    do sports.Add("Swimming")
    set student.FavoriteSports = sports

    set list = student.FavoriteSports
    write !,"Student's favorite sports are: ",!
    for i = 0:1:list.Count-1 {
        write "  "_list.%get(i),!
    }

    // set an object
    set home = gateway.new("Samples.InterSystems.Gateway.Address")
    set street = gateway.new("Samples.InterSystems.Gateway.Street")
    set street.Name = "Memorial Drive"
    set street.Number = "One"
    set home.City = "San Diego"
    set home.Street = street
    set home.State = "CA"
    set home.Zip = "20098"
    set student.Home = home

    // get an object
    write !,"Student's address: ",!
    set home2 = student.Home
    write "  " _ home2.Street.Name,!
    write "  "_home2.City _ ", " _ home2.State _ " " _ home2.Zip,!,!

    write "Change address",!
    set newHome = gateway.new("Samples.InterSystems.Gateway.Address")
    set newStreet = gateway.new("Samples.InterSystems.Gateway.Street")
    set newStreet.Number = "456"
    set newStreet.Name = "Del Monte"
    set newHome.City = "Boston"
    set newHome.State = "MA"
    set newHome.Street = newStreet
    set newHome.Zip = "40480"
    do student.ChangeAddress(home, newHome)

    // get array of strings
    set arr = student.GetAddressAsCollection()
    write "Student's new address is: ",!
    write "  "_arr.%get(3),!,"  "_arr.%get(0)_", "_arr.%get(1)_" "_arr.%get(2),!
}

/// This shows how to use arrays. 
/// This test will automatically start the %DotNetServer if it is not already on.
/// Pass in the path to the DLL containing the sample .NET code
ClassMethod TestArrays(dllPath As %RawString)
{
    // load the DLL into the .NET external language server and instantiate object
    set gateway = $SYSTEM.external.getDotNetGateway()
    quit:'$ISOBJECT(gateway)
    do gateway.addToPath(dllPath)
    set test = gateway.new("Samples.InterSystems.Gateway.Person")

    // test simple string arrays
    set stringArray = ##class(%ListOfDataTypes).%New()
    do stringArray.Insert("test string one")
    do stringArray.Insert("test string two")
    do stringArray.Insert("test string three")
    do stringArray.Insert("test string four")

    set test.StringArray = gateway.new("string[*]", stringArray)
    set outStringArray = test.StringArray.%getall()

    for i=1:1:outStringArray.Count() {
        write "String " _ i _ " : " _ outStringArray.GetAt(i),!
    }

    // test array of objects
    set home = gateway.new("Samples.InterSystems.Gateway.Address")
    set street = gateway.new("Samples.InterSystems.Gateway.Street")
    set street.Name = "Memorial Drive"
    set street.Number = "One"
    set home.City = "Cambridge"
    set home.Street = street
    set home.State = "MA"
    set home.Zip = "02142"

    set home2 = gateway.new("Samples.InterSystems.Gateway.Address")
    set street2 = gateway.new("Samples.InterSystems.Gateway.Street")
    set street2.Name = "Santa Cruz Ave"
    set street2.Number = "4555"
    set home2.City = "San Diego"
    set home2.Street = street2
    set home2.State = "CA"
    set home2.Zip = "92109"

    set addressArray = ##class(%ListOfObjects).%New()
    do addressArray.Insert(home)
    do addressArray.Insert(home2)

    set test.AddressArray = gateway.new("Samples.InterSystems.Gateway.Address[*]", addressArray)
    set addressArray = test.AddressArray.%getall()
    for i=1:1:addressArray.Count() {
        set home = addressArray.GetAt(i)
        write !,"Address "_i_":",!
        write home.Street.Number _ " " _ home.Street.Name,!
        write home.City
        write ", " _ home.State
        write " " _ home.Zip,!
    }

    // byte[] is mapped as %GlobalBinaryStream (%GlobalBinaryStream is deprecated, use %Stream.GlobalBinary instead)
    write !,"Byte array test:",!
    set byteStream = ##class(%Stream.GlobalBinary).%New()
    do byteStream.Write("Global binary stream")
    // Note that byteStream is passed in by value, so any changes on the .NET
    // side will be ignored. The next example will pass the stream by reference
    // meaning changes on the .NET side will be reflected here as well
    set test.ByteArray = gateway.new("byte[?]", byteStream)
    set result = test.ByteArray.%getall()
    write result.Read(result.SizeGet()),!

    set readStream = ##class(%Stream.GlobalBinary).%New()
    // we need to 'reserve' a number of bytes since we are passing the stream
    // by reference (.NET's equivalent is byte[] ba = new byte[max];)
    for i=1:1:50 do readStream.Write("0")
    set byteArray = gateway.new("byte[*]", readStream)
    set bytesRead = test.Read(byteArray,50)
    set readStream = byteArray.%getall()
    write readStream.Read(bytesRead),!
}

}
