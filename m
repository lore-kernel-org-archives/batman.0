Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Wed,  2 Feb 2011 18:37:18 +0100
Message-Id: <1296668238-19323-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1296352379-1546-2-git-send-email-sven@narfation.org>
References: <1296352379-1546-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] Re: batman-adv: Correct rcu refcounting for
	gw_node
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

From: Sven Eckelmann <sven@narfation.org>

Was:
---
<TODO: write a long monologue about every problem we have or could have or
maybe never had and would have when we not have it>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---

So after some more discussions with Marek and Sven, it looks like we
have to use the rcu protected macros rcu_dereference() and
rcu_assign_pointer() for the bat_priv->curr_gw and curr_gw->orig_node.

Changes here also include moving the kref_get() from unicast_send_skb()
into gw_get_selected(). The orig_node could have been freed already at
the time the kref_get() was called in unicast_send_skb().

Some things that are still not that clear to me:

gw_election():
* can the if-block before gw_deselect() be ommited, we had a nullpointer
  check for curr_gw just a couple of lines before during the rcu-lock.

gw_deselet():
* is the refcount at this time always 1 for gw_node, can the null
pointer check + a rcu_dereference be ommited? (at least that's what
it looks like when comparing to the rcuref.txt example)

gw_get_selected():
* Probably the orig_node's refcounting has to be made atomic, too?

Cheers, Linus

Not-Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 gateway_client.c |  169 +++++++++++++++++++++++++++++++++---------------------
 main.c           |    1 +
 types.h          |    7 +-
 unicast.c        |    1 -
 4 files changed, 109 insertions(+), 69 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 429a013..96a67bc 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -28,40 +28,54 @@
 #include <linux/udp.h>
 #include <linux/if_vlan.h>
 
-static void gw_node_free_ref(struct kref *refcount)
+static void gw_node_free_rcu(struct rcu_head *rcu)
 {
 	struct gw_node *gw_node;
 
-	gw_node = container_of(refcount, struct gw_node, refcount);
+	gw_node = container_of(rcu, struct gw_node, rcu);
 	kfree(gw_node);
 }
 
-static void gw_node_free_rcu(struct rcu_head *rcu)
+static void gw_node_free_ref(struct gw_node *gw_node)
 {
-	struct gw_node *gw_node;
-
-	gw_node = container_of(rcu, struct gw_node, rcu);
-	kref_put(&gw_node->refcount, gw_node_free_ref);
+	if (atomic_dec_and_test(&gw_node->refcount))
+		call_rcu(&gw_node->rcu, gw_node_free_rcu);
 }
 
+/* increases the returned orig_node's refcount */
 void *gw_get_selected(struct bat_priv *bat_priv)
 {
-	struct gw_node *curr_gateway_tmp = bat_priv->curr_gw;
+	struct gw_node *curr_gateway_tmp;
+	struct orig_node *orig_node;
 
-	if (!curr_gateway_tmp)
+	rcu_read_lock();
+	curr_gateway_tmp = rcu_dereference(bat_priv->curr_gw);
+	if (!curr_gateway_tmp) {
+		rcu_read_unlock();
 		return NULL;
+	}
 
-	return curr_gateway_tmp->orig_node;
+	orig_node = rcu_dereference(curr_gateway_tmp->orig_node);
+	if (orig_node) {
+		kref_get(&orig_node->refcount);
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	rcu_read_unlock();
+	return orig_node;
 }
 
 void gw_deselect(struct bat_priv *bat_priv)
 {
-	struct gw_node *gw_node = bat_priv->curr_gw;
+	struct gw_node *gw_node;
 
-	bat_priv->curr_gw = NULL;
+	spin_lock_bh(&bat_priv->curr_gw_lock);
+	gw_node = bat_priv->curr_gw;
+	rcu_assign_pointer(bat_priv->curr_gw, NULL);
+	spin_unlock_bh(&bat_priv->curr_gw_lock);
 
-	if (gw_node)
-		kref_put(&gw_node->refcount, gw_node_free_ref);
+	gw_node_free_ref(gw_node);
 }
 
 static struct gw_node *gw_select(struct bat_priv *bat_priv,
@@ -69,17 +83,21 @@ static struct gw_node *gw_select(struct bat_priv *bat_priv,
 {
 	struct gw_node *curr_gw_node = bat_priv->curr_gw;
 
-	if (new_gw_node)
-		kref_get(&new_gw_node->refcount);
+	if (new_gw_node && !atomic_inc_not_zero(&new_gw_node->refcount))
+		return NULL;
+
+	spin_lock_bh(&bat_priv->curr_gw_lock);
+	rcu_assign_pointer(bat_priv->curr_gw, new_gw_node);
+	spin_unlock_bh(&bat_priv->curr_gw_lock);
 
-	bat_priv->curr_gw = new_gw_node;
 	return curr_gw_node;
 }
 
 void gw_election(struct bat_priv *bat_priv)
 {
 	struct hlist_node *node;
-	struct gw_node *gw_node, *curr_gw_tmp = NULL, *old_gw_node = NULL;
+	struct gw_node *gw_node, *curr_gw, *curr_gw_tmp = NULL, *old_gw_node = NULL;
+	struct orig_node *orig_node;
 	uint8_t max_tq = 0;
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
 	int down, up;
@@ -93,25 +111,28 @@ void gw_election(struct bat_priv *bat_priv)
 	if (atomic_read(&bat_priv->gw_mode) != GW_MODE_CLIENT)
 		return;
 
-	if (bat_priv->curr_gw)
-		return;
-
 	rcu_read_lock();
-	if (hlist_empty(&bat_priv->gw_list)) {
+	curr_gw = rcu_dereference(bat_priv->curr_gw);
+	if (curr_gw) {
 		rcu_read_unlock();
+		return;
+	}
 
-		if (bat_priv->curr_gw) {
+	if (hlist_empty(&bat_priv->gw_list)) {
+		if (curr_gw) {
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Removing selected gateway - "
 				"no gateway in range\n");
 			gw_deselect(bat_priv);
 		}
+		rcu_read_unlock();
 
 		return;
 	}
 
 	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
-		if (!gw_node->orig_node->router)
+		orig_node = rcu_dereference(gw_node->orig_node);
+		if (!orig_node->router)
 			continue;
 
 		if (gw_node->deleted)
@@ -119,18 +140,17 @@ void gw_election(struct bat_priv *bat_priv)
 
 		switch (atomic_read(&bat_priv->gw_sel_class)) {
 		case 1: /* fast connection */
-			gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags,
-					     &down, &up);
+			gw_bandwidth_to_kbit(orig_node->gw_flags, &down, &up);
 
-			tmp_gw_factor = (gw_node->orig_node->router->tq_avg *
-					 gw_node->orig_node->router->tq_avg *
+			tmp_gw_factor = (orig_node->router->tq_avg *
+					 orig_node->router->tq_avg *
 					 down * 100 * 100) /
 					 (TQ_LOCAL_WINDOW_SIZE *
 					 TQ_LOCAL_WINDOW_SIZE * 64);
 
 			if ((tmp_gw_factor > max_gw_factor) ||
 			    ((tmp_gw_factor == max_gw_factor) &&
-			     (gw_node->orig_node->router->tq_avg > max_tq)))
+			     (orig_node->router->tq_avg > max_tq)))
 				curr_gw_tmp = gw_node;
 			break;
 
@@ -142,37 +162,38 @@ void gw_election(struct bat_priv *bat_priv)
 			  *     soon as a better gateway appears which has
 			  *     $routing_class more tq points)
 			  **/
-			if (gw_node->orig_node->router->tq_avg > max_tq)
+			if (orig_node->router->tq_avg > max_tq)
 				curr_gw_tmp = gw_node;
 			break;
 		}
 
-		if (gw_node->orig_node->router->tq_avg > max_tq)
-			max_tq = gw_node->orig_node->router->tq_avg;
+		if (orig_node->router->tq_avg > max_tq)
+			max_tq = orig_node->router->tq_avg;
 
 		if (tmp_gw_factor > max_gw_factor)
 			max_gw_factor = tmp_gw_factor;
 	}
 
-	if (bat_priv->curr_gw != curr_gw_tmp) {
-		if ((bat_priv->curr_gw) && (!curr_gw_tmp))
+	if (curr_gw != curr_gw_tmp) {
+		orig_node = rcu_dereference(curr_gw_tmp->orig_node);
+		if ((curr_gw) && (!curr_gw_tmp))
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Removing selected gateway - "
 				"no gateway in range\n");
-		else if ((!bat_priv->curr_gw) && (curr_gw_tmp))
+		else if ((!curr_gw) && (curr_gw_tmp))
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Adding route to gateway %pM "
 				"(gw_flags: %i, tq: %i)\n",
-				curr_gw_tmp->orig_node->orig,
-				curr_gw_tmp->orig_node->gw_flags,
-				curr_gw_tmp->orig_node->router->tq_avg);
+				orig_node->orig,
+				orig_node->gw_flags,
+				orig_node->router->tq_avg);
 		else
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Changing route to gateway %pM "
 				"(gw_flags: %i, tq: %i)\n",
-				curr_gw_tmp->orig_node->orig,
-				curr_gw_tmp->orig_node->gw_flags,
-				curr_gw_tmp->orig_node->router->tq_avg);
+				orig_node->orig,
+				orig_node->gw_flags,
+				orig_node->router->tq_avg);
 
 		old_gw_node = gw_select(bat_priv, curr_gw_tmp);
 	}
@@ -181,36 +202,40 @@ void gw_election(struct bat_priv *bat_priv)
 
 	/* the kfree() has to be outside of the rcu lock */
 	if (old_gw_node)
-		kref_put(&old_gw_node->refcount, gw_node_free_ref);
+		gw_node_free_ref(old_gw_node);
 }
 
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 {
-	struct gw_node *curr_gateway_tmp = bat_priv->curr_gw;
+	struct gw_node *curr_gateway_tmp;
+	struct orig_node *curr_gw_orig;
 	uint8_t gw_tq_avg, orig_tq_avg;
 
+	rcu_read_lock();
+	curr_gateway_tmp = rcu_dereference(bat_priv->curr_gw);
 	if (!curr_gateway_tmp)
-		return;
+		goto rcu_unlock;
 
-	if (!curr_gateway_tmp->orig_node)
+	curr_gw_orig = rcu_dereference(curr_gateway_tmp->orig_node);
+	if (!curr_gw_orig)
 		goto deselect;
 
-	if (!curr_gateway_tmp->orig_node->router)
+	if (!curr_gw_orig->router)
 		goto deselect;
 
 	/* this node already is the gateway */
-	if (curr_gateway_tmp->orig_node == orig_node)
-		return;
+	if (curr_gw_orig == orig_node)
+		goto deselect;
 
 	if (!orig_node->router)
-		return;
+		goto rcu_unlock;
 
-	gw_tq_avg = curr_gateway_tmp->orig_node->router->tq_avg;
+	gw_tq_avg = curr_gw_orig ->router->tq_avg;
 	orig_tq_avg = orig_node->router->tq_avg;
 
 	/* the TQ value has to be better */
 	if (orig_tq_avg < gw_tq_avg)
-		return;
+		goto rcu_unlock;
 
 	/**
 	 * if the routing class is greater than 3 the value tells us how much
@@ -218,7 +243,7 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 	 **/
 	if ((atomic_read(&bat_priv->gw_sel_class) > 3) &&
 	    (orig_tq_avg - gw_tq_avg < atomic_read(&bat_priv->gw_sel_class)))
-		return;
+		goto rcu_unlock;
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Restarting gateway selection: better gateway found (tq curr: "
@@ -227,6 +252,8 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 
 deselect:
 	gw_deselect(bat_priv);
+rcu_unlock:
+	rcu_read_unlock();
 }
 
 static void gw_node_add(struct bat_priv *bat_priv,
@@ -242,7 +269,7 @@ static void gw_node_add(struct bat_priv *bat_priv,
 	memset(gw_node, 0, sizeof(struct gw_node));
 	INIT_HLIST_NODE(&gw_node->list);
 	gw_node->orig_node = orig_node;
-	kref_init(&gw_node->refcount);
+	atomic_set(&gw_node->refcount, 1);
 
 	spin_lock_bh(&bat_priv->gw_list_lock);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw_list);
@@ -325,7 +352,7 @@ void gw_node_purge(struct bat_priv *bat_priv)
 			gw_deselect(bat_priv);
 
 		hlist_del_rcu(&gw_node->list);
-		call_rcu(&gw_node->rcu, gw_node_free_rcu);
+		gw_node_free_ref(gw_node);
 	}
 
 
@@ -335,21 +362,29 @@ void gw_node_purge(struct bat_priv *bat_priv)
 static int _write_buffer_text(struct bat_priv *bat_priv,
 			      struct seq_file *seq, struct gw_node *gw_node)
 {
-	int down, up;
+	struct gw_node *curr_gw;
+	struct orig_node *orig_node;
+	int down, up, ret;
 
-	gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
-
-	return seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %3i - %i%s/%i%s\n",
-		       (bat_priv->curr_gw == gw_node ? "=>" : "  "),
-		       gw_node->orig_node->orig,
-		       gw_node->orig_node->router->tq_avg,
-		       gw_node->orig_node->router->addr,
-		       gw_node->orig_node->router->if_incoming->net_dev->name,
-		       gw_node->orig_node->gw_flags,
+	rcu_read_lock();
+	curr_gw = rcu_dereference(bat_priv->curr_gw);
+	orig_node = rcu_dereference(gw_node->orig_node);
+	gw_bandwidth_to_kbit(orig_node->gw_flags, &down, &up);
+
+	ret = seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %3i - %i%s/%i%s\n",
+		       (curr_gw == gw_node ? "=>" : "  "),
+		       orig_node->orig,
+		       orig_node->router->tq_avg,
+		       orig_node->router->addr,
+		       orig_node->router->if_incoming->net_dev->name,
+		       orig_node->gw_flags,
 		       (down > 2048 ? down / 1024 : down),
 		       (down > 2048 ? "MBit" : "KBit"),
 		       (up > 2048 ? up / 1024 : up),
 		       (up > 2048 ? "MBit" : "KBit"));
+	rcu_read_unlock();
+
+	return ret;
 }
 
 int gw_client_seq_print_text(struct seq_file *seq, void *offset)
@@ -470,8 +505,12 @@ int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
 	if (atomic_read(&bat_priv->gw_mode) == GW_MODE_SERVER)
 		return -1;
 
-	if (!bat_priv->curr_gw)
+	rcu_read_lock();
+	if (!rcu_dereference(bat_priv->curr_gw)) {
+		rcu_read_unlock();
 		return 0;
+	}
+	rcu_read_unlock();
 
 	return 1;
 }
diff --git a/main.c b/main.c
index e687e7f..8679260 100644
--- a/main.c
+++ b/main.c
@@ -85,6 +85,7 @@ int mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->hna_lhash_lock);
 	spin_lock_init(&bat_priv->hna_ghash_lock);
 	spin_lock_init(&bat_priv->gw_list_lock);
+	spin_lock_init(&bat_priv->curr_gw_lock);
 	spin_lock_init(&bat_priv->vis_hash_lock);
 	spin_lock_init(&bat_priv->vis_list_lock);
 	spin_lock_init(&bat_priv->softif_neigh_lock);
diff --git a/types.h b/types.h
index e4a0462..b9b20b6 100644
--- a/types.h
+++ b/types.h
@@ -98,9 +98,9 @@ struct orig_node {
 
 struct gw_node {
 	struct hlist_node list;
-	struct orig_node *orig_node;
+	struct orig_node *orig_node;	/* rcu protected pointer */
 	unsigned long deleted;
-	struct kref refcount;
+	atomic_t refcount;
 	struct rcu_head rcu;
 };
 
@@ -163,6 +163,7 @@ struct bat_priv {
 	spinlock_t hna_lhash_lock; /* protects hna_local_hash */
 	spinlock_t hna_ghash_lock; /* protects hna_global_hash */
 	spinlock_t gw_list_lock; /* protects gw_list */
+	spinlock_t curr_gw_lock; /* protects curr_gw updates */
 	spinlock_t vis_hash_lock; /* protects vis_hash */
 	spinlock_t vis_list_lock; /* protects vis_info::recv_list */
 	spinlock_t softif_neigh_lock; /* protects soft-interface neigh list */
@@ -171,7 +172,7 @@ struct bat_priv {
 	struct delayed_work hna_work;
 	struct delayed_work orig_work;
 	struct delayed_work vis_work;
-	struct gw_node *curr_gw;
+	struct gw_node *curr_gw;	/* rcu protected pointer */
 	struct vis_info *my_vis_info;
 };
 
diff --git a/unicast.c b/unicast.c
index 6a9ab61..8816102 100644
--- a/unicast.c
+++ b/unicast.c
@@ -298,7 +298,6 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 		if (!orig_node)
 			goto trans_search;
 
-		kref_get(&orig_node->refcount);
 		goto find_router;
 	} else {
 		rcu_read_lock();
-- 
1.7.2.3

