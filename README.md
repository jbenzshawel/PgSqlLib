# PgSqlLib

[![Build Status](https://travis-ci.org/jbenzshawel/PgSqlLib.svg?branch=master)](https://travis-ci.org/jbenzshawel/PgSqlLib)

PostgreSql Class Library for ASP.NET Core DAL. This library is basically a wrapepr around [Npgsql](http://www.npgsql.org/) with a Repository / DataService that have a generic parameter for Models in the PostgreSql database. 

## Using with ASP.NET Core WebAPI
In your Startup.cs file add the DataService dependency to the ConfigureServices method:

```C#
public void ConfigureServices(IServiceCollection services)
{
     // note code above omitted for example
     services.AddMvc();
     services.AddScoped<IDataService, DataService>();
}
```
Create a BaseController with a dependency on the DataService:

```C#
using Microsoft.AspNetCore.Mvc;
using PgSqlLib;

namespace YourAppNamespace.AppClasses
{
    public class BaseController : Controller
    {
        internal IDataService _DataService { get; set; }

        public BaseController(IDataService _dataService) 
        {
            _DataService = _dataService;
        }
    }
}
```
Controllers that inherit the BaseController class can then use the DataService with the PostgreSql database. For example, a controller for the model ModelName would have a method like below to get the object by id.

```C#
[HttpGet("{id}")]
public async Task<ModelName> Get(Guid id)
{
    ModelName modelName = await _DataService.ModelName.Get(id.ToString());
    
    if (modelName == null) 
    {
        Response.StatusCode = 404; // not found
    }

    return modelName;
}
```
Note: Since id could be a Guid or integer the Get method in the Repository has a type of string for the parameter. For your use case you may prefer to make parameter overloads for the `Repistory<T>.Get` method. 

## Configuring the DAL

### Setting up the PostgreSql Database
In the directory [/src/PLpgSql](https://github.com/jbenzshawel/PgSqlLib/tree/master/src/PLpgSql) there are example stored procedures as well as an example table schema for setting up the database to work with the library. Since this library was built to not use Entity Framework, the table schema and stored procedures have to be scripted. The examples use [PL/pgSQL](https://www.postgresql.org/docs/9.6/static/plpgsql.html), but any of the [supported](https://www.postgresql.org/docs/9.6/static/xplang.html) procedural languages can be used (PL/pgSQL, PL/Tcl, PL/Perl, or PL/Python).

Note: The schema and stored procedures are intended to be used as an example / template. For the models in your application you will have to alter them for your needs. 

### Models
Models in this library work just like they would in MVC or WebAPI, however there is an additional attribute needed for properties that map to table columns. The [ColumnName](https://github.com/jbenzshawel/PgSqlLib/blob/master/src/App_Classes/ColumnName.cs) attribute should be applied to these properties. For example the attribute `[ColumnName("model_id")]`, with a string parameter corresponding to the PostgreSql column name, would be needed for a class property in a model.

### PgSql Objects 
Each list, get, save, and delete stored procedure created for models will need an entry in the corresponding Dictionary found in [PgSqlLib.PgSql.PgSqlObjects](https://github.com/jbenzshawel/PgSqlLib/blob/master/src/PgSql/PgSqlObjects.cs) with the appropriate parameters and name. An example for a get procedure by id is below.

```C#
private Dictionary<Type, PgSqlFunction> _getProcedures = null;
public  Dictionary<Type, PgSqlFunction> GetProcedures 
{ 
     get 
     {
         if (_getProcedures == null) 
         {
             _getProcedures = new Dictionary<Type, PgSqlFunction> 
             {
                 // add get procedures here 
                 { 
                     typeof(ModelName),  new PgSqlFunction 
                     {
                         Name = "get_model_name_by_id",
                         Parameters = new NpgsqlParameter[] { PgSql.NpgParam(NpgsqlDbType.Uuid, "p_model_id") }
                     } 
                 }             
             };
         } // end if _getProcedures == null        
         return _getProcedures;
    }
}
```

### Repository and DataService 
For each model in the PostgreSql database an instance of the class `PgSqlLib.Repository<T>` should be added to the `PgSqlLib.DataServce` class. See the example below for adding a model called "ModelName" to the DataService. 

```C#
public class DataService : IDataService
{
    // Add each model as property 
    public IRepository<ModelName> ModelName { get; set; }

    public DataService() 
    {
        // initialize the property to a new instance of the Repository class
        this.ModelName = new Repository<ModelName>(); 
    }
}
```

### Notes about Project
Eventually I plan on updating this library to use more reflection so there is less configuration involved. I may also switch the procedural language to Pg/Python. 
