Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 23 Jul 2010 11:38:44 +0200
Message-Id: <1279877924-14638-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unnecessary casts of
	private_data
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
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Joe Perches <joe@perches.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Joe Perches <joe@perches.com>

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 This patch is already added to maint. Please also apply it to trunk.

 batman-adv/bat_debugfs.c |    4 ++--
 batman-adv/icmp_socket.c |   12 ++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/batman-adv/bat_debugfs.c b/batman-adv/bat_debugfs.c
index 83ec177..c73ce4a 100644
--- a/batman-adv/bat_debugfs.c
+++ b/batman-adv/bat_debugfs.c
@@ -107,7 +107,7 @@ static int log_release(struct inode *inode, struct file *file)
 static ssize_t log_read(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
 {
-	struct bat_priv *bat_priv = (struct bat_priv *)file->private_data;
+	struct bat_priv *bat_priv = file->private_data;
 	struct debug_log *debug_log = bat_priv->debug_log;
 	int error, i = 0;
 	char c;
@@ -161,7 +161,7 @@ static ssize_t log_read(struct file *file, char __user *buf,
 
 static unsigned int log_poll(struct file *file, poll_table *wait)
 {
-	struct bat_priv *bat_priv = (struct bat_priv *)file->private_data;
+	struct bat_priv *bat_priv = file->private_data;
 	struct debug_log *debug_log = bat_priv->debug_log;
 
 	poll_wait(file, &debug_log->queue_wait, wait);
diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index a84e84d..6a014a3 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -80,8 +80,7 @@ static int bat_socket_open(struct inode *inode, struct file *file)
 
 static int bat_socket_release(struct inode *inode, struct file *file)
 {
-	struct socket_client *socket_client =
-		(struct socket_client *)file->private_data;
+	struct socket_client *socket_client = file->private_data;
 	struct socket_packet *socket_packet;
 	struct list_head *list_pos, *list_pos_tmp;
 	unsigned long flags;
@@ -109,8 +108,7 @@ static int bat_socket_release(struct inode *inode, struct file *file)
 static ssize_t bat_socket_read(struct file *file, char __user *buf,
 			       size_t count, loff_t *ppos)
 {
-	struct socket_client *socket_client =
-		(struct socket_client *)file->private_data;
+	struct socket_client *socket_client = file->private_data;
 	struct socket_packet *socket_packet;
 	size_t packet_len;
 	int error;
@@ -157,8 +155,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 {
 	/* FIXME: each orig_node->batman_if will be attached to a softif */
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
-	struct socket_client *socket_client =
-		(struct socket_client *)file->private_data;
+	struct socket_client *socket_client = file->private_data;
 	struct icmp_packet_rr icmp_packet;
 	struct orig_node *orig_node;
 	struct batman_if *batman_if;
@@ -249,8 +246,7 @@ out:
 
 static unsigned int bat_socket_poll(struct file *file, poll_table *wait)
 {
-	struct socket_client *socket_client =
-		(struct socket_client *)file->private_data;
+	struct socket_client *socket_client = file->private_data;
 
 	poll_wait(file, &socket_client->queue_wait, wait);
 
-- 
1.7.1

