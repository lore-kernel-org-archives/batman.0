Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu,  6 Oct 2016 01:43:07 +0200
Message-Id: <20161005234308.29871-2-linus.luessing@c0d3.blue>
In-Reply-To: <20161005234308.29871-1-linus.luessing@c0d3.blue>
References: <20161005234308.29871-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v3 1/2] batman-adv: fix race conditions on
	interface removal
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

The most prominent general protection fault I was experiencing when
quickly removing and adding interfaces to batman-adv is the following:

~~~~~~
[ 1137.316136] general protection fault: 0000 [#1] SMP
[ 1137.316717] Modules linked in: batman_adv(O-) evdev kvm_amd kvm acpi_cpufreq i2c_piix4 tpm_tis tpm irqbypass i2c_core serio_raw processor button bridge stp llc ipv6 autofs4 dm_mirror dm_region_hash dm_log dm_mod 9p fscache 9pnet_virtio 9pnet ata_generic virtio_pci libata virtio_ring virtio e1000 scsi_mod [last unloaded: batman_adv]
[ 1137.320038] CPU: 3 PID: 1714 Comm: rmmod Tainted: G           O    4.6.0-rc6+ #1
[ 1137.320038] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-20140531_083030-gandalf 04/01/2014
[ 1137.320038] task: ffff88001d5d0440 ti: ffff88001da5c000 task.ti: ffff88001da5c000
[ 1137.320038] RIP: 0010:[<ffffffffa0371852>]  [<ffffffffa0371852>] batadv_purge_outstanding_packets+0x1c8/0x291 [batman_adv]
[ 1137.320038] RSP: 0018:ffff88001da5fd78  EFLAGS: 00010202
[ 1137.320038] RAX: 6b6b6b6b6b6b6b6b RBX: 6b6b6b6b6b6b6b6b RCX: 0000000000000002
[ 1137.320038] RDX: 0000000000000002 RSI: 00000000000000e0 RDI: ffff88001d5d0c08
[ 1137.320038] RBP: ffff88001da5fdb8 R08: 0000000000000200 R09: 0000000000000001
[ 1137.320038] R10: ffff88001d5d0c08 R11: ffff88001d5d0c08 R12: 0000000000000000
[ 1137.320038] R13: ffff88001bd1d400 R14: ffff88001d15eb48 R15: ffffffffa03d4a01
[ 1137.320038] FS:  00007feeec934700(0000) GS:ffff88001f580000(0000) knlGS:0000000000000000
[ 1137.320038] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1137.320038] CR2: 00007fd9f90d7000 CR3: 000000001b323000 CR4: 00000000000006e0
[ 1137.320038] Stack:
[ 1137.320038]  ffffffffa03d6a90 6b6b6b6b6b6b6b6b 000000001d15ea00 ffff88001bd1d400
[ 1137.320038]  ffff88001d15ea00 ffff88001d15e000 ffff88001bd1d400 ffffffffa03d4a40
[ 1137.320038]  ffff88001da5fe08 ffffffffa0363294 000000001da5fdf8 ffff88001d15e000
[ 1137.320038] Call Trace:
[ 1137.320038]  [<ffffffffa0363294>] batadv_hardif_disable_interface+0x29a/0x3a6 [batman_adv]
[ 1137.320038]  [<ffffffffa0373db4>] batadv_softif_destroy_netlink+0x4b/0xa4 [batman_adv]
[ 1137.320038]  [<ffffffff813b52f3>] __rtnl_link_unregister+0x48/0x92
[ 1137.320038]  [<ffffffff813b9240>] rtnl_link_unregister+0xc1/0xdb
[ 1137.320038]  [<ffffffff8108547c>] ? bit_waitqueue+0x87/0x87
[ 1137.320038]  [<ffffffffa03850d2>] batadv_exit+0x1a/0xf48 [batman_adv]
[ 1137.320038]  [<ffffffff810c26f9>] SyS_delete_module+0x136/0x1b0
[ 1137.320038]  [<ffffffff8144dc65>] entry_SYSCALL_64_fastpath+0x18/0xa8
[ 1137.320038]  [<ffffffff8108aaca>] ? trace_hardirqs_off_caller+0x37/0xa6
[ 1137.320038] Code: 89 f7 e8 21 bd 0d e1 4d 85 e4 75 0e 31 f6 48 c7 c7 50 d7 3b a0 e8 50 16 f2 e0 49 8b 9c 24 28 01 00 00 48 85 db 0f 84 b2 00 00 00 <48> 8b 03 4d 85 ed 48 89 45 c8 74 09 4c 39 ab f8 00 00 00 75 1c
[ 1137.320038] RIP  [<ffffffffa0371852>] batadv_purge_outstanding_packets+0x1c8/0x291 [batman_adv]
[ 1137.320038]  RSP <ffff88001da5fd78>
[ 1137.451885] ---[ end trace 803b9bdc6a4a952b ]---
[ 1137.453154] Kernel panic - not syncing: Fatal exception in interrupt
[ 1137.457143] Kernel Offset: disabled
[ 1137.457143] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
~~~~~~

It can be easily reproduced with some carefully placed
msleeps()/mdelay()s.

The issue is, that on interface removal, any still running worker thread
of a forwarding packet will race with the interface purging routine to
free a forwarding packet. Temporarilly giving up a spin-lock to be able
to sleep in the purging routine is not safe.

Furthermore, there is a potential general protection fault not just for
the purging side shown above, but also on the worker side: Temporarily
removing a forw_packet from the according forw_{bcast,bat}_list will make
it impossible for the purging routine to catch and cancel it.

 # How this patch tries to fix it:

With this patch we split the queue purging into three steps: Step 1),
removing forward packets from the queue of an interface and by that
claim it as our responsibility to free.

Step 2), we are either lucky to cancel a pending worker before it starts
to run. Or if it is already running, we wait and let it do its thing,
except two things:

Through the claiming in step 1) we prevent workers from a) re-arming
themselves. And b) prevent workers from freeing packets which we still
hold in the interface purging routine.

Finally, step 3, we are sure that no forwarding packets are pending or
even running anymore on the interface to remove. We can then safely free
the claimed forwarding packets.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

Changes in v3:
* added compat code for hlist_fake()
* added kerneldoc for @send_time for batadv_forw_packet_queue()
* added "#include <linux/bug.h>" for WARN_ONCE()
(thanks Sven!)

Changes in v2:
* Merged the following two commits:
  - "batman-adv: Fix a potential bcast/ogm queue purging race condition (1)")
  - "batman-adv: Fix a potential bcast/ogm queue purging race condition (2)")
  - "batman-adv: Fix a potential bcast/ogm queue purging race condition (3)")
* Updated commit message
  - e.g. added kernel oops
* renamed:
  - forw_packet->canceled_list -> forw_packet->bm_list
  - batadv_cancel_packets() -> batadv_forw_packet_list_steal()
  - batadv_canceled_packets_free() -> batadv_forw_packet_list_free()
  => overall, tried to keep it more API-like for easier validation
* rebased to master
  -> batadv_forw_packet_list_cancel() takes if_outgoing into account,
     too
* added kerneldoc for forw_packet->bm_list in types.h
* replaced an INIT_HLIST_HEAD() call with direct
  "head = HLIST_INIT_HEAD" assignment

PS: checkpatch throws the following at me, but seems to be bogus?

~~~~
-------------------------------------------------------------------
/tmp/0001-batman-adv-fix-race-conditions-on-interface-removal.patch
-------------------------------------------------------------------
CHECK: spinlock_t definition without comment
+                             spinlock_t *lock);

total: 0 errors, 0 warnings, 1 checks, 411 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/tmp/0001-batman-adv-fix-race-conditions-on-interface-removal.patch has style problems, please review.
~~~~~
---
 compat-include/linux/list.h |  13 +-
 net/batman-adv/bat_iv_ogm.c |  19 +--
 net/batman-adv/send.c       | 286 +++++++++++++++++++++++++++++++++-----------
 net/batman-adv/send.h       |   6 +
 net/batman-adv/types.h      |   2 +
 5 files changed, 240 insertions(+), 86 deletions(-)

diff --git a/compat-include/linux/list.h b/compat-include/linux/list.h
index c7f07f1..30a14e0 100644
--- a/compat-include/linux/list.h
+++ b/compat-include/linux/list.h
@@ -43,12 +43,21 @@
 	pos && ({ n = pos->member.next; 1; }); \
 	pos = hlist_entry_safe(n, typeof(*pos), member))
 
-#endif
+#endif /* < KERNEL_VERSION(3, 9, 0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
 
 #define hlist_add_behind(n, prev) hlist_add_after(prev, n)
 
-#endif
+#endif /* < KERNEL_VERSION(3, 17, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 3, 0)
+
+static inline bool hlist_fake(struct hlist_node *h)
+{
+	return h->pprev == &h->next;
+}
+
+#endif /* < KERNEL_VERSION(4, 3, 0) */
 
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_LIST_H_ */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index e2d18d0..9c723cf 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -717,17 +717,10 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	if (direct_link)
 		forw_packet_aggr->direct_link_flags |= 1;
 
-	/* add new packet to packet list */
-	spin_lock_bh(&bat_priv->forw_bat_list_lock);
-	hlist_add_head(&forw_packet_aggr->list, &bat_priv->forw_bat_list);
-	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
-
-	/* start timer for this packet */
 	INIT_DELAYED_WORK(&forw_packet_aggr->delayed_work,
 			  batadv_iv_send_outstanding_bat_ogm_packet);
-	queue_delayed_work(batadv_event_workqueue,
-			   &forw_packet_aggr->delayed_work,
-			   send_time - jiffies);
+
+	batadv_forw_packet_ogmv1_queue(bat_priv, forw_packet_aggr, send_time);
 }
 
 /* aggregate a new packet into the existing ogm packet */
@@ -1788,9 +1781,6 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
 				   delayed_work);
 	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
-	spin_lock_bh(&bat_priv->forw_bat_list_lock);
-	hlist_del(&forw_packet->list);
-	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
 
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
@@ -1810,7 +1800,10 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 		batadv_iv_ogm_schedule(forw_packet->if_incoming);
 
 out:
-	batadv_forw_packet_free(forw_packet);
+	/* do we get something for free()? */
+	if (batadv_forw_packet_steal(forw_packet,
+				     &bat_priv->forw_bat_list_lock))
+		batadv_forw_packet_free(forw_packet);
 }
 
 static int batadv_iv_ogm_receive(struct sk_buff *skb,
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 8d4e1f5..46ddc82 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -19,6 +19,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -514,6 +515,8 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 	if (if_outgoing)
 		kref_get(&if_outgoing->refcount);
 
+	INIT_HLIST_NODE(&forw_packet->list);
+	INIT_HLIST_NODE(&forw_packet->bm_list);
 	forw_packet->skb = NULL;
 	forw_packet->queue_left = queue_left;
 	forw_packet->if_incoming = if_incoming;
@@ -529,19 +532,190 @@ err:
 	return NULL;
 }
 
+/**
+ * batadv_forw_packet_was_stolen - check whether someone stole this packet
+ * @forw_packet: the forwarding packet to check
+ *
+ * This function checks whether the given forwarding packet was claimed by
+ * someone else for free().
+ *
+ * Return: True if someone stole it, false otherwise.
+ */
+static bool
+batadv_forw_packet_was_stolen(struct batadv_forw_packet *forw_packet)
+{
+	return !hlist_unhashed(&forw_packet->bm_list);
+}
+
+/**
+ * batadv_forw_packet_steal - claim a forw_packet for free()
+ * @forw_packet: the forwarding packet to steal
+ * @lock: a key to the store to steal from (e.g. forw_{bat,bcast}_list_lock)
+ *
+ * This function tries to steal a specific forw_packet from global
+ * visibility for the sole purpose of getting it for free(). That
+ * means the caller is *not* allowed to requeue it. (robbery 101: don't get
+ * back to crime scene)
+ *
+ * Return: True if stealing was successful. False if someone else stole it
+ * before us.
+ */
+bool batadv_forw_packet_steal(struct batadv_forw_packet *forw_packet,
+			      spinlock_t *lock)
+{
+	struct hlist_head head = HLIST_HEAD_INIT;
+
+	/* did purging routine steal it earlier? */
+	spin_lock_bh(lock);
+	if (batadv_forw_packet_was_stolen(forw_packet)) {
+		spin_unlock_bh(lock);
+		return false;
+	}
+
+	hlist_del(&forw_packet->list);
+
+	/* Just to spot misuse of this function */
+	hlist_add_head(&forw_packet->bm_list, &head);
+	hlist_add_fake(&forw_packet->bm_list);
+
+	spin_unlock_bh(lock);
+	return true;
+}
+
+/**
+ * batadv_forw_packet_list_steal - claim a list of forward packets for free()
+ * @forw_list: the to be stolen forward packets
+ * @black_market: a backup pointer, to be able to dispose the packet later
+ * @hard_iface: the interface to steal forward packets from
+ *
+ * This function claims responsibility to free any forw_packet queued on the
+ * given hard_iface. If hard_iface is NULL forwarding packets on all hard
+ * interfaces will be claimed.
+ *
+ * The packets are being moved from the forw_list to the black_market and
+ * by that allows already running threads to notice the claiming.
+ */
+static void
+batadv_forw_packet_list_steal(struct hlist_head *forw_list,
+			      struct hlist_head *black_market,
+			      const struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_forw_packet *forw_packet;
+	struct hlist_node *safe_tmp_node;
+
+	hlist_for_each_entry_safe(forw_packet, safe_tmp_node,
+				  forw_list, list) {
+		/* if purge_outstanding_packets() was called with an argument
+		 * we delete only packets belonging to the given interface
+		 */
+		if (hard_iface &&
+		    (forw_packet->if_incoming != hard_iface) &&
+		    (forw_packet->if_outgoing != hard_iface))
+			continue;
+
+		hlist_del(&forw_packet->list);
+		hlist_add_head(&forw_packet->bm_list, black_market);
+	}
+}
+
+/**
+ * batadv_forw_packet_list_free - free a list of forward packets
+ * @head: a list of to be freed forw_packets
+ *
+ * This function cancels the scheduling of any packet in the provided list,
+ * waits for any possibly running packet forwarding thread to finish and
+ * finally, safely frees this forward packet.
+ *
+ * This function might sleep.
+ */
+static void batadv_forw_packet_list_free(struct hlist_head *head)
+{
+	struct batadv_forw_packet *forw_packet;
+	struct hlist_node *safe_tmp_node;
+
+	hlist_for_each_entry_safe(forw_packet, safe_tmp_node, head,
+				  bm_list) {
+		cancel_delayed_work_sync(&forw_packet->delayed_work);
+
+		hlist_del(&forw_packet->bm_list);
+		batadv_forw_packet_free(forw_packet);
+	}
+}
+
+/**
+ * batadv_forw_packet_queue - try to queue a forwarding packet
+ * @forw_packet: the forwarding packet to queue
+ * @lock: a key to the store (e.g. forw_{bat,bcast}_list_lock)
+ * @head: the shelve to queue it on (e.g. forw_{bat,bcast}_list)
+ * @send_time: timestamp (jiffies) when the packet is to be sent
+ *
+ * This function tries to (re)queue a forwarding packet. If packet was stolen
+ * earlier then the shop owner will (usually) keep quiet about it.
+ *
+ * Caller needs to ensure that forw_packet->delayed_work was initialized.
+ */
+static void batadv_forw_packet_queue(struct batadv_forw_packet *forw_packet,
+				     spinlock_t *lock, struct hlist_head *head,
+				     unsigned long send_time)
+{
+	spin_lock_bh(lock);
+
+	/* did purging routine steal it from us? */
+	if (batadv_forw_packet_was_stolen(forw_packet)) {
+		/* If you got it for free() without trouble, then
+		 * don't get back into the queue after stealing...
+		 */
+		WARN_ONCE(hlist_fake(&forw_packet->bm_list),
+			  "Oh oh... the kernel OOPs are on our tail now... Jim won't bail us out this time!\n");
+
+		spin_unlock_bh(lock);
+		return;
+	}
+
+	hlist_del_init(&forw_packet->list);
+	hlist_add_head(&forw_packet->list, head);
+
+	queue_delayed_work(batadv_event_workqueue,
+			   &forw_packet->delayed_work,
+			   send_time - jiffies);
+	spin_unlock_bh(lock);
+}
+
+/**
+ * batadv_forw_packet_bcast_queue - try to queue a broadcast packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @forw_packet: the forwarding packet to queue
+ * @send_time: timestamp (jiffies) when the packet is to be sent
+ *
+ * This function tries to (re)queue a broadcast packet.
+ *
+ * Caller needs to ensure that forw_packet->delayed_work was initialized.
+ */
 static void
-_batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
-				 struct batadv_forw_packet *forw_packet,
-				 unsigned long send_time)
-{
-	/* add new packet to packet list */
-	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
-	hlist_add_head(&forw_packet->list, &bat_priv->forw_bcast_list);
-	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
-
-	/* start timer for this packet */
-	queue_delayed_work(batadv_event_workqueue, &forw_packet->delayed_work,
-			   send_time);
+batadv_forw_packet_bcast_queue(struct batadv_priv *bat_priv,
+			       struct batadv_forw_packet *forw_packet,
+			       unsigned long send_time)
+{
+	batadv_forw_packet_queue(forw_packet, &bat_priv->forw_bcast_list_lock,
+				 &bat_priv->forw_bcast_list, send_time);
+}
+
+/**
+ * batadv_forw_packet_ogmv1_queue - try to queue an OGMv1 packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @forw_packet: the forwarding packet to queue
+ * @send_time: timestamp (jiffies) when the packet is to be sent
+ *
+ * This function tries to (re)queue an OGMv1 packet.
+ *
+ * Caller needs to ensure that forw_packet->delayed_work was initialized.
+ */
+void batadv_forw_packet_ogmv1_queue(struct batadv_priv *bat_priv,
+				    struct batadv_forw_packet *forw_packet,
+				    unsigned long send_time)
+{
+	batadv_forw_packet_queue(forw_packet, &bat_priv->forw_bat_list_lock,
+				 &bat_priv->forw_bat_list, send_time);
 }
 
 /**
@@ -593,7 +767,7 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	INIT_DELAYED_WORK(&forw_packet->delayed_work,
 			  batadv_send_outstanding_bcast_packet);
 
-	_batadv_add_bcast_packet_to_list(bat_priv, forw_packet, delay);
+	batadv_forw_packet_bcast_queue(bat_priv, forw_packet, jiffies + delay);
 	return NETDEV_TX_OK;
 
 err_packet_free:
@@ -610,6 +784,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	struct sk_buff *skb1;
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
+	unsigned long send_time = jiffies + msecs_to_jiffies(5);
 
 	delayed_work = to_delayed_work(work);
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
@@ -617,10 +792,6 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	soft_iface = forw_packet->if_incoming->soft_iface;
 	bat_priv = netdev_priv(soft_iface);
 
-	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
-	hlist_del(&forw_packet->list);
-	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
-
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
 
@@ -652,22 +823,34 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 
 	/* if we still have some more bcasts to send */
 	if (forw_packet->num_packets < BATADV_NUM_BCASTS_MAX) {
-		_batadv_add_bcast_packet_to_list(bat_priv, forw_packet,
-						 msecs_to_jiffies(5));
+		batadv_forw_packet_bcast_queue(bat_priv, forw_packet,
+					       send_time);
 		return;
 	}
 
 out:
-	batadv_forw_packet_free(forw_packet);
+	/* do we get something for free()? */
+	if (batadv_forw_packet_steal(forw_packet,
+				     &bat_priv->forw_bcast_list_lock))
+		batadv_forw_packet_free(forw_packet);
 }
 
+/**
+ * batadv_purge_outstanding_packets - stop/purge scheduled bcast/OGMv1 packets
+ * @bat_priv: the bat priv with all the soft interface information
+ * @hard_iface:	the hard interface to cancel and purge bcast/ogm packets on
+ *
+ * This method cancels and purges any broadcast and OGMv1 packet on the given
+ * hard_iface. If hard_iface is NULL, broadcast and OGMv1 packets on all hard
+ * interfaces will be canceled and purged.
+ *
+ * This function might sleep.
+ */
 void
 batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 				 const struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_forw_packet *forw_packet;
-	struct hlist_node *safe_tmp_node;
-	bool pending;
+	struct hlist_head head = HLIST_HEAD_INIT;
 
 	if (hard_iface)
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
@@ -677,57 +860,18 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "purge_outstanding_packets()\n");
 
-	/* free bcast list */
+	/* claim bcast list for free() */
 	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
-	hlist_for_each_entry_safe(forw_packet, safe_tmp_node,
-				  &bat_priv->forw_bcast_list, list) {
-		/* if purge_outstanding_packets() was called with an argument
-		 * we delete only packets belonging to the given interface
-		 */
-		if ((hard_iface) &&
-		    (forw_packet->if_incoming != hard_iface) &&
-		    (forw_packet->if_outgoing != hard_iface))
-			continue;
-
-		spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
-
-		/* batadv_send_outstanding_bcast_packet() will lock the list to
-		 * delete the item from the list
-		 */
-		pending = cancel_delayed_work_sync(&forw_packet->delayed_work);
-		spin_lock_bh(&bat_priv->forw_bcast_list_lock);
-
-		if (pending) {
-			hlist_del(&forw_packet->list);
-			batadv_forw_packet_free(forw_packet);
-		}
-	}
+	batadv_forw_packet_list_steal(&bat_priv->forw_bcast_list, &head,
+				      hard_iface);
 	spin_unlock_bh(&bat_priv->forw_bcast_list_lock);
 
-	/* free batman packet list */
+	/* claim batman packet list for free() */
 	spin_lock_bh(&bat_priv->forw_bat_list_lock);
-	hlist_for_each_entry_safe(forw_packet, safe_tmp_node,
-				  &bat_priv->forw_bat_list, list) {
-		/* if purge_outstanding_packets() was called with an argument
-		 * we delete only packets belonging to the given interface
-		 */
-		if ((hard_iface) &&
-		    (forw_packet->if_incoming != hard_iface) &&
-		    (forw_packet->if_outgoing != hard_iface))
-			continue;
-
-		spin_unlock_bh(&bat_priv->forw_bat_list_lock);
-
-		/* send_outstanding_bat_packet() will lock the list to
-		 * delete the item from the list
-		 */
-		pending = cancel_delayed_work_sync(&forw_packet->delayed_work);
-		spin_lock_bh(&bat_priv->forw_bat_list_lock);
-
-		if (pending) {
-			hlist_del(&forw_packet->list);
-			batadv_forw_packet_free(forw_packet);
-		}
-	}
+	batadv_forw_packet_list_steal(&bat_priv->forw_bat_list, &head,
+				      hard_iface);
 	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+
+	/* then cancel or wait for packet workers to finish and free */
+	batadv_forw_packet_list_free(&head);
 }
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 999f786..37b44e0 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -21,6 +21,7 @@
 #include "main.h"
 
 #include <linux/compiler.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 
 #include "packet.h"
@@ -33,6 +34,11 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 			 struct batadv_hard_iface *if_outgoing,
 			 atomic_t *queue_left,
 			 struct batadv_priv *bat_priv);
+bool batadv_forw_packet_steal(struct batadv_forw_packet *forw_packet,
+			      spinlock_t *lock);
+void batadv_forw_packet_ogmv1_queue(struct batadv_priv *bat_priv,
+				    struct batadv_forw_packet *forw_packet,
+				    unsigned long send_time);
 
 int batadv_send_skb_to_orig(struct sk_buff *skb,
 			    struct batadv_orig_node *orig_node,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b3dd1a3..e443c5f 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1364,6 +1364,7 @@ struct batadv_skb_cb {
 /**
  * struct batadv_forw_packet - structure for bcast packets to be sent/forwarded
  * @list: list node for batadv_socket_client::queue_list
+ * @bm_list: list node for purging functions
  * @send_time: execution time for delayed_work (packet sending)
  * @own: bool for locally generated packets (local OGMs are re-scheduled after
  *  sending)
@@ -1380,6 +1381,7 @@ struct batadv_skb_cb {
  */
 struct batadv_forw_packet {
 	struct hlist_node list;
+	struct hlist_node bm_list;
 	unsigned long send_time;
 	u8 own;
 	struct sk_buff *skb;
-- 
2.1.4

