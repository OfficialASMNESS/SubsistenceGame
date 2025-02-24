#!/bin/bash
set -e
if [[ -n $FORCE_UPDATE ]] && [[ $FORCE_UPDATE == "true" ]]; then
    /home/steam/steamcmd/steamcmd.sh +force_install_dir "/opt/palworld" +login anonymous +app_update 1362640 validate +quit
fi

if [[ ! -f /opt/palworld/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini ]]; then
    mkdir -p /opt/palworld/Pal/Saved/Config/LinuxServer/
    cat /opt/palworld/DefaultPalWorldSettings.ini >/opt/palworld/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
    if [[ -n $SERVER_NAME ]]; then
        sed -i "s^ServerName=\"Default Palworld Server\"^ServerName=\"$SERVER_NAME\"^g" /opt/Subsistence Dedicated Server/UDKGame/Config/DefaultDedServerSettings.ini
    fi
    if [[ -n $SERVER_DESC ]]; then
        sed -i "s^ServerDescription=\"\"^ServerDescription=\"$SERVER_DESC\"^g" /opt/Subsistence Dedicated Server/UDKGame/Config/DefaultDedServerSettings.ini
    fi
    if [[ -n $ADMIN_PASSWORD ]]; then
        sed -i "s^AdminPassword=\"\"^AdminPassword=\"$ADMIN_PASSWORD\"^g" /opt/Subsistence Dedicated Server/UDKGame/Config/DefaultDedServerSettings.ini
    fi
    if [[ -n $SERVER_PASSWORD ]]; then
        sed -i "s^Password=\"\"^ServerPassword=\"$SERVER_PASSWORD\"^g" /opt/Subsistence Dedicated Server/UDKGame/Config/DefaultDedServerSettings.ini
    fi
    if [[ -n $RCON_ENABLED ]] && [[ $RCON_ENABLED == "true" ]]; then
        sed -i "s^RCONEnabled=False^RCONEnabled=True^g" /opt/Subsistence Dedicated Server/UDKGame/Config/DefaultDedServerSettings.ini
    fi
    if [[ -n $RCON_PORT ]]; then
        sed -i "s^RCONPort=7779^RCONPort=$RCON_PORT^g" /opt/Subsistence Dedicated Server/UDKGame/Config/DefaultDedServerSettings.ini
    fi
fi

