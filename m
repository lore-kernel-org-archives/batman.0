Return-Path: <Tim.Glaremin@web.de>
Message-ID: <4C63C96F.8070001@web.de>
Date: Thu, 12 Aug 2010 12:14:07 +0200
From: Tim Glaremin <Tim.Glaremin@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: Tim.Glaremin@web.de
Subject: Re: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
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

Hello,

you are really great. Can't thank you enough for helping me with this=20
problem.

If I understand it right batman_adv is loaded right after installing the=20
image:

root@OpenWrt:/# lsmod
Module                  Size  Used by    Not tainted
batman_adv             51104  0
nf_nat_tftp              432  0
nf_conntrack_tftp       2400  1 nf_nat_tftp
nf_nat_irc               864  0
nf_conntrack_irc        2592  1 nf_nat_irc
nf_nat_ftp              1360  0
nf_conntrack_ftp        4896  1 nf_nat_ftp
ipt_MASQUERADE           992  1
iptable_nat             2304  1
nf_nat                 11824  5=20
nf_nat_tftp,nf_nat_irc,nf_nat_ftp,ipt_MASQUERADE,iptable_nat
xt_NOTRACK               672  0
iptable_raw              656  1
xt_state                 800  3
nf_conntrack_ipv4       7808  6 iptable_nat,nf_nat
nf_defrag_ipv4           608  1 nf_conntrack_ipv4
nf_conntrack           42560 12=20
nf_nat_tftp,nf_conntrack_tftp,nf_nat_irc,nf_conntrack_irc,nf_nat_ftp,nf_con=
ntrack_ftp,ipt_MASQUERADE,iptable_nat,nf_nat,xt_NOTRACK,xt_state,nf_conntra=
ck_ipv4
pppoe                  10208  0
pppox                   1312  1 pppoe
ipt_REJECT              1984  2
xt_TCPMSS               1952  1
ipt_LOG                 4640  0
xt_comment               464  0
xt_multiport            1904  0
xt_mac                   576  0
xt_limit                1152  1
iptable_mangle           992  0
iptable_filter           768  1
ip_tables               8864  4=20
iptable_nat,iptable_raw,iptable_mangle,iptable_filter
xt_tcpudp               1856  4
x_tables                9840 13=20
ipt_MASQUERADE,iptable_nat,xt_NOTRACK,xt_state,ipt_REJECT,xt_TCPMSS,ipt_LOG=
,xt_comment,xt_multiport,xt_mac,xt_limit,ip_tables,xt_tcpudp
ppp_async               9040  0
ppp_generic            21200  3 pppoe,pppox,ppp_async
slhc                    5360  1 ppp_generic
b43legacy              97328  0
b43                   153392  0
mac80211              210464  2 b43legacy,b43
crc_ccitt                976  1 ppp_async
cfg80211              128144  3 b43legacy,b43,mac80211
compat_firmware_class     5520  2 b43legacy,b43
compat                   752  0
arc4                     816  2
aes_generic            31056  0
deflate                 1328  0
ecb                     1328  2
cbc                     2016  0
switch_robo             4048  0
switch_core             5200  1 switch_robo
diag                    7504  0"

This is the batman-adv config file, also directly after installing the=20
image:
"config 'mesh' 'bat0'
         option 'interfaces' 'wlan0'
         option 'orig_interval'
         option 'log_level'
         option 'aggregate_ogm'
         option 'vis_mode'"

Here is my logread output (batman-adv:B.A.T.M.A.N. advanced 2010.0.0=20
(compatibility version 8) loaded):

"root@OpenWrt:/# logread
Jan  1 00:00:16 OpenWrt syslog.info syslogd started: BusyBox v1.15.3
Jan  1 00:00:16 OpenWrt user.notice kernel: klogd started: BusyBox=20
v1.15.3 (2010-08-10 01:43:28 CEST)
Jan  1 00:00:16 OpenWrt user.notice kernel: Linux version 2.6.32.16=20
(jonathan@winme-mesh1) (gcc version 4.3.3 (GCC) ) #1 Tue Aug 10 02:14:13=20
CEST 2010
Jan  1 00:00:16 OpenWrt user.info kernel: CPU revision is: 00029008=20
(Broadcom BCM3302)
Jan  1 00:00:16 OpenWrt user.debug kernel: ssb: Core 0 found: ChipCommon=20
(cc 0x800, rev 0x0E, vendor 0x4243)
Jan  1 00:00:16 OpenWrt user.debug kernel: ssb: Core 1 found: Fast=20
Ethernet (cc 0x806, rev 0x09, vendor 0x4243)
Jan  1 00:00:16 OpenWrt user.debug kernel: ssb: Core 2 found: MIPS 3302=20
(cc 0x816, rev 0x06, vendor 0x4243)
Jan  1 00:00:16 OpenWrt user.debug kernel: ssb: Core 3 found: USB 1.1=20
Host (cc 0x817, rev 0x02, vendor 0x4243)
Jan  1 00:00:16 OpenWrt user.debug kernel: ssb: Core 4 found: MEMC SDRAM=20
(cc 0x80F, rev 0x01, vendor 0x4243)
Jan  1 00:00:16 OpenWrt user.debug kernel: ssb: Core 5 found: IEEE=20
802.11 (cc 0x812, rev 0x09, vendor 0x4243)
Jan  1 00:00:16 OpenWrt user.debug kernel: ssb: Core 6 found: Roboswitch=20
(cc 0x81C, rev 0x02, vendor 0x4243)
Jan  1 00:00:16 OpenWrt user.info kernel: ssb: Initializing MIPS core...
Jan  1 00:00:16 OpenWrt user.info kernel: ssb: set_irq: core 0x0806, irq=20
4 =3D> 4
Jan  1 00:00:16 OpenWrt user.info kernel: ssb: set_irq: core 0x0816, irq=20
5 =3D> 2
Jan  1 00:00:16 OpenWrt user.info kernel: ssb: set_irq: core 0x0812, irq=20
2 =3D> 5
Jan  1 00:00:16 OpenWrt user.info kernel: ssb: after irq reconfiguration
Jan  1 00:00:16 OpenWrt user.info kernel: ssb: core 0x0800, irq : 2(S) =20
3* 4  5  6  D  I
Jan  1 00:00:16 OpenWrt user.info kernel: ssb: core 0x0806, irq : 2(S) =20
3  4* 5  6  D  I
Jan  1 00:00:16 OpenWrt user.info kernel: ssb: core 0x0816, irq : 2(S)*=20
3  4  5  6  D  I
Jan  1 00:00:16 OpenWrt user.info kernel: ssb: core 0x0817, irq : 2(S) =20
3  4  5  6* D  I
Jan  1 00:00:16 OpenWrt user.info kernel: ssb: core 0x080f, irq : 2(S) =20
3  4  5  6  D  I*
Jan  1 00:00:16 OpenWrt user.info kernel: ssb: core 0x0812, irq : 2(S) =20
3  4  5* 6  D  I
Jan  1 00:00:16 OpenWrt user.info kernel: ssb: core 0x081c, irq : 2(S) =20
3  4  5  6  D  I*
Jan  1 00:00:16 OpenWrt user.info kernel: ssb: Sonics Silicon Backplane=20
found at address 0x18000000
Jan  1 00:00:16 OpenWrt user.warn kernel: Serial init done.
Jan  1 00:00:16 OpenWrt user.info kernel: Determined physical RAM map:
Jan  1 00:00:16 OpenWrt user.info kernel:  memory: 01000000 @ 00000000=20
(usable)
Jan  1 00:00:16 OpenWrt user.info kernel: Initrd not found or empty -=20
disabling initrd
Jan  1 00:00:16 OpenWrt user.warn kernel: Zone PFN ranges:
Jan  1 00:00:16 OpenWrt user.warn kernel:   Normal   0x00000000 ->=20
0x00001000
Jan  1 00:00:16 OpenWrt user.warn kernel: Movable zone start PFN for=20
each node
Jan  1 00:00:16 OpenWrt user.warn kernel: early_node_map[1] active PFN=20
ranges
Jan  1 00:00:16 OpenWrt user.warn kernel:     0: 0x00000000 -> 0x00001000
Jan  1 00:00:16 OpenWrt user.debug kernel: On node 0 totalpages: 4096
Jan  1 00:00:16 OpenWrt user.debug kernel: free_area_init_node: node 0,=20
pgdat 80283b50, node_mem_map 802c9000
Jan  1 00:00:16 OpenWrt user.debug kernel:   Normal zone: 32 pages used=20
for memmap
Jan  1 00:00:16 OpenWrt user.debug kernel:   Normal zone: 0 pages reserved
Jan  1 00:00:16 OpenWrt user.debug kernel:   Normal zone: 4064 pages,=20
LIFO batch:0
Jan  1 00:00:16 OpenWrt user.warn kernel: Built 1 zonelists in Zone=20
order, mobility grouping off.  Total pages: 4064
Jan  1 00:00:16 OpenWrt user.notice kernel: Kernel command line:=20
root=3D/dev/mtdblock2 rootfstype=3Dsquashfs,jffs2 noinitrd console=3DttyS0,=
115200
Jan  1 00:00:16 OpenWrt user.info kernel: PID hash table entries: 64=20
(order: -4, 256 bytes)
Jan  1 00:00:16 OpenWrt user.info kernel: Dentry cache hash table=20
entries: 2048 (order: 1, 8192 bytes)
Jan  1 00:00:16 OpenWrt user.info kernel: Inode-cache hash table=20
entries: 1024 (order: 0, 4096 bytes)
Jan  1 00:00:16 OpenWrt user.warn kernel: Primary instruction cache=20
16kB, VIPT, 2-way, linesize 16 bytes.
Jan  1 00:00:16 OpenWrt user.warn kernel: Primary data cache 8kB, 2-way,=20
VIPT, no aliases, linesize 16 bytes
Jan  1 00:00:16 OpenWrt user.info kernel: Memory: 13372k/16384k=20
available (2222k kernel code, 3012k reserved, 350k data, 136k init, 0k=20
highmem)
Jan  1 00:00:16 OpenWrt user.info kernel: Hierarchical RCU implementation.
Jan  1 00:00:16 OpenWrt user.info kernel: NR_IRQS:128
Jan  1 00:00:16 OpenWrt user.info kernel: console [ttyS0] enabled
Jan  1 00:00:16 OpenWrt user.info kernel: Calibrating delay loop...=20
199.16 BogoMIPS (lpj=3D398336)
Jan  1 00:00:16 OpenWrt user.warn kernel: Mount-cache hash table=20
entries: 512
Jan  1 00:00:16 OpenWrt user.info kernel: NET: Registered protocol family 16
Jan  1 00:00:16 OpenWrt user.warn kernel: bio: create slab <bio-0> at 0
Jan  1 00:00:16 OpenWrt user.info kernel: Switching to clocksource MIPS
Jan  1 00:00:16 OpenWrt user.info kernel: NET: Registered protocol family 2
Jan  1 00:00:16 OpenWrt user.info kernel: IP route cache hash table=20
entries: 1024 (order: 0, 4096 bytes)
Jan  1 00:00:16 OpenWrt user.info kernel: TCP established hash table=20
entries: 512 (order: 0, 4096 bytes)
Jan  1 00:00:16 OpenWrt user.info kernel: TCP bind hash table entries:=20
512 (order: -1, 2048 bytes)
Jan  1 00:00:16 OpenWrt user.info kernel: TCP: Hash tables configured=20
(established 512 bind 512)
Jan  1 00:00:16 OpenWrt user.info kernel: TCP reno registered
Jan  1 00:00:16 OpenWrt user.info kernel: NET: Registered protocol family 1
Jan  1 00:00:16 OpenWrt user.info kernel: squashfs: version 4.0=20
(2009/01/31) Phillip Lougher
Jan  1 00:00:16 OpenWrt user.warn kernel: Registering mini_fo version $Id$
Jan  1 00:00:16 OpenWrt user.info kernel: JFFS2 version 2.2. (NAND)=20
(SUMMARY)  =A9 2001-2006 Red Hat, Inc.
Jan  1 00:00:16 OpenWrt user.info kernel: msgmni has been set to 26
Jan  1 00:00:16 OpenWrt user.info kernel: io scheduler noop registered
Jan  1 00:00:16 OpenWrt user.info kernel: io scheduler deadline=20
registered (default)
Jan  1 00:00:16 OpenWrt user.info kernel: Serial: 8250/16550 driver, 2=20
ports, IRQ sharing enabled
Jan  1 00:00:16 OpenWrt user.info kernel: serial8250: ttyS0 at MMIO=20
0xb8000300 (irq =3D 3) is a 16550A
Jan  1 00:00:16 OpenWrt user.info kernel: serial8250: ttyS1 at MMIO=20
0xb8000400 (irq =3D 3) is a 16550A
Jan  1 00:00:16 OpenWrt user.info kernel: serial8250.0: ttyS0 at MMIO=20
0xb8000300 (irq =3D 3) is a 16550A
Jan  1 00:00:16 OpenWrt user.info kernel: serial8250.0: ttyS1 at MMIO=20
0xb8000400 (irq =3D 3) is a 16550A
Jan  1 00:00:16 OpenWrt user.warn kernel: flash init: 0x1c000000 0x02000000
Jan  1 00:00:16 OpenWrt user.info kernel: Physically mapped flash: Found=20
1 x16 devices at 0x0 in 16-bit bank
Jan  1 00:00:16 OpenWrt user.debug kernel: Physically mapped flash:=20
Found an alias at 0x400000 for the chip at 0x0
Jan  1 00:00:16 OpenWrt user.debug kernel: Physically mapped flash:=20
Found an alias at 0x800000 for the chip at 0x0
Jan  1 00:00:16 OpenWrt user.debug kernel: Physically mapped flash:=20
Found an alias at 0xc00000 for the chip at 0x0
Jan  1 00:00:16 OpenWrt user.debug kernel: Physically mapped flash:=20
Found an alias at 0x1000000 for the chip at 0x0
Jan  1 00:00:16 OpenWrt user.debug kernel: Physically mapped flash:=20
Found an alias at 0x1400000 for the chip at 0x0
Jan  1 00:00:16 OpenWrt user.debug kernel: Physically mapped flash:=20
Found an alias at 0x1800000 for the chip at 0x0
Jan  1 00:00:16 OpenWrt user.debug kernel: Physically mapped flash:=20
Found an alias at 0x1c00000 for the chip at 0x0
Jan  1 00:00:16 OpenWrt user.warn kernel:  Amd/Fujitsu Extended Query=20
Table at 0x0040
Jan  1 00:00:16 OpenWrt user.notice kernel: number of CFI chips: 1
Jan  1 00:00:16 OpenWrt user.notice kernel: cfi_cmdset_0002: Disabling=20
erase-suspend-program due to code brokenness.
Jan  1 00:00:16 OpenWrt user.notice kernel: Flash device: 0x400000 at=20
0x1fc00000
Jan  1 00:00:16 OpenWrt user.notice kernel: bootloader size: 262144
Jan  1 00:00:16 OpenWrt user.warn kernel: Updating TRX offsets and length:
Jan  1 00:00:16 OpenWrt user.warn kernel: old trx =3D [0x0000001c,=20
0x00000974, 0x000d2000], len=3D0x00271000 crc32=3D0x65c67278
Jan  1 00:00:16 OpenWrt user.warn kernel: new trx =3D [0x0000001c,=20
0x00000974, 0x000d2000], len=3D0x000d2000 crc32=3D0x7f60a9cc
Jan  1 00:00:16 OpenWrt user.warn kernel: Done
Jan  1 00:00:16 OpenWrt user.notice kernel: Creating 4 MTD partitions on=20
"Physically mapped flash":
Jan  1 00:00:16 OpenWrt user.notice kernel:=20
0x000000000000-0x000000040000 : "cfe"
Jan  1 00:00:16 OpenWrt user.notice kernel:=20
0x000000040000-0x0000003f0000 : "linux"
Jan  1 00:00:16 OpenWrt user.notice kernel:=20
0x000000112000-0x0000003f0000 : "rootfs"
Jan  1 00:00:16 OpenWrt user.warn kernel: mtd: partition "rootfs" must=20
either start or end on erase block boundary or be smaller than an erase=20
block -- forcing read-only
Jan  1 00:00:16 OpenWrt user.notice kernel: mtd: partition "rootfs" set=20
to be root filesystem
Jan  1 00:00:16 OpenWrt user.info kernel: mtd: partition "rootfs_data"=20
created automatically, ofs=3D290000, len=3D160000
Jan  1 00:00:16 OpenWrt user.notice kernel:=20
0x000000290000-0x0000003f0000 : "rootfs_data"
Jan  1 00:00:16 OpenWrt user.notice kernel:=20
0x0000003f0000-0x000000400000 : "nvram"
Jan  1 00:00:17 OpenWrt user.info kernel: b44.c:v2.0
Jan  1 00:00:17 OpenWrt user.info kernel: eth0: Broadcom 44xx/47xx=20
10/100BaseT Ethernet 00:25:9c:3c:46:04
Jan  1 00:00:17 OpenWrt user.info kernel: BCM47xx Watchdog Timer enabled=20
(30 seconds, nowayout)
Jan  1 00:00:17 OpenWrt user.info kernel: TCP westwood registered
Jan  1 00:00:17 OpenWrt user.info kernel: NET: Registered protocol family 17
Jan  1 00:00:17 OpenWrt user.info kernel: 802.1Q VLAN Support v1.8 Ben=20
Greear <greearb@candelatech.com>
Jan  1 00:00:17 OpenWrt user.info kernel: All bugs added by David S.=20
Miller <davem@redhat.com>
Jan  1 00:00:17 OpenWrt user.warn kernel: VFS: Mounted root (squashfs=20
filesystem) readonly on device 31:2.
Jan  1 00:00:17 OpenWrt user.info kernel: Freeing unused kernel memory:=20
136k freed
Jan  1 00:00:17 OpenWrt user.warn kernel: Please be patient, while=20
OpenWrt loads ...
Jan  1 00:00:17 OpenWrt user.warn kernel: diag: Detected 'Linksys=20
WRT54G/GS/GL'
Jan  1 00:00:17 OpenWrt user.info kernel: b44: eth0: Link is up at 100=20
Mbps, full duplex.
Jan  1 00:00:17 OpenWrt user.info kernel: b44: eth0: Flow control is off=20
for TX and off for RX.
Jan  1 00:00:17 OpenWrt user.info kernel: roboswitch: Probing device=20
eth0: found a 5325! It's a 5350.
Jan  1 00:00:17 OpenWrt user.info kernel: mini_fo: using base directory: /
Jan  1 00:00:17 OpenWrt user.info kernel: mini_fo: using storage=20
directory: /tmp/root
Jan  1 00:00:17 OpenWrt user.info kernel: b44: eth0: powering down PHY
Jan  1 00:00:18 OpenWrt user.info kernel: b44: eth0: Link is up at 100=20
Mbps, full duplex.
Jan  1 00:00:18 OpenWrt user.info kernel: b44: eth0: Flow control is off=20
for TX and off for RX.
Jan  1 00:00:21 OpenWrt user.info kernel: device eth0.0 entered=20
promiscuous mode
Jan  1 00:00:21 OpenWrt user.info kernel: device eth0 entered=20
promiscuous mode
Jan  1 00:00:21 OpenWrt user.info kernel: br-lan: port 1(eth0.0)=20
entering forwarding state
Jan  1 00:00:21 OpenWrt user.info kernel: Compat-wireless backport=20
release: compat-wireless-2010-07-13-4-g04898a5
Jan  1 00:00:21 OpenWrt user.info kernel: Backport based on=20
wireless-2.6.git v2.6.35-rc6-48432-gdce358e
Jan  1 00:00:22 OpenWrt user.info kernel: cfg80211: Calling CRDA to=20
update world regulatory domain
Jan  1 00:00:26 OpenWrt user.info kernel: b43-phy0: Broadcom 5352 WLAN=20
found (core revision 9)
Jan  1 00:00:27 OpenWrt user.debug kernel: phy0: Selected rate control=20
algorithm 'minstrel'
Jan  1 00:00:27 OpenWrt user.info kernel: Registered led device:=20
b43-phy0::tx
Jan  1 00:00:27 OpenWrt user.info kernel: Registered led device:=20
b43-phy0::rx
Jan  1 00:00:27 OpenWrt user.info kernel: Registered led device:=20
b43-phy0::radio
Jan  1 00:00:27 OpenWrt user.info kernel: Broadcom 43xx driver loaded [=20
Features: PL, Firmware-ID: FW13 ]
Jan  1 00:00:28 OpenWrt user.info kernel: Broadcom 43xx-legacy driver=20
loaded [ Features: PLID, Firmware-ID: FW10 ]
Jan  1 00:00:28 OpenWrt user.info kernel: cfg80211: World regulatory=20
domain updated:
Jan  1 00:00:28 OpenWrt user.info kernel:     (start_freq - end_freq @=20
bandwidth), (max_antenna_gain, max_eirp)
Jan  1 00:00:28 OpenWrt user.info kernel:     (2402000 KHz - 2472000 KHz=20
@ 40000 KHz), (300 mBi, 2000 mBm)
Jan  1 00:00:28 OpenWrt user.info kernel:     (2457000 KHz - 2482000 KHz=20
@ 20000 KHz), (300 mBi, 2000 mBm)
Jan  1 00:00:28 OpenWrt user.info kernel:     (2474000 KHz - 2494000 KHz=20
@ 20000 KHz), (300 mBi, 2000 mBm)
Jan  1 00:00:28 OpenWrt user.info kernel:     (5170000 KHz - 5250000 KHz=20
@ 40000 KHz), (300 mBi, 2000 mBm)
Jan  1 00:00:28 OpenWrt user.info kernel:     (5735000 KHz - 5835000 KHz=20
@ 40000 KHz), (300 mBi, 2000 mBm)
Jan  1 00:00:28 OpenWrt user.info kernel: PPP generic driver version 2.4.2
Jan  1 00:00:29 OpenWrt user.info kernel: ip_tables: (C) 2000-2006=20
Netfilter Core Team
Jan  1 00:00:30 OpenWrt user.info kernel: NET: Registered protocol family 24
Jan  1 00:00:30 OpenWrt user.warn kernel: nf_conntrack version 0.5.0=20
(211 buckets, 844 max)
Jan  1 00:00:32 OpenWrt user.info kernel: batman-adv:B.A.T.M.A.N.=20
advanced 2010.0.0 (compatibility version 8) loaded
Jan  1 00:00:34 OpenWrt user.info sysinit: Loading defaults
Jan  1 00:00:35 OpenWrt user.info sysinit: Loading synflood protection
Jan  1 00:00:36 OpenWrt user.info sysinit: Adding custom chains
Jan  1 00:00:36 OpenWrt user.info sysinit: Loading zones
Jan  1 00:00:37 OpenWrt user.info sysinit: Loading forwarding
Jan  1 00:00:38 OpenWrt user.info sysinit: Loading redirects
Jan  1 00:00:38 OpenWrt user.info sysinit: Loading rules
Jan  1 00:00:38 OpenWrt user.info sysinit: Loading includes
Jan  1 00:00:38 OpenWrt user.info sysinit: Loading zone defaults
Jan  1 00:00:39 OpenWrt user.notice root: adding lan (br-lan) to=20
firewall zone lan
Jan  1 00:00:41 OpenWrt user.notice dnsmasq: DNS rebinding protection is=20
active, will discard upstream RFC1918 responses!
Jan  1 00:00:45 OpenWrt daemon.info dnsmasq[809]: started, version 2.55=20
cachesize 150
Jan  1 00:00:45 OpenWrt daemon.info dnsmasq[809]: compile time options:=20
IPv6 GNU-getopt no-DBus no-I18N DHCP TFTP
Jan  1 00:00:45 OpenWrt daemon.info dnsmasq[809]: using local addresses=20
only for domain lan
Jan  1 00:00:45 OpenWrt daemon.warn dnsmasq[809]: no servers found in=20
/tmp/resolv.conf.auto, will retry
Jan  1 00:00:45 OpenWrt daemon.info dnsmasq[809]: read /etc/hosts - 1=20
addresses
Jan  1 00:00:45 OpenWrt user.info kernel: batman-adv:Adding interface: wlan0
Jan  1 00:00:45 OpenWrt user.err kernel: batman-adv:Not using interface=20
wlan0 (retrying later): interface not active
Jan  1 00:00:46 OpenWrt user.warn kernel: jffs2_scan_eraseblock(): End=20
of filesystem marker found at 0x0
Jan  1 00:00:46 OpenWrt user.warn kernel: jffs2_build_filesystem():=20
unlocking the mtd device... done.
Jan  1 00:01:00 OpenWrt user.warn kernel: jffs2_build_filesystem():=20
erasing all blocks after the end marker... done.
Jan  1 00:01:00 OpenWrt user.info sysinit: copying files ... done
Jan  1 00:01:00 OpenWrt user.info kernel: mini_fo: using base directory: /
Jan  1 00:01:00 OpenWrt user.info kernel: mini_fo: using storage=20
directory: /overlay"

I disabled the batman-adv module with "rmmod batman-adv", checked if it=20
is really disabled via "lsmod" and then avtivating radio0 through=20
removing "option disabled 1" in "/etc/config/wireless". Restarting the=20
network works fine without any segmentation faults.
After thet I reloaded the batman-adv module and did "/etc/init.d/network=20
restart" again and this time it showed an segmentation fault again.

"root@OpenWrt:/# /etc/init.d/network restart
Received SIGTERM
Entering released state
udhcpc (v1.15.3) started
Sending discover...
Configuration file: /var/run/hostapd-phy0.conf
Segmentation fault
Failed to start hostapd for phy0
root@OpenWrt:/# Sending discover...
Sending discover..."

Here is the dmesg output after that Segmentation fault:
"root@OpenWrt:/# dmesg
Linux version 2.6.32.16 (jonathan@winme-mesh1) (gcc version 4.3.3 (GCC)=20
) #1 Tue Aug 10 02:14:13 CEST 2010
CPU revision is: 00029008 (Broadcom BCM3302)
ssb: Core 0 found: ChipCommon (cc 0x800, rev 0x0E, vendor 0x4243)
ssb: Core 1 found: Fast Ethernet (cc 0x806, rev 0x09, vendor 0x4243)
ssb: Core 2 found: MIPS 3302 (cc 0x816, rev 0x06, vendor 0x4243)
ssb: Core 3 found: USB 1.1 Host (cc 0x817, rev 0x02, vendor 0x4243)
ssb: Core 4 found: MEMC SDRAM (cc 0x80F, rev 0x01, vendor 0x4243)
ssb: Core 5 found: IEEE 802.11 (cc 0x812, rev 0x09, vendor 0x4243)
ssb: Core 6 found: Roboswitch (cc 0x81C, rev 0x02, vendor 0x4243)
ssb: Initializing MIPS core...
ssb: set_irq: core 0x0806, irq 4 =3D> 4
ssb: set_irq: core 0x0816, irq 5 =3D> 2
ssb: set_irq: core 0x0812, irq 2 =3D> 5
ssb: after irq reconfiguration
ssb: core 0x0800, irq : 2(S)  3* 4  5  6  D  I
ssb: core 0x0806, irq : 2(S)  3  4* 5  6  D  I
ssb: core 0x0816, irq : 2(S)* 3  4  5  6  D  I
ssb: core 0x0817, irq : 2(S)  3  4  5  6* D  I
ssb: core 0x080f, irq : 2(S)  3  4  5  6  D  I*
ssb: core 0x0812, irq : 2(S)  3  4  5* 6  D  I
ssb: core 0x081c, irq : 2(S)  3  4  5  6  D  I*
ssb: Sonics Silicon Backplane found at address 0x18000000
Serial init done.
Determined physical RAM map:
  memory: 01000000 @ 00000000 (usable)
Initrd not found or empty - disabling initrd
Zone PFN ranges:
   Normal   0x00000000 -> 0x00001000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
     0: 0x00000000 -> 0x00001000
On node 0 totalpages: 4096
free_area_init_node: node 0, pgdat 80283b50, node_mem_map 802c9000
   Normal zone: 32 pages used for memmap
   Normal zone: 0 pages reserved
   Normal zone: 4064 pages, LIFO batch:0
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: root=3D/dev/mtdblock2 rootfstype=3Dsquashfs,jffs2=20
noinitrd console=3DttyS0,115200
PID hash table entries: 64 (order: -4, 256 bytes)
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Primary instruction cache 16kB, VIPT, 2-way, linesize 16 bytes.
Primary data cache 8kB, 2-way, VIPT, no aliases, linesize 16 bytes
Memory: 13372k/16384k available (2222k kernel code, 3012k reserved, 350k=20
data, 136k init, 0k highmem)
Hierarchical RCU implementation.
NR_IRQS:128
console [ttyS0] enabled
Calibrating delay loop... 199.16 BogoMIPS (lpj=3D398336)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
Switching to clocksource MIPS
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
NET: Registered protocol family 1
squashfs: version 4.0 (2009/01/31) Phillip Lougher
Registering mini_fo version $Id$
JFFS2 version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat, Inc.
msgmni has been set to 26
io scheduler noop registered
io scheduler deadline registered (default)
Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
serial8250: ttyS0 at MMIO 0xb8000300 (irq =3D 3) is a 16550A
serial8250: ttyS1 at MMIO 0xb8000400 (irq =3D 3) is a 16550A
serial8250.0: ttyS0 at MMIO 0xb8000300 (irq =3D 3) is a 16550A
serial8250.0: ttyS1 at MMIO 0xb8000400 (irq =3D 3) is a 16550A
flash init: 0x1c000000 0x02000000
Physically mapped flash: Found 1 x16 devices at 0x0 in 16-bit bank
Physically mapped flash: Found an alias at 0x400000 for the chip at 0x0
Physically mapped flash: Found an alias at 0x800000 for the chip at 0x0
Physically mapped flash: Found an alias at 0xc00000 for the chip at 0x0
Physically mapped flash: Found an alias at 0x1000000 for the chip at 0x0
Physically mapped flash: Found an alias at 0x1400000 for the chip at 0x0
Physically mapped flash: Found an alias at 0x1800000 for the chip at 0x0
Physically mapped flash: Found an alias at 0x1c00000 for the chip at 0x0
  Amd/Fujitsu Extended Query Table at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Flash device: 0x400000 at 0x1fc00000
bootloader size: 262144
Updating TRX offsets and length:
old trx =3D [0x0000001c, 0x00000974, 0x000d2000], len=3D0x00271000=20
crc32=3D0x65c67278
new trx =3D [0x0000001c, 0x00000974, 0x000d2000], len=3D0x000d2000=20
crc32=3D0x7f60a9cc
Done
Creating 4 MTD partitions on "Physically mapped flash":
0x000000000000-0x000000040000 : "cfe"
0x000000040000-0x0000003f0000 : "linux"
0x000000112000-0x0000003f0000 : "rootfs"
mtd: partition "rootfs" must either start or end on erase block boundary=20
or be smaller than an erase block -- forcing read-only
mtd: partition "rootfs" set to be root filesystem
mtd: partition "rootfs_data" created automatically, ofs=3D290000, len=3D160=
000
0x000000290000-0x0000003f0000 : "rootfs_data"
0x0000003f0000-0x000000400000 : "nvram"
b44.c:v2.0
eth0: Broadcom 44xx/47xx 10/100BaseT Ethernet 00:25:9c:3c:46:04
BCM47xx Watchdog Timer enabled (30 seconds, nowayout)
TCP westwood registered
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFS: Mounted root (squashfs filesystem) readonly on device 31:2.
Freeing unused kernel memory: 136k freed
Please be patient, while OpenWrt loads ...
diag: Detected 'Linksys WRT54G/GS/GL'
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.
roboswitch: Probing device eth0: found a 5325! It's a 5350.
mini_fo: using base directory: /
mini_fo: using storage directory: /tmp/root
b44: eth0: powering down PHY
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.
device eth0.0 entered promiscuous mode
device eth0 entered promiscuous mode
br-lan: port 1(eth0.0) entering forwarding state
Compat-wireless backport release: compat-wireless-2010-07-13-4-g04898a5
Backport based on wireless-2.6.git v2.6.35-rc6-48432-gdce358e
cfg80211: Calling CRDA to update world regulatory domain
b43-phy0: Broadcom 5352 WLAN found (core revision 9)
phy0: Selected rate control algorithm 'minstrel'
Registered led device: b43-phy0::tx
Registered led device: b43-phy0::rx
Registered led device: b43-phy0::radio
Broadcom 43xx driver loaded [ Features: PL, Firmware-ID: FW13 ]
Broadcom 43xx-legacy driver loaded [ Features: PLID, Firmware-ID: FW10 ]
cfg80211: World regulatory domain updated:
     (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
     (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
     (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
     (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
     (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
     (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
PPP generic driver version 2.4.2
ip_tables: (C) 2000-2006 Netfilter Core Team
NET: Registered protocol family 24
nf_conntrack version 0.5.0 (211 buckets, 844 max)
batman-adv:B.A.T.M.A.N. advanced 2010.0.0 (compatibility version 8) loaded
batman-adv:Adding interface: wlan0
batman-adv:Not using interface wlan0 (retrying later): interface not active
jffs2_scan_eraseblock(): End of filesystem marker found at 0x0
jffs2_build_filesystem(): unlocking the mtd device... done.
jffs2_build_filesystem(): erasing all blocks after the end marker... done.
mini_fo: using base directory: /
mini_fo: using storage directory: /overlay
batman-adv:Removing interface: wlan0
br-lan: port 1(eth0.0) entering disabled state
device eth0 left promiscuous mode
device eth0.0 left promiscuous mode
br-lan: port 1(eth0.0) entering disabled state
device eth0.0 entered promiscuous mode
device eth0 entered promiscuous mode
br-lan: port 1(eth0.0) entering forwarding state
b43-phy0: Loading firmware version 410.2160 (2007-05-26 15:32:10)
b43-phy0: Loading firmware version 410.2160 (2007-05-26 15:32:10)
device wlan0 entered promiscuous mode
br-lan: port 2(wlan0) entering forwarding state
device wlan0 left promiscuous mode
br-lan: port 2(wlan0) entering disabled state
device wlan0 entered promiscuous mode
br-lan: port 2(wlan0) entering forwarding state
batman-adv:B.A.T.M.A.N. advanced 2010.0.0 (compatibility version 8) loaded
br-lan: port 2(wlan0) entering disabled state
br-lan: port 1(eth0.0) entering disabled state
device eth0 left promiscuous mode
device wlan0 left promiscuous mode
br-lan: port 2(wlan0) entering disabled state
device eth0.0 left promiscuous mode
br-lan: port 1(eth0.0) entering disabled state
device eth0.0 entered promiscuous mode
device eth0 entered promiscuous mode
br-lan: port 1(eth0.0) entering forwarding state
device wlan0 entered promiscuous mode
br-lan: port 2(wlan0) entering forwarding state
device wlan0 left promiscuous mode
br-lan: port 2(wlan0) entering disabled state
b43-phy0: Loading firmware version 410.2160 (2007-05-26 15:32:10)
CPU 0 Unable to handle kernel paging request at virtual address=20
00003aa1, epc =3D=3D 80a982f4, ra =3D=3D 80a982dc
Oops[#1]:
Cpu 0
$ 0   : 00000000 10009800 3c9c2500 80d9e800
$ 4   : 803df888 00003a9e 00003a98 00000000
$ 8   : 00000004 00000001 00000000 fffffffb
$12   : 0000000f 80238688 ffffffff 80c47bc8
$16   : 80435e80 80d9e800 80a9c314 80cd26c0
$20   : 00000008 7fd6fd80 7fd6fcd0 00000001
$24   : 0000003c 8f1bbcdc
$28   : 80c46000 80c47d58 00475028 80a982dc
Hi    : 00000103
Lo    : 68655100
epc   : 80a982f4 0x80a982f4
     Not tainted
ra    : 80a982dc 0x80a982dc
Status: 10009803    KERNEL EXL IE
Cause : 0080000c
BadVA : 00003aa1
PrId  : 00029008 (Broadcom BCM3302)
Modules linked in: batman_adv nf_nat_tftp nf_conntrack_tftp nf_nat_irc=20
nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ipt_MASQUERADE iptable_nat=20
nf_nat xt_NOTRACK iptable_raw xt_state nf_conntrack_ipv4 nf_defrag_ipv4=20
nf_conntrack pppoe pppox ipt_REJECT xt_TCPMSS ipt_LOG xt_comment=20
xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ip_tables=20
xt_tcpudp x_tables ppp_async ppp_generic slhc b43legacy b43 mac80211=20
crc_ccitt cfg80211 compat_firmware_class compat arc4 aes_generic deflate=20
ecb cbc switch_robo switch_core diag [last unloaded: batman_adv]
Process hostapd (pid: 2057, threadinfo=3D80c46000, task=3D80739048,=20
tls=3D00000000)
Stack : 80435e80 80d9e800 80a9c314 80cd26c0 80435e80 80a98a5c 80e712a8=20
fffffff2
         00000000 80d9e800 00000000 fffffff0 00000000 80d9e800 00000008=20
800430c0
         00000000 80d9e800 00000000 801a2eb0 00000000 80d9e800 7fd6fcf0=20
00000000
         80c47e18 8004325c 00000000 7fd6fcf0 00008914 00000000 00000000=20
ffffffed
         80d9e800 801a6e18 802c4c90 801a7e40 00000000 0000001d 00008924=20
00008924
         ...
Call Trace:[<80a98a5c>] 0x80a98a5c
[<800430c0>] 0x800430c0
[<801a2eb0>] 0x801a2eb0
[<8004325c>] 0x8004325c
[<801a6e18>] 0x801a6e18
[<801a7e40>] 0x801a7e40
[<801a8aa4>] 0x801a8aa4
[<80190a00>] 0x80190a00
[<800a2858>] 0x800a2858
[<800a6270>] 0x800a6270
[<800a2f90>] 0x800a2f90
[<80192028>] 0x80192028
[<80191330>] 0x80191330
[<800a3034>] 0x800a3034
[<80192878>] 0x80192878
[<80003230>] 0x80003230


Code: 24c50006  88820003  98820000 <a8a20003> b8a20000  90830004 =20
a0a30004  90820005  a0a20005
Disabling lock debugging due to kernel taint"

Hope all this info helps you, for me it's only confusing :)

With best regards,
Tim
