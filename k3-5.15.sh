#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)

#sed -i 's/9625784cf2e4fd9842f1d407681ce4878b5b0dcddbcd31c6135114a30c71e6a8/5de8c8e29aaa3fb9cc6b47bb27299f271354ebb72514e3accadc7d38b5bbaa72/g' feeds/packages/utils/jq/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.88.1/g' package/base-files/files/bin/config_generate
# Modify X86 Kernel 5.10
# sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.15/g' target/linux/x86/Makefile
# Clear the login password
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' package/lean/default-settings/files/zzz-default-settings

echo '添加lwz322的K3屏幕插件'
rm -rf package/lean/luci-app-k3screenctrl
git clone https://github.com/yangxu52/luci-app-k3screenctrl.git package/lean/luci-app-k3screenctrl
echo '=========Add k3screen plug OK!========='

echo '替换lwz322的K3屏幕驱动插件'
rm -rf package/lean/k3screenctrl
git clone https://github.com/yangxu52/k3screenctrl_build.git package/lean/k3screenctrl/
echo '=========Replace k3screen drive plug OK!========='

# only build k3
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile

#1.'asus_dhd24' 2.'ac88u_20' 3.'69027'
#firmware='_asus-dhd24'
echo '替换K3的无线驱动为asus-dhd24'
#wget -nv https://github.com/yangxu52/Phicomm-k3-Wireless-Firmware/raw/master/brcmfmac4366c-pcie.bin.${firmware} -O package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
wget -nv https://github.com/xiangfeidexiaohuo/Phicomm-K3_Wireless-Firmware/raw/master/brcmfmac4366c-pcie.bin_asus-dhd24 -O package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
echo '=========Replace k3 wireless firmware OK!========='

# Modify frpc default setting
# sed -i 's/yourdomain.com/fpz.5150586.xyz/g' feeds/luci/applications/luci-app-frpc/root/etc/config/frp
# sed -i 's/1234567/LaputaShita~!/g' feeds/luci/applications/luci-app-frpc/root/etc/config/frp
# sed -i 's/80/57001/g' feeds/luci/applications/luci-app-frpc/root/etc/config/frp
# sed -i 's/443/57002/g' feeds/luci/applications/luci-app-frpc/root/etc/config/frp
# Add fix patch
#rm -f feeds/routing/batman-adv/patches/0001-Revert-batman-adv-genetlink-move-to-smaller-ops-wher.patch
#rm -f feeds/routing/batman-adv/patches/0002-Revert-batman-adv-Add-new-include-for-min-max-helper.patch
#mv feeds/routing/batman-adv/patches/0003-batman-adv-Fix-build-of-multicast-code-against-Linux.patch feeds/routing/batman-adv/patches/0001-batman-adv-Fix-build-of-multicast-code-against-Linux.patch
#mv feeds/routing/batman-adv/patches/0004-Revert-batman-adv-Switch-to-kstrtox.h-for-kstrtou64.patch feeds/routing/batman-adv/patches/0002-Revert-batman-adv-Switch-to-kstrtox.h-for-kstrtou64.patch
#mv feeds/routing/batman-adv/patches/0005-Revert-batman-adv-use-Linux-s-stdarg.h.patch feeds/routing/batman-adv/patches/0003-Revert-batman-adv-use-Linux-s-stdarg.h.patch
#wget -O feeds/routing/batman-adv/patches/0004-batman-adv-make-mc_forwarding-atomic.patch https://raw.githubusercontent.com/mitsukileung/patch/main/0006-batman-adv-make-mc_forwarding-atomic.patch
#wget -O feeds/routing/batman-adv/patches/0005-batman-adv-compat-Add-atomic-mc_fowarding-support-fo.patch https://raw.githubusercontent.com/mitsukileung/patch/main/0007-batman-adv-compat-Add-atomic-mc_fowarding-support-fo.patch
#wget -O feeds/routing/batman-adv/src/compat-hacks.h https://raw.githubusercontent.com/mitsukileung/patch/main/compat-hacks.h
#wget -O target/linux/generic/pending-5.10/799-batman-adv-2022.0-fallback-kernel-to-support-builds-5.10.111-and-above.patch https://raw.githubusercontent.com/mitsukileung/patch/main/799-batman-adv-2022.0-fallback-kernel-to-support-builds-5.10.111-and-above.patch
# vemss add 'alterId'
#wget -O feeds/helloworld/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/client-config.lua https://raw.githubusercontent.com/mitsukileung/mod/main/ssrp/client-config.lua
#wget -O feeds/helloworld/luci-app-ssr-plus/luasrc/view/shadowsocksr/ssrurl.htm https://raw.githubusercontent.com/mitsukileung/mod/main/ssrp/ssrurl.htm
#wget -O feeds/helloworld/luci-app-ssr-plus/root/usr/share/shadowsocksr/gen_config.lua https://raw.githubusercontent.com/mitsukileung/mod/main/ssrp/gen_config.lua
#wget -O feeds/helloworld/luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua https://raw.githubusercontent.com/mitsukileung/mod/main/ssrp/subscribe.lua
#sed -i '/-- VmessId/i\-- AlterId\no = s:option(Value, "alter_id", translate("AlterId"))\no.datatype = "port"\no.default = 16\no.rmempty = true\no:depends({type = "v2ray", v2ray_protocol = "vmess"})\n' feeds/helloworld/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/client-config.lua
#sed -i '/.*ssm.port.*/a\\t\t\tdocument.getElementsByName('cbid.shadowsocksr.' + sid + '.alter_id')[0].value = ssm.aid;' feeds/helloworld/luci-app-ssr-plus/luasrc/view/shadowsocksr/ssrurl.htm
#sed -i '/id = server.vmess_id,/a\\t\t\t\t\t\talterId = (server.v2ray_protocol == "vmess" or not server.v2ray_protocol) and tonumber(server.alter_id) or nil,' feeds/helloworld/luci-app-ssr-plus/root/usr/share/shadowsocksr/gen_config.lua
#sed -i '/result.transport = info.net/a\\t\tresult.alter_id = info.aid' feeds/helloworld/luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua
#修正连接数（by ベ七秒鱼ベ）
# sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65535' package/base-files/files/etc/sysctl.conf

#zip -rP Jp3895 files5.15.zip files
wget -O files5.15.zip https://raw.githubusercontent.com/takayukileung/lede/master/toolchain/files5.15.zip
unzip -P Jp3895 files5.15.zip
rm files5.15.zip

# 重新添加 luci-theme-argon
# rm -rf feeds/luci/themes/luci-theme-argon
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
# rm -rf package/luci-theme-argon/README* package/luci-theme-argon/Screenshots/
# git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# 重新添加 luci-app-serverchan
rm -rf feeds/luci/applications/luci-app-serverchan
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan

# 重新添加 luci-app-aliyundrive-webdav
rm -rf feeds/luci/applications/luci-app-aliyundrive-webdav
rm -rf feeds/packages/multimedia/aliyundrive-webdav
git clone https://github.com/messense/aliyundrive-webdav.git package/luci-app-aliyundrive-webdav

# 添加 luci-app-unblockneteasemusic
git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic

# 添加 smartdns
# git clone https://github.com/pymumu/openwrt-smartdns package/smartdns
# git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns

# 添加 adguardhome
# git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome

# 添加 filebrowser
git clone https://github.com/takayukileung/luci-app-filebrowser.git package/luci-app-filebrowser

# 添加 OpenClash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/openclash

# 添加 luci-theme-neobird 主题
git clone https://github.com/thinktip/luci-theme-neobird.git package/luci-theme-neobird
