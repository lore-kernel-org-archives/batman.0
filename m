Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  7 May 2013 00:29:22 +0200
Message-Id: <1367879362-3164-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: don't use call_rcu if not
	needed
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
Cc: Antonio Quartulli <ordex@autistici.org>

batadv_tt_global_entry_free_ref uses call_rcu to schedule a
function which will only free the global entry itself.

For this reason call_rcu is useless and kfree_rcu can be
used to simplify the code.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
- removed one useless container_of in compat.c

 compat.c            |  9 +++++++++
 translation-table.c | 20 ++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/compat.c b/compat.c
index 1f3a39d..da556a4 100644
--- a/compat.c
+++ b/compat.c
@@ -27,6 +27,15 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
 
+void batadv_free_rcu_tt_global_entry(struct rcu_head *rcu)
+{
+	struct batadv_tt_global_entry *global;
+
+	global = container_of(rcu, struct batadv_tt_global_entry, common.rcu);
+
+	kfree(global);
+}
+
 void batadv_free_rcu_gw_node(struct rcu_head *rcu)
 {
 	struct batadv_gw_node *gw_node;
diff --git a/translation-table.c b/translation-table.c
index df6b5cd..44e7789 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -117,25 +117,17 @@ batadv_tt_local_entry_free_ref(struct batadv_tt_local_entry *tt_local_entry)
 		kfree_rcu(tt_local_entry, common.rcu);
 }
 
-static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
-{
-	struct batadv_tt_common_entry *tt_common_entry;
-	struct batadv_tt_global_entry *tt_global_entry;
-
-	tt_common_entry = container_of(rcu, struct batadv_tt_common_entry, rcu);
-	tt_global_entry = container_of(tt_common_entry,
-				       struct batadv_tt_global_entry, common);
-
-	kfree(tt_global_entry);
-}
-
+/**
+ * batadv_tt_global_entry_free_ref - decrement the refcounter for a
+ *  tt_global_entry and possibly free it
+ * @tt_global_entry: the object to free
+ */
 static void
 batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
 {
 	if (atomic_dec_and_test(&tt_global_entry->common.refcount)) {
 		batadv_tt_global_del_orig_list(tt_global_entry);
-		call_rcu(&tt_global_entry->common.rcu,
-			 batadv_tt_global_entry_free_rcu);
+		kfree_rcu(tt_global_entry, common.rcu);
 	}
 }
 
-- 
1.8.1.5

