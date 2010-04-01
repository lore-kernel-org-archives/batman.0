Return-Path: <linus.luessing@web.de>
Date: Thu, 1 Apr 2010 19:28:10 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100401172810.GA28422@Linus-Debian>
References: <201003241252.18954.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <201003241252.18954.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] reorganized kernel interface patches (version 3)
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


--LpQ9ahxlCli8rRTG
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Marek,

had a look at your patches and found a bug which causes a kernel panic
(see attachement). I can reproduce this with the following veeery
complicated routine :):
---
ifconfig bat0 down && ifconfig bat0 up
---

The adding and deleting of mesh-port interfaces seems to work fine,
the new, more dynamic interface is awesome :). And I just was
wondering if you forgot about adding something like "batctl if del
all" or did you schedule this for another patch?

Also some additional abbrevations for add/del would be nice (just
"a" and "d" for instance).

Cheers, Linus

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="2010-0401-1838-syspatches.log"
Content-Transfer-Encoding: quoted-printable

=E2=94=94=E2=94=80(18:09:%)=E2=94=80> picocom /dev/ttyUSB0                 =
                                                                           =
               <=E2=94=80(Thu,Apr01)=E2=94=80=E2=94=98
picocom v1.4

port is        : /dev/ttyUSB0
flowcontrol    : none
baudrate is    : 9600
parity is      : none
databits are   : 8
escape is      : C-a
noinit is      : no
noreset is     : no
nolock is      : no
send_cmd is    : ascii_xfr -s -v -l10
receive_cmd is : rz -vv

Terminal ready
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
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BDImage loaded from 0x80041000-0x802c2200
DD-WRT> exec
Now booting linux kernel:
 Base address 0x80030000 Entry 0x80041000
 Cmdline :
Linux version 2.6.30.10 (linus@Linus-Debian) (gcc version 4.3.3 (GCC) ) #25=
 Thu Apr 1 14:30:45 CEST 2010
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
Memory: 13324k/16384k available (1985k kernel code, 3060k reserved, 452k da=
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
msgmni has been set to 26
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
Press Press f<ENTER> to enter failsafe mode
- regular preinit -
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
batman-adv:B.A.T.M.A.N. advanced 0.3.0-alpha r1611 (compatibility version 9=
) loaded
ath_hal: module license 'Proprietary' taints kernel.
Disabling lock debugging due to kernel taint
ath_hal: 2009-05-08 (AR5212, AR5312, RF5111, RF5112, RF2316, RF2317, REGOPS=
_FUNC, TX_DESC_SWAP, XR)
device eth0.4 entered promiscuous mode
br-wan_vpn: port 1(eth0.4) entering forwarding state
br-wan_vpn: starting userspace STP failed, starting kernel STP
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
device ath0 entered promiscuous mode
br-mesh: port 3(ath0) entering forwarding state
device ath0 left promiscuous mode
br-mesh: port 3(ath0) entering disabled state
device ath0 entered promiscuous mode
br-mesh: port 3(ath0) entering forwarding state
device ath1 entered promiscuous mode
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 2(ath1) entering forwarding state
device ath1 left promiscuous mode
br-wan_vpn: port 2(ath1) entering disabled state
device ath1 entered promiscuous mode
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 2(ath1) entering forwarding state
br-wan_vpn: port 2(ath1) entering disabled state
br-wan_vpn: port 1(eth0.4) entering disabled state
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 2(ath1) entering forwarding state
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 1(eth0.4) entering forwarding state
br-mesh: port 3(ath0) entering disabled state
br-mesh: port 2(bat0) entering disabled state
br-mesh: port 1(eth0.1) entering disabled state
br-mesh: port 3(ath0) entering forwarding state
br-mesh: port 2(bat0) entering forwarding state
br-mesh: port 1(eth0.1) entering forwarding state
batman-adv:Adding interface: ath2
batman-adv:Interface activated: ath2
CPU 0 Unable to handle kernel paging request at virtual address 00000011, e=
pc =3D=3D 80bd1524, ra =3D=3D 80bd3ec4
Oops[#1]:
Cpu 0
$ 0   : 00000000 10009c00 00000001 80c2a4a0
$ 4   : 80e9b300 00000001 00000000 80e21020
$ 8   : 00000000 00000000 00000000 00000000
$12   : 00000000 00000000 802d0000 00000000
$16   : 80e21008 809fe2c0 80f33e20 809fe000
$20   : 8096dd80 0000006e ffffffff 80290000
$24   : 00000000 80bd3ddc
$28   : 8057a000 8057bcb0 80279490 80bd3ec4
Hi    : 00000064
Lo    : 00af485a
epc   : 80bd1524 purge_outstanding_packets+0x21c/0x300 [batman_adv]
    Tainted: P
ra    : 80bd3ec4 interface_tx+0xe8/0x294 [batman_adv]
Status: 10009c03    KERNEL EXL IE
Cause : 10800008
BadVA : 00000011
PrId  : 00019064 (MIPS 4KEc)
Modules linked in: ath_ahb ath_hal(P) batman_adv ip6t_REJECT ip6t_LOG ip6t_=
rt ip6t_hbh ip6t_mh ip6t_ipv6header ip6t_frag ip6t_eui64 ip6t_ah ip6table_r=
aw ip6_queue ip6table_mangle ip6table_filter ip6_tables ebt_redirect ebt_ma=
rk ebt_vlan ebt_stp ebt_pkttype ebt_mark_m ebt_limit ebt_among ebt_802_3 eb=
table_nat ebtable_filter ebtable_broute ebtables xt_quota xt_pkttype xt_phy=
sdev ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport xt_mac xt_limit iptable_mang=
le iptable_filter ip_tables xt_tcpudp x_tables tun ipv6
Process dropbearkey (pid: 1090, threadinfo=3D8057a000, task=3D80343988, tls=
=3D00000000)
Stack : 80f33e20 8057bcf4 80e21012 809fe2c0 80f33e20 80e21008 809fe2c0 80bd=
3ec4
        0000000a 80a82e98 809fe000 00000005 80bc9800 801d2c40 80bc9800 80bc=
9800
        00000001 80f33e20 809fe000 8096dd80 ffffa89e ffffffff 80290000 801c=
6310
        80f33e20 80f33e20 80bcb800 802d4ac0 8096dd80 00000000 80f33e20 809f=
e000
        802d4ac0 80e21050 00000003 00000004 80bcb800 801b3e08 00000000 0000=
0060
        ...
Call Trace:
[<80bd1524>] purge_outstanding_packets+0x21c/0x300 [batman_adv]
[<80bd3ec4>] interface_tx+0xe8/0x294 [batman_adv]
[<801c6310>] __qdisc_run+0x118/0x2cc
[<801b3e08>] dev_queue_xmit+0x298/0x3dc
[<80a8615c>] ip6_output+0xcd4/0x103c [ipv6]
[<80aa2934>] ipv6_chk_mcast_addr+0xe18/0x1620 [ipv6]


Code: 8c82004c  ac800000  ac800004 <80430010> 24020001  00808021  10620030 =
 00a08821  40056000
Kernel panic - not syncing: Fatal exception in interrupt


--2oS5YaxWCcQjTEyO--

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLtNepAAoJEBKw7u43QNpftNIQAID0ewuMOGviWqN88wQg+pLS
ch/ldQbsWe2evlw0ZDWw73WH8ltYEi5KzumcPxyQi32IlCoCiSUxonODVz7tk/51
lAfU4CgFGN6iKtPyG6xSzSVd9tqOezd2q3VgV6Bbpj0oRxoyZHOSOlaOtP3xiW4n
jOloDgjA85e8NBHc1y8TjV7w49DWvDNueglJF3IqGjv7uJAB4CrZZm19/BHSKy6v
n7bL9tLs9FbKQziQWDxy6Bfbvi/IhdsjFF8Nco+/J6qDgEwcYqiwgx06sN+z1cU7
nORm3LvtyHpjlrR/g0nkoakLhyjHctqop37oYQM6aDxGkVozL3oruxlLqxkcAja6
b+jzRbe6QKaTg8raDr55MuWfORuAF0VuDoxKhS5gvFS/x8SRN6swYq4zJIBOmGN0
6i1SShadPtIa536vZToGCdeEmiGJHJHTdBSPhulvPoH5y1fu6diXVSDXPJxK2jiq
G1i1LBiwI1wOhXavERMBWMESiPEzBQqK28wtv/DcSV3QF2P+AlvAoDEyJMqeoYv9
vJkgdkS4KCccdHLHsnJxCQv2Mpk0cNa/nEZ1Nb2zSE5cz2hk1Fzwv+Jxsk3Nij7i
hJ3pbwhjnOYPNLbrZeYKlFmNEqE8TLexKYJdjVv0BJcwDahnNY6JMVb68m52zzv7
sa9MPDFu7jGoC2JHJke/
=nfZt
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
