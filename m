Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 21:01:13 +0200
Message-Id: <1284836482-23431-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 03/12] Staging: batman-adv: Mark debugfs
	files as nonseekable
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

We don't allow to seek in the debugfs socket and log files. Thus we
should mark the file descriptor as nonseekable.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/batman-adv/bat_debugfs.c |    2 ++
 drivers/staging/batman-adv/icmp_socket.c |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_debugfs.c b/drivers/staging/batman-adv/bat_debugfs.c
index 507da68..57f84a9 100644
--- a/drivers/staging/batman-adv/bat_debugfs.c
+++ b/drivers/staging/batman-adv/bat_debugfs.c
@@ -90,6 +90,7 @@ int debug_log(struct bat_priv *bat_priv, char *fmt, ...)
 
 static int log_open(struct inode *inode, struct file *file)
 {
+	nonseekable_open(inode, file);
 	file->private_data = inode->i_private;
 	inc_module_count();
 	return 0;
@@ -174,6 +175,7 @@ static const struct file_operations log_fops = {
 	.release        = log_release,
 	.read           = log_read,
 	.poll           = log_poll,
+	.llseek         = no_llseek,
 };
 
 static int debug_log_setup(struct bat_priv *bat_priv)
diff --git a/drivers/staging/batman-adv/icmp_socket.c b/drivers/staging/batman-adv/icmp_socket.c
index 24627be..48856ca 100644
--- a/drivers/staging/batman-adv/icmp_socket.c
+++ b/drivers/staging/batman-adv/icmp_socket.c
@@ -45,6 +45,8 @@ static int bat_socket_open(struct inode *inode, struct file *file)
 	unsigned int i;
 	struct socket_client *socket_client;
 
+	nonseekable_open(inode, file);
+
 	socket_client = kmalloc(sizeof(struct socket_client), GFP_KERNEL);
 
 	if (!socket_client)
@@ -283,6 +285,7 @@ static const struct file_operations fops = {
 	.read = bat_socket_read,
 	.write = bat_socket_write,
 	.poll = bat_socket_poll,
+	.llseek = no_llseek,
 };
 
 int bat_socket_setup(struct bat_priv *bat_priv)
-- 
1.7.2.3

