#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["Sample.ElfoTwo/Sample.ElfoTwo.csproj", "Sample.ElfoTwo/"]
RUN dotnet restore "Sample.ElfoTwo/Sample.ElfoTwo.csproj"
COPY . .
WORKDIR "/src/Sample.ElfoTwo"
RUN dotnet build "Sample.ElfoTwo.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Sample.ElfoTwo.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Sample.ElfoTwo.dll"]
