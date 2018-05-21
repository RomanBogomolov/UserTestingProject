using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    public class CRegion
    {
        public CRegion() {
            Id = new Guid();
        }

        public Guid Id { get; set; }
        public string Name { get; set; }
    }
}
