using System;
using System.Collections.Generic;
using System.Text;

namespace UserServices.DataAccess.SQL.SQLQuery
{
    public static class CSqlQuery
    {
        public static string SelectUserById =>
            "SELECT id,fullname,regionId,[name],passportId,nationality,passportNumber,other from uf_SelectUserById(@userId)";
    }
}
