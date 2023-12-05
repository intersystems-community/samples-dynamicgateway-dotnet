using System.Collections;
using System.Reflection;

namespace Samples.InterSystems.Gateway
{
    public class StudentTest
    {
        Student student;

        [SetUp]
        public void Setup()
        {
            student = new(29L, "976-01-6712");
            student.MySetName("John", "Smith");
            Hashtable grades = new()
            {
                ["Biology"] = "3.1",
                ["French"] = "3.75",
                ["Spanish"] = "2.75"
            };
            student.Grades = grades;
        }

        [Test]
        public void TestHighestGrade()
        {
            decimal highestGrade = student.MyGetHighestGrade();
            Assert.That(highestGrade, Is.EqualTo(3.75F));
        }

        [Test]
        public void TestCompletedClasses()
        {
            Hashtable grades = student.Grades;
            
            Hashtable expected = new()
            {
                ["Biology"] = "3.1",
                ["French"] = "3.75",
                ["Spanish"] = "2.75"
            };
            Assert.That(grades, Is.EquivalentTo(expected));
            Console.WriteLine(grades.GetType());
        }

        [Test]
        public void TestNewInstanceForClassHashTable()
        {
            Type tabletype = Type.GetType("System.Collections.Hashtable");
            Assert.That(tabletype, Is.Not.Null);
            Hashtable table = (Hashtable)Activator.CreateInstance(tabletype);
            Assert.That(table, Is.Not.Null);
            Assert.That(table, Is.TypeOf<Hashtable>());
        }

        [Test]
        public void TestNewInstanceForClassList()
        {
            ArrayList mylist = new();
            Console.WriteLine(mylist.GetType());
            Type listType = Type.GetType("System.Collections.ArrayList");
            Assert.That(listType, Is.Not.Null);
            ArrayList list = (ArrayList)Activator.CreateInstance(listType);
            Assert.That(list, Is.Not.Null);
            Assert.That(list, Is.TypeOf<ArrayList>());
        }
    }
}