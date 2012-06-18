Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 18 Jun 2012 18:10:34 +0200
Message-Id: <1340035834-29105-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix race condition in TT
	full-table replacement
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

In the current TT code, when a TT_Response containing a full table is received
form an originator, the node first purges all the clients for that originator in
the global translation-table and then merges the new received table.
During the purging phase each client deletion is done by means of a call_rcu()
invocation and at the end the global entry counter for that originator is set to
0. However the invoked rcu function decreases by one the global entry counter
for that originator as well and since the rcu invocation is likely to be
postponed, the node will end up in first setting the counter to 0 and then
decreasing it one by one for each deleted client.
To solve this problem the counter is not explicitly set to 0 anymore and the
counter decrement is performed right before the invocation of call_rcu().

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 2a6d7d6..b08cb76 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -145,7 +145,6 @@ static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 	struct batadv_tt_orig_list_entry *orig_entry;
 
 	orig_entry = container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
-	atomic_dec(&orig_entry->orig_node->tt_size);
 	batadv_orig_node_free_ref(orig_entry->orig_node);
 	kfree(orig_entry);
 }
@@ -153,6 +152,8 @@ static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 static void
 batadv_tt_orig_list_entry_free_ref(struct batadv_tt_orig_list_entry *orig_entry)
 {
+	/* to avoid race conditions, immediately decrease the tt counter */
+	atomic_dec(&orig_entry->orig_node->tt_size);
 	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
 }
 
@@ -1025,7 +1026,6 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 		}
 		spin_unlock_bh(list_lock);
 	}
-	atomic_set(&orig_node->tt_size, 0);
 	orig_node->tt_initialised = false;
 }
 
-- 
1.7.9.4

