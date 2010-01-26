Return-Path: <linus.luessing@web.de>
Date: Tue, 26 Jan 2010 07:13:11 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100126061311.GA12697@Sellars>
References: <20100123174616.GA4795@Sellars>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20100123174616.GA4795@Sellars>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I'm now able to reproduce the second problem as well:
Activating the vis-server on one node causes the vis-clients to
throw this call trace with its slow path warning imediately.
Nevertheless, vis output works anyway, clients are sending
vis-packets and the server is drawing nice graphs.
See the attachment for an example call trace.

Cheers, Linus

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment; filename="slowpath-warning.log"
Content-Transfer-Encoding: 8bit

Linux version 2.6.30.10 (linus@Linus-Debian) (gcc version 4.3.3 (GCC) ) #3 Tue Jan 26 02:18:56 CET 2010
CPU revision is: 00019064 (MIPS 4KEc)
Determined physical RAM map:
 memory: 01000000 @ 00000000 (usable)
Initrd not found or empty - disabling initrd
Zone PFN ranges:
  Normal   0x00000000 -> 0x00001000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00001000
On node 0 totalpages: 4096
free_area_init_node: node 0, pgdat 802a0f40, node_mem_map 802d9000
  Normal zone: 32 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 4064 pages, LIFO batch:0
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
Switched to high resolution mode on CPU 0
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
eth0: Atheros AR231x: 00:22:b0:98:87:fa, irq 4
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
mini_fo: using base directory: /
mini_fo: using storage directory: /tmp/root
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
ip_tables: (C) 2000-2006 Netfilter Core Team
device eth0.1 entered promiscuous mode
device eth0 entered promiscuous mode
br-mesh: port 1(eth0.1) entering forwarding state
Ebtables v2.0 registered
ip6_tables: (C) 2000-2006 Netfilter Core Team
batman-adv:B.A.T.M.A.N. advanced 0.2.1-beta r1564 (compatibility version 8) loaded
ath_hal: module license 'Proprietary' taints kernel.
Disabling lock debugging due to kernel taint
ath_hal: 2009-05-08 (AR5212, AR5312, RF5111, RF5112, RF2316, RF2317, REGOPS_FUNC, TX_DESC_SWAP, XR)
device eth0.4 entered promiscuous mode
br-wan_vpn: port 1(eth0.4) entering forwarding state
br-wan_vpn: starting userspace STP failed, starting kernel STP
eth0.1: no IPv6 routers present
br-mesh: no IPv6 routers present
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
eth0.2: no IPv6 routers present
device bat0 entered promiscuous mode
br-mesh: port 2(bat0) entering forwarding state
eth0.3: no IPv6 routers present
eth0.4: no IPv6 routers present
bat0: no IPv6 routers present
br-wan_vpn: port 1(eth0.4) entering disabled state
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 1(eth0.4) entering forwarding state
br-mesh: port 2(bat0) entering disabled state
br-mesh: port 1(eth0.1) entering disabled state
br-mesh: port 2(bat0) entering forwarding state
br-mesh: port 1(eth0.1) entering forwarding state
br-wan_vpn: received tcn bpdu on port 1(eth0.4)
br-wan_vpn: topology change detected, propagating
ath0: no IPv6 routers present
br-mesh: no IPv6 routers present
batman-adv:Adding interface: ath0
batman-adv:Interface activated: ath0
batman-adv:Adding interface: eth0.2
batman-adv:Interface activated: eth0.2
batman-adv:Adding interface: eth0.3
batman-adv:Interface activated: eth0.3
jffs2_scan_eraseblock(): End of filesystem marker found at 0x0
jffs2_build_filesystem(): unlocking the mtd device... done.
jffs2_build_filesystem(): erasing all blocks after the end marker... <6>device VPN entered promiscuous mode
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 2(VPN) entering forwarding state
done.
mini_fo: using base directory: /
mini_fo: using storage directory: /jffs
br-wan_vpn: received tcn bpdu on port 1(eth0.4)
br-wan_vpn: topology change detected, propagating
br-wan_vpn: received tcn bpdu on port 1(eth0.4)
br-wan_vpn: topology change detected, propagating
br-wan_vpn: received tcn bpdu on port 1(eth0.4)
br-wan_vpn: topology change detected, propagating
------------[ cut here ]------------
WARNING: at kernel/softirq.c:141 local_bh_enable+0x48/0xa0()
Modules linked in: ath_ahb ath_hal(P) batman_adv ip6t_REJECT ip6t_LOG ip6t_rt ip6t_hbh ip6t_mh ip6t_ipv6header ip6t_frag ip6t_eui64 ip6t_ah ip6table_raw ip6_queue ip6table_mangle ip6table_filter ip6_tables ebt_redirect ebt_mark ebt_vlan ebt_stp ebt_pkttype ebt_mark_m ebt_limit ebt_among ebt_802_3 ebtable_nat ebtable_filter ebtable_broute ebtables xt_quota xt_pkttype xt_physdev ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ip_tables xt_tcpudp x_tables tun ipv6
Call Trace:
[<800493a4>] dump_stack+0x8/0x34
[<80060cd8>] warn_slowpath_common+0x70/0xb0
[<800674ac>] local_bh_enable+0x48/0xa0
[<801b3ef8>] dev_queue_xmit+0x388/0x3dc
[<8062c454>] ieee80211_parent_queue_xmit+0x8c/0xb4 [ath_ahb]
[<8062c778>] ieee80211_hardstart+0x2fc/0x34c [ath_ahb]
[<801b3e5c>] dev_queue_xmit+0x2ec/0x3dc
[<80bb68d8>] vis_quit+0x7c4/0x950 [batman_adv]

---[ end trace e96b16c908cf7c40 ]---
br-wan_vpn: received tcn bpdu on port 1(eth0.4)
br-wan_vpn: topology change detected, propagating
root@OpenWrt:~#

--n8g4imXOkfNTN/H1--
