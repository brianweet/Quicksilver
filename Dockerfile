# Stage-1: Create image to run our application with
FROM brianweet/iis-mssql:ltsc2016

# Add dbs
WORKDIR /
COPY Setup/Quicksilver.Cms.mdf ./Databases/
COPY Setup/Quicksilver.Cms_log.ldf ./Databases/
COPY Setup/Quicksilver.Commerce.mdf ./Databases/
COPY Setup/Quicksilver.Commerce_log.ldf ./Databases/
ENV attach_dbs='[{"dbName":"Quicksilver.Cms","dbFiles":["C:\\Databases\\Quicksilver.Cms.mdf","C:\\Databases\\Quicksilver.Cms_log.ldf"]},{"dbName":"Quicksilver.Commerce","dbFiles":["C:\\Databases\\Quicksilver.Commerce.mdf","C:\\Databases\\Quicksilver.Commerce_log.ldf"]}]'
ENV sa_password=P@ssw0rd1!
ENV ACCEPT_EULA=Y

WORKDIR /inetpub/wwwroot
COPY Sources/EPiServer.Reference.Commerce.Site/. .
WORKDIR /inetpub
RUN mkdir appdata
RUN icacls ./appdata /grant everyone:F /T
RUN icacls ./wwwroot /grant everyone:F /T
WORKDIR /