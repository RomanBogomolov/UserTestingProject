using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    public class CAnswerFree
    {
        public CAnswerFree()
        {
            TestExist = new CTestExist();
            Id = new Guid();
            QuestionId = new Guid();
        }
        public Guid Id { set; get; }
        public CTestExist TestExist { get; set; }
        public Guid QuestionId { get; set; }
        public string Data { get; set; }


    }
}

