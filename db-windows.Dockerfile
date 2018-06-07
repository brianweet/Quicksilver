# Stage-1: Create image to build our application with
FROM microsoft/dotnet-framework:4.7.2-sdk AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY Sources/*.config .
COPY Sources/*.config /Sources/.
COPY Sources/EPiServer.Reference.Commerce.Manager/*.csproj ./Sources/EPiServer.Reference.Commerce.Manager/
COPY Sources/EPiServer.Reference.Commerce.Manager/*.config ./Sources/EPiServer.Reference.Commerce.Manager/
COPY Sources/EPiServer.Reference.Commerce.Shared/*.csproj ./Sources/EPiServer.Reference.Commerce.Shared/
COPY Sources/EPiServer.Reference.Commerce.Shared/*.config ./Sources/EPiServer.Reference.Commerce.Shared/
COPY Sources/EPiServer.Reference.Commerce.Site/*.csproj ./Sources/EPiServer.Reference.Commerce.Site/
COPY Sources/EPiServer.Reference.Commerce.Site/*.config ./Sources/EPiServer.Reference.Commerce.Site/
COPY Sources/EPiServer.Reference.Commerce.Site.Tests/*.csproj ./Sources/EPiServer.Reference.Commerce.Site.Tests/
COPY Sources/EPiServer.Reference.Commerce.Site.Tests/*.config ./Sources/EPiServer.Reference.Commerce.Site.Tests/
RUN nuget restore

FROM microsoft/mssql-server-windows-developer:1709
WORKDIR /import
COPY Setup/. ./Setup/.
COPY --from=build /app/Packages/. ./Packages/.
#RUN ./Setup/SetupDatabases.cmd
WORKDIR /
