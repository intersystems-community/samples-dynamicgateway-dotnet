using System.Collections;
using System.Text;

namespace Samples.InterSystems.Gateway
{
    public class Person
    {
        public static readonly int INTCONSTANT = 76;
        public static readonly short SHORTCONSTANT = 5;
        public static readonly long LONGCONSTANT = 4441;
        public static readonly bool BOOLEANCONSTANT = false;
        public static readonly double DOUBLECONSTANT = 7.451;
        public static readonly string STRINGCONSTANT = "String constant";
        public static int StaticProperty;

        public int Age { get; set; }
        public double MyDoubleWrapper { get; set; }
        public string Name { get; set; }
        public string SSN { get; set; }
        public ArrayList FavoriteSports { get; set; }
        public Address Home { get; set; }
        public long Weight { get; set; }

        private string[] PrivateStringArray;
        private string[][] PrivateTwoStringArray;
        private Address[] PrivateAddressArray;

        private Type clazz;

        public string[] StringArray
        {
            get => PrivateStringArray; 
            set => PrivateStringArray = value; 
        }

        public string[][] TwoStringArray
        {
            get => PrivateTwoStringArray;
            set => PrivateTwoStringArray = value; 
        }

        public Address[] AddressArray
        {
            get => PrivateAddressArray; 
            set => PrivateAddressArray = value; 
        }


        public byte[] ByteArray;
        public string[] FavoriteColors;

        public Person() { }

        public Person(string ssn) 
        {
            SSN = ssn;
            FavoriteSports = new ArrayList();
        }

        public static string MyStaticMethod() { return "Success"; }

        public void MySetName(string first, string last)
        {
            Name = last + "," + first;
        }

        public string GetStreetAndCity()
        {
            return $"Street: {Home.Street.Number} {Home.Street.Name} \r\nCity: {Home.City}";
        }

        public void ChangeAddress(Address old, Address newAddress)
        {
            if (!old.City.Equals(Home.City)) 
            { 
                throw new Exception($"Invali old city {old.City} {Home.City}");
            } else if (!old.State.Equals(Home.State))
            {
                throw new Exception($"Invalid old address specified {old.State} {Home.State}");
            } else if (!old.Street.Equals(Home.Street))
            {
                throw new Exception($"Invalid old address specified {old.Street.Name} {Home.Street.Name}");
            } else if (!old.Zip.Equals(Home.Zip))
            {
                throw new Exception($"Invalid old address specified {old.Zip} {Home.Zip}");
            }
            Home = newAddress;
        }

        public string[] GetAddressAsCollection()
        {
            string[] address = new string[4];
            address[0] = Home.City;
            address[1] = Home.State;
            address[2] = Home.Zip;
            address[3] = Home.Street.Number + " " + Home.Street.Name;
            return address;
        }

        public int Read(ref byte[] b, int len)
        {
            byte[] temp = Encoding.ASCII.GetBytes("This byte stream has been filled in by .NET");
            int minLength = Math.Min(temp.Length, len);
            Array.Copy(temp, b, minLength);
            return temp.Length;
        }

    }
}

