Return-Path: <faycel.benhajkhalifa@eisox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Jan 2020 16:24:55 +0100
From: faycel.benhajkhalifa@eisox.com
Subject: Internet connection problem with Batman
Message-ID: <1e9ca23deab35c772fdfc80feb96437f@eisox.com>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hello,
I saw that you are contributing to BATMAN, may I ask you a few questions 
about my installation?
I have several boards with OpenWRT firmware:

Mips processor
Kernel version 4.14.131
OpenWRT 18.06.01
BATMAN: Batctl openwrt-2018.1-1 [batman-adv: openwrt-2018.1-8]

I have 8 connected mesh boards.
Internet connection on the boards is not always available.
When a board no longer has an internet connection, I connect to another 
board and try the following commands:

batctl o: I find the board in the table with last-seen <1 and a quality 
between 191 and 233 (good quality)
batctl ping does not succeed every time
ping with the OpenWRT ping command does not work
If I restart the board which no longer has internet, then it reconnects 
to the network and accesses the internet without problem (functional 
pings)

I tried with a Static or Dynamic IP, the result is the same. The 
internet connection works then is interrupted and I can't find why. And 
sometimes without restarting the board, it finds the internet
OpenWRT Config:

/etc/config/network
config interface 'wan'
option type 'bridge'
option ifname 'eth0 bat0'
option dns '8.8.8.8'
option stp '1'
option gateway '192.168.1.1'
option netmask '255.255.255.0'
option ipaddr '192.168.1.101'
option proto 'static'
/etc/config/wireless
config wifi-iface 'wmesh'
option device 'radio0'
option ifname 'adhoc0'
option mode 'adhoc'
option network 'mesh'
option encryption 'psk2'
option ssid 'ssid'
option bssid 'bssid'
option key 'password'

/etc/config/batman-adv

config 'mesh' 'bat0'
option 'aggregated_ogms'
option 'ap_isolation'
option 'bonding'
option 'fragmentation'
option 'gw_bandwidth'
option 'gw_mode'
option 'gw_sel_class'
option 'log_level'
option 'orig_interval'
option 'bridge_loop_avoidance'
option 'distributed_arp_table'
option 'multicast_mode'
option 'network_coding'
option 'hop_penalty' 0
option 'isolation_mark

and I added a patch in batman-adv/patches

--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
--- 2 2019-07-15 17:26:55.717093662 +0200
+++ 1 2019-07-15 17:26:46.565093715 +0200
@@ -43,7 +43,7 @@
/* purge originators after time in seconds if no valid packet comes in
* -> TODO: check influence on BATADV_TQ_LOCAL_WINDOW_SIZE
*/
-#define BATADV_PURGE_TIMEOUT 200000 /* 200 seconds */
+#define BATADV_PURGE_TIMEOUT 10000 /* 10 seconds */
#define BATADV_TT_LOCAL_TIMEOUT 600000 /* in milliseconds */
#define BATADV_TT_CLIENT_ROAM_TIMEOUT 600000 /* in milliseconds */
#define BATADV_TT_CLIENT_TEMP_TIMEOUT 600000 /* in milliseconds */

The purpose of this patch is to make the network reconnect more quickly 
when a board being removed or added.
Thanks for your help,
I can provide more information about my network if you wish.

Regards,
