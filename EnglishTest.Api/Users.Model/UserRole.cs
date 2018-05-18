using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Model
{
    public class CUserRole
    {
        public CUserRole()
        {
            User = new List<CUser>();
            Roles = new List<CRoles>();
        }
        public int ID { get; set;}
        public IEnumerable <CUser> User { get; set; }
        public IEnumerable<CRoles> Roles { get; set; }

    }
}
