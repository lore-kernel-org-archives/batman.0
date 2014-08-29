Return-Path: <baantunes@gmail.com>
MIME-Version: 1.0
Date: Fri, 29 Aug 2014 12:00:37 +0100
Message-ID: <CABUTiXXCFW8+xnk76sbaLRcH3yH9d5r6Oz4ZmA5OXk30eRJgBQ@mail.gmail.com>
From: Bruno Antunes <baantunes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Possible regression? Adhoc Mode broken & kernel oops
 with batman-adv.
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Using OpenWrt trunk r42000 on 2 different boards (gw2388-4 & router
station pro) causes kernel oops when restarting the network or wifi.

The setting that causes the oops is connecting in adhoc mode to a
batman-adv mesh network.

As comparison WDS mode works fine for the same boards.

Also Adhoc mode using wpa_supplicant appears to be broken.
With wpa2 security only allows connections at 54 Mbps, removing
security allows for 802.11n rates.

Don't know if the 2 issues are related or not.

Below the kernel oops from the router station.

Regards,
Bruno

root@RSPro1:/# wifi
root@RSPro1:/# [  182.040000] batman_adv: bat0: Interface deactivated: adhoc0
[  182.050000] batman_adv: bat0: Removing interface: adhoc0
[  182.080000] br-mesh: port 2(bat0) entered disabled state
[  182.080000] device bat0 left promiscuous mode
[  182.090000] br-mesh: port 2(bat0) entered disabled state
[  182.100000] CPU 0 Unable to handle kernel paging request at virtual
address 00000020, epc == 87090884, ra == 870963e8
[  182.110000] Oops[#1]:
[  182.110000] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 3.10.49 #2
[  182.110000] Workqueue: bat_events batadv_softif_vlan_get [batman_adv]
[  182.110000] task: 878294f0 ti: 87844000 task.ti: 87844000
[  182.110000] $ 0   : 00000000 00000001 00000020 00000000
[  182.110000] $ 4   : 00000000 00008004 80321e28 803825a2
[  182.110000] $ 8   : 00180041 00180041 00000001 873d7080
[  182.110000] $12   : 00000020 00000001 00170041 00000000
[  182.110000] $16   : 00000000 86913200 00000000 8690b100
[  182.110000] $20   : 000001b0 00000000 00200200 ffffd1f2
[  182.110000] $24   : 00000000 00000000
[  182.110000] $28   : 87844000 87845da0 802eb3b0 870963e8
[  182.110000] Hi    : 00000009
[  182.110000] Lo    : 00009c40
[  182.110000] epc   : 87090884 batadv_softif_vlan_free_ref+0x14/0xe0
[batman_adv]
[  182.110000]     Not tainted
[  182.110000] ra    : 870963e8 batadv_tt_free+0xc0/0x2e4 [batman_adv]
[  182.110000] Status: 1000fc03 KERNEL EXL IE
[  182.110000] Cause : 00800008
[  182.110000] BadVA : 00000020
[  182.110000] PrId  : 00019374 (MIPS 24Kc)
[  182.110000] Modules linked in: ath9k ath9k_htc ath9k_common pppoe
ppp_async iptable_nat ath9k_hw ath pppox ppp_generic pl2303
nf_nat_ipv4 nf_conntrack_ipvh
[  182.110000] Process kworker/u2:0 (pid: 6, threadinfo=87844000,
task=878294f0, tls=00000000)
[  182.110000] Stack : 00000000 8692ebc0 8692e800 87845e30 8692ebc0
870963e8 ffffd1f2 ffffd1f2
          8692ebc0 8692ebc0 8692ebc0 8692e800 87845e30 80310000
80310f20 00000000
          ffffd1f2 8708a374 ffffd1f2 87084fd4 87845e30 00000001
80310f20 8692e800
          8692e800 8708fa24 00000000 87845e0c 00000000 8692ea08
8692ea08 801b2b74
          878294f0 8027c780 00000000 8692e800 87845e30 87845e30
87813900 8692ecb8
          ...
[  182.110000] Call Trace:
[  182.110000] [<87090884>] batadv_softif_vlan_free_ref+0x14/0xe0 [batman_adv]
[  182.110000] [<870963e8>] batadv_tt_free+0xc0/0x2e4 [batman_adv]
[  182.110000] [<8708a374>] batadv_mesh_free+0x54/0x88 [batman_adv]
[  182.110000] [<8708fa24>]
batadv_purge_outstanding_packets+0x2fc/0x8d8 [batman_adv]
[  182.110000]
[  182.110000]
Code: afb00010  afbf0014  00808021 <c0430000> 2464ffff  e0440000
1080fffc  00000000  24020001
[  182.360000] ---[ end trace 19fd45c8593c0fb4 ]---
[  182.370000] Kernel panic - not syncing: Fatal exception in interrupt
[  182.370000] Rebooting in 3 seconds..+
