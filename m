Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue,  7 Feb 2012 20:34:25 +0100
Message-Id: <1328643265-26349-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: only bloat with bla-structures
	if activated
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

We don't have to bloat the batman internal structures if bla is not
configured. This patch adds a few ifdefs to do this.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 types.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/types.h b/types.h
index 7f7f610..a5b1a63 100644
--- a/types.h
+++ b/types.h
@@ -140,11 +140,13 @@ struct neigh_node {
 	spinlock_t tq_lock;	/* protects: tq_recv, tq_index */
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
 struct bcast_duplist_entry {
 	uint8_t orig[ETH_ALEN];
 	uint16_t crc;
 	unsigned long entrytime;
 };
+#endif
 
 struct bat_priv {
 	atomic_t mesh_state;
@@ -186,14 +188,18 @@ struct bat_priv {
 	struct hashtable_t *orig_hash;
 	struct hashtable_t *tt_local_hash;
 	struct hashtable_t *tt_global_hash;
+#ifdef CONFIG_BATMAN_ADV_BLA
 	struct hashtable_t *claim_hash;
 	struct hashtable_t *backbone_hash;
+#endif
 	struct list_head tt_req_list; /* list of pending tt_requests */
 	struct list_head tt_roam_list;
 	struct hashtable_t *vis_hash;
+#ifdef CONFIG_BATMAN_ADV_BLA
 	struct bcast_duplist_entry bcast_duplist[DUPLIST_SIZE];
 	int bcast_duplist_curr;
 	struct bla_claim_dst claim_dest;
+#endif
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects  */
 	spinlock_t tt_changes_list_lock; /* protects tt_changes */
@@ -261,6 +267,7 @@ struct tt_orig_list_entry {
 	struct hlist_node list;
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
 struct backbone_gw {
 	uint8_t orig[ETH_ALEN];
 	short vid;		/* used VLAN ID */
@@ -282,6 +289,7 @@ struct claim {
 	atomic_t refcount;
 	struct hlist_node hash_entry;
 };
+#endif
 
 struct tt_change_node {
 	struct list_head list;
-- 
1.7.8.3

