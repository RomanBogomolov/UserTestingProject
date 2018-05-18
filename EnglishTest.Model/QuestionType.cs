using System;
using System.Collections.Generic;
using System.Text;

namespace EnglishTest.Model
{
    class CQuestionType
    
    {
        public CQuestionType() {

            Id = new Guid();

        }
        public Guid Id { get; set; }
        public string Name { get; set; }

    }
}
