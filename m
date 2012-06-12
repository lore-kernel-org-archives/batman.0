Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 Jun 2012 09:25:03 +0200
Message-Id: <1339485903-8857-1-git-send-email-sven@narfation.org>
In-Reply-To: <1337119580-1026-1-git-send-email-martin@hundeboll.net>
References: <1337119580-1026-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Correctly check return value
	from debugfs_create_dir
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

From: Martin Hundebøll <martin@hundeboll.net>

The setup code in batadv_socket_setup() and debug_log_setup() wrongly
assumes that debugfs_create_file() returns !0 on error. Since it
actually returns a pointer on success[1], the following check should
be inverted.

Also, use the return value from the two setup functions in
batadv_debugfs_add_meshif().

[1] http://www.fsl.cs.sunysb.edu/kernel-api/re464.html

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
[sven@narfation.org: Fix conflicts with namespace patches]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debugfs.c     |   11 +++++++----
 icmp_socket.c |    4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index de610ba..e45cf0e 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -206,13 +206,13 @@ static int batadv_debug_log_setup(struct batadv_priv *bat_priv)
 	d = debugfs_create_file("log", S_IFREG | S_IRUSR,
 				bat_priv->debug_dir, bat_priv,
 				&batadv_log_fops);
-	if (d)
+	if (!d)
 		goto err;
 
 	return 0;
 
 err:
-	return 1;
+	return -ENOMEM;
 }
 
 static void batadv_debug_log_cleanup(struct batadv_priv *bat_priv)
@@ -362,8 +362,11 @@ int batadv_debugfs_add_meshif(struct net_device *dev)
 	if (!bat_priv->debug_dir)
 		goto out;
 
-	batadv_socket_setup(bat_priv);
-	batadv_debug_log_setup(bat_priv);
+	if (batadv_socket_setup(bat_priv) < 0)
+		goto rem_attr;
+
+	if (batadv_debug_log_setup(bat_priv) < 0)
+		goto rem_attr;
 
 	for (bat_debug = batadv_mesh_debuginfos; *bat_debug; ++bat_debug) {
 		file = debugfs_create_file(((*bat_debug)->attr).name,
diff --git a/icmp_socket.c b/icmp_socket.c
index d370061..bde3cf7 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -284,13 +284,13 @@ int batadv_socket_setup(struct batadv_priv *bat_priv)
 
 	d = debugfs_create_file(BATADV_ICMP_SOCKET, S_IFREG | S_IWUSR | S_IRUSR,
 				bat_priv->debug_dir, bat_priv, &batadv_fops);
-	if (d)
+	if (!d)
 		goto err;
 
 	return 0;
 
 err:
-	return 1;
+	return -ENOMEM;
 }
 
 static void batadv_socket_add_packet(struct batadv_socket_client *socket_client,
-- 
1.7.10

