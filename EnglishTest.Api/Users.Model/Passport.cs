using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
        public class CPassport

    {
        public CPassport(){

            
        }
        public int Id { get; set; }
        public int PassportNumber { get; set; }
        public string Nationality { get; set; }
        public string SomethingElse { get; set; }
    }
}
