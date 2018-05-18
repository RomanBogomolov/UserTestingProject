using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    class CSectionResult
    {
        public CSectionResult()
        {
            TestRequest = new CTestRequest();
            Id = new Guid();
        }
        public Guid Id { set; get; }

        public CTestRequest TestRequest { get; set; }
        public int Grade { get; set; }
    }
}
