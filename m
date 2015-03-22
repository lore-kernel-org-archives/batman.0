Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Mar 2015 16:23:41 +0100
Message-Id: <1427037821-11565-2-git-send-email-sven@narfation.org>
In-Reply-To: <1427037821-11565-1-git-send-email-sven@narfation.org>
References: <1427037821-11565-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv5 2/2] batman-adv: Define the size of
	hashtables by hash bits
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

The common hashtable implementation in the kernel uses bits of the hash to
compute the final size of the hastable. Similar can be done for the partially
locked, concurrent hashtables in batman-adv.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v5: Rebased on top of patches:

 * batman-adv: Remove explicit compat.h include and split compat.h
 * batman-adv: Add required to includes to all files
 * batman-adv: Remove unused IFF_BRIDGE_PORT live patching hack
 * batman-adv: Automatically create nested kfree_rcu helper functions

 main.h  |  9 +++++++++
 types.h | 24 ++++++++++++++++--------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/main.h b/main.h
index 0a653e9..0540248 100644
--- a/main.h
+++ b/main.h
@@ -154,6 +154,15 @@ enum batadv_uev_type {
 #define BATADV_DAT_CANDIDATE_NOT_FOUND	0
 #define BATADV_DAT_CANDIDATE_ORIG	1
 
+#define BATADV_BLA_CLAIM_HASH_BITS 7
+#define BATADV_BLA_BACKBONE_HASH_BITS 5
+#define BATADV_NC_CODING_HASH_BITS 7
+#define BATADV_NC_DECODING_HASH_BITS 7
+#define BATADV_DAT_HASH_BITS 10
+#define BATADV_ORIG_HASH_BITS 10
+#define BATADV_TT_LOCAL_HASH_BITS 10
+#define BATADV_TT_GLOBAL_HASH_BITS 10
+
 /* Debug Messages */
 #ifdef pr_fmt
 #undef pr_fmt
diff --git a/types.h b/types.h
index 3782588..d682232 100644
--- a/types.h
+++ b/types.h
@@ -59,6 +59,14 @@ struct batadv_hashbucket {
 };
 
 /**
+ * BATADV_DECLARE_HASHTABLE - declare an array of buckets for an hashtable
+ * @name: name of the declared array of buckets
+ * @bits: number of bits used from a hash to find a bucket in the hashtable
+ */
+#define BATADV_DECLARE_HASHTABLE(name, bits) \
+		struct batadv_hashbucket name[1u << bits]
+
+/**
  * enum batadv_dhcp_recipient - dhcp destination
  * @BATADV_DHCP_NO: packet is not a dhcp message
  * @BATADV_DHCP_TO_SERVER: dhcp message is directed to a server
@@ -542,8 +550,8 @@ struct batadv_priv_tt {
 	atomic_t ogm_append_cnt;
 	atomic_t local_changes;
 	struct list_head changes_list;
-	struct batadv_hashbucket local_hash[1024];
-	struct batadv_hashbucket global_hash[1024];
+	BATADV_DECLARE_HASHTABLE(local_hash, BATADV_TT_LOCAL_HASH_BITS);
+	BATADV_DECLARE_HASHTABLE(global_hash, BATADV_TT_GLOBAL_HASH_BITS);
 	struct list_head req_list;
 	struct list_head roam_list;
 	spinlock_t changes_list_lock; /* protects changes */
@@ -573,8 +581,8 @@ struct batadv_priv_tt {
 #ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_priv_bla {
 	atomic_t num_requests;
-	struct batadv_hashbucket claim_hash[128];
-	struct batadv_hashbucket backbone_hash[32];
+	BATADV_DECLARE_HASHTABLE(claim_hash, BATADV_BLA_CLAIM_HASH_BITS);
+	BATADV_DECLARE_HASHTABLE(backbone_hash, BATADV_BLA_BACKBONE_HASH_BITS);
 	struct batadv_bcast_duplist_entry bcast_duplist[BATADV_DUPLIST_SIZE];
 	int bcast_duplist_curr;
 	/* protects bcast_duplist & bcast_duplist_curr */
@@ -644,7 +652,7 @@ struct batadv_priv_tvlv {
 #ifdef CONFIG_BATMAN_ADV_DAT
 struct batadv_priv_dat {
 	batadv_dat_addr_t addr;
-	struct batadv_hashbucket hash[1024];
+	BATADV_DECLARE_HASHTABLE(hash, BATADV_DAT_HASH_BITS);
 	struct delayed_work work;
 };
 #endif
@@ -707,8 +715,8 @@ struct batadv_priv_nc {
 	u32 max_buffer_time;
 	unsigned long timestamp_fwd_flush;
 	unsigned long timestamp_sniffed_purge;
-	struct batadv_hashbucket coding_hash[128];
-	struct batadv_hashbucket decoding_hash[128];
+	BATADV_DECLARE_HASHTABLE(coding_hash, BATADV_NC_CODING_HASH_BITS);
+	BATADV_DECLARE_HASHTABLE(decoding_hash, BATADV_NC_DECODING_HASH_BITS);
 };
 
 /**
@@ -821,7 +829,7 @@ struct batadv_priv {
 	struct dentry *debug_dir;
 	struct hlist_head forw_bat_list;
 	struct hlist_head forw_bcast_list;
-	struct batadv_hashbucket orig_hash[1024];
+	BATADV_DECLARE_HASHTABLE(orig_hash, BATADV_ORIG_HASH_BITS);
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects forw_bcast_list */
 	struct delayed_work orig_work;
-- 
2.1.4

