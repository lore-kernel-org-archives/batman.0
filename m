Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  9 Aug 2010 23:56:40 +0200
Message-Id: <1281391002-21577-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1281391002-21577-1-git-send-email-sven.eckelmann@gmx.de>
References: <1281391002-21577-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] Staging: batman-adv: fix batman icmp
	originating from secondary interface
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

If a batman icmp packet had to be routed over a secondary interface
at the first hop, the mac address of that secondary interface would
be written in the 'orig' field of the icmp packet. A node which is
more than one hop away is not aware of the mac address because
secondary interfaces are not flooded through the whole mesh and
therefore can't send a reply.
This patch always sends the mac address of the primary interface
in the 'orig' field of the icmp packet.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/icmp_socket.c |   12 ++++++++----
 drivers/staging/batman-adv/types.h       |    1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/batman-adv/icmp_socket.c b/drivers/staging/batman-adv/icmp_socket.c
index fc3d32c..3ae7dd2 100644
--- a/drivers/staging/batman-adv/icmp_socket.c
+++ b/drivers/staging/batman-adv/icmp_socket.c
@@ -67,6 +67,7 @@ static int bat_socket_open(struct inode *inode, struct file *file)
 	INIT_LIST_HEAD(&socket_client->queue_list);
 	socket_client->queue_len = 0;
 	socket_client->index = i;
+	socket_client->bat_priv = inode->i_private;
 	spin_lock_init(&socket_client->lock);
 	init_waitqueue_head(&socket_client->queue_wait);
 
@@ -151,9 +152,8 @@ static ssize_t bat_socket_read(struct file *file, char __user *buf,
 static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 				size_t len, loff_t *off)
 {
-	/* FIXME: each orig_node->batman_if will be attached to a softif */
-	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct socket_client *socket_client = file->private_data;
+	struct bat_priv *bat_priv = socket_client->bat_priv;
 	struct icmp_packet_rr icmp_packet;
 	struct orig_node *orig_node;
 	struct batman_if *batman_if;
@@ -168,6 +168,9 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 		return -EINVAL;
 	}
 
+	if (!bat_priv->primary_if)
+		return -EFAULT;
+
 	if (len >= sizeof(struct icmp_packet_rr))
 		packet_len = sizeof(struct icmp_packet_rr);
 
@@ -223,7 +226,8 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	if (batman_if->if_status != IF_ACTIVE)
 		goto dst_unreach;
 
-	memcpy(icmp_packet.orig, batman_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(icmp_packet.orig,
+	       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
 
 	if (packet_len == sizeof(struct icmp_packet_rr))
 		memcpy(icmp_packet.rr, batman_if->net_dev->dev_addr, ETH_ALEN);
@@ -271,7 +275,7 @@ int bat_socket_setup(struct bat_priv *bat_priv)
 		goto err;
 
 	d = debugfs_create_file(ICMP_SOCKET, S_IFREG | S_IWUSR | S_IRUSR,
-				bat_priv->debug_dir, NULL, &fops);
+				bat_priv->debug_dir, bat_priv, &fops);
 	if (d)
 		goto err;
 
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 21d0717..9aa9d36 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -126,6 +126,7 @@ struct socket_client {
 	unsigned char index;
 	spinlock_t lock;
 	wait_queue_head_t queue_wait;
+	struct bat_priv *bat_priv;
 };
 
 struct socket_packet {
-- 
1.7.1

