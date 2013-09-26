Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Thu, 26 Sep 2013 09:49:18 +0200
Message-Id: <de510a1e7cb175c854734fa07c347f18ac697446.1380181735.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: set network coding packet
	handlers in batadv_recv_handler_init()
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

Registering and unregistering the packet handlers on softif creation and
destruction is obviously broken when multiple softif are used (and causes the
second softif creation to fail). Instead, just set the network coding handlers
in the __init function (like all other handlers).

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 main.c           |  2 ++
 network-coding.c | 12 ++----------
 network-coding.h |  8 ++++++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/main.c b/main.c
index 08125f3..87ef89a 100644
--- a/main.c
+++ b/main.c
@@ -349,6 +349,8 @@ static void batadv_recv_handler_init(void)
 	batadv_rx_handler[BATADV_TT_QUERY] = batadv_recv_tt_query;
 	/* Roaming advertisement */
 	batadv_rx_handler[BATADV_ROAM_ADV] = batadv_recv_roam_adv;
+	/* network coding */
+	batadv_rx_handler[BATADV_CODED] = batadv_nc_recv_coded_packet;
 }
 
 int
diff --git a/network-coding.c b/network-coding.c
index a487d46..6f392fd 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -31,8 +31,6 @@ static struct lock_class_key batadv_nc_coding_hash_lock_class_key;
 static struct lock_class_key batadv_nc_decoding_hash_lock_class_key;
 
 static void batadv_nc_worker(struct work_struct *work);
-static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
-				       struct batadv_hard_iface *recv_if);
 
 /**
  * batadv_nc_start_timer - initialise the nc periodic worker
@@ -70,11 +68,6 @@ int batadv_nc_init(struct batadv_priv *bat_priv)
 	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
 				   &batadv_nc_decoding_hash_lock_class_key);
 
-	/* Register our packet type */
-	if (batadv_recv_handler_register(BATADV_CODED,
-					 batadv_nc_recv_coded_packet) < 0)
-		goto err;
-
 	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
 	batadv_nc_start_timer(bat_priv);
 
@@ -1657,8 +1650,8 @@ batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
  * @skb: incoming coded packet
  * @recv_if: pointer to interface this packet was received on
  */
-static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
-				       struct batadv_hard_iface *recv_if)
+int batadv_nc_recv_coded_packet(struct sk_buff *skb,
+				struct batadv_hard_iface *recv_if)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_unicast_packet *unicast_packet;
@@ -1726,7 +1719,6 @@ free_nc_packet:
  */
 void batadv_nc_free(struct batadv_priv *bat_priv)
 {
-	batadv_recv_handler_unregister(BATADV_CODED);
 	cancel_delayed_work_sync(&bat_priv->nc.work);
 
 	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash, NULL);
diff --git a/network-coding.h b/network-coding.h
index 85a4ec8..f00cd4d 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -35,6 +35,8 @@ void batadv_nc_purge_orig(struct batadv_priv *bat_priv,
 					   struct batadv_nc_node *));
 void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv);
 void batadv_nc_init_orig(struct batadv_orig_node *orig_node);
+int batadv_nc_recv_coded_packet(struct sk_buff *skb,
+				struct batadv_hard_iface *recv_if);
 bool batadv_nc_skb_forward(struct sk_buff *skb,
 			   struct batadv_neigh_node *neigh_node);
 void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
@@ -85,6 +87,12 @@ static inline void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
 	return;
 }
 
+static inline int batadv_nc_recv_coded_packet(struct sk_buff *skb,
+					      struct batadv_hard_iface *recv_if)
+{
+	return NET_RX_DROP;
+}
+
 static inline bool batadv_nc_skb_forward(struct sk_buff *skb,
 					 struct batadv_neigh_node *neigh_node)
 {
-- 
1.8.4

