using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    public class CGeneralResult
    {
        public CGeneralResult() {

            TestRequest = new CTestRequest();
        }
        public Guid ID { get; set; }
        public CTestRequest TestRequest { get; set; }
        public DateTime ResultDate { get; set; }
        public int Grade { get; set; }
    }
}

