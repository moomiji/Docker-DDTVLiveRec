#!/bin/sh
set -e; set -u

. /etc/os-release

case $ID in
    alpine)
        apk add --no-cache bash ffmpeg su-exec
      # sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g'  /etc/apk/repositories
        ;;

    debian)
        apt update
        apt install --no-install-recommends bash ffmpeg gosu -y
      # sed -i 's/deb.debian.org/mirrors.aliyun.com/g'          /etc/apt/sources.list.d/debian.sources
        ;;

    ubuntu)
        apt update
        apt install --no-install-recommends bash ffmpeg gosu -y
      # sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g'      /etc/apt/sources.list
        ;;

    *)
        echo "Error OS ID: $ID!" && exit 1
        ;;
esac

rm -rf /var/lib/apt/lists/* /var/cache/apk/* /root/.cache /tmp/* "$0"
