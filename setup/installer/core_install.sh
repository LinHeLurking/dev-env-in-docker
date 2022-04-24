#!/bin/bash

# 请以 sudo 执行该脚本

apt install -y sudo git gnupg wget curl vim ca-certificates locales zip
echo \"debconf debconf/frontend select Noninteractive\" | debconf-set-selections
