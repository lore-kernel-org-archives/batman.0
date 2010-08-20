Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 20 Aug 2010 16:44:57 +0200
References: <4C6B80D2.9040906@web.de>
	<201008201211.51847.sven.eckelmann@gmx.de>
	<4C6E8B79.7040801@web.de>
In-Reply-To: <4C6E8B79.7040801@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15107309.rourLgpGLv";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008201644.58520.sven.eckelmann@gmx.de>
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
To: Tim <Timbo2001@web.de>
Cc: b.a.t.m.a.n@lists.open-mesh.net

--nextPart15107309.rourLgpGLv
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Tim wrote:
> root@OpenWrt:/# dmesg
>   8kB, 2-way, VIPT, no aliases, linesize 16 bytes
> Memory: 13236k/16384k available (2231k kernel code, 3148k reserved, 476k
> data, 136k init, 0k highmem)
> Hierarchical RCU implementation.
> NR_IRQS:128
> console [ttyS0] enabled
> Calibrating delay loop... 199.16 BogoMIPS (lpj=3D398336)
> Mount-cache hash table entries: 512
> NET: Registered protocol family 16
> bio: create slab <bio-0> at 0
> Switching to clocksource MIPS
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 512 (order: 0, 4096 bytes)
> TCP bind hash table entries: 512 (order: -1, 2048 bytes)
> TCP: Hash tables configured (established 512 bind 512)
> TCP reno registered
> NET: Registered protocol family 1
> squashfs: version 4.0 (2009/01/31) Phillip Lougher
> Registering mini_fo version $Id$
> JFFS2 version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat, Inc.
> msgmni has been set to 25
> io scheduler noop registered
> io scheduler deadline registered (default)
> Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
> serial8250: ttyS0 at MMIO 0xb8000300 (irq =3D 3) is a 16550A
> serial8250: ttyS1 at MMIO 0xb8000400 (irq =3D 3) is a 16550A
> serial8250.0: ttyS0 at MMIO 0xb8000300 (irq =3D 3) is a 16550A
> serial8250.0: ttyS1 at MMIO 0xb8000400 (irq =3D 3) is a 16550A
> flash init: 0x1c000000 0x02000000
> Physically mapped flash: Found 1 x16 devices at 0x0 in 16-bit bank
> Physically mapped flash: Found an alias at 0x400000 for the chip at 0x0
> Physically mapped flash: Found an alias at 0x800000 for the chip at 0x0
> Physically mapped flash: Found an alias at 0xc00000 for the chip at 0x0
> Physically mapped flash: Found an alias at 0x1000000 for the chip at 0x0
> Physically mapped flash: Found an alias at 0x1400000 for the chip at 0x0
> Physically mapped flash: Found an alias at 0x1800000 for the chip at 0x0
> Physically mapped flash: Found an alias at 0x1c00000 for the chip at 0x0
>   CFI mfr 0x000000c2
>   CFI id  0x000022a8
>   Amd/Fujitsu Extended Query Table at 0x0040
>    Amd/Fujitsu Extended Query version 1.1.
> number of CFI chips: 1
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> Flash device: 0x400000 at 0x1fc00000
> bootloader size: 262144
> Updating TRX offsets and length:
> old trx =3D [0x0000001c, 0x00000974, 0x000e2c00], len=3D0x00281000
> crc32=3D0x16ba3b2e
> new trx =3D [0x0000001c, 0x00000974, 0x000e2c00], len=3D0x000e2c00
> crc32=3D0x0ecec672
> Done
> Creating 4 MTD partitions on "Physically mapped flash":
> 0x000000000000-0x000000040000 : "cfe"
> 0x000000040000-0x0000003f0000 : "linux"
> 0x000000122c00-0x0000003f0000 : "rootfs"
> mtd: partition "rootfs" must either start or end on erase block boundary
> or be smaller than an erase block -- forcing read-only
> mtd: partition "rootfs" set to be root filesystem
> mtd: partition "rootfs_data" created automatically, ofs=3D2A0000, len=3D1=
50000
> 0x0000002a0000-0x0000003f0000 : "rootfs_data"
> 0x0000003f0000-0x000000400000 : "nvram"
> b44.c:v2.0
> eth0: Broadcom 44xx/47xx 10/100BaseT Ethernet 00:25:9c:3c:46:04
> BCM47xx Watchdog Timer enabled (30 seconds, nowayout)
> TCP westwood registered
> NET: Registered protocol family 17
> 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
> All bugs added by David S. Miller <davem@redhat.com>
> VFS: Mounted root (squashfs filesystem) readonly on device 31:2.
> Freeing unused kernel memory: 136k freed
> Please be patient, while OpenWrt loads ...
> diag: Detected 'Linksys WRT54G/GS/GL'
> b44: eth0: Link is up at 100 Mbps, full duplex.
> b44: eth0: Flow control is off for TX and off for RX.
> roboswitch: Probing device eth0: found a 5325! It's a 5350.
> mini_fo: using base directory: /
> mini_fo: using storage directory: /tmp/root
> b44: eth0: powering down PHY
> b44: eth0: Link is up at 100 Mbps, full duplex.
> b44: eth0: Flow control is off for TX and off for RX.
> device eth0.0 entered promiscuous mode
> device eth0 entered promiscuous mode
> br-lan: port 1(eth0.0) entering forwarding state
> Compat-wireless backport release: compat-wireless-2010-07-13-4-g04898a5
> Backport based on wireless-2.6.git v2.6.35-rc6-48432-gdce358e
> cfg80211: Calling CRDA to update world regulatory domain
> cfg80211: World regulatory domain updated:
>      (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
>      (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>      (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
>      (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
>      (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
>      (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
> b43-phy0: Broadcom 5352 WLAN found (core revision 9)
> phy0: Selected rate control algorithm 'minstrel'
> Registered led device: b43-phy0::tx
> Registered led device: b43-phy0::rx
> Registered led device: b43-phy0::radio
> Broadcom 43xx driver loaded [ Features: PL, Firmware-ID: FW13 ]
> Broadcom 43xx-legacy driver loaded [ Features: PLID, Firmware-ID: FW10 ]
> PPP generic driver version 2.4.2
> ip_tables: (C) 2000-2006 Netfilter Core Team
> NET: Registered protocol family 24
> nf_conntrack version 0.5.0 (208 buckets, 832 max)
> batman-adv-dbg: go through if_list
> batman-adv-dbg: final min_mtu is 1500
> batman-adv-dbg: got event 5 for net_dev 80845c00
> batman-adv-dbg: will add net_device 80845c00 to if_list
> batman-adv-dbg: got batman_if (null) for net_dev 80845c00
> batman-adv-dbg: got event 1 for net_dev 80845c00
> batman-adv-dbg: got batman_if (null) for net_dev 80845c00
> batman-adv-dbg: got event 5 for net_dev 8086f000
> batman-adv-dbg: will add net_device 8086f000 to if_list
> batman-adv-dbg: added net_device 8086f000 to if_list as 80e7a900
> batman-adv-dbg: got batman_if 80e7a900 for net_dev 8086f000
> batman-adv-dbg: got event 1 for net_dev 8086f000
> batman-adv-dbg: got batman_if 80e7a900 for net_dev 8086f000
> batman-adv-dbg: hardif_activate_interface(80549ec0, 80e7a900)
> batman-adv-dbg: got event 5 for net_dev 80c16800
> batman-adv-dbg: will add net_device 80c16800 to if_list
> batman-adv-dbg: added net_device 80c16800 to if_list as 80e7a880
> batman-adv-dbg: got batman_if 80e7a880 for net_dev 80c16800
> batman-adv-dbg: got event 1 for net_dev 80c16800
> batman-adv-dbg: got batman_if 80e7a880 for net_dev 80c16800
> batman-adv-dbg: hardif_activate_interface(80549ec0, 80e7a880)
> batman-adv-dbg: got event 5 for net_dev 808e2000
> batman-adv-dbg: will add net_device 808e2000 to if_list
> batman-adv-dbg: added net_device 808e2000 to if_list as 80e7a800
> batman-adv-dbg: got batman_if 80e7a800 for net_dev 808e2000
> batman-adv-dbg: got event 1 for net_dev 808e2000
> batman-adv-dbg: got batman_if 80e7a800 for net_dev 808e2000
> batman-adv-dbg: hardif_activate_interface(80549ec0, 80e7a800)
> batman-adv-dbg: got event 5 for net_dev 80e21800
> batman-adv-dbg: will add net_device 80e21800 to if_list
> batman-adv-dbg: added net_device 80e21800 to if_list as 80e7a780
> batman-adv-dbg: got batman_if 80e7a780 for net_dev 80e21800
> batman-adv-dbg: got event 1 for net_dev 80e21800
> batman-adv-dbg: got batman_if 80e7a780 for net_dev 80e21800
> batman-adv-dbg: hardif_activate_interface(80549ec0, 80e7a780)
> batman-adv-dbg: got event 5 for net_dev 80fd1000
> batman-adv-dbg: will add net_device 80fd1000 to if_list
> batman-adv-dbg: added net_device 80fd1000 to if_list as 80e7a700
> batman-adv-dbg: got batman_if 80e7a700 for net_dev 80fd1000
> batman-adv-dbg: got event 5 for net_dev 80549c00
> batman-adv-dbg: will add net_device 80549c00 to if_list
> batman-adv-dbg: got batman_if (null) for net_dev 80549c00
> batman-adv:B.A.T.M.A.N. advanced 2010.0.0 (compatibility version 8) loaded
> batman-adv:Adding interface: wlan0
> batman-adv:Not using interface wlan0 (retrying later): interface not acti=
ve
> jffs2_scan_eraseblock(): End of filesystem marker found at 0x0
> jffs2_build_filesystem(): unlocking the mtd device... done.
> jffs2_build_filesystem(): erasing all blocks after the end marker... done.
> mini_fo: using base directory: /
> mini_fo: using storage directory: /overlay
> batman-adv-dbg: got event 9 for net_dev 80845c00
> batman-adv-dbg: got batman_if (null) for net_dev 80845c00
> batman-adv-dbg: got event 2 for net_dev 80845c00
> batman-adv-dbg: got batman_if (null) for net_dev 80845c00
> batman-adv-dbg: got event 9 for net_dev 80e21800
> batman-adv-dbg: got batman_if 80e7a780 for net_dev 80e21800
> batman-adv-dbg: hardif_deactivate_interface(80e7a780)
> br-lan: port 1(eth0.0) entering disabled state
> batman-adv-dbg: got event 2 for net_dev 80e21800
> batman-adv-dbg: got batman_if 80e7a780 for net_dev 80e21800
> batman-adv-dbg: hardif_deactivate_interface(80e7a780)
> batman-adv-dbg: got event 9 for net_dev 80c16800
> batman-adv-dbg: got batman_if 80e7a880 for net_dev 80c16800
> batman-adv-dbg: hardif_deactivate_interface(80e7a880)
> device eth0 left promiscuous mode
> batman-adv-dbg: got event 2 for net_dev 80c16800
> batman-adv-dbg: got batman_if 80e7a880 for net_dev 80c16800
> batman-adv-dbg: hardif_deactivate_interface(80e7a880)
> device eth0.0 left promiscuous mode
> br-lan: port 1(eth0.0) entering disabled state
> batman-adv-dbg: got event 6 for net_dev 80e21800
> batman-adv-dbg: got batman_if 80e7a780 for net_dev 80e21800
> batman-adv-dbg: hardif_remove_interface(80e7a780)
> batman-adv-dbg: will remove batman_if 80e7a780
> batman-adv-dbg: putted netdev 80e21800 of batman_if 80e7a780
> batman-adv-dbg: removed batman_if 80e7a780
> batman-adv-dbg: got event 9 for net_dev 808e2000
> batman-adv-dbg: got batman_if 80e7a800 for net_dev 808e2000
> batman-adv-dbg: hardif_deactivate_interface(80e7a800)
> batman-adv-dbg: got event 2 for net_dev 808e2000
> batman-adv-dbg: got batman_if 80e7a800 for net_dev 808e2000
> batman-adv-dbg: hardif_deactivate_interface(80e7a800)
> batman-adv-dbg: got event 13 for net_dev 80845c00
> batman-adv-dbg: got batman_if (null) for net_dev 80845c00
> batman-adv-dbg: got event 1 for net_dev 80845c00
> batman-adv-dbg: got batman_if (null) for net_dev 80845c00
> batman-adv-dbg: got event 9 for net_dev 80845c00
> batman-adv-dbg: got batman_if (null) for net_dev 80845c00
> batman-adv-dbg: got event 2 for net_dev 80845c00
> batman-adv-dbg: got batman_if (null) for net_dev 80845c00
> batman-adv-dbg: got event 13 for net_dev 80845c00
> batman-adv-dbg: got batman_if (null) for net_dev 80845c00
> batman-adv-dbg: got event 1 for net_dev 80845c00
> batman-adv-dbg: got batman_if (null) for net_dev 80845c00
> batman-adv-dbg: got event 13 for net_dev 80c16800
> batman-adv-dbg: got batman_if 80e7a880 for net_dev 80c16800
> batman-adv-dbg: got event 1 for net_dev 80c16800
> batman-adv-dbg: got batman_if 80e7a880 for net_dev 80c16800
> batman-adv-dbg: hardif_activate_interface(80549ec0, 80e7a880)
> batman-adv-dbg: got event 4 for net_dev 80c16800
> batman-adv-dbg: got batman_if 80e7a880 for net_dev 80c16800
> batman-adv-dbg: got event 9 for net_dev 80c16800
> batman-adv-dbg: got batman_if 80e7a880 for net_dev 80c16800
> batman-adv-dbg: hardif_deactivate_interface(80e7a880)
> batman-adv-dbg: got event 2 for net_dev 80c16800
> batman-adv-dbg: got batman_if 80e7a880 for net_dev 80c16800
> batman-adv-dbg: hardif_deactivate_interface(80e7a880)
> batman-adv-dbg: got event 13 for net_dev 80c16800
> batman-adv-dbg: got batman_if 80e7a880 for net_dev 80c16800
> batman-adv-dbg: got event 1 for net_dev 80c16800
> batman-adv-dbg: got batman_if 80e7a880 for net_dev 80c16800
> batman-adv-dbg: hardif_activate_interface(80549ec0, 80e7a880)
> batman-adv-dbg: got event 5 for net_dev 80d66000
> batman-adv-dbg: will add net_device 80d66000 to if_list
> batman-adv-dbg: added net_device 80d66000 to if_list as 808e6400
> batman-adv-dbg: got batman_if 808e6400 for net_dev 80d66000
> batman-adv-dbg: got event 13 for net_dev 80d66000
> batman-adv-dbg: got batman_if 808e6400 for net_dev 80d66000
> batman-adv-dbg: got event 1 for net_dev 80d66000
> batman-adv-dbg: got batman_if 808e6400 for net_dev 80d66000
> batman-adv-dbg: hardif_activate_interface(80549ec0, 808e6400)
> device eth0.0 entered promiscuous mode
> device eth0 entered promiscuous mode
> br-lan: port 1(eth0.0) entering forwarding state
> batman-adv-dbg: got event 4 for net_dev 80c16800
> batman-adv-dbg: got batman_if 80e7a880 for net_dev 80c16800
> batman-adv-dbg: got event 13 for net_dev 808e2000
> batman-adv-dbg: got batman_if 80e7a800 for net_dev 808e2000
> batman-adv-dbg: got event 1 for net_dev 808e2000
> batman-adv-dbg: got batman_if 80e7a800 for net_dev 808e2000
> batman-adv-dbg: hardif_activate_interface(80549ec0, 80e7a800)
> batman-adv-dbg: got event 9 for net_dev 808e2000
> batman-adv-dbg: got batman_if 80e7a800 for net_dev 808e2000
> batman-adv-dbg: hardif_deactivate_interface(80e7a800)
> batman-adv-dbg: got event 2 for net_dev 808e2000
> batman-adv-dbg: got batman_if 80e7a800 for net_dev 808e2000
> batman-adv-dbg: hardif_deactivate_interface(80e7a800)
> batman-adv-dbg: got event 13 for net_dev 808e2000
> batman-adv-dbg: got batman_if 80e7a800 for net_dev 808e2000
> batman-adv-dbg: got event 1 for net_dev 808e2000
> batman-adv-dbg: got batman_if 80e7a800 for net_dev 808e2000
> batman-adv-dbg: hardif_activate_interface(80549ec0, 80e7a800)
> batman-adv-dbg: got event 4 for net_dev 808e2000
> batman-adv-dbg: got batman_if 80e7a800 for net_dev 808e2000
> batman-adv-dbg: got event 6 for net_dev 80fd1000
> batman-adv-dbg: got batman_if 80e7a700 for net_dev 80fd1000
> batman-adv-dbg: hardif_remove_interface(80e7a700)
> batman-adv-dbg: will remove batman_if 80e7a700
> batman-adv:Removing interface: wlan0
> batman-adv-dbg: putted netdev 80fd1000 of batman_if 80e7a700
> batman-adv-dbg: removed batman_if 80e7a700
> batman-adv-dbg: got event 5 for net_dev 80fd1000
> batman-adv-dbg: will add net_device 80fd1000 to if_list
> batman-adv-dbg: added net_device 80fd1000 to if_list as 80e7ae80
> batman-adv-dbg: got batman_if 80e7ae80 for net_dev 80fd1000
> batman-adv-dbg: got event 8 for net_dev 80fd1000
> batman-adv-dbg: got batman_if 80e7ae80 for net_dev 80fd1000
> CPU 0 Unable to handle kernel paging request at virtual address
> 00003aa1, epc =3D=3D 80588300, ra =3D=3D 805882e8
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 10009800 3c9c2500 80fd1000
> $ 4   : 80a89e08 00003a9e 00003a98 00000000
> $ 8   : 00000004 00000001 8029fd20 00000001
> $12   : 0000000f 8023a728 ffffffff 8070fbc8
> $16   : 80e7ae80 80fd1000 8058c8f4 00000008
> $20   : 80549ec0 00460eb4 7f93b8a0 00000000
> $24   : 00000003 8015f9dc
> $28   : 8070e000 8070fd58 00000000 805882e8
> Hi    : 00000000
> Lo    : 00000063
> epc   : 80588300 update_min_mtu+0x204/0x31c [batman_adv]
>      Not tainted
> ra    : 805882e8 update_min_mtu+0x1ec/0x31c [batman_adv]
> Status: 10009803    KERNEL EXL IE
> Cause : 0080000c
> BadVA : 00003aa1
> PrId  : 00029008 (Broadcom BCM3302)
> Modules linked in: batman_adv nf_nat_tftp nf_conntrack_tftp nf_nat_irc
> nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ipt_MASQUERADE iptable_nat
> nf_nat xt_NOTRACK iptable_raw xt_state nf_conntrack_ipv4 nf_defrag_ipv4
> nf_conntrack pppoe pppox ipt_REJECT xt_TCPMSS ipt_LOG xt_comment
> xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ip_tables
> xt_tcpudp x_tables ppp_async ppp_generic slhc b43legacy b43 mac80211
> crc_ccitt cfg80211 compat_firmware_class compat arc4 aes_generic deflate
> ecb cbc switch_robo switch_core diag
> Process ifconfig (pid: 1335, threadinfo=3D8070e000, task=3D805e96b0,
> tls=3D00000000)
> Stack : 80e7ae80 80fd1000 8058c8f4 00000008 80e7ae80 80588bb8 803d02a8
> 80e7ae80
>          80fd1000 0000405a 00000000 fffffff0 00000000 80fd1000 00000008
> 8004343c
>          00000500 00001805 000000bf 00000b3b 00000000 80fd1000 7f93b8e0
> 00000000
>          8070fe18 800435d8 80d35004 8073ff98 802ffc60 00000000 00000000
> ffffffed
>          80fd1000 801a9450 802e6c90 801aa478 00000000 00000054 00008924
> 00008924
>          ...
> Call Trace:
> [<80588300>] update_min_mtu+0x204/0x31c [batman_adv]
>=20
>=20
> Code: 24c50006  88820003  98820000 <a8a20003> b8a20000  90830004
> a0a30004  90820005  a0a20005
> Disabling lock debugging due to kernel taint

>=20
> PS: Soll ich die n=E4chsten Mails wieder auf Englisch an die Mailingliste
> schicken?

Yes, let's switch back to the ml. The the bug can be checked more easily no=
w.=20
The problem is that the compiler optimizes it a little bit.... too much. So=
=20
the backtrace isn't always clear. If I understand the output (and the outpu=
t=20
of Lemonde) correctly then we have the problem with the changeaddr event an=
d=20
not the mtu update as the backtrace would suggest.

Now it really makes fun again to debug those things :D

I haven't wrote that code... so it may take a little bit until I feel in th=
e=20
right mood to hunt it real down.

Thanks a lot for your help in debugging it. Your name will definitely appea=
r=20
in the kernel changelog.

@Lemonde, it seems that you have the same problem. The patch will appear on=
=20
the ml later. But please also add the other patches I'd suggested.

Greetings,
	Sven

--nextPart15107309.rourLgpGLv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMbpTpAAoJEF2HCgfBJntGPDQP/i0vPQUkTklFJyfm56kH+N8t
9GXEJbwcCKy+MP7/HVy7BteP5AyTGs+KE3USLanxr2vsFU4J/O7gOS9dChfCoV2o
DRpx1wVxfm4gqN8Dk/gFn/KeEd027K4lGCrlfItCuXQgPhUd7u/myumn+x1U4qqv
unkVoJxja447Hp54A10vs52xZdvLp6tc6pXdDBtgnaAHeukRSclFqTlsCfvYHz9L
FqJYen5MyoRHiH1r8jMys9Hah0uSEq8Kg/yh2oMoMs0GethwA8laOEiYQKR0CiDs
DnuoPSflXqFCepJiL8BOp6afDUTUPYyYPrKLXfRaDyU3fJAWXyqpeM3bEgAieFf/
iJ8CCUiauA6ZzuetjwWVfJuHkkeQTmGCo/Gm7GpHnODEWBV0dRtf+XC/WrWQ31yz
sFkyzzZCid1VY/rwb7dGT8rqJfUXfclVHk/kQZmx8PgDkTZRCXxraUd3aoBci/pN
SvmkmZ47mG+COGj3IOjsZMCKvuxbaW9BtveplE4hKm/n20jTPVtCW1iq5Z8imFcW
u/3l/oEtLFIHMyjBlEn+tkb3kG+NUpTdtK9o82+bBOE5VyLnvb3wOCe6QnHk5I7q
zIX+/bquP99ASLC91mxhs+2txCM4O/Ui6Btp4zXPlvoQLBn44EZgjiX7sRsqZb7i
lGV/cLOcHAG8u8pnKgl3
=jDrJ
-----END PGP SIGNATURE-----

--nextPart15107309.rourLgpGLv--
