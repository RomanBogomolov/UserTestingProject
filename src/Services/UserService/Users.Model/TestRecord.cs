using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    public class TestRecord
    {
        public TestRecord()
        {
            TestExistId = new List<CTestExist>();
            Id = new Guid();
        }
        public Guid Id { get; set; }
        public IEnumerable <CTestExist> TestExistId { set; get; }
        public string Data { get; set; }


    }
}
