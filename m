Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Fri, 27 Sep 2013 18:03:39 +0200
Message-Id: <e1d5e2f6144c8c36bf80e6f1a6ffc7a4d4c22544.1380297720.git.mschiffer@universe-factory.net>
In-Reply-To: <2446824.BO6cEXVXT6@diderot>
References: <2446824.BO6cEXVXT6@diderot>
Subject: [B.A.T.M.A.N.] [PATCHv3 maint] batman-adv: set up network coding
	packet handlers during module init
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

batman-adv saves its table of packet handlers as a global state, so handlers
must be set up only once (and setting them up a second time will fail).

The recently-added network coding support tries to set up its handler each time
a new softif is registered, which obviously fails when more that one softif is
used (and in consequence, the softif creation fails).

Fix this by splitting up batadv_nc_init into batadv_nc_init (which is called
only once) and batadv_nc_mesh_init (which is called for each softif); in
addition batadv_nc_free is renamed to batadv_nc_mesh_free to keep naming
consistent.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
v3: moved things around as Marek suggested

 main.c           |  5 +++--
 network-coding.c | 28 ++++++++++++++++++----------
 network-coding.h | 14 ++++++++++----
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/main.c b/main.c
index 08125f3..c8e0671 100644
--- a/main.c
+++ b/main.c
@@ -61,6 +61,7 @@ static int __init batadv_init(void)
 	batadv_recv_handler_init();
 
 	batadv_iv_init();
+	batadv_nc_init();
 
 	batadv_event_workqueue = create_singlethread_workqueue("bat_events");
 
@@ -138,7 +139,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	if (ret < 0)
 		goto err;
 
-	ret = batadv_nc_init(bat_priv);
+	ret = batadv_nc_mesh_init(bat_priv);
 	if (ret < 0)
 		goto err;
 
@@ -163,7 +164,7 @@ void batadv_mesh_free(struct net_device *soft_iface)
 	batadv_vis_quit(bat_priv);
 
 	batadv_gw_node_purge(bat_priv);
-	batadv_nc_free(bat_priv);
+	batadv_nc_mesh_free(bat_priv);
 	batadv_dat_free(bat_priv);
 	batadv_bla_free(bat_priv);
 
diff --git a/network-coding.c b/network-coding.c
index a487d46..4ecc0b6 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -35,6 +35,20 @@ static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if);
 
 /**
+ * batadv_nc_init - one-time initialization for network coding
+ */
+int __init batadv_nc_init(void)
+{
+	int ret;
+
+	/* Register our packet type */
+	ret = batadv_recv_handler_register(BATADV_CODED,
+					   batadv_nc_recv_coded_packet);
+
+	return ret;
+}
+
+/**
  * batadv_nc_start_timer - initialise the nc periodic worker
  * @bat_priv: the bat priv with all the soft interface information
  */
@@ -45,10 +59,10 @@ static void batadv_nc_start_timer(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_nc_init - initialise coding hash table and start house keeping
+ * batadv_nc_mesh_init - initialise coding hash table and start house keeping
  * @bat_priv: the bat priv with all the soft interface information
  */
-int batadv_nc_init(struct batadv_priv *bat_priv)
+int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 {
 	bat_priv->nc.timestamp_fwd_flush = jiffies;
 	bat_priv->nc.timestamp_sniffed_purge = jiffies;
@@ -70,11 +84,6 @@ int batadv_nc_init(struct batadv_priv *bat_priv)
 	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
 				   &batadv_nc_decoding_hash_lock_class_key);
 
-	/* Register our packet type */
-	if (batadv_recv_handler_register(BATADV_CODED,
-					 batadv_nc_recv_coded_packet) < 0)
-		goto err;
-
 	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
 	batadv_nc_start_timer(bat_priv);
 
@@ -1721,12 +1730,11 @@ free_nc_packet:
 }
 
 /**
- * batadv_nc_free - clean up network coding memory
+ * batadv_nc_mesh_free - clean up network coding memory
  * @bat_priv: the bat priv with all the soft interface information
  */
-void batadv_nc_free(struct batadv_priv *bat_priv)
+void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
 {
-	batadv_recv_handler_unregister(BATADV_CODED);
 	cancel_delayed_work_sync(&bat_priv->nc.work);
 
 	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash, NULL);
diff --git a/network-coding.h b/network-coding.h
index 85a4ec8..ddfa618 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -22,8 +22,9 @@
 
 #ifdef CONFIG_BATMAN_ADV_NC
 
-int batadv_nc_init(struct batadv_priv *bat_priv);
-void batadv_nc_free(struct batadv_priv *bat_priv);
+int batadv_nc_init(void);
+int batadv_nc_mesh_init(struct batadv_priv *bat_priv);
+void batadv_nc_mesh_free(struct batadv_priv *bat_priv);
 void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
 			      struct batadv_orig_node *orig_node,
 			      struct batadv_orig_node *orig_neigh_node,
@@ -46,12 +47,17 @@ int batadv_nc_init_debugfs(struct batadv_priv *bat_priv);
 
 #else /* ifdef CONFIG_BATMAN_ADV_NC */
 
-static inline int batadv_nc_init(struct batadv_priv *bat_priv)
+static inline int batadv_nc_init(void)
 {
 	return 0;
 }
 
-static inline void batadv_nc_free(struct batadv_priv *bat_priv)
+static inline int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
+{
+	return 0;
+}
+
+static inline void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
 {
 	return;
 }
-- 
1.8.4

