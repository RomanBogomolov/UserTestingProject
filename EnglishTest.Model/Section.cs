using System;
using System.Collections.Generic;
using System.Text;

namespace EnglishTest.Model
{
    /// <summary>
    /// Объектная модель Секции теста
    /// </summary>
        public class CSection
    {
        public CSection()
        {
            Test = new List<CTest>();
            Id = new Guid();
        }
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public IEnumerable<CTest> Test { get; set; }
    }
}
