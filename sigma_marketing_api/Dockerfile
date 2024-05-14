FROM mcr.microsoft.com/dotnet/sdk:6.0 AS base
WORKDIR /app
EXPOSE 5050
ENV ASPNETCORE_URLS=http://+:5050

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY SigmaMarketing/SigmaMarketing.API.csproj SigmaMarketing/
COPY SigmaMarketing.Core/SigmaMarketing.Core.csproj SigmaMarketing.Core/
COPY SigmaMarketing.Infrastructure/SigmaMarketing.Infrastructure.csproj SigmaMarketing.Infrastructure/
COPY SigmaMarketing.Model/SigmaMarketing.Model.csproj SigmaMarketing.Model/
RUN dotnet restore "SigmaMarketing/SigmaMarketing.API.csproj"
COPY . .

WORKDIR "/src/SigmaMarketing"
FROM build AS publish
RUN dotnet publish "SigmaMarketing.API.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .

ENTRYPOINT ["dotnet", "SigmaMarketing.API.dll"]