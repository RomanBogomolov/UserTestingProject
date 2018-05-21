using System;
using System.Collections.Generic;
using System.Text;

namespace EnglishTest.Model
{
    class CCertificationType
    {
     
        public CCertificationType()
        {
            Id = new Guid();
           
        }
        public Guid Id { get; set; }
        public string Type { get; set; }
        
    }
}
