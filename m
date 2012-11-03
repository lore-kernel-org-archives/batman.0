Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  3 Nov 2012 23:41:48 +0100
Message-Id: <1351982508-16991-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: Reorder structs to reduce padding
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Just found pahole from "dwarves" and had to try it out :D

This can save from 8 to 24 bytes per struct on amd64

 types.h |   46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/types.h b/types.h
index ae9ac9a..ae8bc33 100644
--- a/types.h
+++ b/types.h
@@ -55,8 +55,8 @@ struct batadv_hard_iface {
 	struct list_head list;
 	int16_t if_num;
 	char if_status;
-	struct net_device *net_dev;
 	atomic_t frag_seqno;
+	struct net_device *net_dev;
 	struct kobject *hardif_obj;
 	atomic_t refcount;
 	struct packet_type batman_adv_ptype;
@@ -83,28 +83,29 @@ struct batadv_hard_iface {
 struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
-	struct batadv_neigh_node __rcu *router; /* rcu protected pointer */
 #ifdef CONFIG_BATMAN_ADV_DAT
 	batadv_dat_addr_t dat_addr;
 #endif
+	uint8_t flags;
+	uint8_t gw_flags;
+	struct batadv_neigh_node __rcu *router; /* rcu protected pointer */
 	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
 	unsigned long last_seen;
 	unsigned long bcast_seqno_reset;
 	unsigned long batman_seqno_reset;
-	uint8_t gw_flags;
-	uint8_t flags;
-	atomic_t last_ttvn; /* last seen translation table version number */
 	uint16_t tt_crc;
-	unsigned char *tt_buff;
 	int16_t tt_buff_len;
+	atomic_t last_ttvn; /* last seen translation table version number */
+	unsigned char *tt_buff;
+	bool tt_initialised;
+	uint8_t last_ttl;
 	spinlock_t tt_buff_lock; /* protects tt_buff */
 	atomic_t tt_size;
-	bool tt_initialised;
+	atomic_t bond_candidates;
 	uint32_t last_real_seqno;
-	uint8_t last_ttl;
-	DECLARE_BITMAP(bcast_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 	uint32_t last_bcast_seqno;
+	DECLARE_BITMAP(bcast_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 	struct hlist_head neigh_list;
 	struct list_head frag_list;
 	spinlock_t neigh_list_lock; /* protects neigh_list and router */
@@ -120,7 +121,6 @@ struct batadv_orig_node {
 	/* bcast_seqno_lock protects bcast_bits, last_bcast_seqno */
 	spinlock_t bcast_seqno_lock;
 	spinlock_t tt_list_lock; /* protects tt_list */
-	atomic_t bond_candidates;
 	struct list_head bond_list;
 };
 
@@ -147,10 +147,10 @@ struct batadv_neigh_node {
 	unsigned long last_seen;
 	DECLARE_BITMAP(real_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 	atomic_t refcount;
+	spinlock_t lq_update_lock;	/* protects: tq_recv, tq_index */
 	struct rcu_head rcu;
 	struct batadv_orig_node *orig_node;
 	struct batadv_hard_iface *if_incoming;
-	spinlock_t lq_update_lock;	/* protects: tq_recv, tq_index */
 };
 
 #ifdef CONFIG_BATMAN_ADV_BLA
@@ -205,6 +205,8 @@ struct batadv_priv_tt {
 	atomic_t vn;
 	atomic_t ogm_append_cnt;
 	atomic_t local_changes;
+	uint16_t local_crc;
+	int16_t last_changeset_len;
 	struct list_head changes_list;
 	struct batadv_hashtable *local_hash;
 	struct batadv_hashtable *global_hash;
@@ -214,9 +216,7 @@ struct batadv_priv_tt {
 	spinlock_t req_list_lock; /* protects req_list */
 	spinlock_t roam_list_lock; /* protects roam_list */
 	atomic_t local_entry_num;
-	uint16_t local_crc;
 	unsigned char *last_changeset;
-	int16_t last_changeset_len;
 	spinlock_t last_changeset_lock; /* protects last_changeset */
 	struct delayed_work work;
 };
@@ -224,12 +224,12 @@ struct batadv_priv_tt {
 #ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_priv_bla {
 	atomic_t num_requests; /* number of bla requests in flight */
+	/* protects bcast_duplist and bcast_duplist_curr */
+	spinlock_t bcast_duplist_lock;
 	struct batadv_hashtable *claim_hash;
 	struct batadv_hashtable *backbone_hash;
 	struct batadv_bcast_duplist_entry bcast_duplist[BATADV_DUPLIST_SIZE];
 	int bcast_duplist_curr;
-	/* protects bcast_duplist and bcast_duplist_curr */
-	spinlock_t bcast_duplist_lock;
 	struct batadv_bla_claim_dst claim_dest;
 	struct delayed_work work;
 };
@@ -238,8 +238,8 @@ struct batadv_priv_bla {
 struct batadv_priv_gw {
 	struct hlist_head list;
 	spinlock_t list_lock; /* protects gw_list and curr_gw */
-	struct batadv_gw_node __rcu *curr_gw;  /* rcu protected pointer */
 	atomic_t reselect;
+	struct batadv_gw_node __rcu *curr_gw;  /* rcu protected pointer */
 };
 
 struct batadv_priv_vis {
@@ -266,8 +266,9 @@ struct batadv_priv_dat {
 #endif
 
 struct batadv_priv {
-	atomic_t mesh_state;
 	struct net_device_stats stats;
+	atomic_t mesh_state;
+	char num_ifaces;
 	uint64_t __percpu *bat_counters; /* Per cpu counters */
 	atomic_t aggregated_ogms;	/* boolean */
 	atomic_t bonding;		/* boolean */
@@ -287,7 +288,6 @@ struct batadv_priv {
 	atomic_t bcast_seqno;
 	atomic_t bcast_queue_left;
 	atomic_t batman_queue_left;
-	char num_ifaces;
 	struct batadv_debug_log *debug_log;
 	struct kobject *mesh_obj;
 	struct dentry *debug_dir;
@@ -327,8 +327,8 @@ struct batadv_socket_packet {
 
 struct batadv_tt_common_entry {
 	uint8_t addr[ETH_ALEN];
-	struct hlist_node hash_entry;
 	uint16_t flags;
+	struct hlist_node hash_entry;
 	unsigned long added_at;
 	atomic_t refcount;
 	struct rcu_head rcu;
@@ -364,8 +364,8 @@ struct batadv_backbone_gw {
 	atomic_t wait_periods;
 	atomic_t request_sent;
 	atomic_t refcount;
-	struct rcu_head rcu;
 	uint16_t crc;		/* crc checksum over all claims */
+	struct rcu_head rcu;
 };
 
 struct batadv_claim {
@@ -404,10 +404,10 @@ struct batadv_forw_packet {
 	struct hlist_node list;
 	unsigned long send_time;
 	uint8_t own;
-	struct sk_buff *skb;
+	uint8_t num_packets;
 	uint16_t packet_len;
 	uint32_t direct_link_flags;
-	uint8_t num_packets;
+	struct sk_buff *skb;
 	struct delayed_work delayed_work;
 	struct batadv_hard_iface *if_incoming;
 };
@@ -494,9 +494,9 @@ struct batadv_algo_ops {
 struct batadv_dat_entry {
 	__be32 ip;
 	uint8_t mac_addr[ETH_ALEN];
+	atomic_t refcount;
 	unsigned long last_update;
 	struct hlist_node hash_entry;
-	atomic_t refcount;
 	struct rcu_head rcu;
 };
 
-- 
1.7.10.4

