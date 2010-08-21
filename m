Return-Path: <Timbo2001@web.de>
Message-ID: <4C6F89B0.2040506@web.de>
Date: Sat, 21 Aug 2010 10:09:20 +0200
From: Tim <Timbo2001@web.de>
MIME-Version: 1.0
References: <mailman.33.1282337388.934.b.a.t.m.a.n@lists.open-mesh.org>
In-Reply-To: <mailman.33.1282337388.934.b.a.t.m.a.n@lists.open-mesh.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: Timbo2001@web.de
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

Hi everybody,

> Ok, could you please try the attached patch? Just add it to the other pat=
ches
> (you can omit 03-... after a successful test. But it may reveal interesti=
ng
> information if that wasn't the actual problem). Don't forget to cleanup y=
our
> openwrt build environment.
>
> Best regards,
> 	Sven
>   =20

the patch seems to work. Just did some basic testing and was able to=20
build up a network, even with the devices running older versions.
I will continue testing within the next few days, but now I need to=20
focus on creating a presentation for Wednesday.

I also added the output of dmesg:

root@OpenWrt:/# dmesg
Linux version 2.6.32.16 (tim@atze) (gcc version 4.3.3 (GCC) ) #1 Fri Aug=20
20 20:56:09 CEST 2010
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
free_area_init_node: node 0, pgdat 802a5b50, node_mem_map 802eb000
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
Memory: 13236k/16384k available (2231k kernel code, 3148k reserved, 476k=20
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
msgmni has been set to 25
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
  CFI mfr 0x000000c2
  CFI id  0x000022a8
  Amd/Fujitsu Extended Query Table at 0x0040
   Amd/Fujitsu Extended Query version 1.1.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Flash device: 0x400000 at 0x1fc00000
bootloader size: 262144
Creating 4 MTD partitions on "Physically mapped flash":
0x000000000000-0x000000040000 : "cfe"
0x000000040000-0x0000003f0000 : "linux"
0x000000122c00-0x0000003f0000 : "rootfs"
mtd: partition "rootfs" must either start or end on erase block boundary=20
or be smaller than an erase block -- forcing read-only
mtd: partition "rootfs" set to be root filesystem
mtd: partition "rootfs_data" created automatically, ofs=3D2A0000, len=3D150=
000
0x0000002a0000-0x0000003f0000 : "rootfs_data"
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
mini_fo: using storage directory: /overlay
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
cfg80211: World regulatory domain updated:
     (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
     (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
     (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
     (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
     (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
     (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
phy0: Selected rate control algorithm 'minstrel'
Registered led device: b43-phy0::tx
Registered led device: b43-phy0::rx
Registered led device: b43-phy0::radio
Broadcom 43xx driver loaded [ Features: PL, Firmware-ID: FW13 ]
Broadcom 43xx-legacy driver loaded [ Features: PLID, Firmware-ID: FW10 ]
PPP generic driver version 2.4.2
ip_tables: (C) 2000-2006 Netfilter Core Team
NET: Registered protocol family 24
nf_conntrack version 0.5.0 (208 buckets, 832 max)
batman-adv-dbg: go through if_list
batman-adv-dbg: final min_mtu is 1500
batman-adv-dbg: got event 5 for net_dev 80845c00
batman-adv-dbg: will add net_device 80845c00 to if_list
batman-adv-dbg: got batman_if (null) for net_dev 80845c00
batman-adv-dbg: got event 1 for net_dev 80845c00
batman-adv-dbg: got batman_if (null) for net_dev 80845c00
batman-adv-dbg: got event 5 for net_dev 8086f000
batman-adv-dbg: will add net_device 8086f000 to if_list
batman-adv-dbg: added net_device 8086f000 to if_list as 8042b900
batman-adv-dbg: got batman_if 8042b900 for net_dev 8086f000
batman-adv-dbg: got event 1 for net_dev 8086f000
batman-adv-dbg: got batman_if 8042b900 for net_dev 8086f000
batman-adv-dbg: hardif_activate_interface(8054eec0, 8042b900)
batman-adv-dbg: got event 5 for net_dev 80f0d800
batman-adv-dbg: will add net_device 80f0d800 to if_list
batman-adv-dbg: added net_device 80f0d800 to if_list as 8042b880
batman-adv-dbg: got batman_if 8042b880 for net_dev 80f0d800
batman-adv-dbg: got event 1 for net_dev 80f0d800
batman-adv-dbg: got batman_if 8042b880 for net_dev 80f0d800
batman-adv-dbg: hardif_activate_interface(8054eec0, 8042b880)
batman-adv-dbg: got event 5 for net_dev 808e9000
batman-adv-dbg: will add net_device 808e9000 to if_list
batman-adv-dbg: added net_device 808e9000 to if_list as 8042b800
batman-adv-dbg: got batman_if 8042b800 for net_dev 808e9000
batman-adv-dbg: got event 1 for net_dev 808e9000
batman-adv-dbg: got batman_if 8042b800 for net_dev 808e9000
batman-adv-dbg: hardif_activate_interface(8054eec0, 8042b800)
batman-adv-dbg: got event 5 for net_dev 80d03000
batman-adv-dbg: will add net_device 80d03000 to if_list
batman-adv-dbg: added net_device 80d03000 to if_list as 8042b780
batman-adv-dbg: got batman_if 8042b780 for net_dev 80d03000
batman-adv-dbg: got event 1 for net_dev 80d03000
batman-adv-dbg: got batman_if 8042b780 for net_dev 80d03000
batman-adv-dbg: hardif_activate_interface(8054eec0, 8042b780)
batman-adv-dbg: got event 5 for net_dev 80c74800
batman-adv-dbg: will add net_device 80c74800 to if_list
batman-adv-dbg: added net_device 80c74800 to if_list as 8042b700
batman-adv-dbg: got batman_if 8042b700 for net_dev 80c74800
batman-adv-dbg: got event 5 for net_dev 8054ec00
batman-adv-dbg: will add net_device 8054ec00 to if_list
batman-adv-dbg: got batman_if (null) for net_dev 8054ec00
batman-adv:B.A.T.M.A.N. advanced 2010.0.0 (compatibility version 8) loaded
batman-adv-dbg: got event 13 for net_dev 8054ec00
batman-adv-dbg: got batman_if (null) for net_dev 8054ec00
batman-adv-dbg: got event 1 for net_dev 8054ec00
batman-adv-dbg: got batman_if (null) for net_dev 8054ec00
device bat0 entered promiscuous mode
br-lan: port 2(bat0) entering forwarding state
batman-adv-dbg: got event 6 for net_dev 80c74800
batman-adv-dbg: got batman_if 8042b700 for net_dev 80c74800
batman-adv-dbg: hardif_remove_interface(8042b700)
batman-adv-dbg: will remove batman_if 8042b700
batman-adv-dbg: putted netdev 80c74800 of batman_if 8042b700
batman-adv-dbg: removed batman_if 8042b700
batman-adv-dbg: got event 5 for net_dev 80c74800
batman-adv-dbg: will add net_device 80c74800 to if_list
batman-adv-dbg: added net_device 80c74800 to if_list as 8042be80
batman-adv-dbg: got batman_if 8042be80 for net_dev 80c74800
batman-adv-dbg: got event 8 for net_dev 80c74800
batman-adv-dbg: got batman_if 8042be80 for net_dev 80c74800
batman-adv-dbg: got event 13 for net_dev 80c74800
batman-adv-dbg: got batman_if 8042be80 for net_dev 80c74800
b43-phy0: Loading firmware version 410.2160 (2007-05-26 15:32:10)
batman-adv-dbg: got event 1 for net_dev 80c74800
batman-adv-dbg: got batman_if 8042be80 for net_dev 80c74800
batman-adv-dbg: hardif_activate_interface(8054eec0, 8042be80)
batman-adv-dbg: got event 7 for net_dev 80c74800
batman-adv-dbg: got batman_if 8042be80 for net_dev 80c74800
wlan0: Creating new IBSS network, BSSID 02:12:34:56:78:9a
batman-adv:Adding interface: wlan0
batman-adv:Interface activated: wlan0
batman-adv-dbg: update_min_mtu for softdevice 8054ec00
batman-adv-dbg: go through if_list
batman-adv-dbg: check batman_if 8042b900
batman-adv-dbg: batman_if 8042b900 has status 0
batman-adv-dbg: batman_if 8042b900 round got min_mtu 1500
batman-adv-dbg: check batman_if 8042b880
batman-adv-dbg: batman_if 8042b880 has status 0
batman-adv-dbg: batman_if 8042b880 round got min_mtu 1500
batman-adv-dbg: check batman_if 8042b800
batman-adv-dbg: batman_if 8042b800 has status 0
batman-adv-dbg: batman_if 8042b800 round got min_mtu 1500
batman-adv-dbg: check batman_if 8042b780
batman-adv-dbg: batman_if 8042b780 has status 0
batman-adv-dbg: batman_if 8042b780 round got min_mtu 1500
batman-adv-dbg: check batman_if 8042be80
batman-adv-dbg: batman_if 8042be80 has status 4
batman-adv-dbg: compare batman_if 8042be80 with net_dev 80c74800
batman-adv-dbg: compare batman_if 8042be80 with 1524 against 1500
batman-adv-dbg: batman_if 8042be80 round got min_mtu 1500
batman-adv-dbg: final min_mtu is 1500
batman-adv-dbg: found min_mtu 1500
batman-adv-dbg: update_min_mtu for softdevice 8054ec00
batman-adv-dbg: go through if_list
batman-adv-dbg: check batman_if 8042b900
batman-adv-dbg: batman_if 8042b900 has status 0
batman-adv-dbg: batman_if 8042b900 round got min_mtu 1500
batman-adv-dbg: check batman_if 8042b880
batman-adv-dbg: batman_if 8042b880 has status 0
batman-adv-dbg: batman_if 8042b880 round got min_mtu 1500
batman-adv-dbg: check batman_if 8042b800
batman-adv-dbg: batman_if 8042b800 has status 0
batman-adv-dbg: batman_if 8042b800 round got min_mtu 1500
batman-adv-dbg: check batman_if 8042b780
batman-adv-dbg: batman_if 8042b780 has status 0
batman-adv-dbg: batman_if 8042b780 round got min_mtu 1500
batman-adv-dbg: check batman_if 8042be80
batman-adv-dbg: batman_if 8042be80 has status 4
batman-adv-dbg: compare batman_if 8042be80 with net_dev 80c74800
batman-adv-dbg: compare batman_if 8042be80 with 1524 against 1500
batman-adv-dbg: batman_if 8042be80 round got min_mtu 1500
batman-adv-dbg: final min_mtu is 1500
batman-adv-dbg: found min_mtu 1500
root@OpenWrt:/#


Greetings,
Tim

