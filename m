Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:36 +0100
Message-Id: <1450222316-1764-3-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 03/23] batman-adv: Avoid recursive call_rcu
	for batadv_hardif_neigh_node
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

The batadv_hardif_neigh_put function uses call_rcu to delay the free of the
batadv_hardif_neigh_node object until no (already started) rcu_read_lock is
enabled anymore. This makes sure that no context still is trying to access
the object which should be removed. But batadv_hardif_neigh_node also
contains a reference to if_incoming which must be removed.

This if_incoming was done in the call_rcu function
batadv_hardif_neigh_free_rcu but should actually be done in the
batadv_hardif_neigh_release_rcu function to avoid nested call_rcus. This is
important because rcu_barrier (e.g. batadv_softif_free or batadv_exit) will
not detect the inner call_rcu as relevant for its execution because this
barrier was most likely inserted in the queue before the callback of the
first call_rcu was executed. The caller of rcu_barrier will therefore
continue to run before the inner call_rcu callback finished.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 24c62a8..18305d3 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -215,7 +215,6 @@ void batadv_neigh_ifinfo_free_ref(struct batadv_neigh_ifinfo *neigh_ifinfo)
 static void
 batadv_hardif_neigh_free(struct batadv_hardif_neigh_node *hardif_neigh)
 {
-	batadv_hardif_free_ref_now(hardif_neigh->if_incoming);
 	kfree(hardif_neigh);
 }
 
@@ -235,6 +234,8 @@ static void batadv_hardif_neigh_release_now(struct kref *ref)
 	hlist_del_init_rcu(&hardif_neigh->list);
 	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
 
+	batadv_hardif_free_ref_now(hardif_neigh->if_incoming);
+
 	batadv_hardif_neigh_free(hardif_neigh);
 }
 
@@ -277,6 +278,8 @@ static void batadv_hardif_neigh_release_rcu(struct kref *ref)
 	hlist_del_init_rcu(&hardif_neigh->list);
 	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
 
+	batadv_hardif_free_ref(hardif_neigh->if_incoming);
+
 	call_rcu(&hardif_neigh->rcu, batadv_hardif_neigh_free_rcu);
 }
 
-- 
2.6.4

