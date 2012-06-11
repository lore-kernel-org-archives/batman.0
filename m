Return-Path: <ditwal001@gmail.com>
From: "Walter Robert Ditzler" <ditwal001@gmail.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPvMiqao58dPrVwIXxeghf4BAAAAAA==@gmail.com>
	<9663458.DgTmOPncVH@bentobox>
	<!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPMeAInHZDxMj0Jo5ITXNbIBAAAAAA==@gmail.com>
	<1734690.HLHHpGXZRy@bentobox>
In-Reply-To: <1734690.HLHHpGXZRy@bentobox>
Date: Mon, 11 Jun 2012 17:46:15 +0200
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAI5Tx/y7OqVCpYYUmUSCFO4BAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: de-ch
Subject: Re: [B.A.T.M.A.N.] bridging problem
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: 'Sven Eckelmann' <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

hi sven,

thanks, i am too long on the same problem, of course it was the udev!

cheers walter

-----Original Message-----
From: Sven Eckelmann [mailto:sven@narfation.org] 
Sent: Montag, 11. Juni 2012 16:35
To: Walter Robert Ditzler; b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [B.A.T.M.A.N.] bridging problem

On Monday 11 June 2012 15:49:24 Walter Robert Ditzler wrote:
> hi sven,
> 
> as promised my final report :-)
> 
> at the end only one question has left, but it is hardware wifi 
> related. i have several alix hardware boxes, now all with double ath5 wlan
cards.
> strange is sometimes when i create the vif (iw phy phy1) becomes the 
> wlan 0 and sometimes wlan1. any glue on that?

Sounds a little bit like udev is renaming the device even when you told iw
how the device should be named (see persistent net settings).

http://www.ducea.com/2008/09/01/remove-debian-udev-persistent-net-rules/

Kind regards,
	Sven

Just for the other people:
> ***
> as you mentioned hostapd and ath5 are very buggy! under debian i only 
> could get it to run under following conditions:
> 
> 1) system related
> ***************
> add to apt source list:
> deb http://backports.debian.org/debian-backports squeeze-backports 
> main
> 
> install hostapd from:
> DEBIAN_FRONTEND=noninteractive aptitude -y install -t 
> squeeze-backports batctl hostapd
> 
> (hostapd >= 0.6.10)
> 
> kernel:
> ***
> root@srv-ldeb-basic1:/etc/hostapd# cat /boot/config-3.4.0-adx-alix 
> |grep "80211"
> CONFIG_CFG80211=m
> CONFIG_NL80211_TESTMODE=y
> CONFIG_CFG80211_DEVELOPER_WARNINGS=y
> CONFIG_CFG80211_REG_DEBUG=y
> CONFIG_CFG80211_DEFAULT_PS=y
> CONFIG_CFG80211_DEBUGFS=y
> CONFIG_CFG80211_INTERNAL_REGDB=y
> CONFIG_CFG80211_WEXT=y
> CONFIG_LIB80211=m
> CONFIG_LIB80211_CRYPT_WEP=m
> CONFIG_LIB80211_CRYPT_CCMP=m
> CONFIG_LIB80211_CRYPT_TKIP=m
> CONFIG_LIB80211_DEBUG=y
> CONFIG_MAC80211=m
> CONFIG_MAC80211_HAS_RC=y
> CONFIG_MAC80211_RC_PID=y
> CONFIG_MAC80211_RC_MINSTREL=y
> CONFIG_MAC80211_RC_MINSTREL_HT=y
> # CONFIG_MAC80211_RC_DEFAULT_PID is not set 
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
> CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
> CONFIG_MAC80211_MESH=y
> CONFIG_MAC80211_LEDS=y
> CONFIG_MAC80211_DEBUGFS=y
> CONFIG_MAC80211_DEBUG_MENU=y
> CONFIG_MAC80211_NOINLINE=y
> CONFIG_MAC80211_VERBOSE_DEBUG=y
> CONFIG_MAC80211_HT_DEBUG=y
> CONFIG_MAC80211_TKIP_DEBUG=y
> CONFIG_MAC80211_IBSS_DEBUG=y
> CONFIG_MAC80211_VERBOSE_PS_DEBUG=y
> CONFIG_MAC80211_VERBOSE_MPL_DEBUG=y
> CONFIG_MAC80211_VERBOSE_MPATH_DEBUG=y
> CONFIG_MAC80211_VERBOSE_MHWMP_DEBUG=y
> CONFIG_MAC80211_VERBOSE_TDLS_DEBUG=y
> CONFIG_MAC80211_DEBUG_COUNTERS=y
> CONFIG_MAC80211_HWSIM=m
> ***
> 
> 2) wifi related
> ************
> - ath5 only supports 1 adhoc vif
> - ath5 can't run in master mode without hostapd
> - ath5 bridging and mesh only possible with 2 wlan cards
> - ath9 no problems at all
> - ath9 bridging and mesh with one wlan card possible
> 
> !!! attention !!!
> 
> when using ath5 wlan cards hostapd service hast o be restared. only 
> after restarting the hostapd service you will be able to link second 
> wlan ath5 card into the bridge br0. i tried many thing but this ist he 
> only way i succeeded.
> 
> 
> 
> *** (/etc/hostapd/hostapd,.conf can be also an adhoc vif)
> interface=wlan1
> bridge=br0
> driver=nl80211
> hw_mode=g
> channel=1
> ssid=adradix_test
> macaddr_acl=0
> auth_algs=1
> ignore_broadcast_ssid=0
> wpa=2
> wpa_passphrase=xxx
> wpa_key_mgmt=WPA-PSK
> wpa_pairwise=TKIP
> rsn_pairwise=CCMP
> ***
> 
> *** (network script > of course no need to use static ip's also dhcp
> possible)
> #!/bin/bash
> 
> # ADRADIX MODIFIED AT 2012-06-09 23:51:24 # echo "1" > 
> /proc/sys/net/ipv4/ip_forward
> 
> ifconfig eth0 down
> ifconfig wlan0 down
> ifconfig wlan1 down
> ifconfig mesh0 down
> ifconfig bat0 down
> ifconfig br0 down
> 
> brctl delbr br0
> batctl if del mesh0
> 
> iw dev wlan0 del
> iw dev wlan1 del
> iw dev mesh0 del
> iw dev mon.wlan0 del
> iw dev mon.wlan1 del
> 
> iw phy phy0 interface add mesh0 type adhoc ifconfig mesh0 mtu 1528 
> iwconfig mesh0 mode ad-hoc essid adradix_mesh ap xx:xx:xx:xx:xx:xx 
> channel
> 10
> batctl if add mesh0
> ifconfig mesh0 0.0.0.0 up
> 
> iw phy phy1 interface add wlan1 type adhoc
> 
> brctl addbr br0
> brctl addif br0 eth0
> brctl addif br0 bat0
> 
> ifconfig bat0 0.0.0.0 up
> ifconfig eth0 0.0.0.0 up
> ifconfig br0 10.xx.xx.xx netmask 255.255.255.0 up
> 
> route add default gw 10.41.20.1
> 
> #echo "1" > /proc/sys/net/ipv4/conf/mesh0/proxy_arp
> #echo "1" > /proc/sys/net/ipv4/conf/bat0/proxy_arp
> #echo "1" > /proc/sys/net/ipv4/conf/br0/proxy_arp
> #echo "1" > /proc/sys/net/ipv4/conf/eth0/proxy_arp
> 
> #
> # IMPORTANT: WITHOUT THAT RESTART BRIDGING DOES NOT WORK 
> /etc/init.d/hostapd restart brctl addif br0 wlan1
> 
> exit 0;
> ***

