Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Thu, 14 Jan 2016 01:51:54 +0800
Message-Id: <1452707514-5091-3-git-send-email-a@unstable.cc>
In-Reply-To: <1452707514-5091-1-git-send-email-a@unstable.cc>
References: <1452707514-5091-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix list removal of
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

The neigh_list with batadv_hardif_neigh_node objects is accessed with only
rcu_read_lock in batadv_hardif_neigh_get and batadv_iv_neigh_print. Thus it
is not allowed to kfree the object before the rcu grace period ends (which
may still protects context accessing this object). Therefore the object has
first to be removed from the neigh_list and then it has either wait with
synchronize_rcu or call_rcu till the grace period ends before it can be
freed.

Fixes: cef63419f7db ("batman-adv: add list of unique single hop neighbors per hard-interface")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/originator.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 3c782a33bdac..ae6d18cafc5a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -211,10 +211,6 @@ static void batadv_hardif_neigh_free_rcu(struct rcu_head *rcu)
 
 	hardif_neigh = container_of(rcu, struct batadv_hardif_neigh_node, rcu);
 
-	spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
-	hlist_del_init_rcu(&hardif_neigh->list);
-	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
-
 	batadv_hardif_free_ref_now(hardif_neigh->if_incoming);
 	kfree(hardif_neigh);
 }
@@ -227,8 +223,13 @@ static void batadv_hardif_neigh_free_rcu(struct rcu_head *rcu)
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
@@ -238,8 +239,13 @@ batadv_hardif_neigh_free_now(struct batadv_hardif_neigh_node *hardif_neigh)
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
2.7.0

