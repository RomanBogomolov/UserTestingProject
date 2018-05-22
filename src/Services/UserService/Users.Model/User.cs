using System;

namespace Users.Model
{
    public class CUser

    {
        public CUser()
        {
            Id = new Guid();
            Passport = new CPassport();
            RegistrationRegion = new CRegion();
        }

        public Guid Id { get; set; }
        public string FullName { get; set; }
        public CPassport Passport { get; set; }
        public CRegion RegistrationRegion { get; set; }
    }
}
