Return-Path: <ilario.gelmetti@sns.it>
Message-ID: <5339CBBD.9050708@sns.it>
Date: Mon, 31 Mar 2014 22:10:37 +0200
From: Ilario Gelmetti <ilario.gelmetti@sns.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="quvb3Ricj58vCrkXxGEkA1PhqXwE7TXJv"
Subject: [B.A.T.M.A.N.] br-lan: received packet on bat0 with own address as
	source address
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--quvb3Ricj58vCrkXxGEkA1PhqXwE7TXJv
Content-Type: multipart/mixed;
 boundary="------------090903090602080604000102"

This is a multi-part message in MIME format.
--------------090903090602080604000102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,
I have two devices (Ubiquiti PicoStation M2 and Ubiquiti NanoStation M5)
mounted on the same pole both running libre-mesh [1] firmware
(batman-adv: 2014.1.0) and both attached to a Mikrotik RB250GS gigabit
switch (latest 1.11 firmware, default configuration) which is attached
to my pc [2].
When isolated (turning off the port of the other device via the switch
interface), both Ubiquiti devices doesn't see any other device with
batman neither have any client connected.
Both the devices independently (also when are isolated) print the same
error in dmesg:
br-lan: received packet on bat0 with own address as source address

This error is an indication that batman loop avoidance has some
problems, right?
Obviously loop avoidance is enabled.
# batctl bl
enabled

Various interfaces are bridged, for example in PicoStation I have:
# brctl show
bridge name	bridge id		STP enabled	interfaces
br-lan		7fff.dc9fdb31c136	no		eth0
							bat0
							wlan0_ap

I noticed that I'm not the first to ask here about this message [3][4].
I attach to this email dmesg form both isolated devices,
/etc/config/network, ip a, ifconfig, brctl and info from batctl.
Thanks,
Ilario


[1] http://libre-mesh.org/projects/libre-mesh
[2] https://github.com/ilario/configurazione-ilario-fisso
[3]
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-February/006234.ht=
ml
[4]
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2013-October/010770.htm=
l


--------------090903090602080604000102
Content-Type: text/plain; charset=UTF-8;
 name="nano-batctl"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="nano-batctl"

root@ef8bda:~# batctl s
	tx: 45
	tx_bytes: 3399
	tx_dropped: 7
	rx: 26
	rx_bytes: 1092
	forward: 0
	forward_bytes: 0
	mgmt_tx: 775
	mgmt_tx_bytes: 42138
	mgmt_rx: 0
	mgmt_rx_bytes: 0
	frag_tx: 0
	frag_tx_bytes: 0
	frag_rx: 0
	frag_rx_bytes: 0
	frag_fwd: 0
	frag_fwd_bytes: 0
	tt_request_tx: 0
	tt_request_rx: 0
	tt_response_tx: 0
	tt_response_rx: 0
	tt_roam_adv_tx: 0
	tt_roam_adv_rx: 0
	dat_get_tx: 0
	dat_get_rx: 0
	dat_put_tx: 0
	dat_put_rx: 0
	dat_cached_reply_tx: 0

root@ef8bda:~# batctl if
eth0.11: active
eth1.11: active
root@ef8bda:~# batctl dat
disabled
root@ef8bda:~# batctl bl
enabled
root@ef8bda:~# batctl ap
disabled
root@ef8bda:~# batctl ag
enabled
root@ef8bda:~# batctl b
disabled
root@ef8bda:~# batctl f
enabled
root@ef8bda:~# batctl mark
0x00000000/0x00000000
root@ef8bda:~# batctl gw
off
root@ef8bda:~# batctl o
[B.A.T.M.A.N. adv 2014.1.0, MainIF/MAC: eth0.11/dc:9f:db:ef:8b:da (bat0 B=
ATMAN_IV)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   Pot=
ential nexthops ...
No batman nodes in range ...
root@ef8bda:~# batctl gwl
      Gateway      (#/255)           Nexthop [outgoingIF]: advertised upl=
ink bandwidth ... [B.A.T.M.A.N. adv 2014.1.0, MainIF/MAC: eth0.11/dc:9f:d=
b:ef:8b:da (bat0)]
No gateways in range ...
root@ef8bda:~# batctl tl
Locally retrieved addresses (from bat0) announced via TT (TTVN: 5):
       Client         VID Flags    Last seen (CRC       )
 * 1e:d2:cb:8b:cb:24    0 [.P....]   0.000   (0xb7d000e8)
 * 00:1e:8c:65:ef:0b   -1 [......]  17.890   (0x514be548)
 * 1e:d2:cb:8b:cb:24   -1 [.P....]   0.000   (0x514be548)
 * 00:0c:42:ee:fe:e9   -1 [......]  34.960   (0x514be548)
 * dc:9f:db:ef:8b:da   -1 [......] 506.810   (0x514be548)
root@ef8bda:~# batctl tg
Globally announced TT entries received via the mesh bat0
       Client         VID  (TTVN)       Originator      (Curr TTVN) (CRC =
      ) Flags
root@ef8bda:~# batctl cl
Claims announced for the mesh bat0 (orig dc:9f:db:ef:8b:da, group id 0x3a=
6b)
   Client               VID      Originator        [o] (CRC   )
root@ef8bda:~# batctl bbt
Backbones announced for the mesh bat0 (orig dc:9f:db:ef:8b:da, group id 0=
x3a6b)
   Originator           VID   last seen (CRC   )
root@ef8bda:~# batctl dc
Distributed ARP Table (bat0):
          IPv4             MAC        VID   last-seen


--------------090903090602080604000102
Content-Type: text/plain; charset=UTF-8;
 name="nano-brctl"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="nano-brctl"

root@ef8bda:~# brctl show
bridge name	bridge id		STP enabled	interfaces
br-lan		7fff.dc9fdbef8bda	no		eth0
							eth1
							bat0
							wlan0_ap


--------------090903090602080604000102
Content-Type: text/plain; charset=UTF-8;
 name="nano-dmesg"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="nano-dmesg"

BusyBox v1.19.4 (2014-03-30 12:23:28 CEST) built-in shell (ash)
Enter 'help' for a list of built-in commands.

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 BARRIER BREAKER (Bleeding Edge, r38505)
 -----------------------------------------------------
  * 1/2 oz Galliano         Pour all ingredients into
  * 4 oz cold Coffee        an irish coffee mug filled
  * 1 1/2 oz Dark Rum       with crushed ice. Stir.
  * 2 tsp. Creme de Cacao
 -----------------------------------------------------
  ___   __ __                   _______             __
 |   |_|__|  |--.----.-----. _ |   |   |-----.-----|  |--.
 |     |  |  _  |   _|  -__||_||       |  -__|__ --|     |
 |_____|__|_____|__| |_____|   |__|_|__|_____|_____|__|__|

 ---------------------------------------------------------
  (,  rev.-)
 ---------------------------------------------------------

 http://libre-mesh.org
 ---------------------------------------------------------
root@ef8bda:~# dmesg
[    0.000000] Linux version 3.10.15 (ilario@ilario-fisso) (gcc version 4=
=2E6.4 (OpenWrt/Linaro GCC 4.6-2013.05 r38505) ) #1 Sun Mar 30 12:34:05 C=
EST 2014
[    0.000000] MyLoader: sysp=3Daaaaaaaa, boardp=3Daaaaa2aa, parts=3Daaaa=
aaaa
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU revision is: 00019374 (MIPS 24Kc)
[    0.000000] SoC: Atheros AR7241 rev 1
[    0.000000] Clocks: CPU:390.000MHz, DDR:390.000MHz, AHB:195.000MHz, Re=
f:5.000MHz
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 02000000 @ 00000000 (usable)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x00000000-0x01ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x01ffffff]
[    0.000000] On node 0 totalpages: 8192
[    0.000000] free_area_init_node: node 0, pgdat 8030aa90, node_mem_map =
81000000
[    0.000000]   Normal zone: 64 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 8192 pages, LIFO batch:0
[    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 b=
ytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, lines=
ize 32 bytes
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  To=
tal pages: 8128
[    0.000000] Kernel command line:  board=3DUBNT-NM console=3DttyS0,1152=
00 mtdparts=3Dspi0.0:256k(u-boot)ro,64k(u-boot-env)ro,7552k(firmware),256=
k(cfg)ro,64k(EEPROM)ro rootfstype=3Dsquashfs,jffs2 noinitrd
[    0.000000] PID hash table entries: 128 (order: -3, 512 bytes)
[    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 byt=
es)
[    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes=
)
[    0.000000] Writing ErrCtl register=3D00000000
[    0.000000] Readback ErrCtl register=3D00000000
[    0.000000] Memory: 28784k/32768k available (2223k kernel code, 3984k =
reserved, 594k data, 252k init, 0k highmem)
[    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1,=
 Nodes=3D1
[    0.000000] NR_IRQS:51
[    0.060000] Calibrating delay loop... 259.27 BogoMIPS (lpj=3D1296384)
[    0.070000] pid_max: default: 32768 minimum: 301
[    0.070000] Mount-cache hash table entries: 512
[    0.080000] NET: Registered protocol family 16
[    0.090000] MIPS: machine is Ubiquiti Nanostation M
[    0.090000] registering PCI controller with io_map_base unset
[    0.500000] bio: create slab <bio-0> at 0
[    0.510000] PCI host bridge to bus 0000:00
[    0.510000] pci_bus 0000:00: root bus resource [mem 0x10000000-0x13fff=
fff]
[    0.520000] pci_bus 0000:00: root bus resource [io  0x0000]
[    0.520000] pci_bus 0000:00: No busn resource found for root bus, will=
 use [bus 00-ff]
[    0.530000] pci 0000:00:00.0: [168c:002a] type 00 class 0x028000
[    0.530000] pci 0000:00:00.0: fixup device configuration
[    0.530000] pci 0000:00:00.0: reg 10: [mem 0x10000000-0x1000ffff 64bit=
]
[    0.530000] pci 0000:00:00.0: supports D1
[    0.530000] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    0.530000] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 0=
0
[    0.530000] pci 0000:00:00.0: BAR 0: assigned [mem 0x10000000-0x1000ff=
ff 64bit]
[    0.540000] pci 0000:00:00.0: using irq 40 for pin 1
[    0.540000] Switching to clocksource MIPS
[    0.550000] NET: Registered protocol family 2
[    0.550000] TCP established hash table entries: 512 (order: 0, 4096 by=
tes)
[    0.560000] TCP bind hash table entries: 512 (order: -1, 2048 bytes)
[    0.570000] TCP: Hash tables configured (established 512 bind 512)
[    0.570000] TCP: reno registered
[    0.580000] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.580000] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.590000] NET: Registered protocol family 1
[    0.590000] PCI: CLS 0 bytes, default 32
[    0.610000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.620000] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_=
PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    0.630000] msgmni has been set to 56
[    0.630000] io scheduler noop registered
[    0.640000] io scheduler deadline registered (default)
[    0.640000] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
[    0.670000] serial8250.0: ttyS0 at MMIO 0x18020000 (irq =3D 11) is a 1=
6550A
[    0.680000] console [ttyS0] enabled, bootconsole disabled
[    0.690000] ath79-spi ath79-spi: master is unqueued, this is deprecate=
d
[    0.700000] m25p80 spi0.0: found s25fl064k, expected m25p80
[    0.700000] m25p80 spi0.0: s25fl064k (8192 Kbytes)
[    0.710000] 5 cmdlinepart partitions found on MTD device spi0.0
[    0.710000] Creating 5 MTD partitions on "spi0.0":
[    0.720000] 0x000000000000-0x000000040000 : "u-boot"
[    0.730000] 0x000000040000-0x000000050000 : "u-boot-env"
[    0.730000] 0x000000050000-0x0000007b0000 : "firmware"
[    0.750000] 2 uimage-fw partitions found on MTD device firmware
[    0.750000] 0x000000050000-0x00000014b37e : "kernel"
[    0.760000] mtd: partition "kernel" must either start or end on erase =
block boundary or be smaller than an erase block -- forcing read-only
[    0.770000] 0x00000014b37e-0x0000007b0000 : "rootfs"
[    0.780000] mtd: partition "rootfs" must either start or end on erase =
block boundary or be smaller than an erase block -- forcing read-only
[    0.790000] mtd: partition "rootfs" set to be root filesystem
[    0.800000] 1 squashfs-split partitions found on MTD device rootfs
[    0.810000] 0x0000003e0000-0x0000007b0000 : "rootfs_data"
[    0.810000] 0x0000007b0000-0x0000007f0000 : "cfg"
[    0.820000] 0x0000007f0000-0x000000800000 : "EEPROM"
[    0.830000] libphy: ag71xx_mdio: probed
[    0.840000] eth0: Atheros AG71xx at 0xb9000000, irq 4, mode:MII
[    1.400000] ag71xx ag71xx.0 eth0: connected to PHY at ag71xx-mdio.1:04=
 [uid=3D004dd041, driver=3DGeneric PHY]
[    1.410000] eth1: Atheros AG71xx at 0xba000000, irq 5, mode:GMII
[    1.960000] eth1: Found an AR7240/AR9330 built-in switch
[    3.000000] TCP: cubic registered
[    3.000000] NET: Registered protocol family 17
[    3.000000] Bridge firewalling registered
[    3.010000] 8021q: 802.1Q VLAN Support v1.8
[    3.020000] VFS: Mounted root (squashfs filesystem) readonly on device=
 31:4.
[    3.030000] Freeing unused kernel memory: 252K (80321000 - 80360000)
[    6.150000] usbcore: registered new interface driver usbfs
[    6.160000] usbcore: registered new interface driver hub
[    6.170000] usbcore: registered new device driver usb
[    6.180000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver=

[    6.180000] ehci-platform: EHCI generic platform driver
[    6.200000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    8.430000] eth0: link up (100Mbps/Full duplex)
[    9.720000] jffs2: notice: (295) jffs2_build_xattr_subsystem: complete=
 building xattr subsystem, 1 of xdatum (0 unchecked, 0 orphan) and 25 of =
xref (0 dead, 9 orphan) found.
[    9.750000] eth0: link down
[   11.980000] NET: Registered protocol family 10
[   12.000000] tun: Universal TUN/TAP device driver, 1.6
[   12.000000] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   12.030000] nf_conntrack version 0.5.0 (453 buckets, 1812 max)
[   12.040000] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   12.100000] batman_adv: B.A.T.M.A.N. advanced 2014.1.0 (compatibility =
version 15) loaded
[   12.160000] Loading modules backported from Linux version master-2013-=
06-27-0-gdcfa6d5
[   12.160000] Backport generated by backports.git backports-20130617-4-g=
e3220f5
[   12.200000] Ebtables v2.0 registered
[   12.220000] ip_tables: (C) 2000-2006 Netfilter Core Team
[   12.280000] xt_time: kernel timezone is -0000
[   12.460000] cfg80211: Calling CRDA to update world regulatory domain
[   12.470000] cfg80211: World regulatory domain updated:
[   12.480000] cfg80211:   (start_freq - end_freq @ bandwidth), (max_ante=
nna_gain, max_eirp)
[   12.480000] cfg80211:   (2400000 KHz - 2483000 KHz @ 40000 KHz), (N/A,=
 3000 mBm)
[   12.490000] cfg80211:   (5140000 KHz - 5860000 KHz @ 40000 KHz), (N/A,=
 3000 mBm)
[   12.560000] PCI: Enabling device 0000:00:00.0 (0000 -> 0002)
[   12.570000] ath: EEPROM regdomain: 0x0
[   12.570000] ath: EEPROM indicates default country code should be used
[   12.570000] ath: doing EEPROM country->regdmn map search
[   12.570000] ath: country maps to regdmn code: 0x3a
[   12.570000] ath: Country alpha2 being used: US
[   12.570000] ath: Regpair used: 0x3a
[   12.590000] ieee80211 phy0: Selected rate control algorithm 'minstrel_=
ht'
[   12.600000] cfg80211: Calling CRDA for country: US
[   12.600000] cfg80211: Regulatory domain changed to country: US
[   12.610000] cfg80211:   (start_freq - end_freq @ bandwidth), (max_ante=
nna_gain, max_eirp)
[   12.620000] cfg80211:   (2400000 KHz - 2483000 KHz @ 40000 KHz), (N/A,=
 3000 mBm)
[   12.630000] cfg80211:   (5140000 KHz - 5860000 KHz @ 40000 KHz), (N/A,=
 3000 mBm)
[   12.630000] ieee80211 phy0: Atheros AR9280 Rev:2 mem=3D0xb0000000, irq=
=3D40
[   17.010000] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   17.010000] device eth0 entered promiscuous mode
[   17.040000] IPv6: ADDRCONF(NETDEV_UP): br-lan: link is not ready
[   17.180000] device br-lan entered promiscuous mode
[   17.180000] IPv6: ADDRCONF(NETDEV_UP): anygw: link is not ready
[   18.240000] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   18.240000] device eth1 entered promiscuous mode
[   18.250000] br-lan: port 2(eth1) entered forwarding state
[   18.250000] br-lan: port 2(eth1) entered forwarding state
[   18.260000] br-lan: port 2(eth1) entered disabled state
[   18.270000] IPv6: ADDRCONF(NETDEV_UP): eth0.11: link is not ready
[   18.300000] IPv6: ADDRCONF(NETDEV_UP): eth0.12: link is not ready
[   18.350000] IPv6: ADDRCONF(NETDEV_UP): eth1.11: link is not ready
[   18.410000] IPv6: ADDRCONF(NETDEV_UP): eth1.12: link is not ready
[   18.590000] batman_adv: bat0: Adding interface: eth0.11
[   18.590000] batman_adv: bat0: The MTU of interface eth0.11 is too smal=
l (1496) to handle the transport of batman-adv packets. Packets going ove=
r this interface will be fragmented on layer2 which could impact the perf=
ormance. Setting the MTU to 1532 would solve the problem.
[   18.620000] batman_adv: bat0: Interface activated: eth0.11
[   18.660000] 8021q: adding VLAN 0 to HW filter on device bat0
[   18.660000] device bat0 entered promiscuous mode
[   18.670000] br-lan: port 3(bat0) entered forwarding state
[   18.670000] br-lan: port 3(bat0) entered forwarding state
[   18.680000] IPv6: ADDRCONF(NETDEV_CHANGE): br-lan: link becomes ready
[   18.710000] br-lan: received packet on bat0 with own address as source=
 address
[   18.730000] IPv6: ADDRCONF(NETDEV_CHANGE): anygw: link becomes ready
[   18.810000] batman_adv: bat0: Adding interface: eth1.11
[   18.820000] batman_adv: bat0: The MTU of interface eth1.11 is too smal=
l (1496) to handle the transport of batman-adv packets. Packets going ove=
r this interface will be fragmented on layer2 which could impact the perf=
ormance. Setting the MTU to 1532 would solve the problem.
[   18.840000] batman_adv: bat0: Interface activated: eth1.11
[   19.910000] eth0: link up (100Mbps/Full duplex)
[   19.950000] br-lan: port 1(eth0) entered forwarding state
[   19.950000] br-lan: port 1(eth0) entered forwarding state
[   19.960000] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   19.980000] IPv6: ADDRCONF(NETDEV_CHANGE): eth0.11: link becomes ready=

[   19.980000] IPv6: ADDRCONF(NETDEV_CHANGE): eth0.12: link becomes ready=

[   20.450000] batman_adv: bat0: bridge_loop_avoidance: Changing from: di=
sabled to: enabled
[   20.480000] batman_adv: bat0: distributed_arp_table: Changing from: en=
abled to: disabled
[   20.670000] br-lan: port 3(bat0) entered forwarding state
[   21.950000] br-lan: port 1(eth0) entered forwarding state
[   22.480000] IPv6: ADDRCONF(NETDEV_UP): wlan0_ap: link is not ready
[   22.520000] IPv6: ADDRCONF(NETDEV_UP): wlan0_ap.12: link is not ready
[   27.770000] device wlan0_ap entered promiscuous mode
[   27.790000] IPv6: ADDRCONF(NETDEV_UP): wlan0_ap.12: link is not ready
[   27.800000] IPv6: ADDRCONF(NETDEV_UP): wlan0_ap: link is not ready
[   27.830000] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0_ap: link becomes read=
y
[   27.830000] br-lan: port 4(wlan0_ap) entered forwarding state
[   27.840000] br-lan: port 4(wlan0_ap) entered forwarding state
[   27.850000] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0_ap.12: link becomes r=
eady
[   28.600000] br-lan: received packet on bat0 with own address as source=
 address
[   29.840000] br-lan: port 4(wlan0_ap) entered forwarding state
[   31.900000] IPv6: ADDRCONF(NETDEV_UP): wlan0_adhoc: link is not ready
[   31.920000] wlan0_adhoc: Created IBSS using preconfigured BSSID ca:fe:=
00:c0:ff:ee
[   31.920000] wlan0_adhoc: Creating new IBSS network, BSSID ca:fe:00:c0:=
ff:ee
[   31.930000] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0_adhoc: link becomes r=
eady
[   38.620000] br-lan: received packet on bat0 with own address as source=
 address
[   48.640000] br-lan: received packet on bat0 with own address as source=
 address
[   58.660000] br-lan: received packet on bat0 with own address as source=
 address
[   68.680000] br-lan: received packet on bat0 with own address as source=
 address
[   78.700000] br-lan: received packet on bat0 with own address as source=
 address
[   88.720000] br-lan: received packet on bat0 with own address as source=
 address
[   98.740000] br-lan: received packet on bat0 with own address as source=
 address
[  108.760000] br-lan: received packet on bat0 with own address as source=
 address
[  118.780000] br-lan: received packet on bat0 with own address as source=
 address
[  128.800000] br-lan: received packet on bat0 with own address as source=
 address
[  138.820000] br-lan: received packet on bat0 with own address as source=
 address
[  148.840000] br-lan: received packet on bat0 with own address as source=
 address
[  158.860000] br-lan: received packet on bat0 with own address as source=
 address
[  168.880000] br-lan: received packet on bat0 with own address as source=
 address

--------------090903090602080604000102
Content-Type: text/plain; charset=UTF-8;
 name="nano-etc-config-network"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="nano-etc-config-network"

root@ef8bda:/etc/config# cat network=20

config interface 'loopback'
	option ifname 'lo'
	option proto 'static'
	option ipaddr '127.0.0.1'
	option netmask '255.0.0.0'

config globals 'globals'

config interface 'lan'
	option type 'bridge'
	option proto 'static'
	option netmask '255.255.255.0'
	option ip6assign '60'
	option ip6addr '2001:DB8:0:0:0:0:0:8BDA/64'
	option ipaddr '192.0.2.218'
	option mtu '1500'
	list ifname 'bat0'
	list ifname 'eth0'
	list ifname 'eth1'
	list ifname 'wlan0_ap'

config interface 'wan'
	option ifname 'eth1'
	option proto 'dhcp'

config interface 'wan6'
	option ifname '@wan'
	option proto 'dhcpv6'

config device 'lm_anygw_dev'
	option type 'macvlan'
	option name 'anygw'
	option ifname '@lan'
	option macaddr 'aa:aa:aa:8a:15:ad'

config interface 'lm_anygw_if'
	option proto 'static'
	option ifname 'anygw'
	option ip6addr '2001:DB8:0:0:0:0:0:1/64'
	option ipaddr '192.0.2.1'
	option netmask '255.255.255.0'

config interface 'lm_eth0_batadv'
	option ifname 'eth0.11'
	option proto 'batadv'
	option mesh 'bat0'
	option mtu '1496'

config interface 'lm_eth0_bmx6'
	option ifname 'eth0.12'
	option proto 'none'
	option auto '1'
	option mtu '1398'

config interface 'lm_eth1_batadv'
	option ifname 'eth1.11'
	option proto 'batadv'
	option mesh 'bat0'
	option mtu '1496'

config interface 'lm_eth1_bmx6'
	option ifname 'eth1.12'
	option proto 'none'
	option auto '1'
	option mtu '1398'

config interface 'lm_wlan0_ap_bmx6'
	option ifname 'wlan0_ap.12'
	option proto 'none'
	option auto '1'
	option mtu '1398'

config interface 'lm_wlan0_adhoc'
	option proto 'none'
	option mtu '1536'
	option auto '1'

config interface 'lm_wlan0_adhoc_batadv'
	option ifname '@lm_wlan0_adhoc.11'
	option proto 'batadv'
	option mesh 'bat0'
	option mtu '1532'

config interface 'lm_wlan0_adhoc_bmx6'
	option ifname 'wlan0_adhoc.12'
	option proto 'none'
	option auto '1'
	option mtu '1398'


--------------090903090602080604000102
Content-Type: text/plain; charset=UTF-8;
 name="nano-ifconfig"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="nano-ifconfig"

root@ef8bda:~# ifconfig=20
anygw     Link encap:Ethernet  HWaddr AA:AA:AA:8A:15:AD =20
          inet addr:192.0.2.1  Bcast:192.0.2.255  Mask:255.255.255.0
          inet6 addr: 2001:db8::1/64 Scope:Global
          inet6 addr: fe80::a8aa:aaff:fe8a:15ad/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:113 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:6348 (6.1 KiB)  TX bytes:596 (596.0 B)

bat0      Link encap:Ethernet  HWaddr 1E:D2:CB:8B:CB:24 =20
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:48 errors:0 dropped:0 overruns:0 frame:0
          TX packets:72 errors:0 dropped:7 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:2016 (1.9 KiB)  TX bytes:5180 (5.0 KiB)

bmxmain   Link encap:UNSPEC  HWaddr FD-66-00-66-00-66-00-09-00-00-00-00-0=
0-00-00-00 =20
          inet addr:192.0.2.218  P-t-P:192.0.2.218  Mask:255.255.255.255
          inet6 addr: 2001:db8::8bda/128 Scope:Global
          inet6 addr: fe80::de9f:dbff:feef:8bda/64 Scope:Link
          UP POINTOPOINT RUNNING NOARP  MTU:1452  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

br-lan    Link encap:Ethernet  HWaddr DC:9F:DB:EF:8B:DA =20
          inet addr:192.0.2.218  Bcast:192.0.2.255  Mask:255.255.255.0
          inet6 addr: 2001:db8::8bda/64 Scope:Global
          inet6 addr: fe80::de9f:dbff:feef:8bda/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:263 errors:0 dropped:0 overruns:0 frame:0
          TX packets:130 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:21626 (21.1 KiB)  TX bytes:38290 (37.3 KiB)

eth0      Link encap:Ethernet  HWaddr DC:9F:DB:EF:8B:DA =20
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:215 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1532 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:23292 (22.7 KiB)  TX bytes:149303 (145.8 KiB)
          Interrupt:4=20

eth0.11   Link encap:Ethernet  HWaddr DC:9F:DB:EF:8B:DA =20
          inet6 addr: fe80::de9f:dbff:feef:8bda/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1496  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:536 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:35632 (34.7 KiB)

eth0.12   Link encap:Ethernet  HWaddr DC:9F:DB:EF:8B:DA =20
          inet6 addr: fd66:66:66:9:de9f:dbff:feef:8bda/64 Scope:Global
          inet6 addr: fe80::de9f:dbff:feef:8bda/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1398  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:828 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:68893 (67.2 KiB)

eth1      Link encap:Ethernet  HWaddr DE:9F:DB:EF:8B:DA =20
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:5=20

eth1.11   Link encap:Ethernet  HWaddr DE:9F:DB:EF:8B:DA =20
          UP BROADCAST MULTICAST  MTU:1496  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth1.12   Link encap:Ethernet  HWaddr DE:9F:DB:EF:8B:DA =20
          inet6 addr: fd66:66:66:b:de9f:dbff:feef:8bda/64 Scope:Global
          UP BROADCAST MULTICAST  MTU:1398  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:3312 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3312 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:225216 (219.9 KiB)  TX bytes:225216 (219.9 KiB)

wlan0_adhoc Link encap:Ethernet  HWaddr DE:9F:DB:EE:8B:DA =20
          inet6 addr: fe80::dc9f:dbff:feee:8bda/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:833 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 B)  TX bytes:87677 (85.6 KiB)

wlan0_adhoc.12 Link encap:Ethernet  HWaddr DE:9F:DB:EE:8B:DA =20
          inet6 addr: fd66:66:66:10:de9f:dbff:feee:8bda/64 Scope:Global
          inet6 addr: fe80::dc9f:dbff:feee:8bda/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:828 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:68893 (67.2 KiB)

wlan0_ap  Link encap:Ethernet  HWaddr DC:9F:DB:EE:8B:DA =20
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:941 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 B)  TX bytes:95868 (93.6 KiB)

wlan0_ap.12 Link encap:Ethernet  HWaddr DC:9F:DB:EE:8B:DA =20
          inet6 addr: fd66:66:66:e:de9f:dbff:feee:8bda/64 Scope:Global
          inet6 addr: fe80::de9f:dbff:feee:8bda/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:828 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:68893 (67.2 KiB)


--------------090903090602080604000102
Content-Type: text/plain; charset=UTF-8;
 name="nano-ip_a"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="nano-ip_a"

root@ef8bda:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group=
 default=20
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host=20
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master=
 br-lan state UP group default qlen 1000
    link/ether dc:9f:db:ef:8b:da brd ff:ff:ff:ff:ff:ff
3: eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel mast=
er br-lan state DOWN group default qlen 1000
    link/ether de:9f:db:ef:8b:da brd ff:ff:ff:ff:ff:ff
4: ip6tnl0: <NOARP> mtu 1452 qdisc noop state DOWN group default=20
    link/tunnel6 :: brd ::
6: br-lan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state=
 UP group default=20
    link/ether dc:9f:db:ef:8b:da brd ff:ff:ff:ff:ff:ff
    inet 192.0.2.218/24 brd 192.0.2.255 scope global br-lan
       valid_lft forever preferred_lft forever
    inet6 2001:db8::8bda/64 scope global=20
       valid_lft forever preferred_lft forever
    inet6 fe80::de9f:dbff:feef:8bda/64 scope link=20
       valid_lft forever preferred_lft forever
7: anygw@br-lan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue=
 state UP group default=20
    link/ether aa:aa:aa:8a:15:ad brd ff:ff:ff:ff:ff:ff
    inet 192.0.2.1/24 brd 192.0.2.255 scope global anygw
       valid_lft forever preferred_lft forever
    inet6 2001:db8::1/64 scope global=20
       valid_lft forever preferred_lft forever
    inet6 fe80::a8aa:aaff:fe8a:15ad/64 scope link=20
       valid_lft forever preferred_lft forever
8: eth0.11@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1496 qdisc noqueue=
 master bat0 state UP group default=20
    link/ether dc:9f:db:ef:8b:da brd ff:ff:ff:ff:ff:ff
    inet6 fe80::de9f:dbff:feef:8bda/64 scope link=20
       valid_lft forever preferred_lft forever
9: eth0.12@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1398 qdisc noqueue=
 state UP group default=20
    link/ether dc:9f:db:ef:8b:da brd ff:ff:ff:ff:ff:ff
    inet6 fd66:66:66:9:de9f:dbff:feef:8bda/64 scope global=20
       valid_lft forever preferred_lft forever
    inet6 fe80::de9f:dbff:feef:8bda/64 scope link=20
       valid_lft forever preferred_lft forever
10: eth1.11@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1496 qdisc noqu=
eue master bat0 state LOWERLAYERDOWN group default=20
    link/ether de:9f:db:ef:8b:da brd ff:ff:ff:ff:ff:ff
11: eth1.12@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1398 qdisc noqu=
eue state LOWERLAYERDOWN group default=20
    link/ether de:9f:db:ef:8b:da brd ff:ff:ff:ff:ff:ff
    inet6 fd66:66:66:b:de9f:dbff:feef:8bda/64 scope global tentative=20
       valid_lft forever preferred_lft forever
12: bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master=
 br-lan state UNKNOWN group default=20
    link/ether 1e:d2:cb:8b:cb:24 brd ff:ff:ff:ff:ff:ff
13: wlan0_ap: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master =
br-lan state UP group default qlen 1000
    link/ether dc:9f:db:ee:8b:da brd ff:ff:ff:ff:ff:ff
14: wlan0_ap.12@wlan0_ap: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdis=
c noqueue state UP group default=20
    link/ether dc:9f:db:ee:8b:da brd ff:ff:ff:ff:ff:ff
    inet6 fd66:66:66:e:de9f:dbff:feee:8bda/64 scope global=20
       valid_lft forever preferred_lft forever
    inet6 fe80::de9f:dbff:feee:8bda/64 scope link=20
       valid_lft forever preferred_lft forever
15: wlan0_adhoc: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1536 qdisc mq stat=
e UP group default qlen 1000
    link/ether de:9f:db:ee:8b:da brd ff:ff:ff:ff:ff:ff
    inet6 fe80::dc9f:dbff:feee:8bda/64 scope link=20
       valid_lft forever preferred_lft forever
16: wlan0_adhoc.12@wlan0_adhoc: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 150=
0 qdisc noqueue state UP group default=20
    link/ether de:9f:db:ee:8b:da brd ff:ff:ff:ff:ff:ff
    inet6 fd66:66:66:10:de9f:dbff:feee:8bda/64 scope global=20
       valid_lft forever preferred_lft forever
    inet6 fe80::dc9f:dbff:feee:8bda/64 scope link=20
       valid_lft forever preferred_lft forever
17: bmxmain: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1452 qdisc noqueue state=
 UNKNOWN group default=20
    link/tunnel6 fd66:66:66:9:de9f:dbff:feef:8bda peer fd66:66:66:ff00:de=
9f:dbff:feef:8bda
    inet 192.0.2.218/32 scope global bmxmain
       valid_lft forever preferred_lft forever
    inet6 2001:db8::8bda/128 scope global=20
       valid_lft forever preferred_lft forever
    inet6 fe80::de9f:dbff:feef:8bda/64 scope link=20
       valid_lft forever preferred_lft forever

--------------090903090602080604000102
Content-Type: text/plain; charset=UTF-8;
 name="pico-batctl"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pico-batctl"

root@31c136:~# batctl s
	tx: 25
	tx_bytes: 1872
	tx_dropped: 12
	rx: 15
	rx_bytes: 630
	forward: 0
	forward_bytes: 0
	mgmt_tx: 139
	mgmt_tx_bytes: 8870
	mgmt_rx: 0
	mgmt_rx_bytes: 0
	frag_tx: 0
	frag_tx_bytes: 0
	frag_rx: 0
	frag_rx_bytes: 0
	frag_fwd: 0
	frag_fwd_bytes: 0
	tt_request_tx: 0
	tt_request_rx: 0
	tt_response_tx: 0
	tt_response_rx: 0
	tt_roam_adv_tx: 0
	tt_roam_adv_rx: 0
	dat_get_tx: 0
	dat_get_rx: 0
	dat_put_tx: 0
	dat_put_rx: 0
	dat_cached_reply_tx: 0

root@31c136:~# batctl if
eth0.11: active
root@31c136:~# batctl dat
disabled
root@31c136:~# batctl bl
enabled
root@31c136:~# batctl ap
disabled
root@31c136:~# batctl ag
enabled
root@31c136:~# batctl b
disabled
root@31c136:~# batctl f
enabled
root@31c136:~# batctl mark
0x00000000/0x00000000
root@31c136:~# batctl gw
off
root@31c136:~# batctl o
[B.A.T.M.A.N. adv 2014.1.0, MainIF/MAC: eth0.11/dc:9f:db:31:c1:36 (bat0 B=
ATMAN_IV)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   Pot=
ential nexthops ...
No batman nodes in range ...
root@31c136:~# batctl gwl
      Gateway      (#/255)           Nexthop [outgoingIF]: advertised upl=
ink bandwidth ... [B.A.T.M.A.N. adv 2014.1.0, MainIF/MAC: eth0.11/dc:9f:d=
b:31:c1:36 (bat0)]
No gateways in range ...
root@31c136:~# batctl tl
Locally retrieved addresses (from bat0) announced via TT (TTVN: 3):
       Client         VID Flags    Last seen (CRC       )
 * dc:9f:db:31:c1:36   -1 [......] 219.070   (0xf61bea85)
 * 00:1e:8c:65:ef:0b   -1 [......]   8.760   (0xf61bea85)
 * be:17:45:43:f2:e1   -1 [.P....]   0.000   (0xf61bea85)
 * aa:aa:aa:8a:15:ad   -1 [......] 218.710   (0xf61bea85)
 * 00:0c:42:ee:fe:e9   -1 [......]  55.070   (0xf61bea85)
 * be:17:45:43:f2:e1    0 [.P....]   0.000   (0x83bdc53d)
root@31c136:~# batctl tg
Globally announced TT entries received via the mesh bat0
       Client         VID  (TTVN)       Originator      (Curr TTVN) (CRC =
      ) Flags
root@31c136:~# batctl cl
Claims announced for the mesh bat0 (orig dc:9f:db:31:c1:36, group id 0xed=
3d)
   Client               VID      Originator        [o] (CRC   )
root@31c136:~# batctl bbt
Backbones announced for the mesh bat0 (orig dc:9f:db:31:c1:36, group id 0=
xed3d)
   Originator           VID   last seen (CRC   )
root@31c136:~# batctl dc
Distributed ARP Table (bat0):
          IPv4             MAC        VID   last-seen
 *     10.37.133.1 00:1e:8c:65:ef:0b   -1      4:07

--------------090903090602080604000102
Content-Type: text/plain; charset=UTF-8;
 name="pico-brctl"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pico-brctl"

root@31c136:~# brctl show
bridge name	bridge id		STP enabled	interfaces
br-lan		7fff.dc9fdb31c136	no		eth0
							bat0
							wlan0_ap

--------------090903090602080604000102
Content-Type: text/plain; charset=UTF-8;
 name="pico-dmesg"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pico-dmesg"

root@31c136:~# dmesg=20
[    0.000000] Linux version 3.10.15 (ilario@ilario-fisso) (gcc version 4=
=2E6.4 (OpenWrt/Linaro GCC 4.6-2013.05 r38505) ) #1 Sun Mar 30 12:34:05 C=
EST 2014
[    0.000000] MyLoader: sysp=3Dd7bf7fa7, boardp=3D5fe05eaf, parts=3D57ed=
58e6
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU revision is: 00019374 (MIPS 24Kc)
[    0.000000] SoC: Atheros AR7241 rev 1
[    0.000000] Clocks: CPU:390.000MHz, DDR:390.000MHz, AHB:195.000MHz, Re=
f:5.000MHz
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 02000000 @ 00000000 (usable)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x00000000-0x01ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x01ffffff]
[    0.000000] On node 0 totalpages: 8192
[    0.000000] free_area_init_node: node 0, pgdat 8030aa90, node_mem_map =
81000000
[    0.000000]   Normal zone: 64 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 8192 pages, LIFO batch:0
[    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 b=
ytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, lines=
ize 32 bytes
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  To=
tal pages: 8128
[    0.000000] Kernel command line:  board=3DUBNT-BM console=3DttyS0,1152=
00 mtdparts=3Dspi0.0:256k(u-boot)ro,64k(u-boot-env)ro,7552k(firmware),256=
k(cfg)ro,64k(EEPROM)ro rootfstype=3Dsquashfs,jffs2 noinitrd
[    0.000000] PID hash table entries: 128 (order: -3, 512 bytes)
[    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 byt=
es)
[    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes=
)
[    0.000000] Writing ErrCtl register=3D00000000
[    0.000000] Readback ErrCtl register=3D00000000
[    0.000000] Memory: 28784k/32768k available (2223k kernel code, 3984k =
reserved, 594k data, 252k init, 0k highmem)
[    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1,=
 Nodes=3D1
[    0.000000] NR_IRQS:51
[    0.060000] Calibrating delay loop... 259.27 BogoMIPS (lpj=3D1296384)
[    0.070000] pid_max: default: 32768 minimum: 301
[    0.070000] Mount-cache hash table entries: 512
[    0.080000] NET: Registered protocol family 16
[    0.090000] MIPS: machine is Ubiquiti Bullet M
[    0.090000] registering PCI controller with io_map_base unset
[    0.300000] bio: create slab <bio-0> at 0
[    0.310000] PCI host bridge to bus 0000:00
[    0.310000] pci_bus 0000:00: root bus resource [mem 0x10000000-0x13fff=
fff]
[    0.320000] pci_bus 0000:00: root bus resource [io  0x0000]
[    0.320000] pci_bus 0000:00: No busn resource found for root bus, will=
 use [bus 00-ff]
[    0.330000] pci 0000:00:00.0: [168c:002a] type 00 class 0x028000
[    0.330000] pci 0000:00:00.0: fixup device configuration
[    0.330000] pci 0000:00:00.0: reg 10: [mem 0x10000000-0x1000ffff 64bit=
]
[    0.330000] pci 0000:00:00.0: supports D1
[    0.330000] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    0.330000] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 0=
0
[    0.330000] pci 0000:00:00.0: BAR 0: assigned [mem 0x10000000-0x1000ff=
ff 64bit]
[    0.340000] pci 0000:00:00.0: using irq 40 for pin 1
[    0.340000] Switching to clocksource MIPS
[    0.350000] NET: Registered protocol family 2
[    0.350000] TCP established hash table entries: 512 (order: 0, 4096 by=
tes)
[    0.360000] TCP bind hash table entries: 512 (order: -1, 2048 bytes)
[    0.370000] TCP: Hash tables configured (established 512 bind 512)
[    0.370000] TCP: reno registered
[    0.380000] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.380000] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.390000] NET: Registered protocol family 1
[    0.390000] PCI: CLS 0 bytes, default 32
[    0.410000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.420000] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_=
PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    0.430000] msgmni has been set to 56
[    0.430000] io scheduler noop registered
[    0.440000] io scheduler deadline registered (default)
[    0.440000] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
[    0.470000] serial8250.0: ttyS0 at MMIO 0x18020000 (irq =3D 11) is a 1=
6550A
[    0.480000] console [ttyS0] enabled, bootconsole disabled
[    0.490000] ath79-spi ath79-spi: master is unqueued, this is deprecate=
d
[    0.500000] m25p80 spi0.0: found s25fl064k, expected m25p80
[    0.500000] m25p80 spi0.0: s25fl064k (8192 Kbytes)
[    0.510000] 5 cmdlinepart partitions found on MTD device spi0.0
[    0.510000] Creating 5 MTD partitions on "spi0.0":
[    0.520000] 0x000000000000-0x000000040000 : "u-boot"
[    0.530000] 0x000000040000-0x000000050000 : "u-boot-env"
[    0.530000] 0x000000050000-0x0000007b0000 : "firmware"
[    0.550000] 2 uimage-fw partitions found on MTD device firmware
[    0.550000] 0x000000050000-0x00000014b34a : "kernel"
[    0.560000] mtd: partition "kernel" must either start or end on erase =
block boundary or be smaller than an erase block -- forcing read-only
[    0.570000] 0x00000014b34a-0x0000007b0000 : "rootfs"
[    0.580000] mtd: partition "rootfs" must either start or end on erase =
block boundary or be smaller than an erase block -- forcing read-only
[    0.590000] mtd: partition "rootfs" set to be root filesystem
[    0.600000] 1 squashfs-split partitions found on MTD device rootfs
[    0.610000] 0x0000003e0000-0x0000007b0000 : "rootfs_data"
[    0.610000] 0x0000007b0000-0x0000007f0000 : "cfg"
[    0.620000] 0x0000007f0000-0x000000800000 : "EEPROM"
[    0.630000] libphy: ag71xx_mdio: probed
[    0.640000] eth0: Atheros AG71xx at 0xb9000000, irq 4, mode:MII
[    1.200000] ag71xx ag71xx.0 eth0: connected to PHY at ag71xx-mdio.1:04=
 [uid=3D004dd041, driver=3DGeneric PHY]
[    1.210000] TCP: cubic registered
[    1.210000] NET: Registered protocol family 17
[    1.220000] Bridge firewalling registered
[    1.220000] 8021q: 802.1Q VLAN Support v1.8
[    1.230000] VFS: Mounted root (squashfs filesystem) readonly on device=
 31:4.
[    1.240000] Freeing unused kernel memory: 252K (80321000 - 80360000)
[    4.370000] usbcore: registered new interface driver usbfs
[    4.370000] usbcore: registered new interface driver hub
[    4.380000] usbcore: registered new device driver usb
[    4.390000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver=

[    4.400000] ehci-platform: EHCI generic platform driver
[    4.410000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    7.240000] eth0: link up (100Mbps/Full duplex)
[    7.930000] jffs2: notice: (292) jffs2_build_xattr_subsystem: complete=
 building xattr subsystem, 1 of xdatum (0 unchecked, 0 orphan) and 24 of =
xref (0 dead, 8 orphan) found.
[    7.960000] eth0: link down
[   10.220000] NET: Registered protocol family 10
[   10.230000] tun: Universal TUN/TAP device driver, 1.6
[   10.240000] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   10.270000] nf_conntrack version 0.5.0 (453 buckets, 1812 max)
[   10.290000] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   10.350000] batman_adv: B.A.T.M.A.N. advanced 2014.1.0 (compatibility =
version 15) loaded
[   10.390000] Loading modules backported from Linux version master-2013-=
06-27-0-gdcfa6d5
[   10.400000] Backport generated by backports.git backports-20130617-4-g=
e3220f5
[   10.440000] Ebtables v2.0 registered
[   10.460000] ip_tables: (C) 2000-2006 Netfilter Core Team
[   10.650000] xt_time: kernel timezone is -0000
[   10.770000] cfg80211: Calling CRDA to update world regulatory domain
[   10.770000] cfg80211: World regulatory domain updated:
[   10.780000] cfg80211:   (start_freq - end_freq @ bandwidth), (max_ante=
nna_gain, max_eirp)
[   10.790000] cfg80211:   (2400000 KHz - 2483000 KHz @ 40000 KHz), (N/A,=
 3000 mBm)
[   10.790000] cfg80211:   (5140000 KHz - 5860000 KHz @ 40000 KHz), (N/A,=
 3000 mBm)
[   10.850000] PCI: Enabling device 0000:00:00.0 (0000 -> 0002)
[   10.860000] ath: EEPROM regdomain: 0x0
[   10.860000] ath: EEPROM indicates default country code should be used
[   10.860000] ath: doing EEPROM country->regdmn map search
[   10.860000] ath: country maps to regdmn code: 0x3a
[   10.860000] ath: Country alpha2 being used: US
[   10.860000] ath: Regpair used: 0x3a
[   10.880000] ieee80211 phy0: Selected rate control algorithm 'minstrel_=
ht'
[   10.880000] cfg80211: Calling CRDA for country: US
[   10.890000] ieee80211 phy0: Atheros AR9280 Rev:2 mem=3D0xb0000000, irq=
=3D40
[   10.900000] cfg80211: Regulatory domain changed to country: US
[   10.900000] cfg80211:   (start_freq - end_freq @ bandwidth), (max_ante=
nna_gain, max_eirp)
[   10.910000] cfg80211:   (2400000 KHz - 2483000 KHz @ 40000 KHz), (N/A,=
 3000 mBm)
[   10.920000] cfg80211:   (5140000 KHz - 5860000 KHz @ 40000 KHz), (N/A,=
 3000 mBm)
[   15.790000] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   15.790000] device eth0 entered promiscuous mode
[   15.800000] IPv6: ADDRCONF(NETDEV_UP): br-lan: link is not ready
[   15.830000] device br-lan entered promiscuous mode
[   15.840000] IPv6: ADDRCONF(NETDEV_UP): anygw: link is not ready
[   15.910000] IPv6: ADDRCONF(NETDEV_UP): eth0.11: link is not ready
[   15.950000] IPv6: ADDRCONF(NETDEV_UP): eth0.12: link is not ready
[   16.210000] batman_adv: bat0: Adding interface: eth0.11
[   16.220000] batman_adv: bat0: The MTU of interface eth0.11 is too smal=
l (1496) to handle the transport of batman-adv packets. Packets going ove=
r this interface will be fragmented on layer2 which could impact the perf=
ormance. Setting the MTU to 1532 would solve the problem.
[   16.240000] batman_adv: bat0: Interface activated: eth0.11
[   16.250000] 8021q: adding VLAN 0 to HW filter on device bat0
[   16.290000] device bat0 entered promiscuous mode
[   16.290000] br-lan: port 2(bat0) entered forwarding state
[   16.300000] br-lan: port 2(bat0) entered forwarding state
[   16.300000] IPv6: ADDRCONF(NETDEV_CHANGE): br-lan: link becomes ready
[   16.340000] IPv6: ADDRCONF(NETDEV_CHANGE): anygw: link becomes ready
[   16.400000] eth0: link up (100Mbps/Full duplex)
[   16.400000] br-lan: port 1(eth0) entered forwarding state
[   16.410000] br-lan: port 1(eth0) entered forwarding state
[   16.410000] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   16.440000] IPv6: ADDRCONF(NETDEV_CHANGE): eth0.11: link becomes ready=

[   16.440000] IPv6: ADDRCONF(NETDEV_CHANGE): eth0.12: link becomes ready=

[   17.360000] batman_adv: bat0: bridge_loop_avoidance: Changing from: di=
sabled to: enabled
[   17.400000] batman_adv: bat0: distributed_arp_table: Changing from: en=
abled to: disabled
[   18.300000] br-lan: port 2(bat0) entered forwarding state
[   18.410000] br-lan: port 1(eth0) entered forwarding state
[   21.330000] IPv6: ADDRCONF(NETDEV_UP): wlan0_ap: link is not ready
[   21.330000] IPv6: ADDRCONF(NETDEV_UP): wlan0_ap.12: link is not ready
[   26.240000] br-lan: received packet on bat0 with own address as source=
 address
[   29.270000] device wlan0_ap entered promiscuous mode
[   29.310000] IPv6: ADDRCONF(NETDEV_UP): wlan0_ap.12: link is not ready
[   29.310000] IPv6: ADDRCONF(NETDEV_UP): wlan0_ap: link is not ready
[   29.330000] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0_ap: link becomes read=
y
[   29.360000] br-lan: port 3(wlan0_ap) entered forwarding state
[   29.360000] br-lan: port 3(wlan0_ap) entered forwarding state
[   29.380000] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0_ap.12: link becomes r=
eady
[   31.360000] br-lan: port 3(wlan0_ap) entered forwarding state
[   32.940000] device wlan0_adhoc entered promiscuous mode
[   32.940000] IPv6: ADDRCONF(NETDEV_UP): wlan0_adhoc: link is not ready
[   32.960000] wlan0_adhoc: Created IBSS using preconfigured BSSID ca:fe:=
00:c0:ff:ee
[   32.970000] wlan0_adhoc: Creating new IBSS network, BSSID ca:fe:00:c0:=
ff:ee
[   32.980000] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0_adhoc: link becomes r=
eady
[   36.260000] br-lan: received packet on bat0 with own address as source=
 address
[   46.280000] br-lan: received packet on bat0 with own address as source=
 address
[   56.300000] br-lan: received packet on bat0 with own address as source=
 address
[   66.320000] br-lan: received packet on bat0 with own address as source=
 address
[   76.340000] br-lan: received packet on bat0 with own address as source=
 address
[   86.360000] br-lan: received packet on bat0 with own address as source=
 address
[   96.380000] br-lan: received packet on bat0 with own address as source=
 address
[  106.400000] br-lan: received packet on bat0 with own address as source=
 address
[  116.420000] br-lan: received packet on bat0 with own address as source=
 address
[  126.440000] br-lan: received packet on bat0 with own address as source=
 address

--------------090903090602080604000102
Content-Type: text/plain; charset=UTF-8;
 name="pico-etc-config-network"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pico-etc-config-network"

root@31c136:~# cat /etc/config/network=20

config interface 'loopback'
	option ifname 'lo'
	option proto 'static'
	option ipaddr '127.0.0.1'
	option netmask '255.0.0.0'

config globals 'globals'

config interface 'lan'
	option type 'bridge'
	option proto 'static'
	option netmask '255.255.255.0'
	option ip6assign '60'
	option ip6addr '2001:DB8:0:0:0:0:0:C136/64'
	option ipaddr '192.0.2.54'
	option mtu '1500'
	list ifname 'bat0'
	list ifname 'eth0'
	list ifname 'wlan0_ap'

config device 'lm_anygw_dev'
	option type 'macvlan'
	option name 'anygw'
	option ifname '@lan'
	option macaddr 'aa:aa:aa:8a:15:ad'

config interface 'lm_anygw_if'
	option proto 'static'
	option ifname 'anygw'
	option ip6addr '2001:DB8:0:0:0:0:0:1/64'
	option ipaddr '192.0.2.1'
	option netmask '255.255.255.0'

config interface 'lm_eth0_batadv'
	option ifname 'eth0.11'
	option proto 'batadv'
	option mesh 'bat0'
	option mtu '1496'

config interface 'lm_eth0_bmx6'
	option ifname 'eth0.12'
	option proto 'none'
	option auto '1'
	option mtu '1398'

config interface 'lm_wlan0_ap_bmx6'
	option ifname 'wlan0_ap.12'
	option proto 'none'
	option auto '1'
	option mtu '1398'

config interface 'lm_wlan0_adhoc'
	option proto 'none'
	option mtu '1536'
	option auto '1'

config interface 'lm_wlan0_adhoc_batadv'
	option ifname '@lm_wlan0_adhoc.11'
	option proto 'batadv'
	option mesh 'bat0'
	option mtu '1532'

config interface 'lm_wlan0_adhoc_bmx6'
	option ifname 'wlan0_adhoc.12'
	option proto 'none'
	option auto '1'
	option mtu '1398'



--------------090903090602080604000102
Content-Type: text/plain; charset=UTF-8;
 name="pico-ifconfig"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pico-ifconfig"

root@31c136:~# ifconfig=20
anygw     Link encap:Ethernet  HWaddr AA:AA:AA:8A:15:AD =20
          inet addr:192.0.2.1  Bcast:192.0.2.255  Mask:255.255.255.0
          inet6 addr: 2001:db8::1/64 Scope:Global
          inet6 addr: fe80::a8aa:aaff:fe8a:15ad/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:85 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:4799 (4.6 KiB)  TX bytes:526 (526.0 B)

bat0      Link encap:Ethernet  HWaddr BE:17:45:43:F2:E1 =20
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:33 errors:0 dropped:0 overruns:0 frame:0
          TX packets:55 errors:0 dropped:12 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:1386 (1.3 KiB)  TX bytes:3837 (3.7 KiB)

br-lan    Link encap:Ethernet  HWaddr DC:9F:DB:31:C1:36 =20
          inet addr:192.0.2.54  Bcast:192.0.2.255  Mask:255.255.255.0
          inet6 addr: fe80::de9f:dbff:fe31:c136/64 Scope:Link
          inet6 addr: 2001:db8::c136/64 Scope:Global
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:496 errors:0 dropped:0 overruns:0 frame:0
          TX packets:307 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:47337 (46.2 KiB)  TX bytes:78580 (76.7 KiB)

eth0      Link encap:Ethernet  HWaddr DC:9F:DB:31:C1:36 =20
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:464 errors:0 dropped:0 overruns:0 frame:0
          TX packets:719 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:52937 (51.6 KiB)  TX bytes:107147 (104.6 KiB)
          Interrupt:4=20

eth0.11   Link encap:Ethernet  HWaddr DC:9F:DB:31:C1:36 =20
          inet6 addr: fe80::de9f:dbff:fe31:c136/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1496  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:378 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:25547 (24.9 KiB)

eth0.12   Link encap:Ethernet  HWaddr DC:9F:DB:31:C1:36 =20
          inet6 addr: fe80::de9f:dbff:fe31:c136/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1398  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:408 (408.0 B)

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:2112 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2112 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:143616 (140.2 KiB)  TX bytes:143616 (140.2 KiB)

wlan0_adhoc Link encap:Ethernet  HWaddr DE:9F:DB:30:C1:36 =20
          inet6 addr: fe80::dc9f:dbff:fe30:c136/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 B)  TX bytes:844 (844.0 B)

wlan0_adhoc.12 Link encap:Ethernet  HWaddr DC:9F:DB:30:C1:36 =20
          inet6 addr: fe80::de9f:dbff:fe30:c136/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:298 (298.0 B)

wlan0_ap  Link encap:Ethernet  HWaddr DC:9F:DB:30:C1:36 =20
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:83 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 B)  TX bytes:6389 (6.2 KiB)

wlan0_ap.12 Link encap:Ethernet  HWaddr DC:9F:DB:30:C1:36 =20
          inet6 addr: fe80::de9f:dbff:fe30:c136/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:478 (478.0 B)


--------------090903090602080604000102
Content-Type: text/plain; charset=UTF-8;
 name="pico-ip_a"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pico-ip_a"

root@31c136:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group=
 default=20
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host=20
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master=
 br-lan state UP group default qlen 1000
    link/ether dc:9f:db:31:c1:36 brd ff:ff:ff:ff:ff:ff
3: ip6tnl0: <NOARP> mtu 1452 qdisc noop state DOWN group default=20
    link/tunnel6 :: brd ::
5: br-lan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state=
 UP group default=20
    link/ether dc:9f:db:31:c1:36 brd ff:ff:ff:ff:ff:ff
    inet 192.0.2.54/24 brd 192.0.2.255 scope global br-lan
       valid_lft forever preferred_lft forever
    inet6 2001:db8::c136/64 scope global=20
       valid_lft forever preferred_lft forever
    inet6 fe80::de9f:dbff:fe31:c136/64 scope link=20
       valid_lft forever preferred_lft forever
6: anygw@br-lan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue=
 state UP group default=20
    link/ether aa:aa:aa:8a:15:ad brd ff:ff:ff:ff:ff:ff
    inet 192.0.2.1/24 brd 192.0.2.255 scope global anygw
       valid_lft forever preferred_lft forever
    inet6 2001:db8::1/64 scope global=20
       valid_lft forever preferred_lft forever
    inet6 fe80::a8aa:aaff:fe8a:15ad/64 scope link=20
       valid_lft forever preferred_lft forever
7: eth0.11@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1496 qdisc noqueue=
 master bat0 state UP group default=20
    link/ether dc:9f:db:31:c1:36 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::de9f:dbff:fe31:c136/64 scope link=20
       valid_lft forever preferred_lft forever
8: eth0.12@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1398 qdisc noqueue=
 state UP group default=20
    link/ether dc:9f:db:31:c1:36 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::de9f:dbff:fe31:c136/64 scope link=20
       valid_lft forever preferred_lft forever
9: bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master =
br-lan state UNKNOWN group default=20
    link/ether be:17:45:43:f2:e1 brd ff:ff:ff:ff:ff:ff
10: wlan0_ap: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master =
br-lan state UP group default qlen 1000
    link/ether dc:9f:db:30:c1:36 brd ff:ff:ff:ff:ff:ff
11: wlan0_ap.12@wlan0_ap: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdis=
c noqueue state UP group default=20
    link/ether dc:9f:db:30:c1:36 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::de9f:dbff:fe30:c136/64 scope link=20
       valid_lft forever preferred_lft forever
12: wlan0_adhoc: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1536 qdisc mq stat=
e UP group default qlen 1000
    link/ether de:9f:db:30:c1:36 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::dc9f:dbff:fe30:c136/64 scope link=20
       valid_lft forever preferred_lft forever
13: wlan0_adhoc.12@wlan0_adhoc: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 150=
0 qdisc noqueue state UP group default=20
    link/ether dc:9f:db:30:c1:36 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::de9f:dbff:fe30:c136/64 scope link=20
       valid_lft forever preferred_lft forever


--------------090903090602080604000102--

--quvb3Ricj58vCrkXxGEkA1PhqXwE7TXJv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM5y8EACgkQifrzB0y7qpb2TwCgq1V8t7qDzsIwKOc2HOMrg2CN
qB0AnRqmPOjxRWl9tWcr4PJqsoGouvOK
=ND7C
-----END PGP SIGNATURE-----

--quvb3Ricj58vCrkXxGEkA1PhqXwE7TXJv--
