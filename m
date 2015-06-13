Return-Path: <ufo@rund.freifunk.net>
Message-ID: <557C4EF0.3060204@rund.freifunk.net>
Date: Sat, 13 Jun 2015 17:40:32 +0200
From: Ufo <ufo@rund.freifunk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] openwrt config changes when upgrading from 2014-4 to
	2015-0 ?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

thank you for upgrading batman-adv inside openwrt trunk to 2015-0

im testing new version (yesterdays openwrt trunk) but have problems:
the bridge (br-mesh12) with bat-interface and wifi-vAP isnt complete,
the bat-interface is missing :-(
the "wifi" command also doesnt repair that :-(

but, when i delete vlan-setting (for interface, where batman-adv is
running on) problems are gone.

maybe config for openwrt/batman-adv has changed, or some of our settings
are outdated and now obsolete?

 ufo

p.s. with 10 days old openwrt trunk (and batman-adv 2014-4) the problem
doesnt appear

p.p.s. maybe my former firmware problems are related to that? some of
them are gone when we only use one batman-adv on each node instead of two
https://github.com/freifunk/meshkit-firmware/issues/23
https://github.com/freifunk/meshkit-firmware/issues/12

----

tested with minimalized setup it looks like this:

some config-files...

config interface 'wireless0'
        option dns '8.8.8.8 212.204.49.83 141.1.1.1'
        option netmask '255.255.255.255'
        option proto 'static'
        option ipaddr '10.61.234.70'
        option mtu '1536'

config interface 'mesh12'
        option type 'bridge'
        option ifname 'bat12'
        option proto 'none'

config interface 'meshbat12'
        option ifname '@wireless0.12'
        option proto 'batadv'
        option mesh 'bat12'
        option mtu '1532'

------


config wifi-device 'radio0'
        option type 'mac80211'
        option path 'platform/ar934x_wmac'
        option htmode 'HT20'
        option diversity '1'
        option distance '1000'
        option disabled '0'
        option country 'DE'
        option channel '44'
        option hwmode '11na'

config wifi-iface 'radio0_iface'
        option device 'radio0'
        option encryption 'none'
        option mode 'adhoc'
        option mcast_rate '6000'
        option network 'wireless0'
        option ssid 'leipzig.freifunk.net'
        option bssid '02:44:CA:FF:EE:EE'

config wifi-iface 'radio0_meshap12'
        option network 'mesh12'
        option mode 'ap'
        option device 'radio0'
        option encryption 'none'
        option ssid '012Freifunk-Test'


root@234-70:~# cat /etc/config/batman-adv

config mesh 'bat12'
        option gw_mode 'client'
        option multicast_mode '0'
        option bridge_loop_avoidance '1'


----


root@234-70:~# brctl show
bridge name     bridge id               STP enabled     interfaces
br-mesh12               7fff.16cc204886e0       no              wlan0-1



-----------------------------
#############################


changing to test setting, its working in a proper way:


config interface 'meshbat12'
        option ifname '@wireless0'
        option proto 'batadv'
        option mesh 'bat12'
        option mtu '1532'

---
root@234-70:~# brctl show
bridge name     bridge id               STP enabled     interfaces
br-mesh12               7fff.16cc204886e0       no              wlan0-1
                                                        bat12



-- 
---
Freifunk Leipzig http://leipzig.freifunk.net
