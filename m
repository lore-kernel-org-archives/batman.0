Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 26 Oct 2016 17:55:15 +0200
Message-Id: <20161026155515.18075-4-sw@simonwunderlich.de>
In-Reply-To: <20161026155515.18075-1-sw@simonwunderlich.de>
References: <20161026155515.18075-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: fix splat on disabling an
	interface
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Linus Lüssing <linus.luessing@c0d3.blue>

As long as there is still a reference for a hard interface held, there might
still be a forwarding packet relying on its attributes.

Therefore avoid setting hard_iface->soft_iface to NULL when disabling a hard
interface.

This fixes the following, potential splat:

    batman_adv: bat0: Interface deactivated: eth1
    batman_adv: bat0: Removing interface: eth1
    cgroup: new mount options do not match the existing superblock, will be ignored
    batman_adv: bat0: Interface deactivated: eth3
    batman_adv: bat0: Removing interface: eth3
    ------------[ cut here ]------------
    WARNING: CPU: 3 PID: 1986 at ./net/batman-adv/bat_iv_ogm.c:549 batadv_iv_send_outstanding_bat_ogm_packet+0x145/0x643 [batman_adv]
    Modules linked in: batman_adv(O-) <...>
    CPU: 3 PID: 1986 Comm: kworker/u8:2 Tainted: G        W  O    4.6.0-rc6+ #1
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-20140531_083030-gandalf 04/01/2014
    Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet [batman_adv]
     0000000000000000 ffff88001d93bca0 ffffffff8126c26b 0000000000000000
     0000000000000000 ffff88001d93bcf0 ffffffff81051615 ffff88001f19f818
     000002251d93bd68 0000000000000046 ffff88001dc04a00 ffff88001becbe48
    Call Trace:
     [<ffffffff8126c26b>] dump_stack+0x67/0x90
     [<ffffffff81051615>] __warn+0xc7/0xe5
     [<ffffffff8105164b>] warn_slowpath_null+0x18/0x1a
     [<ffffffffa0356f24>] batadv_iv_send_outstanding_bat_ogm_packet+0x145/0x643 [batman_adv]
     [<ffffffff8108b01f>] ? __lock_is_held+0x32/0x54
     [<ffffffff810689a2>] process_one_work+0x2a8/0x4f5
     [<ffffffff81068856>] ? process_one_work+0x15c/0x4f5
     [<ffffffff81068df2>] worker_thread+0x1d5/0x2c0
     [<ffffffff81068c1d>] ? process_scheduled_works+0x2e/0x2e
     [<ffffffff81068c1d>] ? process_scheduled_works+0x2e/0x2e
     [<ffffffff8106dd90>] kthread+0xc0/0xc8
     [<ffffffff8144de82>] ret_from_fork+0x22/0x40
     [<ffffffff8106dcd0>] ? __init_kthread_worker+0x55/0x55
    ---[ end trace 647f9f325123dc05 ]---

What happened here is, that there was still a forw_packet (here: a BATMAN IV
OGM) in the queue of eth3 with the forw_packet->if_incoming set to eth1 and the
forw_packet->if_outgoing set to eth3.

When eth3 is to be deactivated and removed, then this thread waits for the
forw_packet queued on eth3 to finish. Because eth1 was deactivated and removed
earlier and by that had forw_packet->if_incoming->soft_iface, set to NULL, the
splat when trying to send/flush the OGM on eth3 occures.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
[sven@narfation.org: Reduced size of Oops message]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 08ce361..e034afb 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -652,7 +652,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 			batadv_softif_destroy_sysfs(hard_iface->soft_iface);
 	}
 
-	hard_iface->soft_iface = NULL;
 	batadv_hardif_put(hard_iface);
 
 out:
-- 
2.10.1

