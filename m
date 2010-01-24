Return-Path: <linus.luessing@web.de>
Date: Sun, 24 Jan 2010 21:42:12 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100124204212.GA4350@Sellars>
References: <20100123174616.GA4795@Sellars>
 <20100123181048.GO24649@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20100123181048.GO24649@lunn.ch>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Andrew,

Here is the output with the symbols inserted. I can reproduce this
memory leak very reliable now, by just activating the vis server
(didn't do that with the logs I've posted before) in a couple of
minutes. free is showing a nice countdown then :).

For kmemleak... I'm using 2.6.30.10 here and I think Torvalds
merged it into 2.6.33 a month ago. Anyone having a 2.6.33 kernel
running at the moment, patches for kmemleak in 2.6.30 or another
idea of how to debug this in 2.6.30?

"Debug slab memory allocations" (CONFIG_DEBUG_SLAB) and "Memory
leak debugging" (DEBUG_SLAB_LEAK) are activated on the kernel I'm
using here, but they are not of any use, are they?

Cheers, Linus

On Sat, Jan 23, 2010 at 07:10:48PM +0100, Andrew Lunn wrote:
> On Sat, Jan 23, 2010 at 06:46:16PM +0100, Linus L??ssing wrote:
> > Hey guys,
> > 
> > I've been installing a 9 node setup here in our cellar. They are
> > all running B.A.T.M.A.N. adv 0.2.1-beta r1545 (so the current
> > batman-adv maintance version in OpenWRT).
> > 
> > The result over night:
> > - 1x: bat_events: page allocation failure
> 
> This looks like a memory leak somewhere. It could be anywhere, batman
> or some other part of the kernel.
> 
> Can you build your kernel with the kernel memory leak detector
> enabled? It is under the Kernel Hacking options. You probably also
> need to build the kernel with symbols, which will help with ksymopps
> anyway. Documentation for kmemleak is in Documentation/kmemleak.txt.
> I've never used it myself, so i've no idea how good it actually is...
> 
> Interestingly, did you notice the warnings:
> 
> batman-adv:The newly added mac address (00:24:01:b7:6a:d2) already exists on: eth0.2
> batman-adv:It is strongly recommended to keep mac addresses unique to avoid
> +problems!
> 
> I guess this is because you are using VLANs. Have you seen these
> problems without using VLANs? 
> 
> 	 Andrew
> 

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment; filename="2010-01-24-20-53-memory-leak.log"
Content-Transfer-Encoding: 8bit

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
Image loaded from 0x80041000-0x802c8200
DD-WRT> exec
Now booting linux kernel:
 Base address 0x80030000 Entry 0x80041000
 Cmdline :
Linux version 2.6.30.10 (linus@Linus-Debian) (gcc version 4.3.3 (GCC) ) #2 Sun Jan 24 04:12:11 CET 2010
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
Memory: 13300k/16384k available (2002k kernel code, 3084k reserved, 458k data, 128k init, 0k highmem)
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
msgmni has been set to 25
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
Press CTRL-C for failsafe
switching to jffs2
mini_fo: using base directory: /
mini_fo: using storage directory: /jffs
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
device eth0.4 entered promiscuous mode
br-wan_vpn: port 1(eth0.4) entering forwarding state
br-wan_vpn: starting userspace STP failed, starting kernel STP
batman-adv:B.A.T.M.A.N. advanced 0.2.1-beta r1545 (compatibility version 8) loaded
ath_hal: module license 'Proprietary' taints kernel.
Disabling lock debugging due to kernel taint
ath_hal: 2009-05-08 (AR5212, AR5312, RF5111, RF5112, RF2316, RF2317, REGOPS_FUNC, TX_DESC_SWAP, XR)
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
br-wan_vpn: port 1(eth0.4) entering disabled state
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 1(eth0.4) entering forwarding state
br-mesh: port 2(bat0) entering disabled state
br-mesh: port 1(eth0.1) entering disabled state
br-mesh: port 2(bat0) entering forwarding state
br-mesh: port 1(eth0.1) entering forwarding state
batman-adv:Adding interface: ath0
batman-adv:Interface activated: ath0
batman-adv:Adding interface: eth0.2
batman-adv:Interface activated: eth0.2
batman-adv:Adding interface: eth0.3
batman-adv:Interface activated: eth0.3
device VPN entered promiscuous mode
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 2(VPN) entering forwarding state



BusyBox v1.15.3 (2010-01-24 04:59:20 CET) built-in shell (ash)
Enter 'help' for a list of built-in commands.

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 KAMIKAZE (bleeding edge, r19304) ------------------
  * 10 oz Vodka       Shake well with ice and strain
  * 10 oz Triple sec  mixture into 10 shot glasses.
  * 10 oz lime juice  Salute!
 ---------------------------------------------------
root@OpenWrt:/# batctl
Usage: batctl [options] commands
commands:
        interface|if  [none|interface]          display or modify the interface settings
        originators|o                           display the originator table
        interval|it   [orig_interval]           display or modify the originator interval in ms
        loglevel|ll   [level]                   display or modify the log level
        log|l                                   read the log produced by the kernel module
        translocal|tl                           display the local translation table
        transglobal|tg                          display the global translation table
        vis_server|vs [enable|disable]          display or modify the status of the VIS server
        vis_data|vd [dot|JSON]                  display the VIS data in dot or JSON format
        aggregation|ag   [0|1]                  display or modify the packet aggregation setting

        ping|p        <destination>             ping another batman adv host via layer 2
        traceroute|tr <destination>             traceroute another batman adv host via layer 2
        tcpdump|td    <interface>               tcpdump layer 2 traffic on the given interface
        bisect        <file1> .. <fileN>        analyze given log files for routing stability
options:
        -h print this help (or 'batctl <command> -h' for the command specific help)
        -v print version
root@OpenWrt:/# batctl vs enabled
batman-adv:Setting VIS mode to server (enabling vis server)
root@OpenWrt:/# watchdog invoked oom-killer: gfp_mask=0x1201d2, order=0, oomkilladj=0
Call Trace:
[<800493a4>] dump_stack+0x8/0x34
[<8009b644>] oom_kill_process+0x6c/0x1fc
[<8009bd08>] __out_of_memory+0x184/0x1bc
[<8009bdb0>] out_of_memory+0x70/0xa0
[<8009f03c>] __alloc_pages_internal+0x338/0x434
[<800a1e64>] __do_page_cache_readahead+0xe0/0x278
[<800a206c>] do_page_cache_readahead+0x70/0x8c
[<80098880>] filemap_fault+0x19c/0x464
[<800ae778>] __do_fault+0x74/0x4e8
[<800b0e18>] handle_mm_fault+0x314/0x6fc
[<80055d3c>] do_page_fault+0x110/0x30c
[<80041420>] ret_from_exception+0x0/0x24

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:160 active_file:0 inactive_anon:164
 inactive_file:10 dirty:0 writeback:0 unstable:0
 free:126 slab:2222 mapped:0 pagetables:49 bounce:0
Normal free:500kB min:508kB low:632kB high:760kB active_anon:640kB inactive_anon:656kB active_file:0kB inactive_file:40kB present:16256kB pages_scanned:1533 all_unreclaimable? no
lowmem_reserve[]: 0 0
Normal: 1*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 500kB
27 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM
739 pages reserved
10 pages shared
3105 pages non-shared
Out of memory: kill process 967 (dnsmasq) score 225 or a child
Killed process 967 (dnsmasq)
swapper: page allocation failure. order:0, mode:0x20
Call Trace:
[<800493a4>] dump_stack+0x8/0x34
[<8009f0f0>] __alloc_pages_internal+0x3ec/0x434
[<800c2990>] cache_alloc_refill+0x39c/0x950
[<800c30c8>] __kmalloc_track_caller+0x184/0x208
[<801aee18>] __alloc_skb+0x7c/0x158
[<801afd2c>] dev_alloc_skb+0x1c/0x4c
[<8069c2c8>] ieee80211_dev_alloc_skb+0x18/0x60 [ath_ahb]
[<80683f98>] ath_sysctl_unregister+0x2680/0x6ecc [ath_ahb]

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:160 active_file:3 inactive_anon:164
 inactive_file:3 dirty:0 writeback:0 unstable:0
 free:48 slab:2304 mapped:0 pagetables:49 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:640kB inactive_anon:656kB active_file:12kB inactive_file:12kB present:16256kB pages_scanned:2290 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
23 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM
739 pages reserved
6 pages shared
3185 pages non-shared
swapper: page allocation failure. order:0, mode:0x20
Call Trace:
[<800493a4>] dump_stack+0x8/0x34
[<8009f0f0>] __alloc_pages_internal+0x3ec/0x434
[<800c2990>] cache_alloc_refill+0x39c/0x950
[<800c30c8>] __kmalloc_track_caller+0x184/0x208
[<801aee18>] __alloc_skb+0x7c/0x158
[<801afd2c>] dev_alloc_skb+0x1c/0x4c
[<8069c2c8>] ieee80211_dev_alloc_skb+0x18/0x60 [ath_ahb]
[<80683f98>] ath_sysctl_unregister+0x2680/0x6ecc [ath_ahb]

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:160 active_file:3 inactive_anon:164
 inactive_file:3 dirty:0 writeback:0 unstable:0
 free:48 slab:2304 mapped:0 pagetables:49 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:640kB inactive_anon:656kB active_file:12kB inactive_file:12kB present:16256kB pages_scanned:2290 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
23 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM
739 pages reserved
6 pages shared
3185 pages non-shared
wifi0: ath_reset: Unable to start receive logic.
bat_events: page allocation failure. order:0, mode:0x20
Call Trace:
[<800493a4>] dump_stack+0x8/0x34
[<8009f0f0>] __alloc_pages_internal+0x3ec/0x434
[<800c2990>] cache_alloc_refill+0x39c/0x950
[<800c30c8>] __kmalloc_track_caller+0x184/0x208
[<801aee18>] __alloc_skb+0x7c/0x158
[<801afd2c>] dev_alloc_skb+0x1c/0x4c
[<80bc2144>] send_raw_packet+0x3c/0xc0 [batman_adv]
[<80bc23bc>] send_outstanding_bat_packet+0x1f4/0x250 [batman_adv]
[<800767b8>] worker_thread+0x1b0/0x278
[<8007ac14>] kthread+0x5c/0xa0
[<8004ec88>] kernel_thread_helper+0x10/0x18

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:160 active_file:3 inactive_anon:164
 inactive_file:3 dirty:0 writeback:0 unstable:0
 free:48 slab:2304 mapped:0 pagetables:49 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:640kB inactive_anon:656kB active_file:12kB inactive_file:12kB present:16256kB pages_scanned:2290 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
23 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM
739 pages reserved
6 pages shared
3185 pages non-shared
bat_events: page allocation failure. order:0, mode:0x20
Call Trace:
[<800493a4>] dump_stack+0x8/0x34
[<8009f0f0>] __alloc_pages_internal+0x3ec/0x434
[<800c2990>] cache_alloc_refill+0x39c/0x950
[<800c30c8>] __kmalloc_track_caller+0x184/0x208
[<801aee18>] __alloc_skb+0x7c/0x158
[<801afd2c>] dev_alloc_skb+0x1c/0x4c
[<8069c2c8>] ieee80211_dev_alloc_skb+0x18/0x60 [ath_ahb]
[<80683f98>] ath_sysctl_unregister+0x2680/0x6ecc [ath_ahb]

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:160 active_file:3 inactive_anon:164
 inactive_file:3 dirty:0 writeback:0 unstable:0
 free:48 slab:2304 mapped:0 pagetables:49 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:640kB inactive_anon:656kB active_file:12kB inactive_file:12kB present:16256kB pages_scanned:2290 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
23 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM
739 pages reserved
6 pages shared
3185 pages non-shared
wifi0: ath_reset: Unable to start receive logic.
bat_events: page allocation failure. order:0, mode:0x20
Call Trace:
[<800493a4>] dump_stack+0x8/0x34
[<8009f0f0>] __alloc_pages_internal+0x3ec/0x434
[<800c2990>] cache_alloc_refill+0x39c/0x950
[<800c30c8>] __kmalloc_track_caller+0x184/0x208
[<801aee18>] __alloc_skb+0x7c/0x158
[<801afd2c>] dev_alloc_skb+0x1c/0x4c
[<8022bb7c>] br_send_bpdu+0x2c/0x150
[<8022beb8>] br_send_config_bpdu+0x1d0/0x1ec
[<8022b398>] br_transmit_config+0x148/0x180
[<8022b4b4>] br_config_bpdu_generation+0x60/0x8c
[<8022cc58>] br_hello_timer_expired+0x28/0x64
[<8006e204>] run_timer_softirq+0x17c/0x234
[<80068f6c>] __do_softirq+0xa4/0x154
[<80069078>] do_softirq+0x5c/0x98
[<80041444>] ret_from_irq+0x0/0x4
[<800c30e8>] __kmalloc_track_caller+0x1a4/0x208
[<801aee18>] __alloc_skb+0x7c/0x158
[<801afd2c>] dev_alloc_skb+0x1c/0x4c
[<80bc2144>] send_raw_packet+0x3c/0xc0 [batman_adv]
[<80bc23bc>] send_outstanding_bat_packet+0x1f4/0x250 [batman_adv]
[<800767b8>] worker_thread+0x1b0/0x278
[<8007ac14>] kthread+0x5c/0xa0
[<8004ec88>] kernel_thread_helper+0x10/0x18

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:160 active_file:3 inactive_anon:164
 inactive_file:3 dirty:0 writeback:0 unstable:0
 free:48 slab:2304 mapped:0 pagetables:49 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:640kB inactive_anon:656kB active_file:12kB inactive_file:12kB present:16256kB pages_scanned:2290 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
23 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM
739 pages reserved
6 pages shared
3185 pages non-shared
bat_events: page allocation failure. order:0, mode:0x20
Call Trace:
[<800493a4>] dump_stack+0x8/0x34
[<8009f0f0>] __alloc_pages_internal+0x3ec/0x434
[<800c2990>] cache_alloc_refill+0x39c/0x950
[<800c30c8>] __kmalloc_track_caller+0x184/0x208
[<801aee18>] __alloc_skb+0x7c/0x158
[<801afd2c>] dev_alloc_skb+0x1c/0x4c
[<8022bb7c>] br_send_bpdu+0x2c/0x150
[<8022beb8>] br_send_config_bpdu+0x1d0/0x1ec
[<8022b398>] br_transmit_config+0x148/0x180
[<8022b4b4>] br_config_bpdu_generation+0x60/0x8c
[<8022cc58>] br_hello_timer_expired+0x28/0x64
[<8006e204>] run_timer_softirq+0x17c/0x234
[<80068f6c>] __do_softirq+0xa4/0x154
[<80069078>] do_softirq+0x5c/0x98
[<80041444>] ret_from_irq+0x0/0x4
[<800c30e8>] __kmalloc_track_caller+0x1a4/0x208
[<801aee18>] __alloc_skb+0x7c/0x158
[<801afd2c>] dev_alloc_skb+0x1c/0x4c
[<80bc2144>] send_raw_packet+0x3c/0xc0 [batman_adv]
[<80bc23bc>] send_outstanding_bat_packet+0x1f4/0x250 [batman_adv]
[<800767b8>] worker_thread+0x1b0/0x278
[<8007ac14>] kthread+0x5c/0xa0
[<8004ec88>] kernel_thread_helper+0x10/0x18

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:160 active_file:3 inactive_anon:164
 inactive_file:3 dirty:0 writeback:0 unstable:0
 free:48 slab:2304 mapped:0 pagetables:49 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:640kB inactive_anon:656kB active_file:12kB inactive_file:12kB present:16256kB pages_scanned:2290 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
23 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM
739 pages reserved
6 pages shared
3185 pages non-shared
bat_events: page allocation failure. order:0, mode:0x20
Call Trace:
[<800493a4>] dump_stack+0x8/0x34
[<8009f0f0>] __alloc_pages_internal+0x3ec/0x434
[<800c2990>] cache_alloc_refill+0x39c/0x950
[<800c30c8>] __kmalloc_track_caller+0x184/0x208
[<801aee18>] __alloc_skb+0x7c/0x158
[<801afd2c>] dev_alloc_skb+0x1c/0x4c
[<8069c2c8>] ieee80211_dev_alloc_skb+0x18/0x60 [ath_ahb]
[<80683f98>] ath_sysctl_unregister+0x2680/0x6ecc [ath_ahb]

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:160 active_file:3 inactive_anon:164
 inactive_file:3 dirty:0 writeback:0 unstable:0
 free:48 slab:2304 mapped:0 pagetables:49 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:640kB inactive_anon:656kB active_file:12kB inactive_file:12kB present:16256kB pages_scanned:2290 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
23 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM
739 pages reserved
6 pages shared
3185 pages non-shared
wifi0: ath_reset: Unable to start receive logic.
watchdog expired, rebooting system
+

--IS0zKkzwUGydFO0o--
