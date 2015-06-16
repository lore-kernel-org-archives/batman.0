Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 16 Jun 2015 14:44:35 +0200
Message-Id: <1434458675-3343-6-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1434458675-3343-1-git-send-email-linus.luessing@c0d3.blue>
References: <1434458675-3343-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 maint 5/5] batman-adv: Fix potential
 synchronization issues in mcast tvlv handler
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

So far the mcast tvlv handler did not anticipate the processing of
multiple incoming OGMs from the same originator at the same time. This
can lead to various issues:

* Broken refcounting: For instance two mcast handlers might both assume
  that an originator just got multicast capabilities and will together
  wrongly decrease mcast.num_disabled by two, potentially leading to
  an integer underflow.

* Potential kernel panic on hlist_del_rcu(): Two mcast handlers might
  one after another try to do an
  hlist_del_rcu(&orig->mcast_want_all_*_node). The second one will
  cause memory corruption / crashes.
  (Reported by: Sven Eckelmann <sven@narfation.org>)

Right in the beginning the code path makes assumptions about the current
multicast related state of an originator and bases all updates on that. The
easiest and least error prune way to fix the issues in this case is to
serialize multiple mcast handler invocations with a spinlock.

Fixes: 77ec494490d6 ("batman-adv: Announce new capability via multicast TVLV")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 multicast.c  |   68 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 originator.c |    4 ++++
 types.h      |    2 ++
 3 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/multicast.c b/multicast.c
index 00612bf..fcdb118 100644
--- a/multicast.c
+++ b/multicast.c
@@ -565,19 +565,27 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
  *
  * If the BATADV_MCAST_WANT_ALL_UNSNOOPABLES flag of this originator,
  * orig, has toggled then this method updates counter and list accordingly.
+ *
+ * Caller needs to hold orig->mcast_handler_lock.
  */
 static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
 					     struct batadv_orig_node *orig,
 					     uint8_t mcast_flags)
 {
+	struct hlist_node *node = &orig->mcast_want_all_unsnoopables_node;
+	struct hlist_head *head = &bat_priv->mcast.want_all_unsnoopables_list;
+
 	/* switched from flag unset to set */
 	if (mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
 	    !(orig->mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES)) {
 		atomic_inc(&bat_priv->mcast.num_want_all_unsnoopables);
 
 		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
-		hlist_add_head_rcu(&orig->mcast_want_all_unsnoopables_node,
-				   &bat_priv->mcast.want_all_unsnoopables_list);
+		/* flag checks above + mcast_handler_lock prevents this */
+		if (unlikely(!hlist_unhashed(node)))
+			BUG();
+
+		hlist_add_head_rcu(node, head);
 		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
 	/* switched from flag set to unset */
 	} else if (!(mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES) &&
@@ -585,7 +593,11 @@ static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
 		atomic_dec(&bat_priv->mcast.num_want_all_unsnoopables);
 
 		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
-		hlist_del_rcu(&orig->mcast_want_all_unsnoopables_node);
+		/* flag checks above + mcast_handler_lock prevents this */
+		if (unlikely(hlist_unhashed(node)))
+			BUG();
+
+		hlist_del_init_rcu(node);
 		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
 	}
 }
@@ -598,19 +610,27 @@ static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
  *
  * If the BATADV_MCAST_WANT_ALL_IPV4 flag of this originator, orig, has
  * toggled then this method updates counter and list accordingly.
+ *
+ * Caller needs to hold orig->mcast_handler_lock.
  */
 static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  uint8_t mcast_flags)
 {
+	struct hlist_node *node = &orig->mcast_want_all_ipv4_node;
+	struct hlist_head *head = &bat_priv->mcast.want_all_ipv4_list;
+
 	/* switched from flag unset to set */
 	if (mcast_flags & BATADV_MCAST_WANT_ALL_IPV4 &&
 	    !(orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV4)) {
 		atomic_inc(&bat_priv->mcast.num_want_all_ipv4);
 
 		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
-		hlist_add_head_rcu(&orig->mcast_want_all_ipv4_node,
-				   &bat_priv->mcast.want_all_ipv4_list);
+		/* flag checks above + mcast_handler_lock prevents this */
+		if (unlikely(!hlist_unhashed(node)))
+			BUG();
+
+		hlist_add_head_rcu(node, head);
 		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
 	/* switched from flag set to unset */
 	} else if (!(mcast_flags & BATADV_MCAST_WANT_ALL_IPV4) &&
@@ -618,7 +638,11 @@ static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
 		atomic_dec(&bat_priv->mcast.num_want_all_ipv4);
 
 		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
-		hlist_del_rcu(&orig->mcast_want_all_ipv4_node);
+		/* flag checks above + mcast_handler_lock prevents this */
+		if (unlikely(hlist_unhashed(node)))
+			BUG();
+
+		hlist_del_init_rcu(node);
 		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
 	}
 }
@@ -631,19 +655,27 @@ static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
  *
  * If the BATADV_MCAST_WANT_ALL_IPV6 flag of this originator, orig, has
  * toggled then this method updates counter and list accordingly.
+ *
+ * Caller needs to hold orig->mcast_handler_lock.
  */
 static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
 					  uint8_t mcast_flags)
 {
+	struct hlist_node *node = &orig->mcast_want_all_ipv6_node;
+	struct hlist_head *head = &bat_priv->mcast.want_all_ipv6_list;
+
 	/* switched from flag unset to set */
 	if (mcast_flags & BATADV_MCAST_WANT_ALL_IPV6 &&
 	    !(orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV6)) {
 		atomic_inc(&bat_priv->mcast.num_want_all_ipv6);
 
 		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
-		hlist_add_head_rcu(&orig->mcast_want_all_ipv6_node,
-				   &bat_priv->mcast.want_all_ipv6_list);
+		/* flag checks above + mcast_handler_lock prevents this */
+		if (unlikely(!hlist_unhashed(node)))
+			BUG();
+
+		hlist_add_head_rcu(node, head);
 		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
 	/* switched from flag set to unset */
 	} else if (!(mcast_flags & BATADV_MCAST_WANT_ALL_IPV6) &&
@@ -651,7 +683,11 @@ static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 		atomic_dec(&bat_priv->mcast.num_want_all_ipv6);
 
 		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
-		hlist_del_rcu(&orig->mcast_want_all_ipv6_node);
+		/* flag checks above + mcast_handler_lock prevents this */
+		if (unlikely(hlist_unhashed(node)))
+			BUG();
+
+		hlist_del_init_rcu(node);
 		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
 	}
 }
@@ -674,6 +710,11 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	uint8_t mcast_flags = BATADV_NO_FLAGS;
 	bool orig_initialized;
 
+	if (orig_mcast_enabled && tvlv_value &&
+	    (tvlv_value_len >= sizeof(mcast_flags)))
+		mcast_flags = *(uint8_t *)tvlv_value;
+
+	spin_lock_bh(&orig->mcast_handler_lock);
 	orig_initialized = orig->capa_initialized & BATADV_ORIG_CAPA_HAS_MCAST;
 
 	/* If mcast support is turned on decrease the disabled mcast node
@@ -698,15 +739,12 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 
 	set_bit(BATADV_ORIG_CAPA_HAS_MCAST, &orig->capa_initialized);
 
-	if (orig_mcast_enabled && tvlv_value &&
-	    (tvlv_value_len >= sizeof(mcast_flags)))
-		mcast_flags = *(uint8_t *)tvlv_value;
-
 	batadv_mcast_want_unsnoop_update(bat_priv, orig, mcast_flags);
 	batadv_mcast_want_ipv4_update(bat_priv, orig, mcast_flags);
 	batadv_mcast_want_ipv6_update(bat_priv, orig, mcast_flags);
 
 	orig->mcast_flags = mcast_flags;
+	spin_unlock_bh(&orig->mcast_handler_lock);
 }
 
 /**
@@ -740,6 +778,8 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 {
 	struct batadv_priv *bat_priv = orig->bat_priv;
 
+	spin_lock_bh(&orig->mcast_handler_lock);
+
 	if (!(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST) &&
 	    orig->capa_initialized & BATADV_ORIG_CAPA_HAS_MCAST)
 		atomic_dec(&bat_priv->mcast.num_disabled);
@@ -747,4 +787,6 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 	batadv_mcast_want_unsnoop_update(bat_priv, orig, BATADV_NO_FLAGS);
 	batadv_mcast_want_ipv4_update(bat_priv, orig, BATADV_NO_FLAGS);
 	batadv_mcast_want_ipv6_update(bat_priv, orig, BATADV_NO_FLAGS);
+
+	spin_unlock_bh(&orig->mcast_handler_lock);
 }
diff --git a/originator.c b/originator.c
index e3900e4..a2ba182 100644
--- a/originator.c
+++ b/originator.c
@@ -658,11 +658,15 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
 	INIT_LIST_HEAD(&orig_node->vlan_list);
 	INIT_HLIST_HEAD(&orig_node->ifinfo_list);
+	INIT_HLIST_NODE(&orig_node->mcast_want_all_unsnoopables_node);
+	INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv4_node);
+	INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv6_node);
 	spin_lock_init(&orig_node->bcast_seqno_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
 	spin_lock_init(&orig_node->tt_buff_lock);
 	spin_lock_init(&orig_node->tt_lock);
 	spin_lock_init(&orig_node->vlan_list_lock);
+	spin_lock_init(&orig_node->mcast_handler_lock);
 
 	batadv_nc_init_orig(orig_node);
 
diff --git a/types.h b/types.h
index c6ec558..1d800c5 100644
--- a/types.h
+++ b/types.h
@@ -251,6 +251,8 @@ struct batadv_orig_node {
 	unsigned long last_seen;
 	unsigned long bcast_seqno_reset;
 #ifdef CONFIG_BATMAN_ADV_MCAST
+	/* synchronizes mcast tvlv specific orig changes */
+	spinlock_t mcast_handler_lock;
 	uint8_t mcast_flags;
 	struct hlist_node mcast_want_all_unsnoopables_node;
 	struct hlist_node mcast_want_all_ipv4_node;
-- 
1.7.10.4

