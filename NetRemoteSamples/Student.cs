using System.Collections;

namespace Samples.InterSystems.Gateway
{
    public class Student : Person
    {
        public int YearsInProgram { get; set; }
        public float GPA { get; set; }
        public float HighestGrade { get; set; }
        public decimal NextClassCredits { get; set; }
        public bool IsGraduate { get; set; }
        public bool NextClassOnSchedule { get; set; }
        public string NextClassLocation { get; set; }
        public DateTime NextClassDate { get; set; }
        public TimeSpan NextClassTime { get; set; }
        public DateTime ChemistryFinal { get; set; }
        public Hashtable Grades { get; set; }
        public short ClassCount { get; set; }
        public short Credits { get; set; }
        public long StudentID { get; set; }
        private int privateInt;

        public Student(long id, string ssn) : base(ssn)
        {
            StudentID = id;
            Grades = new();
        }

        public Student(string ssn) : base(ssn) 
        {
            Grades = new();
        }

        public Student(long id) : base("111-11-1111")
        {
            StudentID = id;
            Grades = new();
        }

        public void SetGrade(string subject, string grade)
        {
            Grades[subject] = grade;
        }

        public decimal? GetGrade(string subject)
        {
            string grade = (string)Grades[subject];
            if (grade == null)
            {
                Console.WriteLine("No grade yet");
                return null;
            }
            return decimal.Parse(grade);
        }

        public decimal MyGetHighestGrade()
        {
            decimal max = 0.0m;
            if (Grades.Count == 0)
            {
                throw new Exception("Student has not taken any classes yet");
            }
            try
            {
                foreach (DictionaryEntry entry in Grades)
                {
                    decimal elem = decimal.Parse((string)entry.Value);
                    if (elem > max) { max = elem; }
                }
            } catch (Exception ex)
            {
                Console.WriteLine(ex.StackTrace);
            }
            return max;
        }

        public bool SetNextClass(DateTime datetime, string location, decimal credits, bool onSchedule)
        {
            NextClassOnSchedule = onSchedule;
            NextClassLocation = location;
            NextClassCredits = credits;
            NextClassDate = datetime.Date;
            NextClassTime = datetime.TimeOfDay;
            return onSchedule;
        }

    }
}
