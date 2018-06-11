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

# copy everything else and build app
COPY Sources/. ./Sources/
WORKDIR /app
RUN msbuild /p:Configuration=Release

# Stage-2: Create image to run our application with
FROM microsoft/aspnet:4.7.2-windowsservercore-1803
RUN Add-WindowsFeature Web-WebSockets
WORKDIR /inetpub/wwwroot
COPY --from=build /app/Sources/EPiServer.Reference.Commerce.Site/. .
# RUN icacls ./* /grant everyone:F /T