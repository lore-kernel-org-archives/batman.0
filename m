Return-Path: <gluhovchenko@granch.ru>
Message-ID: <9593ED11D39C4938AB059ECE63244111@granch.local>
From: "Michael Y. Gluhovchenko" <gluhovchenko@granch.ru>
Date: Thu, 20 Jan 2011 13:31:34 +0600
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="koi8-r"; reply-type=original
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Stup batman ADv devel on openWRT
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello All;

I am truing to setup two batman openWRT nodes;

I have that topology
br-lan          0002.001e8cc9451b       yes             bat0
		                                                  eth0
                        		                                  eth1
                                               			  wlan0

Counters of RX & TX packets are increase on wlan0, but no RX packets on 
Batman Iface Bat0
In logs first(ha00) node i am only see "[     69443] Sending own packet 
(originator c4:17:fe:b4:0b:97 seqno 70438, TQ 255, TTL 50, IDF off) on 
interface wlan0 [c4:17:fe:b4:0b:97]". Second(ha01) node I am see "[ 
69553] Sending own packet (originator c4:17:fe:b2:50:c8 seqno 70549, TQ 255, 
TTL 50, IDF off) on interface wlan0 [c4:17:fe:b2:50:c8]"
What am i doing wrong?

First Node don't see Second Node.
Bat Setup:
ha00 - /etc/config/wireless:
config wifi-device  radio0
        option type     mac80211
        option channel  1
        option macaddr  c4:17:fe:b4:0b:97
        option hwmode   11g
        option htmode   HT20
        list ht_capab   SHORT-GI-40
        list ht_capab   TX-STBC
        list ht_capab   RX-STBC1
        list ht_capab   DSSS_CCK-40

config wifi-iface
        option device   radio0
        option network  lan
        option mtu      1527
        option mode     ahdemo
        option ssid     g_mesh
        option encryption none
/etc/config/batman-adv

config 'mesh' 'bat0'
        option 'interfaces' 'wlan0'
        option 'orig_interval'
        option 'log_level'
        option 'aggregated_ogms'
        option 'bonding'
        option 'vis_mode'
-------------------------------------
ha01 - /etc/config/wireless
config wifi-device  radio0
        option type     mac80211
        option channel  1
        option macaddr  c4:17:fe:b2:50:c8
        option hwmode   11g
        option htmode   HT20
        list ht_capab   SHORT-GI-40
        list ht_capab   TX-STBC
        list ht_capab   RX-STBC1
        list ht_capab   DSSS_CCK-40

config wifi-iface
        option device   radio0
        option network  lan
        option mode     ahdemo
        option ssid     g_mesh
        option encryption none

/etc/config/batman-adv
config 'mesh' 'bat0'
        option 'interfaces' 'wlan0'
        option 'orig_interval'
        option 'log_level'
        option 'aggregated_ogms'
        option 'bonding'
        option 'vis_mode'
. 

