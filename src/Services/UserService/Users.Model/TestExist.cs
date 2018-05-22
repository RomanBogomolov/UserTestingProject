using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    public class CTestExist
    {
        public CTestExist() {
            ExamId = new List<CExam>();
            UserId = new List<CUser>();
        }   
        public int Id { get; set; }
        public IEnumerable <CUser> UserId { get; set; }
        public DateTime RequestDate { get; set; }
        public DateTime TestDate { get; set; }
        public bool Status { get; set; }
        public IEnumerable <CExam> ExamId { get; set; }

        
    }
}
