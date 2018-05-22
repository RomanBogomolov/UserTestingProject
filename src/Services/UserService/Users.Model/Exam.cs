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
            CertificateNumber = new Guid();


        }
        public Guid Id { get; set; }
        public string Status { get; set; }
        public Guid CertificateNumber { get; set; }
        public Guid TestId { get; set; }
        

    }
}
