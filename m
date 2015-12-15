Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:41 +0100
Message-Id: <1450222316-1764-8-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/23] batman-adv: Convert
	batadv_bla_backbone_gw to kref
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

So switch to kref instead of using the self-made, atomic_t-based
implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 50 ++++++++++++++++++++++------------
 net/batman-adv/types.h                 |  2 +-
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index d9b034a..4e5538a 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -31,6 +31,7 @@
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -143,14 +144,28 @@ static int batadv_compare_claim(const struct hlist_node *node,
 }
 
 /**
- * batadv_compare_backbone_gw - free backbone gw
+ * batadv_backbone_gw_release - release backbone gw from lists and queue for
+ *  free after rcu grace period
+ * * @ref: kref pointer of the backbone gw
+ */
+static void batadv_backbone_gw_release(struct kref *ref)
+{
+	struct batadv_bla_backbone_gw *backbone_gw;
+
+	backbone_gw = container_of(ref, struct batadv_bla_backbone_gw,
+				   refcount);
+
+	kfree_rcu(backbone_gw, rcu);
+}
+
+/**
+ * batadv_backbone_gw_put - decrement the backbone gw refcounter and possibly
+ *  release it
  * @backbone_gw: backbone gateway to be free'd
  */
-static void
-batadv_backbone_gw_free_ref(struct batadv_bla_backbone_gw *backbone_gw)
+static void batadv_backbone_gw_put(struct batadv_bla_backbone_gw *backbone_gw)
 {
-	if (atomic_dec_and_test(&backbone_gw->refcount))
-		kfree_rcu(backbone_gw, rcu);
+	kref_put(&backbone_gw->refcount, batadv_backbone_gw_release);
 }
 
 /**
@@ -163,7 +178,7 @@ static void batadv_claim_free_rcu(struct rcu_head *rcu)
 
 	claim = container_of(rcu, struct batadv_bla_claim, rcu);
 
-	batadv_backbone_gw_free_ref(claim->backbone_gw);
+	batadv_backbone_gw_put(claim->backbone_gw);
 	kfree(claim);
 }
 
@@ -249,7 +264,7 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv, u8 *addr,
 						&search_entry))
 			continue;
 
-		if (!atomic_inc_not_zero(&backbone_gw->refcount))
+		if (!kref_get_unless_zero(&backbone_gw->refcount))
 			continue;
 
 		backbone_gw_tmp = backbone_gw;
@@ -450,7 +465,8 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 	ether_addr_copy(entry->orig, orig);
 
 	/* one for the hash, one for returning */
-	atomic_set(&entry->refcount, 2);
+	kref_init(&entry->refcount);
+	kref_get(&entry->refcount);
 
 	hash_added = batadv_hash_add(bat_priv->bla.backbone_hash,
 				     batadv_compare_backbone_gw,
@@ -506,7 +522,7 @@ batadv_bla_update_own_backbone_gw(struct batadv_priv *bat_priv,
 		return;
 
 	backbone_gw->lasttime = jiffies;
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 }
 
 /**
@@ -555,7 +571,7 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 
 	/* finally, send an announcement frame */
 	batadv_bla_send_announce(bat_priv, backbone_gw);
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 }
 
 /**
@@ -663,10 +679,10 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		spin_lock_bh(&claim->backbone_gw->crc_lock);
 		claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
 		spin_unlock_bh(&claim->backbone_gw->crc_lock);
-		batadv_backbone_gw_free_ref(claim->backbone_gw);
+		batadv_backbone_gw_put(claim->backbone_gw);
 	}
 	/* set (new) backbone gw */
-	atomic_inc(&backbone_gw->refcount);
+	kref_get(&backbone_gw->refcount);
 	claim->backbone_gw = backbone_gw;
 
 	spin_lock_bh(&backbone_gw->crc_lock);
@@ -764,7 +780,7 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 		}
 	}
 
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 	return 1;
 }
 
@@ -835,7 +851,7 @@ static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
 		   claim_addr, BATADV_PRINT_VID(vid), backbone_gw->orig);
 
 	batadv_bla_del_claim(bat_priv, claim_addr, vid);
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 	return 1;
 }
 
@@ -872,7 +888,7 @@ static int batadv_handle_claim(struct batadv_priv *bat_priv,
 
 	/* TODO: we could call something like tt_local_del() here. */
 
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 	return 1;
 }
 
@@ -1135,7 +1151,7 @@ purge_now:
 			batadv_bla_del_backbone_claims(backbone_gw);
 
 			hlist_del_rcu(&backbone_gw->hash_entry);
-			batadv_backbone_gw_free_ref(backbone_gw);
+			batadv_backbone_gw_put(backbone_gw);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -1552,7 +1568,7 @@ int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 	if (!backbone_gw)
 		return 0;
 
-	batadv_backbone_gw_free_ref(backbone_gw);
+	batadv_backbone_gw_put(backbone_gw);
 	return 1;
 }
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c6c3f0f..098ec7f 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -930,7 +930,7 @@ struct batadv_bla_backbone_gw {
 	atomic_t request_sent;
 	u16 crc;
 	spinlock_t crc_lock; /* protects crc */
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4

