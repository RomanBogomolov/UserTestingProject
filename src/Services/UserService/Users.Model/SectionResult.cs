using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    class CSectionResult
    {
        public CSectionResult()
        {
            TestExistID = new List<CTestExist>();
            Id = new Guid();
            GradeCriteriaId = new Guid();
        }
        public Guid Id { set; get; }

        public IEnumerable  <CTestExist> TestExistID { get; set; }
        public int Grade { get; set; }
        public Guid GradeCriteriaId { get; set; }
    }
}
