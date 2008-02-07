Date: Thu, 07 Feb 2008 21:24:17 +1300
From: Donald Gordon <don@dis.org.nz>
Message-id: <47AAC031.8010808@dis.org.nz>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
Subject: [B.A.T.M.A.N.] Kernel panic with batman-advanced,
	pinging remote nodes
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hi

I've installed batman-advanced on a gaggle of Meraki minis, and run into 
a kernel panic when I ping a node over the mesh from my laptop (plugged 
into a meraki).

The kernel I'm running is
Linux OpenWrt 2.6.23.1 #3 Sun Feb 3 16:24:29 NZDT 2008 mips unknown

The version of batman-advanced I'm running is
B.A.T.M.A.N. Adv 0.1-alpha rv963

The laptop is attached via ethernet to mesh node 0a:18:0a:01:1c:43.  On 
this node, eth0 is bridged to bat0, and ath2 is an ahdemo interface.

root@OpenWrt:/# cat /proc/net/batman-adv/originators
   Originator     (#/255)           Nexthop [outgoingIF]:   Potential 
nexthops ... [B.A.T.M.A.N. Adv 0.1-alpha rv963, MainIF/MAC: 
ath2/0a:18:0a:01:1c:43]
0a:18:0a:01:1c:41  (255) 0a:18:0a:01:1c:41 [      ath2]: 
0a:18:0a:01:1c:41 (255) 0a:18:0a:01:1c:31 (241)
0a:18:0a:01:1c:31  (255) 0a:18:0a:01:1c:31 [      ath2]: 
0a:18:0a:01:1c:31 (255) 0a:18:0a:01:1c:41 (244)

root@OpenWrt:/# cat /proc/net/batman-adv/transtable_global
Globally announced HNAs received via the mesh (translation table):
  * 00:ff:4f:62:a2:f6 via 0a:18:0a:01:1c:41
  * 00:ff:37:ac:5e:5b via 0a:18:0a:01:1c:31

root@OpenWrt:/# cat /proc/net/batman-adv/transtable_local
Locally retrieved addresses (from bat0) announced via HNA:
  * 00:ff:7c:45:52:7f
  * 00:1d:60:59:53:bc
  * 00:18:0a:01:1c:43

The last address is the MAC address of eth0, which gets assigned to the 
bridge.

Node 0a:18:0a:01:1c:41 has an IP address assigned to its bridge 
(identical configuration to the :43 node) of 192.168.116.65.

When the laptop pings this address, an ARP goes out over the mesh:
root@OpenWrt:/#
root@OpenWrt:/# skb_under_panic: text:c009da8c len:50 put:8 
head:812be000 data:812bdffa tail:0x812be02c end:0x812be040 dev:bat0
Break instruction in kernel code[#1]:

Cpu 0
$ 0   : 00000000 10009c00 00000073 8025e9a0
$ 4   : 8025e994 00000001 00000000 00000000
$ 8   : 00000000 8129e5c8 00000002 01c9c380
$12   : 00000002 625a0000 00989646 20ab6400
$16   : 81e5e480 812a2ec0 812a2ec0 81f0bf80
$20   : 0000002a 8107e484 8107e480 00000000
$24   : 81292fd0 00008000
$28   : 81292000 81293130 8128c026 80189924
Hi    : 00000140
Lo    : 68fdd3c0
epc   : 80189924     Tainted: P
ra    : 80189924 Status: 10009c03    KERNEL EXL IE
Cause : 10800024
PrId  : 00019064
Modules linked in: ath_ahb wlan_xauth wlan_wep wlan_tkip wlan_ccmp 
wlan_acl ath_rate_minstrel ath_hal(P) wlan_scan_sta wlan_scan_ap wlan 
batman_adv_core nf_nat_tftp nf_conntrack_tftp nf_nat_irc 
nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ppp_async ppp_generic slhc 
crc_ccitt
Process batman-adv (pid: 632, threadinfo=81292000, task=8129e598)
Stack : 00020020 c009da8c 00000032 00000008 812be000 812bdffa 812be02c 
812be040
         81f0bc00 812a2ec0 c009daa8 c009da28 00000000 00008020 8128c026 
800b36f8
         00000000 00000000 812a2ec0 812a2ec0 00000000 81f0bc00 80215768 
801a5d48
         c0a87401 00000000 81118000 00000000 81f0bc00 812a2ec0 00000000 
81f07680
         80196378 801962cc 80268348 8107e480 813b0ea0 8107e480 812a2ec0 
812a2140
         ...
Call 
Trace:[<c009da8c>][<c009daa8>][<c009da28>][<800b36f8>][<80215768>][<801a5d48>][<80196378>][<801962cc>][<80215600>][<801c2118>][<80215680>][<802157d8>][<802154dc>][<80214324>][<801963d4>][<80270000>][<80270000>][<801ef2c0>][<80270000>][<801f04b8>][<801f0334>][<801f0c80>][<8018a9ac>][<80216574>][<80216464>][<802167f0>][<8019280c>][<801959e4>][<80195c48>][<80196460>][<8006a4ac>][<c00edf88>][<8006a588>][<80185c28>][<8006a8ec>][<80196460>][<80211b30>][<8018aea4>][<802126f4>][<80148400>][<80183ca4>][<c009908c>][<c009c4d4>][<801476b4>][<8006a588>][<8007c254>][<8007c254>][<8018405c>][<c009ae24>][<c009d2dc>][<c009d280>][<c00e9d10>][<c012fe60>][<8007c254>][<8005dd20>][<8005e088>][<c01306a8>][<c01391ec>][<c0138f54>][<c013b728>][<80195c48>][<8006a4ac>][<8006a588>][<800431e0>][<c01306a8>][<c01306a8>][<c01306a8>][<c0138f54>][<c01391ec>][<c0138f54>][<c013b728>][<c01306a8>][<80195c48>][<c01391ec>][<c0138f54>][<c013b728>][<8006a588>][<80195c48>][<8006a4ac>][<8006a588>][<8005f140>][<800431e0>]
[<8005e004>][<8005c490>][<8005ccd0>][<8005dd20>][<8005c45c>][<8005e004>][<8005d824>][<8005c490>][<8005ccd0>][<8007bf00>][<c009c3e4>][<8007bf58>][<80045098>][<80045088>]

Code: afa8001c  0c019286  afa20020 <0200000d> 8fbf0028  03e00008 
27bd0030  27bdffd0  afbf0028
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 3 seconds..

84 00:21:13 a:18:a:1:1c:43 -> ff:ff:ff:ff:ff:ff BAT_BCAST 
a:18:a:1:1c:43ARP 192.168.116.1 ARP_REQUEST(1) 192.168.116.65

84 00:21:13 a:18:a:1:1c:41 -> ff:ff:ff:ff:ff:ff BAT_BCAST 
a:18:a:1:1c:43ARP 192.168.116.1 ARP_REQUEST(1) 192.168.116.65

No packets from 0a:18:a:1:1c:41 are seen after the first ARP.

Then 0a:18:a:1:1c:41 panics:

root@OpenWrt:/#
root@OpenWrt:/# skb_under_panic: text:c009da8c len:50 put:8 
head:812be000 data:812bdffa tail:0x812be02c end:0x812be040 dev:bat0
Break instruction in kernel code[#1]:

Cpu 0
$ 0   : 00000000 10009c00 00000073 8025e9a0
$ 4   : 8025e994 00000001 00000000 00000000
$ 8   : 00000000 8129e5c8 00000002 01c9c380
$12   : 00000002 625a0000 00989646 20ab6400
$16   : 81e5e480 812a2ec0 812a2ec0 81f0bf80
$20   : 0000002a 8107e484 8107e480 00000000
$24   : 81292fd0 00008000
$28   : 81292000 81293130 8128c026 80189924
Hi    : 00000140
Lo    : 68fdd3c0
epc   : 80189924     Tainted: P
ra    : 80189924 Status: 10009c03    KERNEL EXL IE
Cause : 10800024
PrId  : 00019064
Modules linked in: ath_ahb wlan_xauth wlan_wep wlan_tkip wlan_ccmp 
wlan_acl ath_rate_minstrel ath_hal(P) wlan_scan_sta wlan_scan_ap wlan 
batman_adv_core nf_nat_tftp nf_conntrack_tftp nf_nat_irc 
nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ppp_async ppp_generic slhc 
crc_ccitt
Process batman-adv (pid: 632, threadinfo=81292000, task=8129e598)
Stack : 00020020 c009da8c 00000032 00000008 812be000 812bdffa 812be02c 
812be040
         81f0bc00 812a2ec0 c009daa8 c009da28 00000000 00008020 8128c026 
800b36f8
         00000000 00000000 812a2ec0 812a2ec0 00000000 81f0bc00 80215768 
801a5d48
         c0a87401 00000000 81118000 00000000 81f0bc00 812a2ec0 00000000 
81f07680
         80196378 801962cc 80268348 8107e480 813b0ea0 8107e480 812a2ec0 
812a2140
         ...
Call 
Trace:[<c009da8c>][<c009daa8>][<c009da28>][<800b36f8>][<80215768>][<801a5d48>][<80196378>][<801962cc>][<80215600>][<801c2118>][<80215680>][<802157d8>][<802154dc>][<80214324>][<801963d4>][<80270000>][<80270000>][<801ef2c0>][<80270000>][<801f04b8>][<801f0334>][<801f0c80>][<8018a9ac>][<80216574>][<80216464>][<802167f0>][<8019280c>][<801959e4>][<80195c48>][<80196460>][<8006a4ac>][<c00edf88>][<8006a588>][<80185c28>][<8006a8ec>][<80196460>][<80211b30>][<8018aea4>][<802126f4>][<80148400>][<80183ca4>][<c009908c>][<c009c4d4>][<801476b4>][<8006a588>][<8007c254>][<8007c254>][<8018405c>][<c009ae24>][<c009d2dc>][<c009d280>][<c00e9d10>][<c012fe60>][<8007c254>][<8005dd20>][<8005e088>][<c01306a8>][<c01391ec>][<c0138f54>][<c013b728>][<80195c48>][<8006a4ac>][<8006a588>][<800431e0>][<c01306a8>][<c01306a8>][<c01306a8>][<c0138f54>][<c01391ec>][<c0138f54>][<c013b728>][<c01306a8>][<80195c48>][<c01391ec>][<c0138f54>][<c013b728>][<8006a588>][<80195c48>][<8006a4ac>][<8006a588>][<8005f140>][<800431e0>]
[<8005e004>][<8005c490>][<8005ccd0>][<8005dd20>][<8005c45c>][<8005e004>][<8005d824>][<8005c490>][<8005ccd0>][<8007bf00>][<c009c3e4>][<8007bf58>][<80045098>][<80045088>]

Code: afa8001c  0c019286  afa20020 <0200000d> 8fbf0028  03e00008 
27bd0030  27bdffd0  afbf0028
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 3 seconds..

I realise this dump is full of unhelpful hex; if you can tell me how to 
get symbol names out of my kernel I'll gladly forward them on :-)

donald
