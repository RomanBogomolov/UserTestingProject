using System;
using System.Collections.Generic;
using System.Text;

namespace EnglishTest.Model
{
    class CQuestion
    {
        public CQuestion ()
            {

                Section= new List<CSection>();
                Id = new Guid();
            }
 
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string QuestionType { get; set; }
        public int MinGrade { get; set; }
        public IEnumerable<CSection> Section { get; set; }
    }
}
