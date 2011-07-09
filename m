Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 10 Jul 2011 00:36:36 +0200
Message-Id: <1310250996-4456-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: hash_add() has to discriminate
	on the return value
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

hash_add() returns 0 on success while returns -1 either on error and on
entry already present. The caller could use such information to select
its behaviour. For this reason it is useful that hash_add() returns -1
in case on error and returns 1 in case of entry already present.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 hash.h       |    9 ++++++---
 originator.c |    2 +-
 vis.c        |    4 ++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/hash.h b/hash.h
index dd5c9fd..864b9b0 100644
--- a/hash.h
+++ b/hash.h
@@ -82,7 +82,7 @@ static inline int hash_add(struct hashtable_t *hash,
 			   hashdata_choose_cb choose,
 			   const void *data, struct hlist_node *data_node)
 {
-	int index;
+	int index, ret = -1;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	spinlock_t *list_lock; /* spinlock to protect write access */
@@ -98,6 +98,7 @@ static inline int hash_add(struct hashtable_t *hash,
 	__hlist_for_each_rcu(node, head) {
 		if (!compare(node, data))
 			continue;
+		ret = 1;
 
 		goto err_unlock;
 	}
@@ -108,12 +109,14 @@ static inline int hash_add(struct hashtable_t *hash,
 	hlist_add_head_rcu(data_node, head);
 	spin_unlock_bh(list_lock);
 
-	return 0;
+	ret = 0;
+
+	return ret;
 
 err_unlock:
 	rcu_read_unlock();
 err:
-	return -1;
+	return ret;
 }
 
 /* removes data from hash, if found. returns pointer do data on success, so you
diff --git a/originator.c b/originator.c
index f3c3f62..d448018 100644
--- a/originator.c
+++ b/originator.c
@@ -252,7 +252,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
 
 	hash_added = hash_add(bat_priv->orig_hash, compare_orig,
 			      choose_orig, orig_node, &orig_node->hash_entry);
-	if (hash_added < 0)
+	if (hash_added != 0)
 		goto free_bcast_own_sum;
 
 	return orig_node;
diff --git a/vis.c b/vis.c
index 8a1b985..8b75cc5 100644
--- a/vis.c
+++ b/vis.c
@@ -465,7 +465,7 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 	/* try to add it */
 	hash_added = hash_add(bat_priv->vis_hash, vis_info_cmp, vis_info_choose,
 			      info, &info->hash_entry);
-	if (hash_added < 0) {
+	if (hash_added != 0) {
 		/* did not work (for some reason) */
 		kref_put(&info->refcount, free_info);
 		info = NULL;
@@ -920,7 +920,7 @@ int vis_init(struct bat_priv *bat_priv)
 	hash_added = hash_add(bat_priv->vis_hash, vis_info_cmp, vis_info_choose,
 			      bat_priv->my_vis_info,
 			      &bat_priv->my_vis_info->hash_entry);
-	if (hash_added < 0) {
+	if (hash_added != 0) {
 		pr_err("Can't add own vis packet into hash\n");
 		/* not in hash, need to remove it manually. */
 		kref_put(&bat_priv->my_vis_info->refcount, free_info);
-- 
1.7.3.4

