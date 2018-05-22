using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    public class CRegion
    {
        public CRegion()
        {
            RegionId = new Guid();
        }
        public Guid RegionId { get; set; }
        public string Name { get; set; }
    }
}
