using System;
using System.ComponentModel.DataAnnotations;
using PgSqlLib.App_Classes;

namespace PgSqlLib.Models 
{
    public class ModelName 
    {    
        [ColumnName("model_id")]
        public Guid Id { get; set; }

        [Required]
        [ColumnName("name")]
        public string Name { get; set; }

        [Required]
        [ColumnName("description")]
        public string Description { get; set; }

        [ColumnName("created")]
        public DateTime Created { get; set; }

        [ColumnName("updated")]
        public DateTime? Updated { get; set; }
    }
}