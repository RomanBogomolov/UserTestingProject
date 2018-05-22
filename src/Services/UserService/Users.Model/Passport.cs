using System;

namespace Users.Model
{
        public class CPassport

    {
        public CPassport(){

            PassportId = new Guid();
        }

        public Guid PassportId { get; set; }
        public string PassportNumber { get; set; }
        public string Nationality { get; set; }
        public string Other { get; set; }
    }
}
