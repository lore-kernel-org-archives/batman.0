Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu,  6 Oct 2016 01:43:08 +0200
Message-Id: <20161005234308.29871-3-linus.luessing@c0d3.blue>
In-Reply-To: <20161005234308.29871-1-linus.luessing@c0d3.blue>
References: <20161005234308.29871-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v3 2/2] batman-adv: fix splat on disabling an
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
To: b.a.t.m.a.n@lists.open-mesh.org

As long as there is still a reference for a hard interface held, there
might still be a forwarding packet relying on its attributes.

Therefore avoid setting hard_iface->soft_iface to NULL when disabling a
hard interface.

This fixes the following, potential splat:

~~~~
[ 3082.208900] batman_adv: bat0: Interface deactivated: eth1
[ 3082.209483] batman_adv: bat0: Removing interface: eth1
[ 3092.087816] cgroup: new mount options do not match the existing superblock, will be ignored
[ 3095.774399] batman_adv: bat0: Interface deactivated: eth3
[ 3095.780828] batman_adv: bat0: Removing interface: eth3
[ 3096.344658] ------------[ cut here ]------------
[ 3096.345168] WARNING: CPU: 3 PID: 1986 at ./net/batman-adv/bat_iv_ogm.c:549 batadv_iv_send_outstanding_bat_ogm_packet+0x145/0x643 [batman_adv]
[ 3096.348972] Modules linked in: batman_adv(O-) evdev kvm_amd kvm acpi_cpufreq i2c_piix4 tpm_tis tpm irqbypass i2c_core serio_raw processor button bridge stp llc ipv6 autofs4 dm_mirror dm_region_hash dm_log dm_mod 9p fscache 9pnet_virtio 9pnet ata_generic virtio_pci libata virtio_ring virtio scsi_mod e1000 [last unloaded: batman_adv]
[ 3096.437029] CPU: 3 PID: 1986 Comm: kworker/u8:2 Tainted: G        W  O    4.6.0-rc6+ #1
[ 3096.439874] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-20140531_083030-gandalf 04/01/2014
[ 3096.452150] Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet [batman_adv]
[ 3096.452150]  0000000000000000 ffff88001d93bca0 ffffffff8126c26b 0000000000000000
[ 3096.452150]  0000000000000000 ffff88001d93bcf0 ffffffff81051615 ffff88001f19f818
[ 3096.452150]  000002251d93bd68 0000000000000046 ffff88001dc04a00 ffff88001becbe48
[ 3096.452150] Call Trace:
[ 3096.452150]  [<ffffffff8126c26b>] dump_stack+0x67/0x90
[ 3096.452150]  [<ffffffff81051615>] __warn+0xc7/0xe5
[ 3096.452150]  [<ffffffff8105164b>] warn_slowpath_null+0x18/0x1a
[ 3096.452150]  [<ffffffffa0356f24>] batadv_iv_send_outstanding_bat_ogm_packet+0x145/0x643 [batman_adv]
[ 3096.452150]  [<ffffffff8108b01f>] ? __lock_is_held+0x32/0x54
[ 3096.452150]  [<ffffffff810689a2>] process_one_work+0x2a8/0x4f5
[ 3096.452150]  [<ffffffff81068856>] ? process_one_work+0x15c/0x4f5
[ 3096.452150]  [<ffffffff81068df2>] worker_thread+0x1d5/0x2c0
[ 3096.452150]  [<ffffffff81068c1d>] ? process_scheduled_works+0x2e/0x2e
[ 3096.452150]  [<ffffffff81068c1d>] ? process_scheduled_works+0x2e/0x2e
[ 3096.452150]  [<ffffffff8106dd90>] kthread+0xc0/0xc8
[ 3096.452150]  [<ffffffff8144de82>] ret_from_fork+0x22/0x40
[ 3096.452150]  [<ffffffff8106dcd0>] ? __init_kthread_worker+0x55/0x55
[ 3096.612402] ---[ end trace 647f9f325123dc05 ]---
~~~~

What happened here is, that there was still a forw_packet (here: a
BATMAN IV OGM) in the queue of eth3 with the forw_packet->if_incoming
set to eth1 and the forw_packet->if_outgoing set to eth3.

When eth3 is to be deactivated and removed, then this thread waits for
the forw_packet queued on eth3 to finish. Because eth1 was deactivated
and removed earlier and by that had forw_packet->if_incoming->soft_iface,
set to NULL, the splat when trying to send/flush the OGM on eth3
occures.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

Changes in v3:
* none

Changes in v2:
* none, new patch
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
2.1.4

