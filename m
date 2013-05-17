Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 17 May 2013 10:10:11 +0200
Message-Id: <1368778211-2142-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1368778211-2142-1-git-send-email-ordex@autistici.org>
References: <1368778211-2142-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix rcu_barrier() miss due to
	double call_rcu() in TT code
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <ordex@autistici.org>

From: Linus Lüssing <linus.luessing@web.de>

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
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Acked-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/originator.c        | 16 ++++++++++++++++
 net/batman-adv/originator.h        |  1 +
 net/batman-adv/translation-table.c |  7 ++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 2f34525..fad1a20 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -156,12 +156,28 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 	kfree(orig_node);
 }
 
+/**
+ * batadv_orig_node_free_ref - decrement the orig node refcounter and possibly
+ * schedule an rcu callback for freeing it
+ * @orig_node: the orig node to free
+ */
 void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node)
 {
 	if (atomic_dec_and_test(&orig_node->refcount))
 		call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
 }
 
+/**
+ * batadv_orig_node_free_ref_now - decrement the orig node refcounter and
+ * possibly free it (without rcu callback)
+ * @orig_node: the orig node to free
+ */
+void batadv_orig_node_free_ref_now(struct batadv_orig_node *orig_node)
+{
+	if (atomic_dec_and_test(&orig_node->refcount))
+		batadv_orig_node_free_rcu(&orig_node->rcu);
+}
+
 void batadv_originator_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 7df48fa..734e5a3 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -26,6 +26,7 @@ int batadv_originator_init(struct batadv_priv *bat_priv);
 void batadv_originator_free(struct batadv_priv *bat_priv);
 void batadv_purge_orig_ref(struct batadv_priv *bat_priv);
 void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node);
+void batadv_orig_node_free_ref_now(struct batadv_orig_node *orig_node);
 struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 					      const uint8_t *addr);
 struct batadv_neigh_node *
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5e89dee..9e87485 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -144,7 +144,12 @@ static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 	struct batadv_tt_orig_list_entry *orig_entry;
 
 	orig_entry = container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
-	batadv_orig_node_free_ref(orig_entry->orig_node);
+
+	/* We are in an rcu callback here, therefore we cannot use
+	 * batadv_orig_node_free_ref() and its call_rcu():
+	 * An rcu_barrier() wouldn't wait for that to finish
+	 */
+	batadv_orig_node_free_ref_now(orig_entry->orig_node);
 	kfree(orig_entry);
 }
 
-- 
1.8.1.5

