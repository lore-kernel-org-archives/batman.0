Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Dec 2015 14:17:50 +0100
Message-Id: <1450617490-3544-10-git-send-email-sven@narfation.org>
In-Reply-To: <1450617490-3544-1-git-send-email-sven@narfation.org>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 10/30] batman-adv: Drop reference to
	netdevice on last reference
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

The references to the network device should be dropped inside the release
function for batadv_hard_iface similar to what is done with the batman-adv
internal datastructures.

Fixes: b25cb3ddcccd ("batman-adv: use rcu callbacks when freeing batman_if")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - split patchset into fixes and kref migration to make it easier when the
   decision is made where each patch will be applied

 net/batman-adv/hard-interface.c | 13 ++++++++-----
 net/batman-adv/hard-interface.h |  4 ++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 49e05d2..aea4d06 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -47,13 +47,16 @@
 #include "sysfs.h"
 #include "translation-table.h"
 
-void batadv_hardif_free_rcu(struct rcu_head *rcu)
+/**
+ * batadv_hardif_release - release hard interface from lists and queue for
+ *  free after rcu grace period
+ * @hard_iface: the hard interface to free
+ */
+void batadv_hardif_release(struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_hard_iface *hard_iface;
-
-	hard_iface = container_of(rcu, struct batadv_hard_iface, rcu);
 	dev_put(hard_iface->net_dev);
-	kfree(hard_iface);
+
+	kfree_rcu(hard_iface, rcu);
 }
 
 struct batadv_hard_iface *
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 7b12ea8..6bcc536 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -61,7 +61,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 void batadv_hardif_remove_interfaces(void);
 int batadv_hardif_min_mtu(struct net_device *soft_iface);
 void batadv_update_min_mtu(struct net_device *soft_iface);
-void batadv_hardif_free_rcu(struct rcu_head *rcu);
+void batadv_hardif_release(struct batadv_hard_iface *hard_iface);
 
 /**
  * batadv_hardif_free_ref - decrement the hard interface refcounter and
@@ -72,7 +72,7 @@ static inline void
 batadv_hardif_free_ref(struct batadv_hard_iface *hard_iface)
 {
 	if (atomic_dec_and_test(&hard_iface->refcount))
-		call_rcu(&hard_iface->rcu, batadv_hardif_free_rcu);
+		batadv_hardif_release(hard_iface);
 }
 
 static inline struct batadv_hard_iface *
-- 
2.6.4

