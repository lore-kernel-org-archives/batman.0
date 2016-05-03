Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed,  4 May 2016 06:23:40 +0800
Message-Id: <1462314230-16257-6-git-send-email-a@unstable.cc>
In-Reply-To: <1462314230-16257-1-git-send-email-a@unstable.cc>
References: <1462314230-16257-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 05/15] batman-adv: use
	list_for_each_entry_safe
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>, Geliang Tang <geliangtang@163.com>

From: Geliang Tang <geliangtang@163.com>

Use list_for_each_entry_safe() instead of list_for_each_safe() to
simplify the code.

Signed-off-by: Geliang Tang <geliangtang@163.com>
Acked-by: Antonio Quartulli <a@unstable.cc>
Reviewed-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/icmp_socket.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 14d0013b387e..8a5889d134bc 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -104,25 +104,21 @@ static int batadv_socket_open(struct inode *inode, struct file *file)
 
 static int batadv_socket_release(struct inode *inode, struct file *file)
 {
-	struct batadv_socket_client *socket_client = file->private_data;
-	struct batadv_socket_packet *socket_packet;
-	struct list_head *list_pos, *list_pos_tmp;
+	struct batadv_socket_client *client = file->private_data;
+	struct batadv_socket_packet *packet, *tmp;
 
-	spin_lock_bh(&socket_client->lock);
+	spin_lock_bh(&client->lock);
 
 	/* for all packets in the queue ... */
-	list_for_each_safe(list_pos, list_pos_tmp, &socket_client->queue_list) {
-		socket_packet = list_entry(list_pos,
-					   struct batadv_socket_packet, list);
-
-		list_del(list_pos);
-		kfree(socket_packet);
+	list_for_each_entry_safe(packet, tmp, &client->queue_list, list) {
+		list_del(&packet->list);
+		kfree(packet);
 	}
 
-	batadv_socket_client_hash[socket_client->index] = NULL;
-	spin_unlock_bh(&socket_client->lock);
+	batadv_socket_client_hash[client->index] = NULL;
+	spin_unlock_bh(&client->lock);
 
-	kfree(socket_client);
+	kfree(client);
 	module_put(THIS_MODULE);
 
 	return 0;
-- 
2.8.2

