Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:34 +0100
Message-Id: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/23] batman-adv: Fix list removal of
	batadv_hardif_neigh_node
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

The neigh_list with batadv_hardif_neigh_node objects is accessed with only
rcu_read_lock in batadv_neigh_node_get and batadv_iv_neigh_print. Thus is
is not allowed to kfree the object before the rcu grace period ends which
may still tries to access this object. Therefore the object has first to be
removed from the neigh_list and then it has either wait with
synchronize_rcu or call_rcu till the grace period ends before it can be
freed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
I have no idea why batadv_hardif_neigh_free_now is considered to be safe to
call. The only caller is batadv_neigh_node_free_rcu but this function never
makes sure that the previously mentioned two functions are actually not
accessing it right now when hlist_del_rcu_init + kfree is called.
---
 net/batman-adv/originator.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 00b0437..2681c7d 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -217,10 +217,6 @@ static void batadv_hardif_neigh_free_rcu(struct rcu_head *rcu)
 
 	hardif_neigh = container_of(rcu, struct batadv_hardif_neigh_node, rcu);
 
-	spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
-	hlist_del_init_rcu(&hardif_neigh->list);
-	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
-
 	batadv_hardif_free_ref_now(hardif_neigh->if_incoming);
 	kfree(hardif_neigh);
 }
@@ -233,8 +229,13 @@ static void batadv_hardif_neigh_free_rcu(struct rcu_head *rcu)
 static void
 batadv_hardif_neigh_free_now(struct batadv_hardif_neigh_node *hardif_neigh)
 {
-	if (atomic_dec_and_test(&hardif_neigh->refcount))
+	if (atomic_dec_and_test(&hardif_neigh->refcount)) {
+		spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
+		hlist_del_init_rcu(&hardif_neigh->list);
+		spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
+
 		batadv_hardif_neigh_free_rcu(&hardif_neigh->rcu);
+	}
 }
 
 /**
@@ -244,8 +245,13 @@ batadv_hardif_neigh_free_now(struct batadv_hardif_neigh_node *hardif_neigh)
  */
 void batadv_hardif_neigh_free_ref(struct batadv_hardif_neigh_node *hardif_neigh)
 {
-	if (atomic_dec_and_test(&hardif_neigh->refcount))
+	if (atomic_dec_and_test(&hardif_neigh->refcount)) {
+		spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
+		hlist_del_init_rcu(&hardif_neigh->list);
+		spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
+
 		call_rcu(&hardif_neigh->rcu, batadv_hardif_neigh_free_rcu);
+	}
 }
 
 /**
-- 
2.6.4

