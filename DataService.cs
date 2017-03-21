using PgSqlLib.PgSql;
using PgSqlLib.Models;

namespace PgSqlLib
{
    public interface IDataService 
    {
        IRepository<ModelName> ModelName { get; set; }    
    }

    public class DataService : IDataService
    {
       public IRepository<ModelName> ModelName { get; set;}

       public DataService() 
       {
           this.ModelName = new Repository<ModelName>(); 
       }

       /// <summary>
       /// Overload to make unit testing easier. May also add PgSql to DI services 
       /// </summary>
       /// <param name="_pgSql"></param>
       public DataService(IPgSql _pgSql) 
       {
           this.ModelName = new Repository<ModelName>(_pgSql); 
       }
    }
}