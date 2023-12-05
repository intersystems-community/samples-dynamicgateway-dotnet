namespace Samples.InterSystems.Gateway
{
    public class Address
    {
        public string City { get; set; }
        public string State { get; set; }
        public Street Street { get; set; }
        public string Zip { get; set; }

        public Address() { }
        
        public string MyGetStreet()
        {
            return Street.Number + " " + Street.Name;
        }
    }
}
