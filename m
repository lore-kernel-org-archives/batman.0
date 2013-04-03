Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed,  3 Apr 2013 03:25:13 +0200
Message-Id: <1364952313-3163-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <20130330131029.GB4024@ritirata.org>
References: <20130330131029.GB4024@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: Fix rcu_barrier() miss due
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
---
* v2: Added a code comment as discussed on IRC:
      To avoid forgetting about it, to avoid accidentally changing things
      back in the future.

 originator.c        |    2 +-
 originator.h        |    1 +
 translation-table.c |    8 +++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/originator.c b/originator.c
index 2f34525..1f01e93 100644
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
index 9322320..4fe07cf 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -144,7 +144,13 @@ static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 	struct batadv_tt_orig_list_entry *orig_entry;
 
 	orig_entry = container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
-	batadv_orig_node_free_ref(orig_entry->orig_node);
+
+	/* We are in an rcu callback here, therefore we cannot use
+	 * batadv_orig_node_free_ref() and its call_rcu():
+	 * An rcu_barrier() wouldn't wait for that to finish */
+	if (atomic_dec_and_test(&orig_entry->orig_node->refcount))
+		batadv_orig_node_free_rcu(&orig_entry->orig_node->rcu);
+
 	kfree(orig_entry);
 }
 
-- 
1.7.10.4

