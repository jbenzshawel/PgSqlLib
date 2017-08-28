set -ev
dotnet restore src/PgSql.csproj
dotnet build src/PgSql.csproj
#dotnet build ./test/
#dotnet test ./test/
