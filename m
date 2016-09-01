Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  1 Sep 2016 10:25:12 +0200
Message-Id: <20160901082512.16160-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Use octal permissions instead
	of macros
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

Linus prefers to have octal permission numbers instead of combinations of
macro names ("random line noise"). Also old existing "bad symbolic
permission bit macro use" should be converted to octal numbers.
(http://lkml.kernel.org/r/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com)

Also remove the S_IFREG bit from the octal representation because it is
filtered out by debugfs_create.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - fix error in patch subject
---
 net/batman-adv/icmp_socket.c    | 4 ++--
 net/batman-adv/log.c            | 3 +--
 net/batman-adv/network-coding.c | 7 +++----
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 378cc11..aed8125 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -322,8 +322,8 @@ int batadv_socket_setup(struct batadv_priv *bat_priv)
 	if (!bat_priv->debug_dir)
 		goto err;
 
-	d = debugfs_create_file(BATADV_ICMP_SOCKET, S_IFREG | S_IWUSR | S_IRUSR,
-				bat_priv->debug_dir, bat_priv, &batadv_fops);
+	d = debugfs_create_file(BATADV_ICMP_SOCKET, 0600, bat_priv->debug_dir,
+				bat_priv, &batadv_fops);
 	if (!d)
 		goto err;
 
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index 56dc532..46b0725 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -212,8 +212,7 @@ int batadv_debug_log_setup(struct batadv_priv *bat_priv)
 	spin_lock_init(&bat_priv->debug_log->lock);
 	init_waitqueue_head(&bat_priv->debug_log->queue_wait);
 
-	d = debugfs_create_file("log", S_IFREG | S_IRUSR,
-				bat_priv->debug_dir, bat_priv,
+	d = debugfs_create_file("log", 0400, bat_priv->debug_dir, bat_priv,
 				&batadv_log_fops);
 	if (!d)
 		goto err;
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index e3baf69..0fc3b5f 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1961,17 +1961,16 @@ int batadv_nc_init_debugfs(struct batadv_priv *bat_priv)
 	if (!nc_dir)
 		goto out;
 
-	file = debugfs_create_u8("min_tq", S_IRUGO | S_IWUSR, nc_dir,
-				 &bat_priv->nc.min_tq);
+	file = debugfs_create_u8("min_tq", 0644, nc_dir, &bat_priv->nc.min_tq);
 	if (!file)
 		goto out;
 
-	file = debugfs_create_u32("max_fwd_delay", S_IRUGO | S_IWUSR, nc_dir,
+	file = debugfs_create_u32("max_fwd_delay", 0644, nc_dir,
 				  &bat_priv->nc.max_fwd_delay);
 	if (!file)
 		goto out;
 
-	file = debugfs_create_u32("max_buffer_time", S_IRUGO | S_IWUSR, nc_dir,
+	file = debugfs_create_u32("max_buffer_time", 0644, nc_dir,
 				  &bat_priv->nc.max_buffer_time);
 	if (!file)
 		goto out;
-- 
2.9.3

