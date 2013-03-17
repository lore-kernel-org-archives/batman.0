Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 17 Mar 2013 05:44:57 +0100
Message-Id: <1363495498-17830-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <trinity-97d57b03-203f-4915-9bec-fcae5d01e618-1363490537768@3capp-webde-bs08>
References: <trinity-97d57b03-203f-4915-9bec-fcae5d01e618-1363490537768@3capp-webde-bs08>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix rcu_barrier() miss due
	to double call_rcu() in TT code
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

rcu_barrier() only waits for the currently scheduled rcu functions
to finish - it won't wait for any function scheduled via another
call_rcu() within an rcu scheduled function.

Unfortunately our batadv_tt_orig_list_entry_free_ref() does just that,
via a batadv_orig_node_free_ref() call, leading to our rcu_barrier()
call potentially missing such a batadv_orig_node_free_ref().

This patch fixes this issue by calling the batadv_orig_node_free_rcu()
directly from the rcu callback, removing the unnecessary, additional
call_rcu() layer here.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>

diff --git a/originator.c b/originator.c
index 585e684..013c7d0 100644
--- a/originator.c
+++ b/originator.c
@@ -117,7 +117,7 @@ out:
 	return neigh_node;
 }
 
-static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
+void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 {
 	struct hlist_node *node_tmp;
 	struct batadv_neigh_node *neigh_node, *tmp_neigh_node;
diff --git a/originator.h b/originator.h
index 7df48fa..4f9f88b 100644
--- a/originator.h
+++ b/originator.h
@@ -25,6 +25,7 @@
 int batadv_originator_init(struct batadv_priv *bat_priv);
 void batadv_originator_free(struct batadv_priv *bat_priv);
 void batadv_purge_orig_ref(struct batadv_priv *bat_priv);
+void batadv_orig_node_free_rcu(struct rcu_head *rcu);
 void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node);
 struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 					      const uint8_t *addr);
diff --git a/translation-table.c b/translation-table.c
index 9322320..ee91cc1 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -144,7 +144,10 @@ static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 	struct batadv_tt_orig_list_entry *orig_entry;
 
 	orig_entry = container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
-	batadv_orig_node_free_ref(orig_entry->orig_node);
+
+	if (atomic_dec_and_test(&orig_entry->orig_node->refcount))
+		batadv_orig_node_free_rcu(&orig_entry->orig_node->rcu);
+
 	kfree(orig_entry);
 }
 
-- 
1.7.10.4

