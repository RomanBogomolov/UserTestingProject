using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    public class TestRecord
    {
        public TestRecord()
        {
            TestRequest = new CTestRequest();
            Id = new Guid();
        }
        public Guid Id { get; set; }
        public CTestRequest TestRequest { set; get; }


    }
}
