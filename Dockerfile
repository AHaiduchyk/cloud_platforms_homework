FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

COPY SampleWebApiAspNetCore.sln .
COPY SampleWebApiAspNetCore/ ./SampleWebApiAspNetCore/

RUN dotnet restore "SampleWebApiAspNetCore/SampleWebApiAspNetCore.csproj"
RUN dotnet publish "SampleWebApiAspNetCore/SampleWebApiAspNetCore.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .


ENV ASPNETCORE_URLS=http://+:8080

ENTRYPOINT ["dotnet", "SampleWebApiAspNetCore.dll"]
