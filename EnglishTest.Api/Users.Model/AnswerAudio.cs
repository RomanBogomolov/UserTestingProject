using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    class CAnswerAudio
    {
        public CAnswerAudio()
        {
            TestRequest = new CTestRequest();
            Id = new Guid();
        }
        public Guid Id { set; get; }
        public CTestRequest TestRequest { get; set; }
    }
}
