using System;
using System.Collections.Generic;
namespace Users.Model
{
    public class CUser

    {
        public CUser() {

            Id = new Guid();
            Passport = new CPassport();
            RegistrationRegion = new List <CRegion>();
        }
        public Guid Id { get; set; }
        public string FullName { get; set; }
  
        public CPassport Passport { get; set; }

        public IEnumerable <CRegion> RegistrationRegion { get; set; }
        
    }
}
