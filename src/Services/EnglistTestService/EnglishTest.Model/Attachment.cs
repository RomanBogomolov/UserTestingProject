using System;
using System.Collections.Generic;
using System.Text;

namespace EnglishTest.Model
{
    class CAttachment
    {
        public CAttachment() {

            Id = new Guid();

        }
        public Guid Id { get; set; }
        public string Data { get; set; }
    }
}
