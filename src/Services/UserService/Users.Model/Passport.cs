using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
        public class CPassport

    {
        public CPassport(){

            Id = new Guid();
        }
        public Guid Id { get; set; }
        public string PassportNumber { get; set; }
        public string Nationality { get; set; }
        public string Other { get; set; }
    }
}
