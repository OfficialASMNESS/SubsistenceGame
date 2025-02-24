FROM cm2network/steamcmd:steam

ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /opt/subsistence

RUN /home/steam/steamcmd/steamcmd.sh +force_install_dir "/opt/subsistence" +login anonymous +app_update 1362640 validate +quit

ENV GAME_PORT=7778
ENV MAX_PLAYERS=32
ENV ENABLE_MULTITHREAD=true
ENV IS_PUBLIC=false
ENV PUBLIC_IP=
ENV PUBLIC_PORT=
ENV FORCE_UPDATE=false
ENV SERVER_NAME="Default Subsistence Server"
ENV SERVER_DESC="Default Subsistence Server"
ENV ADMIN_PASSWORD=changeme
ENV SERVER_PASSWORD=
ENV RCON_ENABLED=false
ENV RCON_PORT=7779

ADD docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE ${GAME_PORT}/udp ${RCON_PORT}/tcp ${RESTAPI_PORT}/tcp

# fix permission
RUN mkdir -p /opt/subsistence
VOLUME [ "/opt/subsistence" ]

ENTRYPOINT [ "/docker-entrypoint.sh" ]
