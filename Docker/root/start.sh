#!/bin/bash
# 当前可用参数有：--no-update
ARGs=${*:-"--no-arguments"}
if [[ "$ARGs" != "--"* ]]; then echo "exec $ARGs"; eval "$ARGs"; exit $?; fi # 测试用
set -e; set -u
echo '
          ____  ____  _______    __     _____  ____
         / __ \/ __ \/_  __/ |  / /    |__  / / __ \
        / / / / / / / / /  | | / /      /_ < / / / /
       / /_/ / /_/ / / /   | |/ /     ___/ // /_/ /
      /_____/_____/ /_/    |___/     /____(_)____/

 _       ____________     _____
| |     / / ____/ __ )   / ___/___  ______   _____  _____
| | /| / / __/ / __  |   \__ \/ _ \/ ___/ | / / _ \/ ___/
| |/ |/ / /___/ /_/ /   ___/ /  __/ /   | |/ /  __/ /
|__/|__/_____/_____/   /____/\___/_/    |___/\___/_/
'
echo "Running as UID ${PUID:=$UID} and GID ${PGID:=$PUID}."
echo ""
cd /DDTV

Backups_Path=/DDTV_Backups
BiliUser_Path=./BiliUser.ini
DDTV_Config=${DDTV_Config:-"./DDTV_Config.ini"}
RoomListConfig=${RoomListConfig:-"./RoomListConfig.json"}

# 检测 DDTV 目录文件是否齐全
if [ "$(ls -A $Backups_Path)" ]; then
    shopt -s globstar nullglob
    for file in test/**; do
        [ "${file##"$Backups_Path"/}" = "" ] && continue
        [ ! -e "${file##"$Backups_Path"/}" ] && cp -vur "$file" "${file##"$Backups_Path"/}"
    done
fi

# 写入 RoomListConfig.json
if [ ! -e "$RoomListConfig" ]; then
    if [ -n "${RoomList:-}" ]; then
        echo "$RoomList" > "$RoomListConfig"
    fi
fi

# 写入 BiliUser.ini
if [ ! -e "$BiliUser_Path" ]; then
    if [ -n "${BiliUser:-}" ]; then
        echo -e "$BiliUser" > $BiliUser_Path
    fi
fi

# 写入 DDTV_Config.ini
if [ ! -e "$DDTV_Config" ]; then
echo "[Core]
RoomListConfig=$RoomListConfig
GUI_FirstStart=true
WEB_FirstStart=true
${TranscodParmetrs:+TranscodParmetrs=$TranscodParmetrs}
${IsAutoTranscod:+IsAutoTranscod=$IsAutoTranscod}
${ClientAID:+ClientAID=$ClientAID}
[Download]
${DownloadPath:+DownloadPath=$DownloadPath}
${TmpPath:+TmpPath=$TmpPath}
${DownloadDirectoryName:+DownloadDirectoryName=$DownloadDirectoryName}
${DownloadFileName:+DownloadFileName=$DownloadFileName}
${RecQuality:+RecQuality=$RecQuality}
${IsRecDanmu:+IsRecDanmu=$IsRecDanmu}
${IsRecGift:+IsRecGift=$IsRecGift}
${IsRecGuard:+IsRecGuard=$IsRecGuard}
${IsRecSC:+IsRecSC=$IsRecSC}
${IsFlvSplit:+IsFlvSplit=$IsFlvSplit}
${FlvSplitSize:+FlvSplitSize=$FlvSplitSize}
[WEB_API]
${WEB_API_SSL:+WEB_API_SSL=$WEB_API_SSL}
${pfxFileName:+pfxFileName=$pfxFileName}
${pfxPasswordFileName:+pfxPasswordFileName=$pfxPasswordFileName}
${WebUserName:+WebUserName=$WebUserName}
${WebPassword:+WebPassword=$WebPassword}
${AccessKeyId:+AccessKeyId=$AccessKeyId}
${AccessKeySecret:+AccessKeySecret=$AccessKeySecret}
${ServerAID:+ServerAID=$ServerAID}
${ServerName:+ServerName=$ServerName}
${AccessControlAllowOrigin:+AccessControlAllowOrigin=$AccessControlAllowOrigin}
${AccessControlAllowCredentials:+AccessControlAllowCredentials=$AccessControlAllowCredentials}
" > "$DDTV_Config"
fi # 22.03.06 更新至AccessControlAllowCredentials

# 更新 DDTV
if [[ "$ARGs" != *"--no-update"* ]]; then
    dotnet DDTV_Update.dll docker
fi

./etc/os-release
chown -R $PUID:$PGID /DDTV "${DownloadPath:-}" "${TmpPath:-}"

if [[ "$ID" == "debian" ]]; then
    gosu $PUID:$PGID dotnet DDTV_WEB_Server.dll
elif [[ "$ID" == "alpine" ]]; then
    su-exec $PUID:$PGID dotnet DDTV_WEB_Server.dll
else
    echo "未支持$ID" && exit 1
fi
