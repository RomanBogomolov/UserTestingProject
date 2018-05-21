using System;
using System.Collections.Generic;
using System.Text;

namespace EnglishTest.Model
{
    class CQuestion
    {
        public CQuestion() { 
            Id = new Guid();
            SectionId = new List<CSection>();
            AttachmentId = new CAttachment();
            CriteriaId = new List<COpenQuestionCriteria>();
        }
        public Guid Id { get; set; }
        public string Name { get; set; }
        public IEnumerable <CSection> SectionId { get; set; }
        public CAttachment AttachmentId { get; set; } 
        public IEnumerable <COpenQuestionCriteria> CriteriaId { get; set; }
        public int CoesCost { get; set; }
        

    }
}
