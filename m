Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Apr 2015 10:42:42 +0200
Message-Id: <1429605763-17186-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv6 1/2] batman-adv: Remove dynamically
	allocated hashtables
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
To: b.a.t.m.a.n@lists.open-mesh.org

It is unnecessary to allocate an extra memory region for hashtables and the
corresponding locks. This brings the hashes used in batman-adv slightly in
the direction of the common statically sized hash table implementation.
More common hashtable functionality cannot be used batman-adv wide because
the simple hashtable and rhashtable implementations don't provide bucket
based locking.

A side-effect of this change is the initialization of each array of locks
for each hashtable with a different lock_class. This allows to correct
nesting of write access to two different hashtables withouttriggering
a lockdep warning.

This also fixes the problem of unprotected access to the pointer to the
hashtables. These were dynamically allocated/freed and the pointers were
stored in batadv_priv*. Access to these pointers were never protected by
any lock and using them could always lead to problems when the batman-adv
device was removed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v6:

 * remove kerneldoc about hash_lock in types.h when there was no hash_lock in
   the struct batadv_priv_dat

v5: Rebased on top of patches:

 * batman-adv: Remove explicit compat.h include and split compat.h
 * batman-adv: Add required to includes to all files
 * batman-adv: Remove unused IFF_BRIDGE_PORT live patching hack
 * batman-adv: Automatically create nested kfree_rcu helper functions

 Makefile.kbuild         |   1 -
 bat_iv_ogm.c            |  13 ++--
 bridge_loop_avoidance.c | 131 ++++++++++++-------------------------
 distributed-arp-table.c |  49 ++++----------
 hash.c                  |  80 -----------------------
 hash.h                  | 106 +++++++++++++-----------------
 network-coding.c        | 146 ++++++++++++++++++++---------------------
 originator.c            |  56 +++++-----------
 originator.h            |  12 ++--
 translation-table.c     | 170 ++++++++++++++++++++----------------------------
 types.h                 |  26 +++++---
 11 files changed, 286 insertions(+), 504 deletions(-)
 delete mode 100644 hash.c

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 6903703..6ee8b04 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -26,7 +26,6 @@ batman-adv-y += fragmentation.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
-batman-adv-y += hash.o
 batman-adv-y += icmp_socket.o
 batman-adv-y += main.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index f3214ed..f2df840 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -19,6 +19,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/kernel.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
@@ -892,7 +893,7 @@ static void
 batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_hashbucket *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
 	unsigned long *word;
@@ -901,8 +902,8 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 	uint8_t *w;
 	int if_num;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
@@ -1828,7 +1829,7 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 				     struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_neigh_node *neigh_node;
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_hashbucket *hash = bat_priv->orig_hash;
 	int last_seen_msecs, last_seen_secs;
 	struct batadv_orig_node *orig_node;
 	struct batadv_neigh_ifinfo *n_ifinfo;
@@ -1841,8 +1842,8 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 		   "Originator", "last-seen", "#", BATADV_TQ_MAX_VALUE,
 		   "Nexthop", "outgoingIF", "Potential nexthops");
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 1882b91..540392b 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -22,7 +22,6 @@
 #include <linux/byteorder/generic.h>
 #include <linux/compiler.h>
 #include <linux/crc16.h>
-#include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/fs.h>
 #include <linux/if_arp.h>
@@ -32,7 +31,6 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -155,17 +153,14 @@ static struct batadv_bla_claim
 *batadv_claim_hash_find(struct batadv_priv *bat_priv,
 			struct batadv_bla_claim *data)
 {
-	struct batadv_hashtable *hash = bat_priv->bla.claim_hash;
+	struct batadv_hashbucket *hash = bat_priv->bla.claim_hash;
 	struct hlist_head *head;
 	struct batadv_bla_claim *claim;
 	struct batadv_bla_claim *claim_tmp = NULL;
 	int index;
 
-	if (!hash)
-		return NULL;
-
-	index = batadv_choose_claim(data, hash->size);
-	head = &hash->table[index];
+	index = batadv_choose_claim(data, ARRAY_SIZE(bat_priv->bla.claim_hash));
+	head = &hash[index].head;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(claim, head, hash_entry) {
@@ -195,20 +190,18 @@ static struct batadv_bla_backbone_gw *
 batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 			  uint8_t *addr, unsigned short vid)
 {
-	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
+	struct batadv_hashbucket *hash = bat_priv->bla.backbone_hash;
 	struct hlist_head *head;
 	struct batadv_bla_backbone_gw search_entry, *backbone_gw;
 	struct batadv_bla_backbone_gw *backbone_gw_tmp = NULL;
 	int index;
-
-	if (!hash)
-		return NULL;
+	uint32_t hash_size = ARRAY_SIZE(bat_priv->bla.backbone_hash);
 
 	ether_addr_copy(search_entry.orig, addr);
 	search_entry.vid = vid;
 
-	index = batadv_choose_backbone_gw(&search_entry, hash->size);
-	head = &hash->table[index];
+	index = batadv_choose_backbone_gw(&search_entry, hash_size);
+	head = &hash[index].head;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
@@ -231,20 +224,19 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 static void
 batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 {
-	struct batadv_hashtable *hash;
+	struct batadv_priv *bat_priv = backbone_gw->bat_priv;
+	struct batadv_hashbucket *hash;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
 	struct batadv_bla_claim *claim;
 	int i;
 	spinlock_t *list_lock;	/* protects write access to the hash lists */
 
-	hash = backbone_gw->bat_priv->bla.claim_hash;
-	if (!hash)
-		return;
+	hash = bat_priv->bla.claim_hash;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.claim_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(claim, node_tmp,
@@ -479,7 +471,7 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 				      unsigned short vid)
 {
 	struct hlist_head *head;
-	struct batadv_hashtable *hash;
+	struct batadv_hashbucket *hash;
 	struct batadv_bla_claim *claim;
 	struct batadv_bla_backbone_gw *backbone_gw;
 	int i;
@@ -494,8 +486,8 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 		return;
 
 	hash = bat_priv->bla.claim_hash;
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.claim_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
@@ -1008,17 +1000,15 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 	struct batadv_bla_backbone_gw *backbone_gw;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
-	struct batadv_hashtable *hash;
+	struct batadv_hashbucket *hash;
 	spinlock_t *list_lock;	/* protects write access to the hash lists */
 	int i;
 
 	hash = bat_priv->bla.backbone_hash;
-	if (!hash)
-		return;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(backbone_gw, node_tmp,
@@ -1062,15 +1052,13 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 {
 	struct batadv_bla_claim *claim;
 	struct hlist_head *head;
-	struct batadv_hashtable *hash;
+	struct batadv_hashbucket *hash;
 	int i;
 
 	hash = bat_priv->bla.claim_hash;
-	if (!hash)
-		return;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.claim_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
@@ -1110,7 +1098,7 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
 	struct hlist_head *head;
-	struct batadv_hashtable *hash;
+	struct batadv_hashbucket *hash;
 	__be16 group;
 	int i;
 
@@ -1129,11 +1117,9 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 	}
 
 	hash = bat_priv->bla.backbone_hash;
-	if (!hash)
-		return;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
@@ -1164,7 +1150,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 	struct batadv_priv_bla *priv_bla;
 	struct hlist_head *head;
 	struct batadv_bla_backbone_gw *backbone_gw;
-	struct batadv_hashtable *hash;
+	struct batadv_hashbucket *hash;
 	struct batadv_hard_iface *primary_if;
 	int i;
 
@@ -1182,11 +1168,9 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 		goto out;
 
 	hash = bat_priv->bla.backbone_hash;
-	if (!hash)
-		goto out;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
@@ -1226,14 +1210,6 @@ out:
 			   msecs_to_jiffies(BATADV_BLA_PERIOD_LENGTH));
 }
 
-/* The hash for claim and backbone hash receive the same key because they
- * are getting initialized by hash_new with the same key. Reinitializing
- * them with to different keys to allow nested locking without generating
- * lockdep warnings
- */
-static struct lock_class_key batadv_claim_hash_lock_class_key;
-static struct lock_class_key batadv_backbone_hash_lock_class_key;
-
 /* initialize all bla structures */
 int batadv_bla_init(struct batadv_priv *bat_priv)
 {
@@ -1265,19 +1241,8 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 		bat_priv->bla.bcast_duplist[i].entrytime = entrytime;
 	bat_priv->bla.bcast_duplist_curr = 0;
 
-	if (bat_priv->bla.claim_hash)
-		return 0;
-
-	bat_priv->bla.claim_hash = batadv_hash_new(128);
-	bat_priv->bla.backbone_hash = batadv_hash_new(32);
-
-	if (!bat_priv->bla.claim_hash || !bat_priv->bla.backbone_hash)
-		return -ENOMEM;
-
-	batadv_hash_set_lock_class(bat_priv->bla.claim_hash,
-				   &batadv_claim_hash_lock_class_key);
-	batadv_hash_set_lock_class(bat_priv->bla.backbone_hash,
-				   &batadv_backbone_hash_lock_class_key);
+	batadv_hash_init(bat_priv->bla.claim_hash);
+	batadv_hash_init(bat_priv->bla.backbone_hash);
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla hashes initialized\n");
 
@@ -1371,7 +1336,7 @@ out:
 bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig,
 				    unsigned short vid)
 {
-	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
+	struct batadv_hashbucket *hash = bat_priv->bla.backbone_hash;
 	struct hlist_head *head;
 	struct batadv_bla_backbone_gw *backbone_gw;
 	int i;
@@ -1379,11 +1344,8 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig,
 	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
 		return false;
 
-	if (!hash)
-		return false;
-
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
@@ -1442,16 +1404,9 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 	cancel_delayed_work_sync(&bat_priv->bla.work);
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 
-	if (bat_priv->bla.claim_hash) {
-		batadv_bla_purge_claims(bat_priv, primary_if, 1);
-		batadv_hash_destroy(bat_priv->bla.claim_hash);
-		bat_priv->bla.claim_hash = NULL;
-	}
-	if (bat_priv->bla.backbone_hash) {
-		batadv_bla_purge_backbone_gw(bat_priv, 1);
-		batadv_hash_destroy(bat_priv->bla.backbone_hash);
-		bat_priv->bla.backbone_hash = NULL;
-	}
+	batadv_bla_purge_claims(bat_priv, primary_if, 1);
+	batadv_bla_purge_backbone_gw(bat_priv, 1);
+
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 }
@@ -1643,7 +1598,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->bla.claim_hash;
+	struct batadv_hashbucket *hash = bat_priv->bla.claim_hash;
 	struct batadv_bla_claim *claim;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
@@ -1662,8 +1617,8 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 		   ntohs(bat_priv->bla.claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s    %-17s [o] (%-6s)\n",
 		   "Client", "VID", "Originator", "CRC");
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.claim_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
@@ -1687,7 +1642,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
+	struct batadv_hashbucket *hash = bat_priv->bla.backbone_hash;
 	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
@@ -1707,8 +1662,8 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 		   ntohs(bat_priv->bla.claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s %-9s (%-6s)\n",
 		   "Originator", "VID", "last seen", "CRC");
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 0b3d13d..b9025c3 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -20,7 +20,6 @@
 
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
-#include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/fs.h>
 #include <linux/if_arp.h>
@@ -103,12 +102,9 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 	struct hlist_head *head;
 	uint32_t i;
 
-	if (!bat_priv->dat.hash)
-		return;
-
-	for (i = 0; i < bat_priv->dat.hash->size; i++) {
-		head = &bat_priv->dat.hash->table[i];
-		list_lock = &bat_priv->dat.hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->dat.hash); i++) {
+		head = &bat_priv->dat.hash[i].head;
+		list_lock = &bat_priv->dat.hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(dat_entry, node_tmp, head,
@@ -263,17 +259,14 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 {
 	struct hlist_head *head;
 	struct batadv_dat_entry to_find, *dat_entry, *dat_entry_tmp = NULL;
-	struct batadv_hashtable *hash = bat_priv->dat.hash;
+	struct batadv_hashbucket *hash = bat_priv->dat.hash;
 	uint32_t index;
 
-	if (!hash)
-		return NULL;
-
 	to_find.ip = ip;
 	to_find.vid = vid;
 
-	index = batadv_hash_dat(&to_find, hash->size);
-	head = &hash->table[index];
+	index = batadv_hash_dat(&to_find, ARRAY_SIZE(bat_priv->dat.hash));
+	head = &hash[index].head;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
@@ -498,7 +491,7 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 {
 	batadv_dat_addr_t max = 0, tmp_max = 0;
 	struct batadv_orig_node *orig_node, *max_orig_node = NULL;
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_hashbucket *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	int i;
 
@@ -510,8 +503,8 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 	/* iterate over the originator list and find the node with the closest
 	 * dat_address which has not been selected yet
 	 */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
@@ -565,9 +558,6 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
 	struct batadv_dat_candidate *res;
 
-	if (!bat_priv->orig_hash)
-		return NULL;
-
 	res = kmalloc_array(BATADV_DAT_CANDIDATES_NUM, sizeof(*res),
 			    GFP_ATOMIC);
 	if (!res)
@@ -724,14 +714,7 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
  */
 static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
 {
-	if (!bat_priv->dat.hash)
-		return;
-
 	__batadv_dat_purge(bat_priv, NULL);
-
-	batadv_hash_destroy(bat_priv->dat.hash);
-
-	bat_priv->dat.hash = NULL;
 }
 
 /**
@@ -740,13 +723,7 @@ static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
  */
 int batadv_dat_init(struct batadv_priv *bat_priv)
 {
-	if (bat_priv->dat.hash)
-		return 0;
-
-	bat_priv->dat.hash = batadv_hash_new(1024);
-
-	if (!bat_priv->dat.hash)
-		return -ENOMEM;
+	batadv_hash_init(bat_priv->dat.hash);
 
 	batadv_dat_start_timer(bat_priv);
 
@@ -780,7 +757,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->dat.hash;
+	struct batadv_hashbucket *hash = bat_priv->dat.hash;
 	struct batadv_dat_entry *dat_entry;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
@@ -796,8 +773,8 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "          %-7s          %-9s %4s %11s\n", "IPv4",
 		   "MAC", "VID", "last-seen");
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->dat.hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
diff --git a/hash.c b/hash.c
deleted file mode 100644
index 0532dc9..0000000
--- a/hash.c
+++ /dev/null
@@ -1,80 +0,0 @@
-/* Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
- *
- * Simon Wunderlich, Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "hash.h"
-#include "main.h"
-
-#include <linux/fs.h>
-#include <linux/lockdep.h>
-#include <linux/slab.h>
-
-/* clears the hash */
-static void batadv_hash_init(struct batadv_hashtable *hash)
-{
-	uint32_t i;
-
-	for (i = 0; i < hash->size; i++) {
-		INIT_HLIST_HEAD(&hash->table[i]);
-		spin_lock_init(&hash->list_locks[i]);
-	}
-}
-
-/* free only the hashtable and the hash itself. */
-void batadv_hash_destroy(struct batadv_hashtable *hash)
-{
-	kfree(hash->list_locks);
-	kfree(hash->table);
-	kfree(hash);
-}
-
-/* allocates and clears the hash */
-struct batadv_hashtable *batadv_hash_new(uint32_t size)
-{
-	struct batadv_hashtable *hash;
-
-	hash = kmalloc(sizeof(*hash), GFP_ATOMIC);
-	if (!hash)
-		return NULL;
-
-	hash->table = kmalloc_array(size, sizeof(*hash->table), GFP_ATOMIC);
-	if (!hash->table)
-		goto free_hash;
-
-	hash->list_locks = kmalloc_array(size, sizeof(*hash->list_locks),
-					 GFP_ATOMIC);
-	if (!hash->list_locks)
-		goto free_table;
-
-	hash->size = size;
-	batadv_hash_init(hash);
-	return hash;
-
-free_table:
-	kfree(hash->table);
-free_hash:
-	kfree(hash);
-	return NULL;
-}
-
-void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
-				struct lock_class_key *key)
-{
-	uint32_t i;
-
-	for (i = 0; i < hash->size; i++)
-		lockdep_set_class(&hash->list_locks[i], key);
-}
diff --git a/hash.h b/hash.h
index b7cc418..6c69be5 100644
--- a/hash.h
+++ b/hash.h
@@ -29,6 +29,15 @@
 
 struct lock_class_key;
 
+#define batadv_hash_init(hashtable) \
+	do { \
+		uint32_t _it; \
+		for (_it = 0; _it < ARRAY_SIZE(hashtable); _it++) { \
+			INIT_HLIST_HEAD(&hashtable[_it].head); \
+			spin_lock_init(&hashtable[_it].lock); \
+		} \
+	} while (0)
+
 /* callback to a compare function.  should compare 2 element datas for their
  * keys, return 0 if same and not 0 if not same
  */
@@ -42,55 +51,25 @@ typedef int (*batadv_hashdata_compare_cb)(const struct hlist_node *,
 typedef uint32_t (*batadv_hashdata_choose_cb)(const void *, uint32_t);
 typedef void (*batadv_hashdata_free_cb)(struct hlist_node *, void *);
 
-struct batadv_hashtable {
-	struct hlist_head *table;   /* the hashtable itself with the buckets */
-	spinlock_t *list_locks;     /* spinlock for each hash list entry */
-	uint32_t size;		    /* size of hashtable */
-};
-
-/* allocates and clears the hash */
-struct batadv_hashtable *batadv_hash_new(uint32_t size);
-
-/* set class key for all locks */
-void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
-				struct lock_class_key *key);
-
-/* free only the hashtable and the hash itself. */
-void batadv_hash_destroy(struct batadv_hashtable *hash);
-
-/* remove the hash structure. if hashdata_free_cb != NULL, this function will be
- * called to remove the elements inside of the hash.  if you don't remove the
- * elements, memory might be leaked.
+/**
+ *	batadv_hash_add - adds data to the hashtable
+ *	@hash: storage hash table
+ *	@compare: callback to determine if 2 hash elements are identical
+ *	@choose: callback calculating the hash index
+ *	@data: data passed to the aforementioned callbacks as argument
+ *	@data_node: to be added element
+ *
+ *	Returns 0 on success, 1 if the element already is in the hash
+ *	and -1 on error.
  */
-static inline void batadv_hash_delete(struct batadv_hashtable *hash,
-				      batadv_hashdata_free_cb free_cb,
-				      void *arg)
-{
-	struct hlist_head *head;
-	struct hlist_node *node, *node_tmp;
-	spinlock_t *list_lock; /* spinlock to protect write access */
-	uint32_t i;
-
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
-
-		spin_lock_bh(list_lock);
-		hlist_for_each_safe(node, node_tmp, head) {
-			hlist_del_rcu(node);
-
-			if (free_cb)
-				free_cb(node, arg);
-		}
-		spin_unlock_bh(list_lock);
-	}
-
-	batadv_hash_destroy(hash);
-}
+#define batadv_hash_add(hash, compare, choose, data, data_node) \
+	_batadv_hash_add(hash, ARRAY_SIZE(hash), compare, choose, data, \
+			 data_node)
 
 /**
- *	batadv_hash_add - adds data to the hashtable
+ *	_batadv_hash_add - adds data to the hashtable of a given size
  *	@hash: storage hash table
+ *	@hash_size: number of buckets in the hashtable @hash
  *	@compare: callback to determine if 2 hash elements are identical
  *	@choose: callback calculating the hash index
  *	@data: data passed to the aforementioned callbacks as argument
@@ -99,11 +78,12 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
  *	Returns 0 on success, 1 if the element already is in the hash
  *	and -1 on error.
  */
-static inline int batadv_hash_add(struct batadv_hashtable *hash,
-				  batadv_hashdata_compare_cb compare,
-				  batadv_hashdata_choose_cb choose,
-				  const void *data,
-				  struct hlist_node *data_node)
+static inline int _batadv_hash_add(struct batadv_hashbucket *hash,
+				   uint32_t hash_size,
+				   batadv_hashdata_compare_cb compare,
+				   batadv_hashdata_choose_cb choose,
+				   const void *data,
+				   struct hlist_node *data_node)
 {
 	uint32_t index;
 	int ret = -1;
@@ -114,9 +94,9 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
 	if (!hash)
 		goto out;
 
-	index = choose(data, hash->size);
-	head = &hash->table[index];
-	list_lock = &hash->list_locks[index];
+	index = choose(data, hash_size);
+	head = &hash[index].head;
+	list_lock = &hash[index].lock;
 
 	spin_lock_bh(list_lock);
 
@@ -144,20 +124,24 @@ out:
  * structure you use with just the key filled, we just need the key for
  * comparing.
  */
-static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
-				       batadv_hashdata_compare_cb compare,
-				       batadv_hashdata_choose_cb choose,
-				       void *data)
+#define batadv_hash_remove(hash, compare, choose, data) \
+	_batadv_hash_remove(hash, ARRAY_SIZE(hash), compare, choose, data)
+
+static inline void *_batadv_hash_remove(struct batadv_hashbucket *hash,
+					uint32_t hash_size,
+					batadv_hashdata_compare_cb compare,
+					batadv_hashdata_choose_cb choose,
+					void *data)
 {
 	uint32_t index;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	void *data_save = NULL;
 
-	index = choose(data, hash->size);
-	head = &hash->table[index];
+	index = choose(data, hash_size);
+	head = &hash[index].head;
 
-	spin_lock_bh(&hash->list_locks[index]);
+	spin_lock_bh(&hash[index].lock);
 	hlist_for_each(node, head) {
 		if (!compare(node, data))
 			continue;
@@ -166,7 +150,7 @@ static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
 		hlist_del_rcu(node);
 		break;
 	}
-	spin_unlock_bh(&hash->list_locks[index]);
+	spin_unlock_bh(&hash[index].lock);
 
 	return data_save;
 }
diff --git a/network-coding.c b/network-coding.c
index b3b3c4e..79e49ca 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -32,7 +32,6 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
 #include <linux/random.h>
@@ -54,9 +53,6 @@
 #include "routing.h"
 #include "send.h"
 
-static struct lock_class_key batadv_nc_coding_hash_lock_class_key;
-static struct lock_class_key batadv_nc_decoding_hash_lock_class_key;
-
 static void batadv_nc_worker(struct work_struct *work);
 static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if);
@@ -148,22 +144,8 @@ int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 	bat_priv->nc.timestamp_fwd_flush = jiffies;
 	bat_priv->nc.timestamp_sniffed_purge = jiffies;
 
-	if (bat_priv->nc.coding_hash || bat_priv->nc.decoding_hash)
-		return 0;
-
-	bat_priv->nc.coding_hash = batadv_hash_new(128);
-	if (!bat_priv->nc.coding_hash)
-		goto err;
-
-	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
-				   &batadv_nc_coding_hash_lock_class_key);
-
-	bat_priv->nc.decoding_hash = batadv_hash_new(128);
-	if (!bat_priv->nc.decoding_hash)
-		goto err;
-
-	batadv_hash_set_lock_class(bat_priv->nc.decoding_hash,
-				   &batadv_nc_decoding_hash_lock_class_key);
+	batadv_hash_init(bat_priv->nc.coding_hash);
+	batadv_hash_init(bat_priv->nc.decoding_hash);
 
 	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
 	batadv_nc_start_timer(bat_priv);
@@ -173,9 +155,6 @@ int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 	batadv_nc_tvlv_container_update(bat_priv);
 	return 0;
-
-err:
-	return -ENOMEM;
 }
 
 /**
@@ -378,17 +357,14 @@ void batadv_nc_purge_orig(struct batadv_priv *bat_priv,
  */
 static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_hashbucket *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
 	uint32_t i;
 
-	if (!hash)
-		return;
-
 	/* For each orig_node */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry)
@@ -408,10 +384,25 @@ static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
  *	      a boolean value: true is the entry has to be deleted, false
  *	      otherwise
  */
-static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
-				  struct batadv_hashtable *hash,
-				  bool (*to_purge)(struct batadv_priv *,
-						   struct batadv_nc_path *))
+#define batadv_nc_purge_paths(bat_priv, hash, to_purge) \
+	_batadv_nc_purge_paths(bat_priv, hash, ARRAY_SIZE(hash), to_purge)
+
+/**
+ * _batadv_nc_purge_paths - traverse all nc paths part of the hash and remove
+ *  unused ones
+ * @bat_priv: the bat priv with all the soft interface information
+ * @hash: hash table containing the nc paths to check
+ * @hash_size: number of buckets in the hashtable
+ * @to_purge: function in charge to decide whether an entry has to be purged or
+ *	      not. This function takes the nc node as argument and has to return
+ *	      a boolean value: true is the entry has to be deleted, false
+ *	      otherwise
+ */
+static void _batadv_nc_purge_paths(struct batadv_priv *bat_priv,
+				   struct batadv_hashbucket *hash,
+				   uint32_t hash_size,
+				   bool (*to_purge)(struct batadv_priv *,
+						    struct batadv_nc_path *))
 {
 	struct hlist_head *head;
 	struct hlist_node *node_tmp;
@@ -419,9 +410,9 @@ static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
 	spinlock_t *lock; /* Protects lists in hash */
 	uint32_t i;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		lock = &hash->list_locks[i];
+	for (i = 0; i < hash_size; i++) {
+		head = &hash[i].head;
+		lock = &hash[i].lock;
 
 		/* For each nc_path in this bin */
 		spin_lock_bh(lock);
@@ -519,23 +510,21 @@ static int batadv_nc_hash_compare(const struct hlist_node *node,
 /**
  * batadv_nc_hash_find - search for an existing nc path and return it
  * @hash: hash table containing the nc path
+ * @hash_size: number of buckets in the hashtable
  * @data: search key
  *
  * Returns the nc_path if found, NULL otherwise.
  */
 static struct batadv_nc_path *
-batadv_nc_hash_find(struct batadv_hashtable *hash,
+batadv_nc_hash_find(struct batadv_hashbucket *hash, uint32_t hash_size,
 		    void *data)
 {
 	struct hlist_head *head;
 	struct batadv_nc_path *nc_path, *nc_path_tmp = NULL;
 	int index;
 
-	if (!hash)
-		return NULL;
-
-	index = batadv_nc_hash_choose(data, hash->size);
-	head = &hash->table[index];
+	index = batadv_nc_hash_choose(data, hash_size);
+	head = &hash[index].head;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(nc_path, head, hash_entry) {
@@ -648,12 +637,26 @@ static bool batadv_nc_fwd_flush(struct batadv_priv *bat_priv,
  *	        to encourage this function to proceed with the next packet.
  *	        Otherwise the rest of the current queue is skipped.
  */
+#define batadv_nc_process_nc_paths(bat_priv, hash, process_fn) \
+	_batadv_nc_process_nc_paths(bat_priv, hash, ARRAY_SIZE(hash), \
+				    process_fn)
+
+/**
+ * _batadv_nc_process_nc_paths - traverse given nc packet pool and free timed
+ *  out nc packets
+ * @bat_priv: the bat priv with all the soft interface information
+ * @hash: to be processed hash table
+ * @hash_size: number of buckets in the hashtable
+ * @process_fn: Function called to process given nc packet. Should return true
+ *	        to encourage this function to proceed with the next packet.
+ *	        Otherwise the rest of the current queue is skipped.
+ */
 static void
-batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
-			   struct batadv_hashtable *hash,
-			   bool (*process_fn)(struct batadv_priv *,
-					      struct batadv_nc_path *,
-					      struct batadv_nc_packet *))
+_batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
+			    struct batadv_hashbucket *hash, uint32_t hash_size,
+			    bool (*process_fn)(struct batadv_priv *,
+					       struct batadv_nc_path *,
+					       struct batadv_nc_packet *))
 {
 	struct hlist_head *head;
 	struct batadv_nc_packet *nc_packet, *nc_packet_tmp;
@@ -661,12 +664,9 @@ batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
 	bool ret;
 	int i;
 
-	if (!hash)
-		return;
-
 	/* Loop hash table bins */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < hash_size; i++) {
+		head = &hash[i].head;
 
 		/* Loop coding paths */
 		rcu_read_lock();
@@ -929,6 +929,7 @@ out:
  * batadv_nc_get_path - get existing nc_path or allocate a new one
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: hash table containing the nc path
+ * @hash_size: number of buckets in the hashtable
  * @src: ethernet source address - first half of the nc path search key
  * @dst: ethernet destination address - second half of the nc path search key
  *
@@ -936,7 +937,8 @@ out:
  * on error.
  */
 static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
-						 struct batadv_hashtable *hash,
+						 struct batadv_hashbucket *hash,
+						 uint32_t hash_size,
 						 uint8_t *src,
 						 uint8_t *dst)
 {
@@ -946,7 +948,7 @@ static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
 	batadv_nc_hash_key_gen(&nc_path_key, src, dst);
 
 	/* Search for existing nc_path */
-	nc_path = batadv_nc_hash_find(hash, (void *)&nc_path_key);
+	nc_path = batadv_nc_hash_find(hash, hash_size, (void *)&nc_path_key);
 
 	if (nc_path) {
 		/* Set timestamp to delay removal of nc_path */
@@ -973,9 +975,9 @@ static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
 		   nc_path->next_hop);
 
 	/* Add nc_path to hash table */
-	hash_added = batadv_hash_add(hash, batadv_nc_hash_compare,
-				     batadv_nc_hash_choose, &nc_path_key,
-				     &nc_path->hash_entry);
+	hash_added = _batadv_hash_add(hash, hash_size, batadv_nc_hash_compare,
+				      batadv_nc_hash_choose, &nc_path_key,
+				      &nc_path->hash_entry);
 
 	if (hash_added < 0) {
 		kfree(nc_path);
@@ -1259,20 +1261,18 @@ batadv_nc_path_search(struct batadv_priv *bat_priv,
 	struct batadv_nc_path *nc_path, nc_path_key;
 	struct batadv_nc_packet *nc_packet_out = NULL;
 	struct batadv_nc_packet *nc_packet, *nc_packet_tmp;
-	struct batadv_hashtable *hash = bat_priv->nc.coding_hash;
+	struct batadv_hashbucket *hash = bat_priv->nc.coding_hash;
 	int idx;
 
-	if (!hash)
-		return NULL;
-
 	/* Create almost path key */
 	batadv_nc_hash_key_gen(&nc_path_key, in_nc_node->addr,
 			       out_nc_node->addr);
-	idx = batadv_nc_hash_choose(&nc_path_key, hash->size);
+	idx = batadv_nc_hash_choose(&nc_path_key,
+				    ARRAY_SIZE(bat_priv->nc.coding_hash));
 
 	/* Check for coding opportunities in this nc_path */
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(nc_path, &hash->table[idx], hash_entry) {
+	hlist_for_each_entry_rcu(nc_path, &hash[idx].head, hash_entry) {
 		if (!batadv_compare_eth(nc_path->prev_hop, in_nc_node->addr))
 			continue;
 
@@ -1516,6 +1516,7 @@ bool batadv_nc_skb_forward(struct sk_buff *skb,
 	/* Find or create a nc_path for this src-dst pair */
 	nc_path = batadv_nc_get_path(bat_priv,
 				     bat_priv->nc.coding_hash,
+				     ARRAY_SIZE(bat_priv->nc.coding_hash),
 				     ethhdr->h_source,
 				     neigh_node->addr);
 
@@ -1565,6 +1566,7 @@ void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
 	/* Find existing nc_path or create a new */
 	nc_path = batadv_nc_get_path(bat_priv,
 				     bat_priv->nc.decoding_hash,
+				     ARRAY_SIZE(bat_priv->nc.decoding_hash),
 				     ethhdr->h_source,
 				     ethhdr->h_dest);
 
@@ -1726,16 +1728,13 @@ batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
 			       struct ethhdr *ethhdr,
 			       struct batadv_coded_packet *coded)
 {
-	struct batadv_hashtable *hash = bat_priv->nc.decoding_hash;
+	struct batadv_hashbucket *hash = bat_priv->nc.decoding_hash;
 	struct batadv_nc_packet *tmp_nc_packet, *nc_packet = NULL;
 	struct batadv_nc_path *nc_path, nc_path_key;
 	uint8_t *dest, *source;
 	__be32 packet_id;
 	int index;
 
-	if (!hash)
-		return NULL;
-
 	/* Select the correct packet id based on the location of our mac-addr */
 	dest = ethhdr->h_source;
 	if (!batadv_is_my_mac(bat_priv, coded->second_dest)) {
@@ -1747,11 +1746,12 @@ batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
 	}
 
 	batadv_nc_hash_key_gen(&nc_path_key, source, dest);
-	index = batadv_nc_hash_choose(&nc_path_key, hash->size);
+	index = batadv_nc_hash_choose(&nc_path_key,
+				      ARRAY_SIZE(bat_priv->nc.decoding_hash));
 
 	/* Search for matching coding path */
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(nc_path, &hash->table[index], hash_entry) {
+	hlist_for_each_entry_rcu(nc_path, &hash[index].head, hash_entry) {
 		/* Find matching nc_packet */
 		spin_lock_bh(&nc_path->packet_list_lock);
 		list_for_each_entry(tmp_nc_packet,
@@ -1857,9 +1857,7 @@ void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
 	cancel_delayed_work_sync(&bat_priv->nc.work);
 
 	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash, NULL);
-	batadv_hash_destroy(bat_priv->nc.coding_hash);
 	batadv_nc_purge_paths(bat_priv, bat_priv->nc.decoding_hash, NULL);
-	batadv_hash_destroy(bat_priv->nc.decoding_hash);
 }
 
 /**
@@ -1871,7 +1869,7 @@ int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_hashbucket *hash = bat_priv->orig_hash;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
@@ -1883,8 +1881,8 @@ int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	/* Traverse list of originators */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		/* For each orig_node in this bin */
 		rcu_read_lock();
diff --git a/originator.c b/originator.c
index 684536e..7ab6be8 100644
--- a/originator.c
+++ b/originator.c
@@ -24,7 +24,6 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -41,9 +40,6 @@
 #include "routing.h"
 #include "translation-table.h"
 
-/* hash class keys */
-static struct lock_class_key batadv_orig_hash_lock_class_key;
-
 static void batadv_purge_orig(struct work_struct *work);
 
 /* returns 1 if they are the same originator */
@@ -139,16 +135,7 @@ void batadv_orig_node_vlan_free_ref(struct batadv_orig_node_vlan *orig_vlan)
 
 int batadv_originator_init(struct batadv_priv *bat_priv)
 {
-	if (bat_priv->orig_hash)
-		return 0;
-
-	bat_priv->orig_hash = batadv_hash_new(1024);
-
-	if (!bat_priv->orig_hash)
-		goto err;
-
-	batadv_hash_set_lock_class(bat_priv->orig_hash,
-				   &batadv_orig_hash_lock_class_key);
+	batadv_hash_init(bat_priv->orig_hash);
 
 	INIT_DELAYED_WORK(&bat_priv->orig_work, batadv_purge_orig);
 	queue_delayed_work(batadv_event_workqueue,
@@ -156,9 +143,6 @@ int batadv_originator_init(struct batadv_priv *bat_priv)
 			   msecs_to_jiffies(BATADV_ORIG_WORK_PERIOD));
 
 	return 0;
-
-err:
-	return -ENOMEM;
 }
 
 /**
@@ -619,23 +603,18 @@ void batadv_orig_node_free_ref_now(struct batadv_orig_node *orig_node)
 
 void batadv_originator_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_hashbucket *hash = bat_priv->orig_hash;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct batadv_orig_node *orig_node;
 	uint32_t i;
 
-	if (!hash)
-		return;
-
 	cancel_delayed_work_sync(&bat_priv->orig_work);
 
-	bat_priv->orig_hash = NULL;
-
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(orig_node, node_tmp,
@@ -645,8 +624,6 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 		}
 		spin_unlock_bh(list_lock);
 	}
-
-	batadv_hash_destroy(hash);
 }
 
 /**
@@ -971,20 +948,17 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 
 static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_hashbucket *hash = bat_priv->orig_hash;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct batadv_orig_node *orig_node;
 	uint32_t i;
 
-	if (!hash)
-		return;
-
 	/* for all origins... */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(orig_node, node_tmp,
@@ -1107,7 +1081,7 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_hashbucket *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
 	uint32_t i;
@@ -1116,8 +1090,8 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num
 	 */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
@@ -1142,7 +1116,7 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_hashbucket *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_hard_iface *hard_iface_tmp;
 	struct batadv_orig_node *orig_node;
@@ -1153,8 +1127,8 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num
 	 */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
diff --git a/originator.h b/originator.h
index 39085cc..a2e4fe7 100644
--- a/originator.h
+++ b/originator.h
@@ -21,6 +21,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/kernel.h>
 #include <linux/compiler.h>
 #include <linux/if_ether.h>
 #include <linux/jhash.h>
@@ -29,8 +30,6 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
-#include "hash.h"
-
 struct seq_file;
 
 int batadv_compare_orig(const struct hlist_node *node, const void *data2);
@@ -97,16 +96,13 @@ static inline uint32_t batadv_choose_orig(const void *data, uint32_t size)
 static inline struct batadv_orig_node *
 batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_hashbucket *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node, *orig_node_tmp = NULL;
 	int index;
 
-	if (!hash)
-		return NULL;
-
-	index = batadv_choose_orig(data, hash->size);
-	head = &hash->table[index];
+	index = batadv_choose_orig(data, ARRAY_SIZE(bat_priv->orig_hash));
+	head = &hash[index].head;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
diff --git a/translation-table.c b/translation-table.c
index 5551ecc..18eb9c5 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -23,7 +23,6 @@
 #include <linux/byteorder/generic.h>
 #include <linux/compiler.h>
 #include <linux/crc32c.h>
-#include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/fs.h>
 #include <linux/if_ether.h>
@@ -31,7 +30,6 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -51,10 +49,6 @@
 #include "packet.h"
 #include "soft-interface.h"
 
-/* hash class keys */
-static struct lock_class_key batadv_tt_local_hash_lock_class_key;
-static struct lock_class_key batadv_tt_global_hash_lock_class_key;
-
 static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 				 unsigned short vid,
 				 struct batadv_orig_node *orig_node);
@@ -105,22 +99,32 @@ static inline uint32_t batadv_choose_tt(const void *data, uint32_t size)
  * Returns a pointer to the tt_common struct belonging to the searched client if
  * found, NULL otherwise.
  */
+#define batadv_tt_hash_find(hash, addr, vid) \
+	_batadv_tt_hash_find(hash, ARRAY_SIZE(hash), addr, vid)
+
+/**
+ * _batadv_tt_hash_find - look for a client in the given hash table
+ * @hash: the hash table to search
+ * @hash_size: number of buckets in the hashtable
+ * @addr: the mac address of the client to look for
+ * @vid: VLAN identifier
+ *
+ * Returns a pointer to the tt_common struct belonging to the searched client if
+ * found, NULL otherwise.
+ */
 static struct batadv_tt_common_entry *
-batadv_tt_hash_find(struct batadv_hashtable *hash, const uint8_t *addr,
-		    unsigned short vid)
+_batadv_tt_hash_find(struct batadv_hashbucket *hash, uint32_t hash_size,
+		     const uint8_t *addr, unsigned short vid)
 {
 	struct hlist_head *head;
 	struct batadv_tt_common_entry to_search, *tt, *tt_tmp = NULL;
 	uint32_t index;
 
-	if (!hash)
-		return NULL;
-
 	ether_addr_copy(to_search.addr, addr);
 	to_search.vid = vid;
 
-	index = batadv_choose_tt(&to_search, hash->size);
-	head = &hash->table[index];
+	index = batadv_choose_tt(&to_search, hash_size);
+	head = &hash[index].head;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tt, head, hash_entry) {
@@ -483,16 +487,7 @@ static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 
 static int batadv_tt_local_init(struct batadv_priv *bat_priv)
 {
-	if (bat_priv->tt.local_hash)
-		return 0;
-
-	bat_priv->tt.local_hash = batadv_hash_new(1024);
-
-	if (!bat_priv->tt.local_hash)
-		return -ENOMEM;
-
-	batadv_hash_set_lock_class(bat_priv->tt.local_hash,
-				   &batadv_tt_local_hash_lock_class_key);
+	batadv_hash_init(bat_priv->tt.local_hash);
 
 	return 0;
 }
@@ -620,8 +615,9 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	    is_multicast_ether_addr(addr))
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
-	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
-				     batadv_choose_tt, &tt_local->common,
+	hash_added = batadv_hash_add(bat_priv->tt.local_hash,
+				     batadv_compare_tt, batadv_choose_tt,
+				     &tt_local->common,
 				     &tt_local->common.hash_entry);
 
 	if (unlikely(hash_added != 0)) {
@@ -921,7 +917,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct batadv_hashbucket *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_hard_iface *primary_if;
@@ -945,8 +941,8 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "       %-13s  %s %-8s %-9s (%-10s)\n", "Client", "VID",
 		   "Flags", "Last seen", "CRC");
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
@@ -1120,14 +1116,14 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
 				  int timeout)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct batadv_hashbucket *hash = bat_priv->tt.local_hash;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		batadv_tt_local_purge_list(bat_priv, head, timeout);
@@ -1137,7 +1133,7 @@ static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
 
 static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash;
+	struct batadv_hashbucket *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local;
@@ -1146,14 +1142,11 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 	struct hlist_head *head;
 	uint32_t i;
 
-	if (!bat_priv->tt.local_hash)
-		return;
-
 	hash = bat_priv->tt.local_hash;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node_tmp,
@@ -1173,24 +1166,11 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 		}
 		spin_unlock_bh(list_lock);
 	}
-
-	batadv_hash_destroy(hash);
-
-	bat_priv->tt.local_hash = NULL;
 }
 
 static int batadv_tt_global_init(struct batadv_priv *bat_priv)
 {
-	if (bat_priv->tt.global_hash)
-		return 0;
-
-	bat_priv->tt.global_hash = batadv_hash_new(1024);
-
-	if (!bat_priv->tt.global_hash)
-		return -ENOMEM;
-
-	batadv_hash_set_lock_class(bat_priv->tt.global_hash,
-				   &batadv_tt_global_hash_lock_class_key);
+	batadv_hash_init(bat_priv->tt.global_hash);
 
 	return 0;
 }
@@ -1592,7 +1572,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
+	struct batadv_hashbucket *hash = bat_priv->tt.global_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global;
 	struct batadv_hard_iface *primary_if;
@@ -1610,8 +1590,8 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		   "Client", "VID", "(TTVN)", "Originator", "(Curr TTVN)",
 		   "CRC", "Flags");
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
@@ -1823,18 +1803,15 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 	struct batadv_tt_global_entry *tt_global;
 	struct batadv_tt_common_entry *tt_common_entry;
 	uint32_t i;
-	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
+	struct batadv_hashbucket *hash = bat_priv->tt.global_hash;
 	struct hlist_node *safe;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	unsigned short vid;
 
-	if (!hash)
-		return;
-
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, safe,
@@ -1889,7 +1866,7 @@ static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
 
 static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
+	struct batadv_hashbucket *hash = bat_priv->tt.global_hash;
 	struct hlist_head *head;
 	struct hlist_node *node_tmp;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
@@ -1898,9 +1875,9 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
@@ -1928,7 +1905,7 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 
 static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash;
+	struct batadv_hashbucket *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global;
@@ -1936,14 +1913,11 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 	struct hlist_head *head;
 	uint32_t i;
 
-	if (!bat_priv->tt.global_hash)
-		return;
-
 	hash = bat_priv->tt.global_hash;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node_tmp,
@@ -1956,10 +1930,6 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 		}
 		spin_unlock_bh(list_lock);
 	}
-
-	batadv_hash_destroy(hash);
-
-	bat_priv->tt.global_hash = NULL;
 }
 
 static bool
@@ -2068,7 +2038,7 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 				     struct batadv_orig_node *orig_node,
 				     unsigned short vid)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
+	struct batadv_hashbucket *hash = bat_priv->tt.global_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_head *head;
@@ -2076,8 +2046,8 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	uint8_t flags;
 	__be16 tmp_vid;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, head, hash_entry) {
@@ -2144,15 +2114,15 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv,
 				    unsigned short vid)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct batadv_hashbucket *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct hlist_head *head;
 	uint32_t i, crc_tmp, crc = 0;
 	uint8_t flags;
 	__be16 tmp_vid;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, head, hash_entry) {
@@ -2307,14 +2277,16 @@ static int batadv_tt_global_valid(const void *entry_ptr,
  *  specified tt hash
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: hash table containing the tt entries
+ * @hash_size: number of buckets in the hashtable
  * @tt_len: expected tvlv tt data buffer length in number of bytes
  * @tvlv_buff: pointer to the buffer to fill with the TT data
  * @valid_cb: function to filter tt change entries
  * @cb_data: data passed to the filter function as argument
  */
 static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
-				    struct batadv_hashtable *hash,
-				    void *tvlv_buff, uint16_t tt_len,
+				    struct batadv_hashbucket *hash,
+				    uint32_t hash_size, void *tvlv_buff,
+				    uint16_t tt_len,
 				    int (*valid_cb)(const void *, const void *),
 				    void *cb_data)
 {
@@ -2328,8 +2300,8 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 	tt_change = (struct batadv_tvlv_tt_change *)tvlv_buff;
 
 	rcu_read_lock();
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < hash_size; i++) {
+		head = &hash[i].head;
 
 		hlist_for_each_entry_rcu(tt_common_entry,
 					 head, hash_entry) {
@@ -2608,6 +2580,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 
 		/* fill the rest of the tvlv with the real TT entries */
 		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.global_hash,
+					ARRAY_SIZE(bat_priv->tt.global_hash),
 					tt_change, tt_len,
 					batadv_tt_global_valid,
 					req_dst_orig_node);
@@ -2737,6 +2710,7 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 
 		/* fill the rest of the tvlv with the real TT entries */
 		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.local_hash,
+					ARRAY_SIZE(bat_priv->tt.local_hash),
 					tt_change, tt_len,
 					batadv_tt_local_valid, NULL);
 	}
@@ -3133,17 +3107,14 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv,
 				      uint16_t flags, bool enable, bool count)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct batadv_hashbucket *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	uint16_t changed_num = 0;
 	struct hlist_head *head;
 	uint32_t i;
 
-	if (!hash)
-		return;
-
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
@@ -3172,7 +3143,7 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv,
 /* Purge out all the tt local entries marked with BATADV_TT_CLIENT_PENDING */
 static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct batadv_hashbucket *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_softif_vlan *vlan;
@@ -3181,12 +3152,9 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
 
-	if (!hash)
-		return;
-
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
diff --git a/types.h b/types.h
index 1d4781e..f025cc0 100644
--- a/types.h
+++ b/types.h
@@ -49,6 +49,16 @@ struct seq_file;
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
 /**
+ * struct batadv_hashbucket - bucket for concurrent, list based hashtable
+ * @head: pointer to the data of this bucket
+ * @lock: lock protecting writes to this bucket
+ */
+struct batadv_hashbucket {
+	struct hlist_head head;
+	spinlock_t lock; /* Protects head */
+};
+
+/**
  * enum batadv_dhcp_recipient - dhcp destination
  * @BATADV_DHCP_NO: packet is not a dhcp message
  * @BATADV_DHCP_TO_SERVER: dhcp message is directed to a server
@@ -532,8 +542,8 @@ struct batadv_priv_tt {
 	atomic_t ogm_append_cnt;
 	atomic_t local_changes;
 	struct list_head changes_list;
-	struct batadv_hashtable *local_hash;
-	struct batadv_hashtable *global_hash;
+	struct batadv_hashbucket local_hash[1024];
+	struct batadv_hashbucket global_hash[1024];
 	struct list_head req_list;
 	struct list_head roam_list;
 	spinlock_t changes_list_lock; /* protects changes */
@@ -563,8 +573,8 @@ struct batadv_priv_tt {
 #ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_priv_bla {
 	atomic_t num_requests;
-	struct batadv_hashtable *claim_hash;
-	struct batadv_hashtable *backbone_hash;
+	struct batadv_hashbucket claim_hash[128];
+	struct batadv_hashbucket backbone_hash[32];
 	struct batadv_bcast_duplist_entry bcast_duplist[BATADV_DUPLIST_SIZE];
 	int bcast_duplist_curr;
 	/* protects bcast_duplist & bcast_duplist_curr */
@@ -633,7 +643,7 @@ struct batadv_priv_tvlv {
 #ifdef CONFIG_BATMAN_ADV_DAT
 struct batadv_priv_dat {
 	batadv_dat_addr_t addr;
-	struct batadv_hashtable *hash;
+	struct batadv_hashbucket hash[1024];
 	struct delayed_work work;
 };
 #endif
@@ -696,8 +706,8 @@ struct batadv_priv_nc {
 	u32 max_buffer_time;
 	unsigned long timestamp_fwd_flush;
 	unsigned long timestamp_sniffed_purge;
-	struct batadv_hashtable *coding_hash;
-	struct batadv_hashtable *decoding_hash;
+	struct batadv_hashbucket coding_hash[128];
+	struct batadv_hashbucket decoding_hash[128];
 };
 
 /**
@@ -810,7 +820,7 @@ struct batadv_priv {
 	struct dentry *debug_dir;
 	struct hlist_head forw_bat_list;
 	struct hlist_head forw_bcast_list;
-	struct batadv_hashtable *orig_hash;
+	struct batadv_hashbucket orig_hash[1024];
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects forw_bcast_list */
 	struct delayed_work orig_work;
-- 
2.1.4

