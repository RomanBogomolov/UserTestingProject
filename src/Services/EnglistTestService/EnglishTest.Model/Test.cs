using System;

namespace EnglishTest.Model
{
    public class CTest

    {
        public CTest() {

            Id = new Guid();
            CertificateTypeId = new Guid();
        }
        public Guid Id { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public bool IsFree { get; set; }
        public Guid CertificateTypeId { set; get; }
        public int MinGrade { get; set; }
    }
}
