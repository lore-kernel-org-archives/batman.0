Return-Path: <linus.luessing@web.de>
Date: Mon, 8 Feb 2010 20:38:48 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100208193848.GA8545@Sellars>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] race condition with activate_module?
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


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi guys,

I think I've seen this bug a couple of times but I've never been
able to reproduce it. Now I added a little patch to slow down the
activate_module() procedure and the bug occures every time now. My
question is, did I make a race condition apparent or did I introduce
a bug with this patch?

Cheers, Linus

--UugvWAfsgieZRqgk
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-slowing-activate_module.patch"

diff --git a/hard-interface.c b/hard-interface.c
index db264bd..7239284 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -386,7 +386,11 @@ static int hard_if_event(struct notifier_block *this,
 		hardif_activate_interface(batman_if);
 		if ((atomic_read(&module_state) == MODULE_INACTIVE) &&
 		    (hardif_get_active_if_num() > 0)) {
+printk(KERN_ERR "batman-adv:NETDEV_UP, activating module\n");
+ssleep(3);
 			activate_module();
+printk(KERN_ERR "batman-adv:NETDEV_UP, activating module finished!\n");
+ssleep(3);
 		}
 		break;
 	/* NETDEV_CHANGEADDR - mac address change - what are we doing here ? */
diff --git a/proc.c b/proc.c
index 248ca10..9efc076 100644
--- a/proc.c
+++ b/proc.c
@@ -114,7 +114,13 @@ static ssize_t proc_interfaces_write(struct file *instance,
 
 	if ((atomic_read(&module_state) == MODULE_INACTIVE) &&
 	    (hardif_get_active_if_num() > 0))
+	{
+printk(KERN_ERR "batman-adv:proc_interface_write, activating module...\n");
+ssleep(3);
 		activate_module();
+printk(KERN_ERR "batman-adv:proc_interface_write, activating module finished!\n");
+ssleep(3);
+	}
 
 	rcu_read_lock();
 	if (list_empty(&if_list)) {

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment; filename="2010-02-08-2029-slowed-activate_module.log"
Content-Transfer-Encoding: 8bit

root@OpenWrt:/# +Ethernet eth0: MAC address 00:22:b0:98:87:de
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
== Executing boot script in 5.000 seconds - enter ^C to abort
+Ethernet eth0: MAC address 00:22:b0:98:87:de
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
== Executing boot script in 5.000 seconds - enter ^C to abort
DD-WRT> fis load -l vmlinux.bin.l7
Image loaded from 0x80041000-0x802c2200
DD-WRT> exec
Now booting linux kernel:
 Base address 0x80030000 Entry 0x80041000
 Cmdline :
Linux version 2.6.30.10 (linus@Linus-Debian) (gcc version 4.3.3 (GCC) ) #12 Mon Feb 8 19:26:43 CET 2010
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
Kernel command line: console=ttyS0,9600 rootfstype=squashfs,jffs2
Primary instruction cache 16kB, VIPT, 4-way, linesize 16 bytes.
Primary data cache 16kB, 4-way, VIPT, no aliases, linesize 16 bytes
NR_IRQS:128
PID hash table entries: 64 (order: 6, 256 bytes)
console [ttyS0] enabled
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 13324k/16384k available (1985k kernel code, 3060k reserved, 452k data, 128k init, 0k highmem)
Calibrating delay loop... 183.50 BogoMIPS (lpj=917504)
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
JFFS2 version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
msgmni has been set to 26
io scheduler noop registered
io scheduler deadline registered (default)
gpiodev: gpio device registered with major 254
gpiodev: gpio platform device registered with access mask FFFFFFFF
Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0xb1100003 (irq = 37) is a 16550A
eth0: Atheros AR231x: 00:22:b0:98:87:de, irq 4
ar231x_eth_mii: probed
eth0: attached PHY driver [IC+ IP175C] (mii_bus:phy_addr=0:00)
cmdlinepart partition parsing not available
Searching for RedBoot partition table in spiflash at offset 0x3d0000
Searching for RedBoot partition table in spiflash at offset 0x3e0000
6 RedBoot partitions found on MTD device spiflash
Creating 6 MTD partitions on "spiflash":
0x000000000000-0x000000030000 : "RedBoot"
0x000000030000-0x0000002f0000 : "rootfs"
mtd: partition "rootfs" set to be root filesystem
mtd: partition "rootfs_data" created automatically, ofs=230000, len=C0000
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

Please press Enter to activate this console. NET: Registered protocol family 10
lo: Disabled Privacy Extensions
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
device eth0.1 entered promiscuous mode
device eth0 entered promiscuous mode
br-mesh: port 1(eth0.1) entering forwarding state
ip_tables: (C) 2000-2006 Netfilter Core Team
Ebtables v2.0 registered
ip6_tables: (C) 2000-2006 Netfilter Core Team
batman-adv:B.A.T.M.A.N. advanced 0.2.1-beta r1568 (compatibility version 8) loaded
ath_hal: module license 'Proprietary' taints kernel.
Disabling lock debugging due to kernel taint
ath_hal: 2009-05-08 (AR5212, AR5312, RF5111, RF5112, RF2316, RF2317, REGOPS_FUNC, TX_DESC_SWAP, XR)
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
wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
wifi0: turboG rates: 6Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
wifi0: H/W encryption support: WEP AES AES_CCM TKIP
ath_ahb: wifi0: Atheros 2317 WiSoC REV1: mem=0xb0000000, irq=3
IRQ 3/wifi0: IRQF_DISABLED is not guaranteed on shared IRQs
device bat0 entered promiscuous mode
br-mesh: port 2(bat0) entering forwarding state
device ath0 entered promiscuous mode
br-mesh: port 3(ath0) entering forwarding state
device ath0 left promiscuous mode
br-mesh: port 3(ath0) entering disabled state
device ath0 entered promiscuous mode
br-mesh: port 3(ath0) entering forwarding state
br-wan_vpn: port 1(eth0.4) entering disabled state
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 1(eth0.4) entering forwarding state
br-mesh: port 3(ath0) entering disabled state
br-mesh: port 2(bat0) entering disabled state
br-mesh: port 1(eth0.1) entering disabled state
br-mesh: port 3(ath0) entering forwarding state
br-mesh: port 2(bat0) entering forwarding state
br-mesh: port 1(eth0.1) entering forwarding state
batman-adv:Adding interface: ath1
batman-adv:Interface activated: ath1
batman-adv:proc_interface_write, activating module...
batman-adv:proc_interface_write, activating module finished!
CPU 0 Unable to handle kernel paging request at virtual address 00000010, epc == 804235f0, ra == 80423550
Oops[#1]:
Cpu 0
$ 0   : 00000000 10009c00 00000010 808d9800
$ 4   : 00000000 00000000 00000000 808d9800
$ 8   : 00006afd 808d918e 00000010 00000000
$12   : 00000000 00442000 00441fb0 00000000
$16   : 80965d40 80965d00 808d9180 80965d40
$20   : 80965d00 00000000 00000001 80542060
$24   : 00000010 8061c874
$28   : 80da4000 80da5c60 80290000 80423550
Hi    : 0000002e
Lo    : 008c26ac
epc   : 804235f0 receive_bat_packet+0x3d8/0x6ec [batman_adv]
    Tainted: P
ra    : 80423550 receive_bat_packet+0x338/0x6ec [batman_adv]
Status: 10009c02    KERNEL EXL
Cause : 10800008
BadVA : 00000010
PrId  : 00019064 (MIPS 4KEc)
Modules linked in: ath_ahb ath_hal(P) batman_adv ip6t_REJECT ip6t_LOG ip6t_rt ip6t_hbh ip6t_mh ip6t_ipv6header ip6t_frag ip6t_eui64 ip6t_ah ip6table_raw ip6_queue ip6table_mangle ip6table_filter ip6_tables ebt_redirect ebt_mark ebt_vlan ebt_stp ebt_pkttype ebt_mark_m ebt_limit ebt_among ebt_802_3 ebtable_nat ebtable_filter ebtable_broute ebtables xt_quota xt_pkttype xt_physdev ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ip_tables xt_tcpudp x_tables tun ipv6
Process dropbearkey (pid: 1103, threadinfo=80da4000, task=803520c8, tls=00000000)
Stack : 00000000 00000001 805f82c0 10009c01 00000000 80621ae0 8054206c 00000001
        80542058 00000000 00000005 80542052 80542074 0000000c 808d9800 00000000
        80542060 00000000 80542060 00000040 80542052 808d9800 00004305 00000000
        80542040 80428040 00000000 00000000 00000000 00000000 808d9800 809c9000
        809c9000 80f42cc0 80542052 808d9800 10009c01 804be000 804be000 80422f50
        ...
Call Trace:
[<804235f0>] receive_bat_packet+0x3d8/0x6ec [batman_adv]
[<80428040>] receive_aggr_bat_packet+0x7c/0xbc [batman_adv]
[<80422f50>] recv_bat_packet+0x94/0x24c [batman_adv]
[<80427974>] batman_skb_recv+0x128/0x1dc [batman_adv]
[<806215c4>] ieee80211_saveath+0xb24/0xb80 [ath_ahb]


Code: 9245000e  84640008  00441021 <90440000> 00a4102b  00a2200b  10800003  00000000  14a00003
Kernel panic - not syncing: Fatal exception in interrupt
+Ethernet eth0: MAC address 00:22:b0:98:87:de
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
== Executing boot script in 5.000 seconds - enter ^C to abort
DD-WRT> fis load -l vmlinux.bin.l7
Image loaded from 0x80041000-0x802c2200
DD-WRT> exec
Now booting linux kernel:
 Base address 0x80030000 Entry 0x80041000
 Cmdline :
Linux version 2.6.30.10 (linus@Linus-Debian) (gcc version 4.3.3 (GCC) ) #12 Mon Feb 8 19:26:43 CET 2010
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
Kernel command line: console=ttyS0,9600 rootfstype=squashfs,jffs2
Primary instruction cache 16kB, VIPT, 4-way, linesize 16 bytes.
Primary data cache 16kB, 4-way, VIPT, no aliases, linesize 16 bytes
NR_IRQS:128
PID hash table entries: 64 (order: 6, 256 bytes)
console [ttyS0] enabled
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 13324k/16384k available (1985k kernel code, 3060k reserved, 452k data, 128k init, 0k highmem)
Calibrating delay loop... 183.50 BogoMIPS (lpj=917504)
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
JFFS2 version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
msgmni has been set to 26
io scheduler noop registered
io scheduler deadline registered (default)
gpiodev: gpio device registered with major 254
gpiodev: gpio platform device registered with access mask FFFFFFFF
Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0xb1100003 (irq = 37) is a 16550A
eth0: Atheros AR231x: 00:22:b0:98:87:de, irq 4
ar231x_eth_mii: probed
eth0: attached PHY driver [IC+ IP175C] (mii_bus:phy_addr=0:00)
cmdlinepart partition parsing not available
Searching for RedBoot partition table in spiflash at offset 0x3d0000
Searching for RedBoot partition table in spiflash at offset 0x3e0000
6 RedBoot partitions found on MTD device spiflash
Creating 6 MTD partitions on "spiflash":
0x000000000000-0x000000030000 : "RedBoot"
0x000000030000-0x0000002f0000 : "rootfs"
mtd: partition "rootfs" set to be root filesystem
mtd: partition "rootfs_data" created automatically, ofs=230000, len=C0000
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

Please press Enter to activate this console. NET: Registered protocol family 10
lo: Disabled Privacy Extensions
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
device eth0.1 entered promiscuous mode
device eth0 entered promiscuous mode
br-mesh: port 1(eth0.1) entering forwarding state
ip_tables: (C) 2000-2006 Netfilter Core Team
Ebtables v2.0 registered
ip6_tables: (C) 2000-2006 Netfilter Core Team
batman-adv:B.A.T.M.A.N. advanced 0.2.1-beta r1568 (compatibility version 8) loaded
ath_hal: module license 'Proprietary' taints kernel.
Disabling lock debugging due to kernel taint
ath_hal: 2009-05-08 (AR5212, AR5312, RF5111, RF5112, RF2316, RF2317, REGOPS_FUNC, TX_DESC_SWAP, XR)
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
wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
wifi0: turboG rates: 6Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
wifi0: H/W encryption support: WEP AES AES_CCM TKIP
ath_ahb: wifi0: Atheros 2317 WiSoC REV1: mem=0xb0000000, irq=3
IRQ 3/wifi0: IRQF_DISABLED is not guaranteed on shared IRQs
device bat0 entered promiscuous mode
br-mesh: port 2(bat0) entering forwarding state
device ath0 entered promiscuous mode
br-mesh: port 3(ath0) entering forwarding state
device ath0 left promiscuous mode
br-mesh: port 3(ath0) entering disabled state
device ath0 entered promiscuous mode
br-mesh: port 3(ath0) entering forwarding state
br-wan_vpn: port 1(eth0.4) entering disabled state
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 1(eth0.4) entering forwarding state
br-mesh: port 3(ath0) entering disabled state
br-mesh: port 2(bat0) entering disabled state
br-mesh: port 1(eth0.1) entering disabled state
br-mesh: port 3(ath0) entering forwarding state
br-mesh: port 2(bat0) entering forwarding state
br-mesh: port 1(eth0.1) entering forwarding state
batman-adv:Adding interface: ath1
batman-adv:Interface activated: ath1
batman-adv:proc_interface_write, activating module...
batman-adv:proc_interface_write, activating module finished!
CPU 0 Unable to handle kernel paging request at virtual address 00000010, epc == 80bb58b8, ra == 80bb33d4
Oops[#1]:
Cpu 0
$ 0   : 00000000 10009c00 00000010 80ee8880
$ 4   : 00000010 00000000 00000000 00000007
$ 8   : 8054b06c 80e95e86 00000010 00000000
$12   : 00000000 802ff208 ffffffff 00000000
$16   : 80e95e80 00000010 00000000 00000000
$20   : 00000001 00000001 80bbcc70 8054b060
$24   : 00000010 8061c874
$28   : 80e34000 80e35a90 8054b040 80bb33d4
Hi    : 00000027
Lo    : 01e4f99d
epc   : 80bb58b8 bit_mark+0x14/0x30 [batman_adv]
    Tainted: P
ra    : 80bb33d4 receive_bat_packet+0x1bc/0x6ec [batman_adv]
Status: 10009c02    KERNEL EXL
Cause : 10800008
BadVA : 00000010
PrId  : 00019064 (MIPS 4KEc)
Modules linked in: ath_ahb ath_hal(P) batman_adv ip6t_REJECT ip6t_LOG ip6t_rt ip6t_hbh ip6t_mh ip6t_ipv6header ip6t_frag ip6t_eui64 ip6t_ah ip6table_raw ip6_queue ip6table_mangle ip6table_filter ip6_tables ebt_redirect ebt_mark ebt_vlan ebt_stp ebt_pkttype ebt_mark_m ebt_limit ebt_among ebt_802_3 ebtable_nat ebtable_filter ebtable_broute ebtables xt_quota xt_pkttype xt_physdev ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ip_tables xt_tcpudp x_tables tun ipv6
Process S90batman-adv-k (pid: 1112, threadinfo=80e34000, task=806e8ae8, tls=00000000)
Stack : 00000000 00000001 807192c0 10009c01 00000000 8005aebc 8054b06c 00000000
        8054b058 00000040 00000005 8054b052 8054b074 00000000 80ee8880 80e35b18
        8054b060 00000000 8054b060 00000014 8054b052 80ee8880 00004305 00000000
        8054b040 80bb8040 0000004d 11e1a300 0000004d 8007d7c0 80ee8880 802963b0
        802d0000 80f370a0 8054b052 80ee8880 10009c01 80bc2000 80bc2000 80bb2f50
        ...
Call Trace:
[<80bb58b8>] bit_mark+0x14/0x30 [batman_adv]
[<80bb33d4>] receive_bat_packet+0x1bc/0x6ec [batman_adv]
[<80bb8040>] receive_aggr_bat_packet+0x7c/0xbc [batman_adv]
[<80bb2f50>] recv_bat_packet+0x94/0x24c [batman_adv]
[<80bb7974>] batman_skb_recv+0x128/0x1dc [batman_adv]
[<806215c4>] ieee80211_saveath+0xb24/0xb80 [ath_ahb]


Code: 00051142  00021080  00821021 <8c440000> 24030001  00a31804  00832025  ac440000  03e00008
Kernel panic - not syncing: Fatal exception in interrupt


--UugvWAfsgieZRqgk--
