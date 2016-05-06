Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 6 May 2016 09:50:16 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160506085016.GA2811@otheros>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Kernel panic by BATMAN_V @WBMv9
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


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Just dumping this here, got a plane to catch.

Guido can explain how you can trigger this.

Cheers, Linus

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="wbm-crash-batman-v.log"
Content-Transfer-Encoding: quoted-printable

Time: 1462523738.517396
Modules:	ath9k@873e0000+15476	ath9k_common@872e8000+4ace	pppoe@8722a000+1fd=
0	ppp_async@87228000+18b0	iptable_nat@87215000+300	batman_adv@872c0000+20e7=
0	ath9k_hw@87380000+52341	ath@87278000+4e35	pppox@87213000+54a	ppp_generic@=
87238000+5082	nf_nat_ipv4@871f6000+e51	nf_conntrack_ipv6@87210000+1340	nf_c=
onntrack_ipv4@87236000+1220	mac80211@87300000+6114a	ipt_REJECT@87231000+390=
	ipt_MASQUERADE@87233000+270	cfg80211@87240000+34c53	xt_time@871ca000+660	x=
t_tcpudp@871cf000+6a0	xt_state@871cb000+2b0	xt_nat@871c9000+430	xt_multipor=
t@871c5000+4a0	xt_mark@871c3000+2a0	xt_mac@871c0000+270	xt_limit@871f3000+3=
e0	xt_id@87182000+1e0	xt_conntrack@87186000+870	xt_comment@87180000+1e0	xt_=
TCPMSS@87181000+a30	xt_REDIRECT@8719f000+420	xt_LOG@87119000+300	xt_CT@8711=
8000+8b0	slhc@87076000+10cb	nf_reject_ipv4@87064000+723	nf_nat_masquerade_i=
pv4@87133000+56c	nf_nat_ftp@8707f000+4b0	nf_nat@87130000+22ab	nf_log_ipv4@8=
70c8000+c40	nf_defrag_ipv6@8707c000+2377	nf_defrag_ipv4@87136000+326	nf_con=
ntrack_rtcache@8718f000+990	nf_conntrack_ftp@871fa000+14a0	nf_conntrack@871=
90000+b9ab	iptable_raw@8707a000+280	iptable_mangle@8706b000+3b0	iptable_fil=
ter@87066000+2a0	ip_tables@8706c000+24cd	crc_ccitt@87074000+3fb	compat@8707=
0000+3163	ledtrig_usbdev@87079000+790	libcrc32c@87117000+247	ip6t_REJECT@87=
0de000+4a0	nf_reject_ipv6@870cb000+767	nf_log_ipv6@870cd000+ce0	nf_log_comm=
on@870ca000+8ef	ip6table_raw@8710b000+240	ip6table_mangle@870cf000+430	ip6t=
able_filter@870f3000+260	ip6_tables@87110000+2441	x_tables@87108000+29f5	du=
mmy@870f0000+560	ip6_tunnel@870d8000+4111	tunnel6@870f1000+65e	tun@8712c000=
+3aef	vfat@87bde000+1f00	fat@870e0000+b92f	ipv6@87140000+3eb08	arc4@870b600=
0+520	crypto_blkcipher@870b0000+2907	usb_storage@87050000+928f	uhci_hcd@87b=
a8000+4770	ohci_platform@87af5000+ac0	ohci_hcd@87b10000+56bf	ehci_platform@=
87b6a000+d30	ehci_hcd@87b08000+7d5c	sd_mod@87b98000+6410	scsi_mod@87b80000+=
14e87	gpio_button_hotplug@87b5e000+1170	ext4@87000000+4c13c	jbd2@87b70000+b=
9c2	mbcache@87b66000+11cd	usbcore@87b40000+1cbd4	nls_base@87b04000+1370	usb=
_common@87af6000+488	crc16@87af8000+3f7	crc32c_generic@87af7000+3a0	crypto_=
hash@87b00000+2602
<4>[   12.160000] PCI: Enabling device 0000:00:00.0 (0000 -> 0002)
<7>[   12.170000] ath: EEPROM regdomain: 0x0
<7>[   12.170000] ath: EEPROM indicates default country code should be used
<7>[   12.170000] ath: doing EEPROM country->regdmn map search
<7>[   12.170000] ath: country maps to regdmn code: 0x3a
<7>[   12.170000] ath: Country alpha2 being used: US
<7>[   12.170000] ath: Regpair used: 0x3a
<7>[   12.180000] ieee80211 phy1: Selected rate control algorithm 'minstrel=
_ht'
<6>[   12.180000] ieee80211 phy1: Atheros AR9300 Rev:4 mem=3D0xb0000000, ir=
q=3D40
<5>[   15.800000] random: nonblocking pool is initialized
<5>[   19.810000] jffs2: notice: (1272) jffs2_build_xattr_subsystem: comple=
te building xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of x=
ref (0 dead, 0 orphan) found.
<6>[   23.410000] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
<6>[   23.430000] device eth0.1 entered promiscuous mode
<6>[   23.430000] device eth0 entered promiscuous mode
<6>[   23.450000] IPv6: ADDRCONF(NETDEV_UP): br-mgmt: link is not ready
<6>[   23.490000] device eth0.3 entered promiscuous mode
<6>[   23.530000] IPv6: ADDRCONF(NETDEV_UP): br-wiredtests: link is not rea=
dy
<6>[   23.540000] IPv6: ADDRCONF(NETDEV_UP): eth0.2: link is not ready
<6>[   24.540000] eth0: link up (1000Mbps/Full duplex)
<6>[   24.540000] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
<6>[   24.570000] br-mgmt: port 1(eth0.1) entered forwarding state
<6>[   24.570000] br-mgmt: port 1(eth0.1) entered forwarding state
<6>[   24.580000] IPv6: ADDRCONF(NETDEV_CHANGE): eth0.2: link becomes ready
<6>[   24.580000] br-wiredtests: port 1(eth0.3) entered forwarding state
<6>[   24.590000] br-wiredtests: port 1(eth0.3) entered forwarding state
<6>[   24.600000] IPv6: ADDRCONF(NETDEV_CHANGE): br-mgmt: link becomes ready
<6>[   24.610000] IPv6: ADDRCONF(NETDEV_CHANGE): br-wiredtests: link become=
s ready
<6>[   25.370000] IPv6: ADDRCONF(NETDEV_UP): wbm1: link is not ready
<6>[   25.420000] wbm1: Created IBSS using preconfigured BSSID 02:ca:ff:ee:=
ba:be
<6>[   25.430000] wbm1: Creating new IBSS network, BSSID 02:ca:ff:ee:ba:be
<6>[   25.470000] IPv6: ADDRCONF(NETDEV_UP): mgmt0: link is not ready
<6>[   25.810000] IPv6: ADDRCONF(NETDEV_CHANGE): wbm1: link becomes ready
<6>[   25.820000] IPv6: ADDRCONF(NETDEV_CHANGE): mgmt0: link becomes ready
<6>[   26.100000] batman_adv: bat0: Adding interface: mgmt0
<6>[   26.100000] batman_adv: bat0: Interface activated: mgmt0
<6>[   26.110000] 8021q: adding VLAN 0 to HW filter on device bat0
<6>[   26.110000] device bat0 entered promiscuous mode
<6>[   26.120000] br-mgmt: port 2(bat0) entered forwarding state
<6>[   26.120000] br-mgmt: port 2(bat0) entered forwarding state
<6>[   26.570000] br-mgmt: port 1(eth0.1) entered forwarding state
<6>[   26.590000] br-wiredtests: port 1(eth0.3) entered forwarding state
<6>[   27.090000] batman_adv: bat0: distributed_arp_table: Changing from: e=
nabled to: disabled
<6>[   27.110000] batman_adv: bat0: Changing gw mode from: off to: client
<6>[   27.110000] batman_adv: bat0: orig_interval: Changing from: 1000 to: =
5000
<6>[   28.120000] br-mgmt: port 2(bat0) entered forwarding state
<6>[ 1682.510000] br-wiredtests: port 1(eth0.3) entered disabled state
<6>[ 1682.520000] device eth0.3 left promiscuous mode
<6>[ 1682.520000] br-wiredtests: port 1(eth0.3) entered disabled state
<6>[ 1682.620000] IPv6: ADDRCONF(NETDEV_UP): eth0.3: link is not ready
<6>[ 1682.660000] device eth0.3 entered promiscuous mode
<6>[ 1682.700000] br-wiredtests: port 1(eth0.3) entered forwarding state
<6>[ 1682.700000] br-wiredtests: port 1(eth0.3) entered forwarding state
<6>[ 1683.100000] batman_adv: bat1: Adding interface: wbm1
<6>[ 1683.100000] batman_adv: bat1: Interface activated: wbm1
<6>[ 1683.110000] 8021q: adding VLAN 0 to HW filter on device bat1
<6>[ 1683.130000] batman_adv: bat1: Adding interface: lan_12
<6>[ 1683.130000] batman_adv: bat1: The MTU of interface lan_12 is too smal=
l (1496) to handle the transport of batman-adv packets. Packets going over =
this interface will be fragmented on layer2 which could impact the performa=
nce. Setting the MTU to 1532 would solve the problem.
<6>[ 1683.160000] batman_adv: bat1: Interface activated: lan_12
<6>[ 1683.260000] device bat1 entered promiscuous mode
<6>[ 1683.260000] br-wiredtests: port 2(bat1) entered forwarding state
<6>[ 1683.270000] br-wiredtests: port 2(bat1) entered forwarding state
<6>[ 1684.030000] batman_adv: bat1: distributed_arp_table: Changing from: e=
nabled to: disabled
<6>[ 1684.700000] br-wiredtests: port 1(eth0.3) entered forwarding state
<6>[ 1685.270000] br-wiredtests: port 2(bat1) entered forwarding state
<6>[ 1981.530000] device bat1 left promiscuous mode
<6>[ 1981.540000] br-wiredtests: port 2(bat1) entered disabled state
<6>[ 1981.550000] br-wiredtests: port 1(eth0.3) entered disabled state
<6>[ 1981.570000] device eth0.3 left promiscuous mode
<6>[ 1981.570000] br-wiredtests: port 1(eth0.3) entered disabled state
<6>[ 1981.590000] IPv6: ADDRCONF(NETDEV_UP): eth0.3: link is not ready
<4>[ 1981.600000] batman_adv: The newly added mac address (64:70:02:3e:9e:7=
c) already exists on: lan_12
<4>[ 1981.610000] batman_adv: It is strongly recommended to keep mac addres=
ses unique to avoid problems!
<6>[ 1981.620000] device eth0.3 entered promiscuous mode
<6>[ 1981.650000] br-wiredtests: port 1(eth0.3) entered forwarding state
<6>[ 1981.650000] br-wiredtests: port 1(eth0.3) entered forwarding state
<6>[ 1981.700000] 8021q: adding VLAN 0 to HW filter on device bat1
<4>[ 1981.740000] batman_adv: The newly added mac address (64:70:02:3e:9e:7=
c) already exists on: lan_12
<4>[ 1981.750000] batman_adv: It is strongly recommended to keep mac addres=
ses unique to avoid problems!
<6>[ 1981.940000] batman_adv: bat1: Interface deactivated: wbm1
<6>[ 1981.940000] batman_adv: bat1: Removing interface: wbm1
<6>[ 1982.000000] batman_adv: bat1: Interface deactivated: lan_12
<6>[ 1982.010000] batman_adv: bat1: Removing interface: lan_12
<6>[ 1983.650000] br-wiredtests: port 1(eth0.3) entered forwarding state
<6>[ 2261.000000] Atheros AR8216/AR8236/AR8316 ag71xx-mdio.0:00: Port 1 is =
up
<6>[ 3719.000000] Atheros AR8216/AR8236/AR8316 ag71xx-mdio.0:00: Port 1 is =
down
<6>[ 3735.000000] Atheros AR8216/AR8236/AR8316 ag71xx-mdio.0:00: Port 1 is =
up
<6>[ 6286.160000] br-wiredtests: port 1(eth0.3) entered disabled state
<6>[ 6286.170000] device eth0.3 left promiscuous mode
<6>[ 6286.170000] br-wiredtests: port 1(eth0.3) entered disabled state
<6>[ 6286.190000] IPv6: ADDRCONF(NETDEV_UP): eth0.3: link is not ready
<6>[ 6286.200000] device eth0.3 entered promiscuous mode
<6>[ 6286.220000] br-wiredtests: port 1(eth0.3) entered forwarding state
<6>[ 6286.230000] br-wiredtests: port 1(eth0.3) entered forwarding state
<6>[ 6286.510000] batman_adv: bat1: Adding interface: wbm1
<6>[ 6286.510000] batman_adv: bat1: Interface activated: wbm1
<6>[ 6286.520000] 8021q: adding VLAN 0 to HW filter on device bat1
<6>[ 6286.600000] batman_adv: bat1: Adding interface: lan_12
<6>[ 6286.610000] batman_adv: bat1: The MTU of interface lan_12 is too smal=
l (1496) to handle the transport of batman-adv packets. Packets going over =
this interface will be fragmented on layer2 which could impact the performa=
nce. Setting the MTU to 1532 would solve the problem.
<6>[ 6286.630000] batman_adv: bat1: Interface activated: lan_12
<6>[ 6286.650000] device bat1 entered promiscuous mode
<6>[ 6286.660000] br-wiredtests: port 2(bat1) entered forwarding state
<6>[ 6286.660000] br-wiredtests: port 2(bat1) entered forwarding state
<6>[ 6287.640000] batman_adv: bat1: distributed_arp_table: Changing from: e=
nabled to: disabled
<6>[ 6288.230000] br-wiredtests: port 1(eth0.3) entered forwarding state
<6>[ 6288.660000] br-wiredtests: port 2(bat1) entered forwarding state
<6>[ 7011.790000] batman_adv: bat1: Interface deactivated: wbm1
<6>[ 7011.790000] batman_adv: bat1: Removing interface: wbm1
<4>[ 7011.800000] br-wiredtests: received packet on bat1 with own address a=
s source address
<6>[ 7013.790000] batman_adv: bat1: Interface deactivated: lan_12
<6>[ 7013.790000] batman_adv: bat1: Removing interface: lan_12
<6>[ 7013.800000] br-wiredtests: port 2(bat1) entered disabled state
<6>[ 7013.810000] device bat1 left promiscuous mode
<6>[ 7013.820000] br-wiredtests: port 2(bat1) entered disabled state
<6>[ 7025.310000] batman_adv: bat1: Adding interface: wbm1
<6>[ 7025.320000] batman_adv: bat1: Interface activated: wbm1
<6>[ 7025.320000] 8021q: adding VLAN 0 to HW filter on device bat1
<6>[ 7025.350000] device bat1 entered promiscuous mode
<6>[ 7025.350000] br-wiredtests: port 2(bat1) entered forwarding state
<6>[ 7025.360000] br-wiredtests: port 2(bat1) entered forwarding state
<6>[ 7025.510000] batman_adv: bat1: distributed_arp_table: Changing from: e=
nabled to: disabled
<6>[ 7027.360000] br-wiredtests: port 2(bat1) entered forwarding state
<6>[ 7147.610000] batman_adv: bat1: Interface deactivated: wbm1
<6>[ 7147.610000] batman_adv: bat1: Removing interface: wbm1
<6>[ 7147.620000] br-wiredtests: port 2(bat1) entered disabled state
<6>[ 7147.630000] device bat1 left promiscuous mode
<6>[ 7147.630000] br-wiredtests: port 2(bat1) entered disabled state
<6>[ 7151.000000] batman_adv: bat1: Adding interface: lan_12
<6>[ 7151.000000] batman_adv: bat1: The MTU of interface lan_12 is too smal=
l (1496) to handle the transport of batman-adv packets. Packets going over =
this interface will be fragmented on layer2 which could impact the performa=
nce. Setting the MTU to 1532 would solve the problem.
<6>[ 7151.030000] batman_adv: bat1: Interface activated: lan_12
<6>[ 7151.030000] 8021q: adding VLAN 0 to HW filter on device bat1
<6>[ 7151.090000] device bat1 entered promiscuous mode
<6>[ 7151.090000] br-wiredtests: port 2(bat1) entered forwarding state
<6>[ 7151.100000] br-wiredtests: port 2(bat1) entered forwarding state
<4>[ 7151.100000] br-wiredtests: received packet on bat1 with own address a=
s source address
<6>[ 7151.220000] batman_adv: bat1: distributed_arp_table: Changing from: e=
nabled to: disabled
<6>[ 7153.100000] br-wiredtests: port 2(bat1) entered forwarding state
<4>[ 7161.020000] br-wiredtests: received packet on bat1 with own address a=
s source address
<4>[ 7171.040000] br-wiredtests: received packet on bat1 with own address a=
s source address
<4>[ 7181.060000] br-wiredtests: received packet on bat1 with own address a=
s source address
<6>[ 7187.400000] batman_adv: bat1: Adding interface: wbm1
<6>[ 7187.410000] batman_adv: bat1: Interface activated: wbm1
<4>[ 7191.080000] br-wiredtests: received packet on bat1 with own address a=
s source address
<4>[ 7201.100000] br-wiredtests: received packet on bat1 with own address a=
s source address
<4>[ 7211.120000] br-wiredtests: received packet on bat1 with own address a=
s source address
<4>[ 7221.140000] br-wiredtests: received packet on bat1 with own address a=
s source address
<1>[ 7224.990000] CPU 0 Unable to handle kernel paging request at virtual a=
ddress 01020100, epc =3D=3D 872d000c, ra =3D=3D 872d0004
<4>[ 7225.000000] Oops[#1]:
<4>[ 7225.000000] CPU: 0 PID: 13762 Comm: kworker/u2:1 Not tainted 3.18.29 =
#10
<4>[ 7225.000000] Workqueue: bat_events batadv_orig_node_put [batman_adv]
<4>[ 7225.000000] task: 879aa6c0 ti: 861e0000 task.ti: 861e0000
<4>[ 7225.000000] $ 0   : 00000000 00000000 86b76c80 01020100
<4>[ 7225.000000] $ 4   : 00000034 00000400 1100dc00 ffff00fe
<4>[ 7225.000000] $ 8   : 861e1fe0 0000dc00 00000015 000c002a
<4>[ 7225.000000] $12   : 00000001 0000000c 00000000 00000005
<4>[ 7225.000000] $16   : 8628e400 86b76500 86b20440 0000025a
<4>[ 7225.000000] $20   : 86278880 872e0000 00000000 00000034
<4>[ 7225.000000] $24   : 00000010 8006df08                 =20
<4>[ 7225.000000] $28   : 861e0000 861e1df0 00200200 872d0004
<4>[ 7225.000000] Hi    : 00000009
<4>[ 7225.000000] Lo    : 00004e20
<4>[ 7225.000000] epc   : 872d000c batadv_orig_node_put+0x250/0x4a4 [batman=
_adv]
<4>[ 7225.000000]     Not tainted
<4>[ 7225.000000] ra    : 872d0004 batadv_orig_node_put+0x248/0x4a4 [batman=
_adv]
<4>[ 7225.000000] Status: 1100dc03	KERNEL EXL IE=20
<4>[ 7225.000000] Cause : 8080000c
<4>[ 7225.000000] BadVA : 01020100
<4>[ 7225.000000] PrId  : 0001974c (MIPS 74Kc)
<4>[ 7225.000000] Modules linked in: ath9k ath9k_common pppoe ppp_async ipt=
able_nat batman_adv ath9k_hw ath pppox ppp_generic nf_nat_ipv4 nf_conntrack=
_ipv6 nf_conntrack_ipv4 mac80211 ipt_REJECT ipt_MASQUERADE cfg80211 xt_time=
 xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_id xt_co=
nntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_CT slhc nf_reject_ipv4 n=
f_nat_masquerade_ipv4 nf_nat_ftp nf_nat nf_log_ipv4 nf_defrag_ipv6 nf_defra=
g_ipv4 nf_conntrack_rtcache nf_conntrack_ftp nf_conntrack iptable_raw iptab=
le_mangle iptable_filter ip_tables crc_ccitt compat ledtrig_usbdev libcrc32=
c ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw ip6tabl=
e_mangle ip6table_filter ip6_tables x_tables dummy ip6_tunnel tunnel6 tun v=
fat fat ipv6 arc4 crypto_blkcipher usb_storage uhci_hcd ohci_platform ohci_=
hcd ehci_platform ehci_hcd sd_mod scsi_mod gpio_button_hotplug ext4 jbd2 mb=
cache usbcore nls_base usb_common crc16 crc32c_generic crypto_hash
<4>[ 7225.000000] Process kworker/u2:1 (pid: 13762, threadinfo=3D861e0000, =
task=3D879aa6c0, tls=3D00000000)
<4>[ 7225.000000] Stack : 86900258 800993c0 86900240 860db710 86900240 8731=
3c1c 00000000 00000000
<4>[ 7225.000000] 	  004038c0 86b76c80 86b20504 86b20504 87804a00 87188900 =
00000000 00000000
<4>[ 7225.000000] 	  87804a10 87804a00 00000088 872d022c 879aa6c0 80357590 =
00000000 8009c1c4
<4>[ 7225.000000] 	  86906380 86906380 86b20504 80091d30 80357590 80066648 =
00000000 8006df08
<4>[ 7225.000000] 	  861e1e78 87188e00 86906380 86906380 87804a00 86906398 =
80305420 00000001
<4>[ 7225.000000] 	  ...
<4>[ 7225.000000] Call Trace:
<4>[ 7225.000000] [<872d000c>] batadv_orig_node_put+0x250/0x4a4 [batman_adv]
<4>[ 7225.000000] [<872d0004>] batadv_orig_node_put+0x248/0x4a4 [batman_adv]
<4>[ 7225.000000]=20
<4>[ 7225.000000]=20
<4>[ 7225.000000] Code: 02e02021  8e220000  8e230004 <10400002> ac620000  a=
c430004  ae3e0004  0dcb3c95  02202021=20
<4>[ 7225.250000] ---[ end trace 3c49293b9d62884b ]---

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Time: 1462523738.526930

--jI8keyz6grp/JLjh--
