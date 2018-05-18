using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    class CAnswerVariative

    {
        public CAnswerVariative() {
            TestRequest = new CTestRequest();
            Id = new Guid();
        }
        public Guid Id { set; get; }
        public CTestRequest TestRequest { get; set; }

            
    }
}
