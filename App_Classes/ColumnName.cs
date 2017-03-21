using System;

namespace PgSqlLib.App_Classes
{
    [AttributeUsage(AttributeTargets.Property)]
    public class ColumnName : Attribute 
    {
        public string AttributeValue { get; set; }
        public ColumnName(string _attributeValue)
        {
            AttributeValue = _attributeValue;
        }
    }
}