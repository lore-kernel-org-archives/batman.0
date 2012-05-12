Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 02:09:33 +0200
Message-Id: <1336781383-15649-13-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-1-git-send-email-sven@narfation.org>
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 13/23] batman-adv: Prefix icmp-socket
	non-static functions with batadv_
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
 icmp_socket.c |    8 ++++----
 icmp_socket.h |    8 ++++----
 main.c        |    2 +-
 routing.c     |    2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index 939c5be..f8b3fa5 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -349,7 +349,7 @@ int batadv_debugfs_add_meshif(struct net_device *dev)
 	if (!bat_priv->debug_dir)
 		goto out;
 
-	bat_socket_setup(bat_priv);
+	batadv_socket_setup(bat_priv);
 	debug_log_setup(bat_priv);
 
 	for (bat_debug = mesh_debuginfos; *bat_debug; ++bat_debug) {
diff --git a/icmp_socket.c b/icmp_socket.c
index 2e98a57..c734655 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -34,7 +34,7 @@ static void bat_socket_add_packet(struct socket_client *socket_client,
 				  struct icmp_packet_rr *icmp_packet,
 				  size_t icmp_len);
 
-void bat_socket_init(void)
+void batadv_socket_init(void)
 {
 	memset(socket_client_hash, 0, sizeof(socket_client_hash));
 }
@@ -276,7 +276,7 @@ static const struct file_operations fops = {
 	.llseek = no_llseek,
 };
 
-int bat_socket_setup(struct bat_priv *bat_priv)
+int batadv_socket_setup(struct bat_priv *bat_priv)
 {
 	struct dentry *d;
 
@@ -336,8 +336,8 @@ static void bat_socket_add_packet(struct socket_client *socket_client,
 	wake_up(&socket_client->queue_wait);
 }
 
-void bat_socket_receive_packet(struct icmp_packet_rr *icmp_packet,
-			       size_t icmp_len)
+void batadv_socket_receive_packet(struct icmp_packet_rr *icmp_packet,
+				  size_t icmp_len)
 {
 	struct socket_client *hash = socket_client_hash[icmp_packet->uid];
 
diff --git a/icmp_socket.h b/icmp_socket.h
index 380ed4c..7b88636 100644
--- a/icmp_socket.h
+++ b/icmp_socket.h
@@ -24,9 +24,9 @@
 
 #define ICMP_SOCKET "socket"
 
-void bat_socket_init(void);
-int bat_socket_setup(struct bat_priv *bat_priv);
-void bat_socket_receive_packet(struct icmp_packet_rr *icmp_packet,
-			       size_t icmp_len);
+void batadv_socket_init(void);
+int batadv_socket_setup(struct bat_priv *bat_priv);
+void batadv_socket_receive_packet(struct icmp_packet_rr *icmp_packet,
+				  size_t icmp_len);
 
 #endif /* _NET_BATMAN_ADV_ICMP_SOCKET_H_ */
diff --git a/main.c b/main.c
index 0d42edf..534956b 100644
--- a/main.c
+++ b/main.c
@@ -65,7 +65,7 @@ static int __init batman_init(void)
 	if (!bat_event_workqueue)
 		return -ENOMEM;
 
-	bat_socket_init();
+	batadv_socket_init();
 	batadv_debugfs_init();
 
 	register_netdevice_notifier(&batadv_hard_if_notifier);
diff --git a/routing.c b/routing.c
index 97901f3..3f03427 100644
--- a/routing.c
+++ b/routing.c
@@ -289,7 +289,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 
 	/* add data to device queue */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
-		bat_socket_receive_packet(icmp_packet, icmp_len);
+		batadv_socket_receive_packet(icmp_packet, icmp_len);
 		goto out;
 	}
 
-- 
1.7.10

