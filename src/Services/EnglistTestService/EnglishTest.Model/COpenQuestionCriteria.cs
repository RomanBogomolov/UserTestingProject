using System;
using System.Collections.Generic;
using System.Text;

namespace EnglishTest.Model
{
    class COpenQuestionCriteria
    
    {
        public COpenQuestionCriteria() {

            Id = new Guid();

        }
        public Guid Id { get; set; }
        public string Descripion { get; set; }

    }
}
