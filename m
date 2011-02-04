Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri,  4 Feb 2011 16:21:34 +0100
Message-Id: <1296832896-30081-6-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <201102031802.52134.lindner_marek@yahoo.de>
References: <201102031802.52134.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 5/7] batman-adv: Make bat_priv->curr_gw an
	rcu protected pointer
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

The rcu protected macros rcu_dereference() and rcu_assign_pointer()
for the bat_priv->curr_gw need to be used, as well as spin/rcu locking.

Otherwise we might end up using a curr_gw pointer pointing to already
freed memory.

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 gateway_client.c |   87 ++++++++++++++++++++++++++++++++++++++---------------
 main.c           |    1 +
 types.h          |    1 +
 3 files changed, 64 insertions(+), 25 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 517e001..4624515 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -44,19 +44,30 @@ static void gw_node_free_ref(struct gw_node *gw_node)
 
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
+	orig_node = curr_gateway_tmp->orig_node;
+	rcu_read_unlock();
+
+	return orig_node;
 }
 
 void gw_deselect(struct bat_priv *bat_priv)
 {
-	struct gw_node *gw_node = bat_priv->curr_gw;
+	struct gw_node *gw_node;
 
-	bat_priv->curr_gw = NULL;
+	spin_lock_bh(&bat_priv->curr_gw_lock);
+	gw_node = rcu_dereference(bat_priv->curr_gw);
+	rcu_assign_pointer(bat_priv->curr_gw, NULL);
+	spin_unlock_bh(&bat_priv->curr_gw_lock);
 
 	if (gw_node)
 		gw_node_free_ref(gw_node);
@@ -64,12 +75,15 @@ void gw_deselect(struct bat_priv *bat_priv)
 
 static void gw_select(struct bat_priv *bat_priv, struct gw_node *new_gw_node)
 {
-	struct gw_node *curr_gw_node = bat_priv->curr_gw;
+	struct gw_node *curr_gw_node;
 
 	if (new_gw_node && !atomic_inc_not_zero(&new_gw_node->refcount))
 		new_gw_node = NULL;
 
-	bat_priv->curr_gw = new_gw_node;
+	spin_lock_bh(&bat_priv->curr_gw_lock);
+	curr_gw_node = rcu_dereference(bat_priv->curr_gw);
+	rcu_assign_pointer(bat_priv->curr_gw, new_gw_node);
+	spin_unlock_bh(&bat_priv->curr_gw_lock);
 
 	if (curr_gw_node)
 		gw_node_free_ref(curr_gw_node);
@@ -78,7 +92,7 @@ static void gw_select(struct bat_priv *bat_priv, struct gw_node *new_gw_node)
 void gw_election(struct bat_priv *bat_priv)
 {
 	struct hlist_node *node;
-	struct gw_node *gw_node, *curr_gw_tmp = NULL;
+	struct gw_node *gw_node, *curr_gw, *curr_gw_tmp = NULL;
 	uint8_t max_tq = 0;
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
 	int down, up;
@@ -92,19 +106,24 @@ void gw_election(struct bat_priv *bat_priv)
 	if (atomic_read(&bat_priv->gw_mode) != GW_MODE_CLIENT)
 		return;
 
-	if (bat_priv->curr_gw)
+	rcu_read_lock();
+	curr_gw = rcu_dereference(bat_priv->curr_gw);
+	if (curr_gw) {
+		rcu_read_unlock();
 		return;
+	}
 
-	rcu_read_lock();
 	if (hlist_empty(&bat_priv->gw_list)) {
-		rcu_read_unlock();
 
-		if (bat_priv->curr_gw) {
+		if (curr_gw) {
+			rcu_read_unlock();
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Removing selected gateway - "
 				"no gateway in range\n");
 			gw_deselect(bat_priv);
 		}
+		else
+			rcu_read_unlock();
 
 		return;
 	}
@@ -153,12 +172,12 @@ void gw_election(struct bat_priv *bat_priv)
 			max_gw_factor = tmp_gw_factor;
 	}
 
-	if (bat_priv->curr_gw != curr_gw_tmp) {
-		if ((bat_priv->curr_gw) && (!curr_gw_tmp))
+	if (curr_gw != curr_gw_tmp) {
+		if ((curr_gw) && (!curr_gw_tmp))
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Removing selected gateway - "
 				"no gateway in range\n");
-		else if ((!bat_priv->curr_gw) && (curr_gw_tmp))
+		else if ((!curr_gw) && (curr_gw_tmp))
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Adding route to gateway %pM "
 				"(gw_flags: %i, tq: %i)\n",
@@ -181,11 +200,13 @@ void gw_election(struct bat_priv *bat_priv)
 
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 {
-	struct gw_node *curr_gateway_tmp = bat_priv->curr_gw;
+	struct gw_node *curr_gateway_tmp;
 	uint8_t gw_tq_avg, orig_tq_avg;
 
+	rcu_read_lock();
+	curr_gateway_tmp = rcu_dereference(bat_priv->curr_gw);
 	if (!curr_gateway_tmp)
-		return;
+		goto rcu_unlock;
 
 	if (!curr_gateway_tmp->orig_node)
 		goto deselect;
@@ -195,12 +216,14 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 
 	/* this node already is the gateway */
 	if (curr_gateway_tmp->orig_node == orig_node)
-		return;
+		goto rcu_unlock;
 
 	if (!orig_node->router)
-		return;
+		goto rcu_unlock;
 
 	gw_tq_avg = curr_gateway_tmp->orig_node->router->tq_avg;
+	rcu_read_unlock();
+
 	orig_tq_avg = orig_node->router->tq_avg;
 
 	/* the TQ value has to be better */
@@ -222,6 +245,9 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 
 deselect:
 	gw_deselect(bat_priv);
+	return;
+rcu_unlock:
+	rcu_read_unlock();
 }
 
 static void gw_node_add(struct bat_priv *bat_priv,
@@ -278,7 +304,7 @@ void gw_node_update(struct bat_priv *bat_priv,
 				"Gateway %pM removed from gateway list\n",
 				orig_node->orig);
 
-			if (gw_node == bat_priv->curr_gw) {
+			if (gw_node == rcu_dereference(bat_priv->curr_gw)) {
 				rcu_read_unlock();
 				gw_deselect(bat_priv);
 				return;
@@ -316,7 +342,7 @@ void gw_node_purge(struct bat_priv *bat_priv)
 		    atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE)
 			continue;
 
-		if (bat_priv->curr_gw == gw_node)
+		if (rcu_dereference(bat_priv->curr_gw) == gw_node)
 			gw_deselect(bat_priv);
 
 		hlist_del_rcu(&gw_node->list);
@@ -330,12 +356,16 @@ void gw_node_purge(struct bat_priv *bat_priv)
 static int _write_buffer_text(struct bat_priv *bat_priv,
 			      struct seq_file *seq, struct gw_node *gw_node)
 {
-	int down, up;
+	struct gw_node *curr_gw;
+	int down, up, ret;
 
 	gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
 
-	return seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %3i - %i%s/%i%s\n",
-		       (bat_priv->curr_gw == gw_node ? "=>" : "  "),
+	rcu_read_lock();
+	curr_gw = rcu_dereference(bat_priv->curr_gw);
+
+	ret = seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %3i - %i%s/%i%s\n",
+		       (curr_gw == gw_node ? "=>" : "  "),
 		       gw_node->orig_node->orig,
 		       gw_node->orig_node->router->tq_avg,
 		       gw_node->orig_node->router->addr,
@@ -345,6 +375,9 @@ static int _write_buffer_text(struct bat_priv *bat_priv,
 		       (down > 2048 ? "MBit" : "KBit"),
 		       (up > 2048 ? up / 1024 : up),
 		       (up > 2048 ? "MBit" : "KBit"));
+
+	rcu_read_unlock();
+	return ret;
 }
 
 int gw_client_seq_print_text(struct seq_file *seq, void *offset)
@@ -465,8 +498,12 @@ int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
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
diff --git a/batman-adv/main.c b/batman-adv/main.c
index 658ad5a..6823868 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -84,6 +84,7 @@ int mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->hna_lhash_lock);
 	spin_lock_init(&bat_priv->hna_ghash_lock);
 	spin_lock_init(&bat_priv->gw_list_lock);
+	spin_lock_init(&bat_priv->curr_gw_lock);
 	spin_lock_init(&bat_priv->vis_hash_lock);
 	spin_lock_init(&bat_priv->vis_list_lock);
 	spin_lock_init(&bat_priv->softif_neigh_lock);
diff --git a/batman-adv/types.h b/batman-adv/types.h
index ee77d48..4ae11c3 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -162,6 +162,7 @@ struct bat_priv {
 	spinlock_t hna_lhash_lock; /* protects hna_local_hash */
 	spinlock_t hna_ghash_lock; /* protects hna_global_hash */
 	spinlock_t gw_list_lock; /* protects gw_list */
+	spinlock_t curr_gw_lock; /* protects curr_gw updates */
 	spinlock_t vis_hash_lock; /* protects vis_hash */
 	spinlock_t vis_list_lock; /* protects vis_info::recv_list */
 	spinlock_t softif_neigh_lock; /* protects soft-interface neigh list */
-- 
1.7.2.3

