Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri,  4 Feb 2011 16:21:31 +0100
Message-Id: <1296832896-30081-3-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <201102031802.52134.lindner_marek@yahoo.de>
References: <201102031802.52134.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: Correct rcu refcounting for
	softif_neigh
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

From: Sven Eckelmann <sven@narfation.org>

It might be possible that 2 threads access the same data in the same
rcu grace period. The first thread calls call_rcu() to decrement the
refcount and free the data while the second thread increases the
refcount to use the data. To avoid this race condition all refcount
operations have to be atomic.

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 soft-interface.c |   35 +++++++++++++++++------------------
 types.h          |    2 +-
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index bd088f8..bd8b539 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -78,20 +78,18 @@ int my_skb_head_push(struct sk_buff *skb, unsigned int len)
 	return 0;
 }
 
-static void softif_neigh_free_ref(struct kref *refcount)
-{
-	struct softif_neigh *softif_neigh;
-
-	softif_neigh = container_of(refcount, struct softif_neigh, refcount);
-	kfree(softif_neigh);
-}
-
 static void softif_neigh_free_rcu(struct rcu_head *rcu)
 {
 	struct softif_neigh *softif_neigh;
 
 	softif_neigh = container_of(rcu, struct softif_neigh, rcu);
-	kref_put(&softif_neigh->refcount, softif_neigh_free_ref);
+	kfree(softif_neigh);
+}
+
+static void softif_neigh_free_ref(struct softif_neigh *softif_neigh)
+{
+	if (atomic_dec_and_test(&softif_neigh->refcount))
+		call_rcu(&softif_neigh->rcu, softif_neigh_free_rcu);
 }
 
 void softif_neigh_purge(struct bat_priv *bat_priv)
@@ -118,11 +116,10 @@ void softif_neigh_purge(struct bat_priv *bat_priv)
 				 softif_neigh->addr, softif_neigh->vid);
 			softif_neigh_tmp = bat_priv->softif_neigh;
 			bat_priv->softif_neigh = NULL;
-			kref_put(&softif_neigh_tmp->refcount,
-				 softif_neigh_free_ref);
+			softif_neigh_free_ref(softif_neigh_tmp);
 		}
 
-		call_rcu(&softif_neigh->rcu, softif_neigh_free_rcu);
+		softif_neigh_free_ref(softif_neigh);
 	}
 
 	spin_unlock_bh(&bat_priv->softif_neigh_lock);
@@ -143,8 +140,11 @@ static struct softif_neigh *softif_neigh_get(struct bat_priv *bat_priv,
 		if (softif_neigh->vid != vid)
 			continue;
 
+		if (!atomic_inc_not_zero(&softif_neigh->refcount))
+			continue;
+
 		softif_neigh->last_seen = jiffies;
-		goto found;
+		goto out;
 	}
 
 	softif_neigh = kzalloc(sizeof(struct softif_neigh), GFP_ATOMIC);
@@ -154,15 +154,14 @@ static struct softif_neigh *softif_neigh_get(struct bat_priv *bat_priv,
 	memcpy(softif_neigh->addr, addr, ETH_ALEN);
 	softif_neigh->vid = vid;
 	softif_neigh->last_seen = jiffies;
-	kref_init(&softif_neigh->refcount);
+	/* initialize with 2 - caller decrements counter by one */
+	atomic_set(&softif_neigh->refcount, 2);
 
 	INIT_HLIST_NODE(&softif_neigh->list);
 	spin_lock_bh(&bat_priv->softif_neigh_lock);
 	hlist_add_head_rcu(&softif_neigh->list, &bat_priv->softif_neigh_list);
 	spin_unlock_bh(&bat_priv->softif_neigh_lock);
 
-found:
-	kref_get(&softif_neigh->refcount);
 out:
 	rcu_read_unlock();
 	return softif_neigh;
@@ -266,7 +265,7 @@ static void softif_batman_recv(struct sk_buff *skb, struct net_device *dev,
 			 softif_neigh->addr, softif_neigh->vid);
 		softif_neigh_tmp = bat_priv->softif_neigh;
 		bat_priv->softif_neigh = softif_neigh;
-		kref_put(&softif_neigh_tmp->refcount, softif_neigh_free_ref);
+		softif_neigh_free_ref(softif_neigh_tmp);
 		/* we need to hold the additional reference */
 		goto err;
 	}
@@ -284,7 +283,7 @@ static void softif_batman_recv(struct sk_buff *skb, struct net_device *dev,
 	}
 
 out:
-	kref_put(&softif_neigh->refcount, softif_neigh_free_ref);
+	softif_neigh_free_ref(softif_neigh);
 err:
 	kfree_skb(skb);
 	return;
diff --git a/batman-adv/types.h b/batman-adv/types.h
index ca5f20a..8df6d9d 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -270,7 +270,7 @@ struct softif_neigh {
 	uint8_t addr[ETH_ALEN];
 	unsigned long last_seen;
 	short vid;
-	struct kref refcount;
+	atomic_t refcount;
 	struct rcu_head rcu;
 };
 
-- 
1.7.2.3

