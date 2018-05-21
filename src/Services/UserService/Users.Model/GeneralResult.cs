using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    public class CGeneralResult
    {
        public CGeneralResult() {

            TestExist = new List<CTestExist>();
        }
        public Guid ID { get; set; }
        public IEnumerable <CTestExist> TestExist { get; set; }
        public DateTime ResultDate { get; set; }
        public decimal Grade { get; set; }
    }
}

