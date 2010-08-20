Return-Path: <zukky@bb.banban.jp>
Message-ID: <4C6E2EF6.6000407@bb.banban.jp>
Date: Fri, 20 Aug 2010 16:29:58 +0900
From: Lemonde <zukky@bb.banban.jp>
MIME-Version: 1.0
References: <4C6437BF.9080909@web.de>
	<201008130524.24059.sven.eckelmann@gmx.de>
In-Reply-To: <201008130524.24059.sven.eckelmann@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] problem openwrt-trunk + ath5k + batman-adv-devel in
	my case
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

  Hi, batman community members.

I also met problem similar to Tim's case.
My environment is,
board: gateworks avila gw2348-4
wlan module: wistron dcma-82(ar5414)
firmware: openwrt trunk r22692
wlan driver: ath5k
batman version: batman-adv-devel (refered to 
http://www.open-mesh.org/wiki/building-batman-adv-with-openwrt) (for 
trial of multi interface altering)

I built firmware image with symbol table option. Is it helpful?

regards,
Kazuki


Please press Enter to activate this console. net eth0: firmware: 
requesting NPE-B
NPE-B: firmware's license can be found in /usr/share/doc/LICENSE.IPL
NPE-B: firmware functionality 0x2, revision 0x2:1
device eth0 entered promiscuous mode
br-lan: port 1(eth0) entering forwarding state
net eth1: firmware: requesting NPE-C
NPE-C: firmware's license can be found in /usr/share/doc/LICENSE.IPL
NPE-C: firmware functionality 0x5, revision 0x2:1
device eth1 entered promiscuous mode
br-lan: port 2(eth1) entering forwarding state
Compat-wireless backport release: compat-wireless-2010-07-13-4-g04898a5
Backport based on wireless-2.6.git v2.6.35-rc6-48432-gdce358e
br-lan: port 1(eth0) entering disabled state
cfg80211: Calling CRDA to update world regulatory domain
eth1: link up, speed 100 Mb/s, full duplex
cfg80211: World regulatory domain updated:
     (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
     (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
     (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
     (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
     (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
     (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
PCI: enabling device 0000:00:01.0 (0340 -> 0342)
ath5k 0000:00:01.0: registered as 'phy0'
ath5k phy0: Atheros AR5414 chip found (MAC: 0xa5, PHY: 0x61)
PCI: enabling device 0000:00:02.0 (0340 -> 0342)
ath5k 0000:00:02.0: registered as 'phy1'
cfg80211: Calling CRDA for country: US
ath5k phy1: Atheros AR5414 chip found (MAC: 0xa5, PHY: 0x61)
cfg80211: Calling CRDA for country: US
cfg80211: Current regulatory domain intersected:
     (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
     (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
     (2457000 KHz - 2472000 KHz @ 15000 KHz), (300 mBi, 2000 mBm)
     (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 1700 mBm)
     (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
ip_tables: (C) 2000-2006 Netfilter Core Team
cfg80211: Current regulatory domain intersected:
     (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
     (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
     (2457000 KHz - 2472000 KHz @ 15000 KHz), (300 mBi, 2000 mBm)
     (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 1700 mBm)
     (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
nf_conntrack version 0.5.0 (974 buckets, 3896 max)
batman_adv: B.A.T.M.A.N. advanced devel (compatibility version 10) loaded
device bat0 entered promiscuous mode
br-lan: port 3(bat0) entering forwarding state
Unable to handle kernel paging request at virtual address 00001778
pgd = c3abc000
[00001778] *pgd=03aaa031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1]
last sysfs file: /sys/kernel/uevent_seqnum
Modules linked in: batman_adv nf_nat_tftp nf_conntrack_tftp nf_nat_irc 
nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ipt_MASQUERADE iptable_nat 
nf_nat xt_NOTRACK iptable_raw xt_state nf_conntrack_ipv4 nf_defrag_ipv4 
nf_conntrack ipt_REJECT xt_TCPMSS ipt_LOG xt_comment xt_multiport xt_mac 
xt_limit iptable_mangle iptable_filter ip_tables xt_tcpudp x_tables 
ath5k ath mac80211 cfg80211 compat_firmware_class compat arc4 
aes_generic deflate ecb cbc
CPU: 0    Not tainted  (2.6.32.16 #22)
PC is at memcpy+0xb4/0x330
LR is at 0xb6b2d
pc : [<c0107174>]    lr : [<000b6b2d>]    psr: 00000013
sp : c3273d74  ip : 0000001c  fp : c3273da4
r10: 00000008  r9 : be99f768  r8 : c31f12c0
r7 : bf19211c  r6 : bf19210c  r5 : 00000006  r4 : c38e6980
r3 : c301b000  r2 : ffffffe6  r1 : c31726ac  r0 : 00001778
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 000039ff  Table: 03abc000  DAC: 00000015
Process ifconfig (pid: 1772, stack limit = 0xc3272270)
Stack: (0xc3273d74 to 0xc3274000)
3d60:                                              00000006 bf19210c 
bf19211c
3d80: c31f12c0 00001778 c38e6980 bf18c940 c38e6980 c301b000 c3273dcc 
c3273da8
3da0: bf18d040 bf18c910 00000000 fffffff1 00000000 00000000 c301b000 
00000008
3dc0: c3273df4 c3273dd0 c004aa44 bf18cea4 00000000 c301b000 c3273e70 
c3273e70
3de0: 00000000 0005b9e4 c3273e0c c3273df8 c004abf8 c004aa1c 00000000 
c301b000
3e00: c3273e24 c3273e10 c01797b4 c004abe4 00008924 c301b000 c3273e44 
c3273e28
3e20: c017a99c c017975c 00008924 c0297488 00000000 c3273e70 c3273ec4 
c3273e48
3e40: c017b364 c017a7cc c00265c8 c004a3c4 c3906748 c34093a4 c3273e7c 
c3273e68
3e60: c007930c c007c1ec c3a019e0 4000d000 776c616e 30000000 00000000 
00000000
3e80: 0001000b 6b2df47e 00000041 4008818c c3a43800 c382cda0 00000000 
00008924
3ea0: fffffdfd be99f768 c3882340 c0020fe4 c3272000 0005b9e4 c3273ee4 
c3273ec8
3ec0: c0168c48 c017abe0 c3882340 00008924 be99f768 c3882340 c3273f04 
c3273ee8
3ee0: c0096050 c0168a14 00008924 00000003 be99f768 c3882340 c3273f7c 
c3273f08
3f00: c009682c c0096028 c3273f5c c3273f18 c016927c c008a7c4 c01f7a28 
c3273f28
3f20: c008a8f0 00000000 00000000 c0247600 c34042e0 00000000 00000003 
c34042e0
3f40: 00000119 c0020fe4 c3272000 0000c8d0 c3273f84 00000003 be99f768 
00008924
3f60: c3882340 c0020fe4 c3272000 0005b9e4 c3273fa4 c3273f80 c00968c8 
c00962cc
3f80: c016a0a4 00000000 be99f768 00000006 00000012 00000036 00000000 
c3273fa8
3fa0: c0020e60 c0096894 be99f768 00000006 00000003 00008924 be99f768 
be99f73c
3fc0: be99f768 00000006 00000012 00000036 0005ba7c 00000000 0005b9e4 
00000000
3fe0: 400520c4 be99f720 0000d32c 400520e4 20000010 00000003 0031d021 
0031d421
Backtrace:
[<bf18c904>] (hardif_free_interface+0xb4/0x260 [batman_adv]) from 
[<bf18d040>] (hard_if_event+0x1a8/0x214 [batman_adv])
  r5:c301b000 r4:c38e6980
[<bf18ce98>] (hard_if_event+0x0/0x214 [batman_adv]) from [<c004aa44>] 
(notifier_call_chain+0x34/0x78)
[<c004aa10>] (notifier_call_chain+0x0/0x78) from [<c004abf8>] 
(raw_notifier_call_chain+0x20/0x28)
[<c004abd8>] (raw_notifier_call_chain+0x0/0x28) from [<c01797b4>] 
(dev_set_mac_address+0x64/0x70)
[<c0179750>] (dev_set_mac_address+0x0/0x70) from [<c017a99c>] 
(dev_ifsioc+0x1dc/0x414)
  r5:c301b000 r4:00008924
[<c017a7c0>] (dev_ifsioc+0x0/0x414) from [<c017b364>] 
(dev_ioctl+0x790/0x8bc)
  r7:c3273e70 r6:00000000 r5:c0297488 r4:00008924
[<c017abd4>] (dev_ioctl+0x0/0x8bc) from [<c0168c48>] 
(sock_ioctl+0x240/0x26c)
[<c0168a08>] (sock_ioctl+0x0/0x26c) from [<c0096050>] (vfs_ioctl+0x34/0x78)
  r7:c3882340 r6:be99f768 r5:00008924 r4:c3882340
[<c009601c>] (vfs_ioctl+0x0/0x78) from [<c009682c>] 
(do_vfs_ioctl+0x56c/0x5c8)
  r7:c3882340 r6:be99f768 r5:00000003 r4:00008924
[<c00962c0>] (do_vfs_ioctl+0x0/0x5c8) from [<c00968c8>] 
(sys_ioctl+0x40/0x64)
[<c0096888>] (sys_ioctl+0x0/0x64) from [<c0020e60>] 
(ret_fast_syscall+0x0/0x28)
  r7:00000036 r6:00000012 r5:00000006 r4:be99f768
Code: e4805004 e4806004 e4807004 e4808004 (e480e004)
---[ end trace d7cdc7fcf2096927 ]---



BusyBox v1.17.1 (2010-08-17 17:04:22 JST) built-in shell (ash)
Enter 'help' for a list of built-in commands.

   _______                     ________        __
  |       |.-----.-----.-----.|  |  |  |.----.|  |_
  |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
  |_______||   __|_____|__|__||________||__|  |____|
           |__| W I R E L E S S   F R E E D O M
  KAMIKAZE (bleeding edge, r22692) ------------------
   * 10 oz Vodka       Shake well with ice and strain
   * 10 oz Triple sec  mixture into 10 shot glasses.
   * 10 oz lime juice  Salute!
  ---------------------------------------------------
root@OpenWrt:/# cat /etc/config/batman-adv

config 'mesh' 'bat0'
         option 'interfaces' 'wlan0 wlan1'
         option 'orig_interval'
         option 'log_level'
         option 'aggregate_ogm'
         option 'vis_mode'
root@OpenWrt:/#
root@OpenWrt:/# cat /etc/config/network
# Copyright (C) 2006 OpenWrt.org

config interface loopback
         option ifname   lo
         option proto    static
         option ipaddr   127.0.0.1
         option netmask  255.0.0.0

config interface lan
         option ifname   'eth0 eth1 bat0'
         option type     bridge
         option proto    static
         option ipaddr   192.168.1.1
         option netmask  255.255.255.0
root@OpenWrt:/#
root@OpenWrt:/# cat /etc/config/wireless
config wifi-device  radio0
         option type     mac80211
         option channel  5
         option macaddr  00:0b:6b:2d:f4:7e
         option hwmode   11g

         # REMOVE THIS LINE TO ENABLE WIFI:
#       option disabled 1

config wifi-iface
         option device   radio0
#       option network  lan
         option mode     adhoc
         option ssid     mesh1
         option encryption none

config wifi-device  radio1
         option type     mac80211
         option channel  5
         option macaddr  00:0b:6b:2d:f4:ac
         option hwmode   11g

         # REMOVE THIS LINE TO ENABLE WIFI:
#       option disabled 1

config wifi-iface
         option device   radio1
#       option network  lan
         option mode     adhoc
         option ssid     mesh2
         option encryption none

root@OpenWrt:/#
