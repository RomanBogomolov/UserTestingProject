using System;
using System.Collections.Generic;
using System.Text;

namespace EnglishTest.Model
{
    class CGradeCriteria

    {
        public CGradeCriteria() {
            Section = new List<CSection>();
            Id = new Guid();
        }
        public Guid Id { set; get; }
        public string Name { get; set; }
        public IEnumerable<CSection> Section { get; set;}

    }
}
