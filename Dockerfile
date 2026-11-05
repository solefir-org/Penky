FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY CardGame/CardGame.csproj CardGame/
RUN dotnet restore CardGame/CardGame.csproj
COPY CardGame/ CardGame/
RUN dotnet publish CardGame/CardGame.csproj -c Release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "CardGame.dll"]
