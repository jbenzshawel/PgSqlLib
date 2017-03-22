# PgSqlLib

[![Build Status](https://travis-ci.org/jbenzshawel/PgSqlLib.svg?branch=master)](https://travis-ci.org/jbenzshawel/PgSqlLib)

 PostgreSql Class Library for ASP.NET Core DAL.

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
using  PgSqlLib;

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
Controllers that inherit the BaseController class can then use the DataService with the PostgreSql database. 
