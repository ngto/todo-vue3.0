#!/bin/bash
# 压缩文件
tar -zcvf todos-vue.tar.gz dist
echo "[文件压缩完成！]"

# scp 将压缩包上传到服务器
scp todos-vue.tar.gz root@47.104.216.85:/docker/nginx/html
echo "[文件上传完成完成！]"

# shh链接服务器
ssh root@47.104.216.85 << remotessh
cd  /docker/nginx/html
rm -rf todos-vue
mkdir todos-vue 
tar -zxvf todos-vue.tar.gz -C /docker/nginx/html/todos-vue 
rm -rf todos-vue.tar.gz
docker restart myNginx
exit
remotessh

echo "[代码发布完成！]"

rm -rf todos-vue.tar.gz
echo "[删除本地压缩包！]"
