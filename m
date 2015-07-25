Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 26 Jul 2015 04:37:15 +0800
Message-Id: <1437856635-27068-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: move hardif refcount inc to
	batadv_neigh_node_new()
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

The batadv_neigh_node cleanup function 'batadv_neigh_node_free_rcu()'
takes care of reducing the hardif refcounter, hence it's only logical
to assume the creating function of that same object
'batadv_neigh_node_new()' takes care of increasing the same refcounter.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bat_iv_ogm.c | 6 ------
 net/batman-adv/originator.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 5c12200..b9b8b33 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -303,12 +303,6 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 	if (!neigh_node)
 		goto out;
 
-	if (!atomic_inc_not_zero(&hard_iface->refcount)) {
-		kfree(neigh_node);
-		neigh_node = NULL;
-		goto out;
-	}
-
 	neigh_node->orig_node = orig_neigh;
 	neigh_node->if_incoming = hard_iface;
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 610620a..f8317c1 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -461,6 +461,12 @@ batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
 	if (!neigh_node)
 		goto out;
 
+	if (!atomic_inc_not_zero(&hard_iface->refcount)) {
+		kfree(neigh_node);
+		neigh_node = NULL;
+		goto out;
+	}
+
 	INIT_HLIST_NODE(&neigh_node->list);
 	INIT_HLIST_HEAD(&neigh_node->ifinfo_list);
 	spin_lock_init(&neigh_node->ifinfo_lock);
-- 
2.1.4

