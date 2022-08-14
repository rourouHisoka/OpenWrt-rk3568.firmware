#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# Add luci-app-passwall
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git luci-app-passwall https://github.com/xiaorouji/openwrt-passwall/tree/luci/luci-app-passwall' >>feeds.conf.default

#Add luci-app-filebrowser
echo 'src-git filebrowser https://github.com/kenzok8/openwrt-packages/tree/master/filebrowser' >>feeds.conf.default
echo 'src-git luci-app-filebrowser https://github.com/kenzok8/openwrt-packages/tree/master/luci-app-filebrowser' >>feeds.conf.default

# Mod zzz-default-settings
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
sed -i '/18.06/d' zzz-default-settings
export orig_version=$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date -d "$(rdate -n -4 -p ntp.aliyun.com)" +'%Y-%m-%d')
sed -i "s/${orig_version}/${orig_version} (${date_version})/g" zzz-default-settings
popd


