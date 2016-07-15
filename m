Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Jul 2016 17:39:28 +0200
Message-Id: <1468597173-25378-13-git-send-email-sven@narfation.org>
In-Reply-To: <1468597173-25378-1-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 13/18] batman-adv: Place kref_get for
	hard_iface near use
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

It is hard to understand why the refcnt is increased when it isn't done
near the actual place the new reference is used. So using kref_get right
before the place which requires the reference and in the same function
helps to avoid accidental problems causedy incorrect reference counting.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - split patch based on type

 net/batman-adv/hard-interface.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 714af8e..adb0377 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -658,6 +658,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	INIT_HLIST_HEAD(&hard_iface->neigh_list);
 
 	spin_lock_init(&hard_iface->neigh_list_lock);
+	kref_init(&hard_iface->refcount);
 
 	hard_iface->num_bcasts = BATADV_NUM_BCASTS_DEFAULT;
 	if (batadv_is_wifi_netdev(net_dev))
@@ -665,11 +666,8 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 
 	batadv_v_hardif_init(hard_iface);
 
-	/* extra reference for return */
-	kref_init(&hard_iface->refcount);
-	kref_get(&hard_iface->refcount);
-
 	batadv_check_known_mac_addr(hard_iface->net_dev);
+	kref_get(&hard_iface->refcount);
 	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
 
 	return hard_iface;
-- 
2.8.1

