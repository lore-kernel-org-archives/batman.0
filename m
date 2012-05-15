Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Wed, 16 May 2012 00:06:20 +0200
Message-Id: <1337119580-1026-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Correctly check return value
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

The setup code in batadv_socket_setup() and debug_log_setup() wrongly
assumes that debugfs_create_file() returns !0 on error. Since it
actually returns a pointer on success[1], the following check should
be inverted.

Also, use the return value from the two setup functions in
batadv_debugfs_add_meshif().

[1] http://www.fsl.cs.sunysb.edu/kernel-api/re464.html

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 bat_debugfs.c |   11 +++++++----
 icmp_socket.c |    4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index cd636db..bd9325d 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -193,13 +193,13 @@ static int debug_log_setup(struct bat_priv *bat_priv)
 
 	d = debugfs_create_file("log", S_IFREG | S_IRUSR,
 				bat_priv->debug_dir, bat_priv, &log_fops);
-	if (d)
+	if (!d)
 		goto err;
 
 	return 0;
 
 err:
-	return 1;
+	return -ENOMEM;
 }
 
 static void debug_log_cleanup(struct bat_priv *bat_priv)
@@ -347,8 +347,11 @@ int batadv_debugfs_add_meshif(struct net_device *dev)
 	if (!bat_priv->debug_dir)
 		goto out;
 
-	batadv_socket_setup(bat_priv);
-	debug_log_setup(bat_priv);
+	if (batadv_socket_setup(bat_priv))
+		goto rem_attr;
+
+	if (debug_log_setup(bat_priv))
+		goto rem_attr;
 
 	for (bat_debug = mesh_debuginfos; *bat_debug; ++bat_debug) {
 		file = debugfs_create_file(((*bat_debug)->attr).name,
diff --git a/icmp_socket.c b/icmp_socket.c
index 3fad5aa..40c5e18 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -283,13 +283,13 @@ int batadv_socket_setup(struct bat_priv *bat_priv)
 
 	d = debugfs_create_file(ICMP_SOCKET, S_IFREG | S_IWUSR | S_IRUSR,
 				bat_priv->debug_dir, bat_priv, &fops);
-	if (d)
+	if (!d)
 		goto err;
 
 	return 0;
 
 err:
-	return 1;
+	return -ENOMEM;
 }
 
 static void bat_socket_add_packet(struct socket_client *socket_client,
-- 
1.7.10.2

