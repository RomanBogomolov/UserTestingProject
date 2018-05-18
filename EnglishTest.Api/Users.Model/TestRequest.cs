using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    public class CTestRequest
    {
        public CTestRequest() {
            ExamId = new CExam();
            AttachmentID = new CAttachment();
        }
        public int Id { get; set; }
        public Guid UserId { get; set; }
        public DateTime RequestDate { get; set; }
        public DateTime TestDate { get; set; }
        public string Status { get; set; }
        public CExam ExamId { get; set; }

        public CAttachment AttachmentID { get; set; }
    }
}
