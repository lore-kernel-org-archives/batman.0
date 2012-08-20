Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Aug 2012 10:26:48 +0200
Message-Id: <1345451209-8898-2-git-send-email-sven@narfation.org>
In-Reply-To: <1345451209-8898-1-git-send-email-sven@narfation.org>
References: <1345451209-8898-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Check return value of
	try_module_get
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

New operations should not be started when they need an increased module
reference counter and try_module_get failed.

This patch addresses Coverity #712284: Unchecked return value

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debugfs.c     |    4 +++-
 icmp_socket.c |    4 +++-
 main.c        |    4 ++--
 main.h        |    2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index 391d4fb..63152be 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -99,9 +99,11 @@ int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
 
 static int batadv_log_open(struct inode *inode, struct file *file)
 {
+	if (!batadv_inc_module_count())
+		return -EBUSY;
+
 	nonseekable_open(inode, file);
 	file->private_data = inode->i_private;
-	batadv_inc_module_count();
 	return 0;
 }
 
diff --git a/icmp_socket.c b/icmp_socket.c
index bde3cf7..8c8d0b8 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -42,6 +42,9 @@ static int batadv_socket_open(struct inode *inode, struct file *file)
 	unsigned int i;
 	struct batadv_socket_client *socket_client;
 
+	if (!batadv_inc_module_count())
+		return -EBUSY;
+
 	nonseekable_open(inode, file);
 
 	socket_client = kmalloc(sizeof(*socket_client), GFP_KERNEL);
@@ -71,7 +74,6 @@ static int batadv_socket_open(struct inode *inode, struct file *file)
 
 	file->private_data = socket_client;
 
-	batadv_inc_module_count();
 	return 0;
 }
 
diff --git a/main.c b/main.c
index b4aa470..b4b5b89 100644
--- a/main.c
+++ b/main.c
@@ -160,9 +160,9 @@ void batadv_mesh_free(struct net_device *soft_iface)
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 }
 
-void batadv_inc_module_count(void)
+bool batadv_inc_module_count(void)
 {
-	try_module_get(THIS_MODULE);
+	return try_module_get(THIS_MODULE);
 }
 
 void batadv_dec_module_count(void)
diff --git a/main.h b/main.h
index f2227df..ded65b8 100644
--- a/main.h
+++ b/main.h
@@ -152,7 +152,7 @@ extern struct workqueue_struct *batadv_event_workqueue;
 
 int batadv_mesh_init(struct net_device *soft_iface);
 void batadv_mesh_free(struct net_device *soft_iface);
-void batadv_inc_module_count(void);
+bool batadv_inc_module_count(void);
 void batadv_dec_module_count(void);
 int batadv_is_my_mac(const uint8_t *addr);
 int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
-- 
1.7.10.4

