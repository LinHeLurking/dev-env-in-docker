#!/bin/bash

HOST_IP="127.0.0.1"
PROXY_PORT="1081"

PROXY_HTTP="http://${HOST_IP}:${PROXY_PORT}"

run_xray(){
  ~/.xray/xray 1> ~/.xray/log/access.log 2> ~/.xray/log/error.log &
}

stop_xray(){
  _pid=$(pgrep -f xray)
  [ "$_pid" = "" ] || sudo kill -9 $_pid 
}

update_xray(){
  cd ~/.xray
  wget https://ghproxy.com/https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
  wget https://ghproxy.com/https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip.dgst
  got=$(sha256sum Xray-linux-64.zip | sed "s/Xray-linux-64.zip//g"  | sed "s/\ //g")
  expected=$(cat Xray-linux-64.zip.dgst | grep SHA256 | sed "s/SHA256=//g" | sed "s/\ //g")
  [ "$got" = "$expected" ]
  unzip Xray-linux-64.zip
  rm Xray-linux-64.zip
  rm Xray-linux-64.zip.dgst
  chmod 755 xray geoip.dat geosite.dat
}

set_proxy_env(){
    export http_proxy="${PROXY_HTTP}"
    export HTTP_PROXY="${PROXY_HTTP}"

    export https_proxy="${PROXY_HTTP}"
    export HTTPS_PROXY="${PROXY_HTTP}"

    export all_proxy="${PROXY_HTTP}"
    export ALL_PROXY="${PROXY_HTTP}"
    

    git config --global http.proxy ${PROXY_HTTP}
    git config --global https.proxy ${PROXY_HTTP}
}

unset_proxy_env(){
    unset http_proxy
    unset HTTP_PROXY
    unset https_proxy
    unset HTTPS_PROXY
    unset all_proxy
    unset ALL_PROXY
    
    git config --global --unset http.proxy ${PROXY_HTTP}
    git config --global --unset https.proxy ${PROXY_HTTP}
}

test_proxy_env(){
    echo "Current proxy:" ${https_proxy}
}
