Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 02:09:41 +0200
Message-Id: <1336781383-15649-21-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-1-git-send-email-sven@narfation.org>
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 21/23] batman-adv: Prefix vis non-static
	functions with batadv_
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

batman-adv can be compiled as part of the kernel instead of an module. In that
case the linker will see all non-static symbols of batman-adv and all other
non-static symbols of the kernel. This could lead to symbol collisions. A
prefix for the batman-adv symbols that defines their private namespace avoids
such a problem.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_debugfs.c |    2 +-
 main.c        |    4 ++--
 routing.c     |    8 ++++----
 vis.c         |   20 ++++++++++----------
 vis.h         |   18 +++++++++---------
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index cab2425..43a422b 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -263,7 +263,7 @@ static int transtable_local_open(struct inode *inode, struct file *file)
 static int vis_data_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
-	return single_open(file, vis_seq_print_text, net_dev);
+	return single_open(file, batadv_vis_seq_print_text, net_dev);
 }
 
 struct bat_debuginfo {
diff --git a/main.c b/main.c
index a405513..3cc3b28 100644
--- a/main.c
+++ b/main.c
@@ -121,7 +121,7 @@ int mesh_init(struct net_device *soft_iface)
 
 	batadv_tt_local_add(soft_iface, soft_iface->dev_addr, NULL_IFINDEX);
 
-	ret = vis_init(bat_priv);
+	ret = batadv_vis_init(bat_priv);
 	if (ret < 0)
 		goto err;
 
@@ -147,7 +147,7 @@ void mesh_free(struct net_device *soft_iface)
 
 	batadv_purge_outstanding_packets(bat_priv, NULL);
 
-	vis_quit(bat_priv);
+	batadv_vis_quit(bat_priv);
 
 	batadv_gw_node_purge(bat_priv);
 	batadv_originator_free(bat_priv);
diff --git a/routing.c b/routing.c
index 8c71b57..6a57aa1 100644
--- a/routing.c
+++ b/routing.c
@@ -1151,13 +1151,13 @@ int batadv_recv_vis_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	switch (vis_packet->vis_type) {
 	case VIS_TYPE_SERVER_SYNC:
-		receive_server_sync_packet(bat_priv, vis_packet,
-					   skb_headlen(skb));
+		batadv_receive_server_sync_packet(bat_priv, vis_packet,
+						  skb_headlen(skb));
 		break;
 
 	case VIS_TYPE_CLIENT_UPDATE:
-		receive_client_update_packet(bat_priv, vis_packet,
-					     skb_headlen(skb));
+		batadv_receive_client_update_packet(bat_priv, vis_packet,
+						    skb_headlen(skb));
 		break;
 
 	default:	/* ignore unknown packet */
diff --git a/vis.c b/vis.c
index c56737c..24040c3 100644
--- a/vis.c
+++ b/vis.c
@@ -188,7 +188,7 @@ static ssize_t vis_data_read_entry(char *buff,
 	return 0;
 }
 
-int vis_seq_print_text(struct seq_file *seq, void *offset)
+int batadv_vis_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct hard_iface *primary_if;
 	struct hlist_node *node;
@@ -483,9 +483,9 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 }
 
 /* handle the server sync packet, forward if needed. */
-void receive_server_sync_packet(struct bat_priv *bat_priv,
-				struct vis_packet *vis_packet,
-				int vis_info_len)
+void batadv_receive_server_sync_packet(struct bat_priv *bat_priv,
+				       struct vis_packet *vis_packet,
+				       int vis_info_len)
 {
 	struct vis_info *info;
 	int is_new, make_broadcast;
@@ -508,9 +508,9 @@ end:
 }
 
 /* handle an incoming client update packet and schedule forward if needed. */
-void receive_client_update_packet(struct bat_priv *bat_priv,
-				  struct vis_packet *vis_packet,
-				  int vis_info_len)
+void batadv_receive_client_update_packet(struct bat_priv *bat_priv,
+					 struct vis_packet *vis_packet,
+					 int vis_info_len)
 {
 	struct vis_info *info;
 	struct vis_packet *packet;
@@ -880,7 +880,7 @@ static void send_vis_packets(struct work_struct *work)
 
 /* init the vis server. this may only be called when if_list is already
  * initialized (e.g. bat0 is initialized, interfaces have been added) */
-int vis_init(struct bat_priv *bat_priv)
+int batadv_vis_init(struct bat_priv *bat_priv)
 {
 	struct vis_packet *packet;
 	int hash_added;
@@ -944,7 +944,7 @@ free_info:
 	bat_priv->my_vis_info = NULL;
 err:
 	spin_unlock_bh(&bat_priv->vis_hash_lock);
-	vis_quit(bat_priv);
+	batadv_vis_quit(bat_priv);
 	return -ENOMEM;
 }
 
@@ -959,7 +959,7 @@ static void free_info_ref(struct hlist_node *node, void *arg)
 }
 
 /* shutdown vis-server */
-void vis_quit(struct bat_priv *bat_priv)
+void batadv_vis_quit(struct bat_priv *bat_priv)
 {
 	if (!bat_priv->vis_hash)
 		return;
diff --git a/vis.h b/vis.h
index ee2e46e..932514e 100644
--- a/vis.h
+++ b/vis.h
@@ -25,14 +25,14 @@
 #define VIS_TIMEOUT		200000	/* timeout of vis packets
 					 * in miliseconds */
 
-int vis_seq_print_text(struct seq_file *seq, void *offset);
-void receive_server_sync_packet(struct bat_priv *bat_priv,
-				struct vis_packet *vis_packet,
-				int vis_info_len);
-void receive_client_update_packet(struct bat_priv *bat_priv,
-				  struct vis_packet *vis_packet,
-				  int vis_info_len);
-int vis_init(struct bat_priv *bat_priv);
-void vis_quit(struct bat_priv *bat_priv);
+int batadv_vis_seq_print_text(struct seq_file *seq, void *offset);
+void batadv_receive_server_sync_packet(struct bat_priv *bat_priv,
+				       struct vis_packet *vis_packet,
+				       int vis_info_len);
+void batadv_receive_client_update_packet(struct bat_priv *bat_priv,
+					 struct vis_packet *vis_packet,
+					 int vis_info_len);
+int batadv_vis_init(struct bat_priv *bat_priv);
+void batadv_vis_quit(struct bat_priv *bat_priv);
 
 #endif /* _NET_BATMAN_ADV_VIS_H_ */
-- 
1.7.10

