FROM openjdk:8u171-jre-alpine
LABEL maintainer "pascal"

RUN apk add --no-cache -U \
          openssl \
          imagemagick \
          lsof \
          su-exec \
          shadow \
          bash \
          curl iputils wget \
          git \
          jq \
          mysql-client \
          python python-dev py2-pip
          

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && mkdir -m 777 /data /mods /config /plugins \
  && chown minecraft:minecraft /data /config /mods /plugins /home/minecraft


RUN wget -O /tmp/tekkit.zip http://servers.technicpack.net/Technic/servers/tekkitlite/Tekkit_Lite_Server_0.6.5.zip
RUN unzip /tmp/tekkit.zip -d /data
RUN chmod +x /data/launch.sh

VOLUME ["/data"]
EXPOSE 25565

WORKDIR /data
ENTRYPOINT ["/bin/sh","/data/launch.sh"]


#Geht um nen Tekkit Minecraft server
#also, mein problem ist, dass ich gerne ein Volume hätte, dass mir die Daten des Servers im Docker container seperat auf meiner maschine speichert, damit ich z.B die Welt ändern kann oder Einstellungen vornehmen kann.
# mein Ansatz war jetzt folgender (Nach dem bauen des images): "docker run -p 25565:25565 -v /home/pascal/workspace:/data (containername)"
#der sagt mir aber, dass er /data/launch.sh nicht finden kann.
# Wenn ich das starte, ohne ein Volume zu erstellen klappt es ohne probleme, nur komme ich nur schwer an die Serverdaten ran


# Hast du evtl. einen Lösungsansatz?