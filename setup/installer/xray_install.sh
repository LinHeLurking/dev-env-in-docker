#!/bin/bash

# 请以普通用户执行该脚本

choice="$1"
shell="$2"

install_dir="/home/$USER/.xray"
log_dir="/home/$USER/.xray/log"
xray_core_url="https://ghproxy.com/https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip"
xray_core_dgst_url="https://ghproxy.com/https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip.dgst"

install_func_cmd=$(cat << END
update_xray() {
    cd $install_dir 
    wget $xray_core_url 
    wget $xray_core_dgst_url 
    got=\$(sha256sum Xray-linux-64.zip | sed "s/Xray-linux-64.zip//g"  | sed "s/\ //g") 
    expected=\$(cat Xray-linux-64.zip.dgst | grep SHA256 | sed "s/SHA256=//g" | sed "s/\ //g") 
    [ "\$got" = "\$expected" ] 
    unzip Xray-linux-64.zip 
    rm Xray-linux-64.zip 
    rm Xray-linux-64.zip.dgst 
    chmod 755 xray geoip.dat geosite.dat
}
END
)

[ "$choice" = "1" ] || exit 0

mkdir -p $install_dir && \
mkdir -p $log_dir && \
cd $install_dir && \
wget $xray_core_url && \
wget $xray_core_dgst_url && \
got=$(sha256sum Xray-linux-64.zip | sed "s/Xray-linux-64.zip//g"  | sed "s/\ //g") && \
expected=$(cat Xray-linux-64.zip.dgst | grep SHA256 | sed "s/SHA256=//g" | sed "s/\ //g") && \
[ "$got" = "$expected" ] && \
unzip Xray-linux-64.zip && \
rm Xray-linux-64.zip && \
rm Xray-linux-64.zip.dgst && \
chmod 755 xray geoip.dat geosite.dat && \
cp /tmp/util/proxy.sh /home/$USER/.proxy.sh && \
( \
  ( \
    [ -f /tmp/config/xray.config.json ] && \
    cp /tmp/config/xray.config.json "$install_dir/config.json" \
  ) || \
  true \
) && \
echo "source ~/.proxy.sh" >> "/home/$USER/.${shell}rc"

