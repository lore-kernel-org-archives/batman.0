Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 19 Oct 2011 11:02:25 +0200
Message-Id: <1319014945-32281-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove references for global tt
	entries
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

struct tt_global_entry holds a reference to an orig_node which must be
decremented before deallocating the structure.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 compat.c            |    8 --------
 compat.h            |    1 -
 translation-table.c |   14 +++++++++++++-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/compat.c b/compat.c
index 88ceb40..1793904 100644
--- a/compat.c
+++ b/compat.c
@@ -36,12 +36,4 @@ void free_rcu_tt_local_entry(struct rcu_head *rcu)
 	kfree(tt_local_entry);
 }
 
-void free_rcu_tt_global_entry(struct rcu_head *rcu)
-{
-	struct tt_global_entry *tt_global_entry;
-
-	tt_global_entry = container_of(rcu, struct tt_global_entry, rcu);
-	kfree(tt_global_entry);
-}
-
 #endif /* < KERNEL_VERSION(3, 0, 0) */
diff --git a/compat.h b/compat.h
index 43654e8..58c3c6a 100644
--- a/compat.h
+++ b/compat.h
@@ -63,7 +63,6 @@ void free_rcu_gw_node(struct rcu_head *rcu);
 void free_rcu_neigh_node(struct rcu_head *rcu);
 void free_rcu_softif_neigh(struct rcu_head *rcu);
 void free_rcu_tt_local_entry(struct rcu_head *rcu);
-void free_rcu_tt_global_entry(struct rcu_head *rcu);
 
 #endif /* < KERNEL_VERSION(3, 0, 0) */
 
diff --git a/translation-table.c b/translation-table.c
index 873fb3d..abf05cb 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -137,10 +137,22 @@ static void tt_local_entry_free_ref(struct tt_local_entry *tt_local_entry)
 		kfree_rcu(tt_local_entry, rcu);
 }
 
+static void tt_global_entry_free_rcu(struct rcu_head *rcu)
+{
+	struct tt_global_entry *tt_global_entry;
+
+	tt_global_entry = container_of(rcu, struct tt_global_entry, rcu);
+
+	if (tt_global_entry->orig_node)
+		orig_node_free_ref(tt_global_entry->orig_node);
+
+	kfree(tt_global_entry);
+}
+
 static void tt_global_entry_free_ref(struct tt_global_entry *tt_global_entry)
 {
 	if (atomic_dec_and_test(&tt_global_entry->refcount))
-		kfree_rcu(tt_global_entry, rcu);
+		call_rcu(&tt_global_entry->rcu, tt_global_entry_free_rcu);
 }
 
 static void tt_local_event(struct bat_priv *bat_priv, const uint8_t *addr,
-- 
1.7.7

