using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    class CAnswerVariative

    {
        public CAnswerVariative() {
            TestExist = new CTestExist();
            Id = new Guid();
            AnswerVariative = new Guid();
            QuestionId = new Guid();
        }
        public Guid Id { set; get; }
        public CTestExist TestExist { get; set; }
        public Guid AnswerVariative { get; set; }
        public Guid QuestionId { get; set; }

            
    }
}
