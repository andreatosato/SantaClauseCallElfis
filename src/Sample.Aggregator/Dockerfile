#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["Sample.Aggregator/Sample.Aggregator.csproj", "Sample.Aggregator/"]
RUN dotnet restore "Sample.Aggregator/Sample.Aggregator.csproj"
COPY . .
WORKDIR "/src/Sample.Aggregator"
RUN dotnet build "Sample.Aggregator.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Sample.Aggregator.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Sample.Aggregator.dll"]