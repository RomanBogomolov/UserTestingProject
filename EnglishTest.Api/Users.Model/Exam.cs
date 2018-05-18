using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    public class CExam
    {
        public CExam() {

            //TestID = new CTestRequest();
            Id = new Guid();

        }
        public Guid Id { get; set; }
        public string Status { get; set; }
        //public CTestRequest TestID { get; set; }
        public string CertifcateNumber { get; set; }

    }
}
