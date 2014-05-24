Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 24 May 2014 06:43:47 +0200
Message-Id: <1400906627-18725-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: prefer kmalloc_array to kmalloc
	when possible
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Reported by checkpatch with the following warning:
WARNING: Prefer kmalloc_array over kmalloc with multiply

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 bat_iv_ogm.c            | 13 +++++++------
 distributed-arp-table.c |  3 ++-
 hash.c                  |  6 +++---
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index f04224c..1e80539 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -108,14 +108,15 @@ static int batadv_iv_ogm_orig_add_if(struct batadv_orig_node *orig_node,
 				     int max_if_num)
 {
 	void *data_ptr;
-	size_t data_size, old_size;
+	size_t old_size;
 	int ret = -ENOMEM;
 
 	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 
-	data_size = max_if_num * sizeof(unsigned long) * BATADV_NUM_WORDS;
 	old_size = (max_if_num - 1) * sizeof(unsigned long) * BATADV_NUM_WORDS;
-	data_ptr = kmalloc(data_size, GFP_ATOMIC);
+	data_ptr = kmalloc_array(max_if_num,
+				 BATADV_NUM_WORDS * sizeof(unsigned long),
+				 GFP_ATOMIC);
 	if (!data_ptr)
 		goto unlock;
 
@@ -123,7 +124,7 @@ static int batadv_iv_ogm_orig_add_if(struct batadv_orig_node *orig_node,
 	kfree(orig_node->bat_iv.bcast_own);
 	orig_node->bat_iv.bcast_own = data_ptr;
 
-	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
+	data_ptr = kmalloc_array(max_if_num, sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
 		kfree(orig_node->bat_iv.bcast_own);
 		goto unlock;
@@ -164,7 +165,7 @@ static int batadv_iv_ogm_orig_del_if(struct batadv_orig_node *orig_node,
 		goto free_bcast_own;
 
 	chunk_size = sizeof(unsigned long) * BATADV_NUM_WORDS;
-	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
+	data_ptr = kmalloc_array(max_if_num, chunk_size, GFP_ATOMIC);
 	if (!data_ptr)
 		goto unlock;
 
@@ -183,7 +184,7 @@ free_bcast_own:
 	if (max_if_num == 0)
 		goto free_own_sum;
 
-	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
+	data_ptr = kmalloc_array(max_if_num, sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
 		kfree(orig_node->bat_iv.bcast_own);
 		goto unlock;
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index dcd99b2..b7406e0 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -537,7 +537,8 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	if (!bat_priv->orig_hash)
 		return NULL;
 
-	res = kmalloc(BATADV_DAT_CANDIDATES_NUM * sizeof(*res), GFP_ATOMIC);
+	res = kmalloc_array(BATADV_DAT_CANDIDATES_NUM, sizeof(*res),
+			    GFP_ATOMIC);
 	if (!res)
 		return NULL;
 
diff --git a/hash.c b/hash.c
index 63bdf7e..7c1c630 100644
--- a/hash.c
+++ b/hash.c
@@ -46,12 +46,12 @@ struct batadv_hashtable *batadv_hash_new(uint32_t size)
 	if (!hash)
 		return NULL;
 
-	hash->table = kmalloc(sizeof(*hash->table) * size, GFP_ATOMIC);
+	hash->table = kmalloc_array(size, sizeof(*hash->table), GFP_ATOMIC);
 	if (!hash->table)
 		goto free_hash;
 
-	hash->list_locks = kmalloc(sizeof(*hash->list_locks) * size,
-				   GFP_ATOMIC);
+	hash->list_locks = kmalloc_array(size, sizeof(*hash->list_locks),
+					 GFP_ATOMIC);
 	if (!hash->list_locks)
 		goto free_table;
 
-- 
1.8.5.5

