# Backend für Marina-Team

## Project setup

1. Install the .NET Core SDK.
2. Set up the .NET Core Project:
```
> dotnet dev-certs https --trust
> dotnet nuget add source --name nuget.org https://api.nuget.org/v3/index.json
> dotnet restore
```

3. Install Postgres 14 and setup the user according to the appsettings.json.
4. Run the Migrations.

## Migrations

Install the Migration Tool
```
> dotnet tool install --global dotnet-ef
```

Update database schema:
```
> dotnet ef migrations add InitialCreate
> dotnet ef database update
```

## Running

Use Visual Studio Code or the .Net Core CLI
```
dotnet watch run
```

## Dependencies

- Npgsql.EntityFrameworkCore.PostgreSQL
- Microsoft.AspNetCore.Mvc.NewtonsoftJson
- Microsoft.EntityFrameworkCore.Design
- Microsoft.EntityFrameworkCore.Tools