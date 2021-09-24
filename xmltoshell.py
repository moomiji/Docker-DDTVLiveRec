import xml.etree.ElementTree as ET

s = '''<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <appSettings>
    <!--大多数内容修改过后可能会导致录制失败或完成后文件被自动删除，修改前请咨询开发者或阅读代码-->
    <add key="file" value="./tmp/" /><!--指定录制的文件储存路径(相对路径或者绝对路径均可，但是必须保证路径存在)-->
    <add key="Livefile" value="./tmp/LiveCache/" />
    <add key="DANMU" value="0" />
    <add key="PlayWindowHeight" value="440" />
    <add key="PlayWindowWidth" value="720" />
    <add key="YouTubeResolution" value="640x360" />
    <add key="RoomConfiguration" value="./RoomListConfig.json" />
    <add key="RoomTime" value="40" />
    <add key="danmupost" value="0" />
    <add key="DefaultVolume" value="100" />
    <add key="Zoom" value="1" />
    <add key="cookie" value="" />
    <add key="DT1" value="0" />
    <add key="DT2" value="0" />
    <add key="PlayNum" value="5" />
    <add key="DanMuColor" value="0xFF,0x00,0x00,0x00" />
    <add key="ZiMuColor" value="0xFF,0x00,0x00,0x00" />
    <add key="DanMuSize" value="20" />
    <add key="ZiMuSize" value="24" />
    <add key="ClientSettingsProvider.ServiceUri" value="" />
    <add key="LiveListTime" value="5" />
    <add key="PlayWindowH" value="450" />
    <add key="PlayWindowW" value="800" />
    <add key="BufferDuration" value="3" />
    <add key="AutoTranscoding" value="0" />
    <add key="ClipboardMonitoring" value="0" />
    <add key="DataSource" value="0" />
    <add key="IsFirstTimeUsing" value="1" />
    <add key="NotVTBStatus" value="0" /><!--监控非VTBS房间(启动WSS连接组，因为阿B的连接限制，请确保非VTBS的房间数不超过3个，否则会导致未知的错误)-->
    <add key="LiveRecWebServerDefaultIP" value="0.0.0.0" /><!--WEB监控的默认IP地址-->
    <add key="Port" value="11419"/><!--WEB监控的默认端口-->
    <add key="RecordDanmu" value="0" /><!--录制弹幕信息(该功能可能会导致房间监控失效，如果必须录制，推荐监控列表中就放目标房间，并且由于是因为阿B的服务器接口限制问题，暂时无法修复)-->
    <add key="BootUp" value="0" />
    <add key="DebugFile" value="1" />
    <add key="DebugCmd" value="1" />
    <add key="DebugMod" value="1" /><!--启动Debug模式，会在日志中输出debug信息，并且把debug信息储存到LOG文件夹中-->
    <add key="DevelopmentModel" value="0" /><!---->
    <add key="DokiDoki" value="300" /><!--心跳打印的间隔时间(秒)-->
    <add key="NetStatusMonitor" value="0" />
    <add key="WebAuthenticationAadminPassword" value="admin" /><!--WEB页验证所需的管理员权限验证码-->
    <add key="WebAuthenticationGhostPasswrod" value="ghost" /><!--WEB页验证所需的游客权限验证码-->
    <add key="WebAuthenticationCode" value="DDTVLiveRec" /><!--页验证所需的二次验证码-->
    <add key="sslName" value="" /> <!--在DDTVLiveRec根目录存在的pfx证书文件完整文件名(例:DDTV.pfx)-->
    <add key="sslPssword" value="" /><!--pfx证书文件的密码-->   
    <add key="EnableUpload" value="0"/><!--开启上传(0:关闭，1:开启)-->
    <add key="DeleteAfterUpload" value="1"/><!--上传后删除源文件-->
    <add key="EnableOneDrive" value="0"/><!--OneDrive上传(0:关闭，其他:上传顺序)-->
    <add key="OneDriveConfig" value="" />
    <add key="OneDrivePath" value=""/>
    <add key="EnableCos" value="0"/><!--COS上传(0:关闭，其他:上传顺序)-->
    <add key="CosSecretId" value=""/>
    <add key="CosSecretKey" value=""/>
    <add key="CosRegion" value=""/><!--cos桶区域，格式为xx-xxxx-->
    <add key="CosBucket" value=""/><!--cos桶名称，格式为bucketname-appid-->
    <add key="CosPath" value=""/>
    <add key="EnableBaiduPan" value="0"/><!--百度网盘上传(0:关闭，其他:上传顺序) 需提前登录-->
    <add key="BaiduPanPath" value=""/>
    <add key="EnableOss" value="0"/><!--OSS上传(0:关闭，其他:上传顺序)-->
    <add key="OssAccessKeyId" value=""/>
    <add key="OssAccessKeySecret" value=""/>
    <add key="OssEndpoint" value=""/>
    <add key="OssBucketName" value=""/>
    <add key="OssPath" value=""/>
    <add key="AutoTranscodingDelFile" value="0" /><!--转码后自动删除文件-->
    <add key="ServerName" value="DDTVServer" /><!-- 服务器默认名称 -->
    <add key="ServerAID" value="8198ae60-094f-48a6-8272-1c2be8959c6a" /><!-- 服务器编号 -->
    <add key="ServerGroup" value="default" /><!-- 服务器默认分组 -->
    <add key="ApiToken" value="1145141919810A" /><!-- 默认APIToken -->
    <add key="WebUserName" value="ami" /><!-- WEB详情页账号 -->
    <add key="WebPassword" value="ddtv" /><!-- WEB详情页密码 -->
    <add key="WebhookUrl" value="" /><!-- webhoob目标URL -->
    <add key="WebhookEnable" value="0" /><!-- webhook使能 -->
    <add key="WebSocketPort" value="11451" /><!-- WS服务器默认端口 -->
    <add key="WebSocketEnable" value="0" /><!-- WS服务器使能 -->
    <add key="WebSocketUserName" value="defaultUserName" /><!-- WS服务器默认账号 -->
    <add key="WebSocketPassword" value="defaultPassword" /><!-- WS服务器默认密码 -->
    <add key="DefaultFileName" value="{date}_{title}_{time}" /><!-- 保存的文件名默认格式，没有特殊需求请勿修改 -->
  </appSettings>
</configuration>'''


path = "$FILEPATH"
tree = ET.fromstring(s)

for node in tree.iter('add'):
    key = node.attrib['key']
    value = node.attrib['value'].replace("/", "\/")
    key2 = '$' + key
    if not value:
        key2 = r'\"{}\"'.format(key2)
        value = r'\"\"'
    
    print("""    if [ ! "${0}" ]; then
        sed -i "/{0}/s/{1}/{2}/" {3}
    fi""".format(key, value, key2, path)
    )
