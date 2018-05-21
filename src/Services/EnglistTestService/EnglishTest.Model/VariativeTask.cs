using System;
using System.Collections.Generic;
using System.Text;

namespace EnglishTest.Model
{
    class CVariativeTask
    {
        public CVariativeTask()
        {
            Id = new Guid();
            QuestionId = new List<CQuestion>();
        }

        public Guid Id { get; set; }
        public IEnumerable<CQuestion> QuestionId { get; set; }
        public string AnswerVariant { get; set; }
        public bool IsRight { get; set; }


    }
}
