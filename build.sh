set -ev
dotnet restore
dotnet build project.json
#dotnet build ./test/ApiQuizGenerator.Tests/project.json
#dotnet test ./test/ApiQuizGenerator.Tests/project.json
