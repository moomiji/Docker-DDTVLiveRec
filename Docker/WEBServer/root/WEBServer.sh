#!/bin/bash
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
|__/|__/_____/_____/   /____/\___/_/    |___/\___/_/'

set -e; set -u
./checkup.sh
cd /DDTV

# 参数更新需修改 README.md docker-compose.yml
# 可用参数有: 
#   --no-update
if [[ "$*" != "--"* ]]; then
    # 运行测试命令
    echo "exec $ARGs" && eval "$ARGs" && exit $?
else
    # 更新 DDTV
    [[ "$*" != *"--no-update"* ]] && dotnet DDTV_Update.dll docker
fi

# 运行 DDTV
# 可用参数有:
#   $PUID
#   $PGID
#   $DownloadPath
#   $TmpPath
. /etc/os-release
echo "Running as UID ${PUID:=$UID} and GID ${PGID:=$PUID}."
mkdir -vp "${DownloadPath:=./Rec/}" "${TmpPath:=./tmp/}"
chown -R "$PUID:$PGID" "$DDTV_Path" "$DownloadPath" "$TmpPath"

if [[ "$ID" == "debian" ]]; then
    gosu $PUID:$PGID dotnet DDTV_WEB_Server.dll
elif [[ "$ID" == "alpine" ]]; then
    su-exec $PUID:$PGID dotnet DDTV_WEB_Server.dll
else
    echo "未支持$ID" && exit 1
fi