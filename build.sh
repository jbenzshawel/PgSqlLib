set -ev
dotnet restore src/project.json
dotnet build src/project.json
#dotnet build ./test/
#dotnet test ./test/
