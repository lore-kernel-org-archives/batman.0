Return-Path: <linus.luessing@web.de>
Date: Sun, 24 Jan 2010 05:24:52 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100124042452.GA16702@Sellars>
References: <20100123174616.GA4795@Sellars>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <20100123174616.GA4795@Sellars>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] bat_events: page allocation failure (batman-adv
 maint)
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


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

And another (different) one. Which occured right after flashing
and booting causing a kernel panic.
Sorry couldn't find a method for reproducing them yet.

Cheers, Linus

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="kernel-panic-0512-24-01-10.log"
Content-Transfer-Encoding: quoted-printable

root@OpenWrt:/# n+Warning: IP address 192.168.1.1 in use
Ethernet eth0: MAC address 00:22:b0:98:87:de
IP: 192.168.1.1/255.255.255.0, Gateway: 0.0.0.0
Default server: 192.168.1.2

RedBoot(tm) bootstrap and debug environment [ROMRAM]
production release, version "2.1.3" - built 18:43:19, Sep 20 2007

Platform: ap61 (Atheros WiSOC)
Copyright (C) 2000, 2001, 2002, 2003, 2004 Red Hat, Inc.
Copyright (C) 2007, NewMedia-NET GmbH.

Board: DLINK DIR-300
RAM: 0x80000000-0x81000000, [0x80040580-0x80fe1000] available
FLASH: 0xbfc00000 - 0xbfff0000, 64 blocks of 0x00010000 bytes each.
=3D=3D Executing boot script in 5.000 seconds - enter ^C to abort
+Warning: IP address 192.168.1.1 in use
Ethernet eth0: MAC address 00:22:b0:98:87:de
IP: 192.168.1.1/255.255.255.0, Gateway: 0.0.0.0
Default server: 192.168.1.2

RedBoot(tm) bootstrap and debug environment [ROMRAM]
production release, version "2.1.3" - built 18:43:19, Sep 20 2007

Platform: ap61 (Atheros WiSOC)
Copyright (C) 2000, 2001, 2002, 2003, 2004 Red Hat, Inc.
Copyright (C) 2007, NewMedia-NET GmbH.

Board: DLINK DIR-300
RAM: 0x80000000-0x81000000, [0x80040580-0x80fe1000] available
FLASH: 0xbfc00000 - 0xbfff0000, 64 blocks of 0x00010000 bytes each.
=3D=3D Executing boot script in 5.000 seconds - enter ^C to abort
DD-WRT> fis load -l vmlinux.bin.l7
Image loaded from 0x80041000-0x802c8200
DD-WRT> exec
Now booting linux kernel:
 Base address 0x80030000 Entry 0x80041000
 Cmdline :
Linux version 2.6.30.10 (linus@Linus-Debian) (gcc version 4.3.3 (GCC) ) #2 =
Sun Jan 24 04:12:11 CET 2010
CPU revision is: 00019064 (MIPS 4KEc)
Determined physical RAM map:
 memory: 01000000 @ 00000000 (usable)
Initrd not found or empty - disabling initrd
Zone PFN ranges:
  Normal   0x00000000 -> 0x00001000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00001000
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: console=3DttyS0,9600 rootfstype=3Dsquashfs,jffs2
Primary instruction cache 16kB, VIPT, 4-way, linesize 16 bytes.
Primary data cache 16kB, 4-way, VIPT, no aliases, linesize 16 bytes
NR_IRQS:128
PID hash table entries: 64 (order: 6, 256 bytes)
console [ttyS0] enabled
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 13300k/16384k available (2002k kernel code, 3084k reserved, 458k da=
ta, 128k init, 0k highmem)
Calibrating delay loop... 183.50 BogoMIPS (lpj=3D917504)
Mount-cache hash table entries: 512
net_namespace: 732 bytes
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
NET: Registered protocol family 1
Radio config found at offset 0xf8(0x1f8)
squashfs: version 4.0 (2009/01/31) Phillip Lougher
Registering mini_fo version $Id$
JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red Hat, Inc.
msgmni has been set to 25
io scheduler noop registered
io scheduler deadline registered (default)
gpiodev: gpio device registered with major 254
gpiodev: gpio platform device registered with access mask FFFFFFFF
Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0xb1100003 (irq =3D 37) is a 16550A
eth0: Atheros AR231x: 00:22:b0:98:87:de, irq 4
ar231x_eth_mii: probed
eth0: attached PHY driver [IC+ IP175C] (mii_bus:phy_addr=3D0:00)
cmdlinepart partition parsing not available
Searching for RedBoot partition table in spiflash at offset 0x3d0000
Searching for RedBoot partition table in spiflash at offset 0x3e0000
6 RedBoot partitions found on MTD device spiflash
Creating 6 MTD partitions on "spiflash":
0x000000000000-0x000000030000 : "RedBoot"
0x000000030000-0x0000002f0000 : "rootfs"
mtd: partition "rootfs" set to be root filesystem
mtd: partition "rootfs_data" created automatically, ofs=3D230000, len=3DC00=
00
0x000000230000-0x0000002f0000 : "rootfs_data"
0x0000002f0000-0x0000003d0000 : "vmlinux.bin.l7"
0x0000003e0000-0x0000003ef000 : "FIS directory"
0x0000003ef000-0x0000003f0000 : "RedBoot config"
0x0000003f0000-0x000000400000 : "boardconfig"
TCP westwood registered
NET: Registered protocol family 17
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFS: Mounted root (squashfs filesystem) readonly on device 31:1.
Freeing unused kernel memory: 128k freed
Please be patient, while OpenWrt loads ...
- preinit -
Press CTRL-C for failsafe
jffs2 not ready yet; using ramdisk
mini_fo: using base directory: /
mini_fo: using storage directory: /tmp/root
- init -

Please press Enter to activate this console. NET: Registered protocol famil=
y 10
lo: Disabled Privacy Extensions
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
device eth0.1 entered promiscuous mode
device eth0 entered promiscuous mode
br-mesh: port 1(eth0.1) entering forwarding state
ip_tables: (C) 2000-2006 Netfilter Core Team
Ebtables v2.0 registered
ip6_tables: (C) 2000-2006 Netfilter Core Team
device eth0.4 entered promiscuous mode
br-wan_vpn: port 1(eth0.4) entering forwarding state
br-wan_vpn: starting userspace STP failed, starting kernel STP
batman-adv:B.A.T.M.A.N. advanced 0.2.1-beta r1545 (compatibility version 8)=
 loaded
ath_hal: module license 'Proprietary' taints kernel.
Disabling lock debugging due to kernel taint
ath_hal: 2009-05-08 (AR5212, AR5312, RF5111, RF5112, RF2316, RF2317, REGOPS=
_FUNC, TX_DESC_SWAP, XR)
ath_ahb: trunk
wlan: trunk
wlan: mac acl policy registered
ath_rate_minstrel: Minstrel automatic rate control algorithm 1.2 (trunk)
ath_rate_minstrel: look around rate set to 10%
ath_rate_minstrel: EWMA rolloff level set to 75%
ath_rate_minstrel: max segment size in the mrr set to 6000 us
Atheros HAL provided by OpenWrt, DD-WRT and MakSat Technologies
wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mb=
ps 36Mbps 48Mbps 54Mbps
wifi0: turboG rates: 6Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
wifi0: H/W encryption support: WEP AES AES_CCM TKIP
ath_ahb: wifi0: Atheros 2317 WiSoC REV1: mem=3D0xb0000000, irq=3D3
IRQ 3/wifi0: IRQF_DISABLED is not guaranteed on shared IRQs
device bat0 entered promiscuous mode
br-mesh: port 2(bat0) entering forwarding state
br-wan_vpn: port 1(eth0.4) entering disabled state
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 1(eth0.4) entering forwarding state
br-mesh: port 2(bat0) entering disabled state
br-mesh: port 1(eth0.1) entering disabled state
br-mesh: port 2(bat0) entering forwarding state
br-mesh: port 1(eth0.1) entering forwarding state
batman-adv:Adding interface: ath0
batman-adv:Interface activated: ath0
CPU 0 Unable to handle kernel paging request at virtual address 00000010, e=
pc =3D=3D 80be3584, ra =3D=3D 80be34e4
Oops[#1]:
Cpu 0
$ 0   : 00000000 10009c00 00000010 80afd800
$ 4   : 00000000 00000000 00000000 80be85f8
$ 8   : 0000611b 80afd68e 00000010 00000000
$12   : 00000000 feced300 ffffffff 61636520
$16   : 8064ca40 8064ca00 80afd680 8064ca40
$20   : 8064ca00 00000000 00000001 80640060
$24   : 00000010 8069c74c
$28   : 8046c000 8046d9a8 802a0000 80be34e4
Hi    : 00000000
Lo    : 0000000b
epc   : 80be3584 receive_bat_packet+0x3d8/0x6ec [batman_adv]
    Tainted: P
ra    : 80be34e4 receive_bat_packet+0x338/0x6ec [batman_adv]
Status: 10009c02    KERNEL EXL
Cause : 10800008
BadVA : 00000010
PrId  : 00019064 (MIPS 4KEc)
Modules linked in: ath_ahb ath_hal(P) batman_adv ip6t_REJECT ip6t_LOG ip6t_=
rt ip6t_hbh ip6t_mh ip6t_ipv6header ip6t_frag ip6t_eui64 ip6t_ah ip6table_r=
aw ip6_queue ip6table_mangle ip6table_filter ip6_tables ebt_redirect ebt_ma=
rk ebt_vlan ebt_stp ebt_pkttype ebt_mark_m ebt_limit ebt_among ebt_802_3 eb=
table_nat ebtable_filter ebtable_broute ebtables xt_quota xt_pkttype xt_phy=
sdev ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport xt_mac xt_limit iptable_mang=
le iptable_filter ip_tables xt_tcpudp x_tables tun ipv6
Process batctl (pid: 1140, threadinfo=3D8046c000, task=3D8052bad0, tls=3D00=
000000)
Stack : 00000000 806a2aac 10009c01 80303620 802a0000 80f38a90 8064006c 0000=
0001
        80640058 00000000 00000002 80640052 80640074 0000000c 80afd800 0000=
0000
        80640060 00000000 80640060 00000040 80640052 80afd800 00004305 0000=
0000
        80640040 80be8094 80f38a90 8005cd6c 00000001 80c27798 80afd800 80c2=
7798
        80303620 80c176b8 80640052 80afd800 10009c01 80547000 80547000 80be=
2ee4
        ...
Call Trace:
[<80be3584>] receive_bat_packet+0x3d8/0x6ec [batman_adv]
[<80be8094>] receive_aggr_bat_packet+0x7c/0xbc [batman_adv]
[<80be2ee4>] recv_bat_packet+0x94/0x24c [batman_adv]
[<80be79c8>] batman_skb_recv+0x128/0x1dc [batman_adv]
[<806a1494>] ieee80211_saveath+0xb24/0xb80 [ath_ahb]


Code: 9245000e  84640008  00441021 <90440000> 00a4102b  00a2200b  10800003 =
 00000000  14a00003
Kernel panic - not syncing: Fatal exception in interrupt

--vGgW1X5XWziG23Ko--
