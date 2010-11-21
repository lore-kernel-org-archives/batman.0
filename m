Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:47 +0100
Message-Id: <1290383767-32602-10-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 09/29] Staging: batman-adv: move skb
	reassembly of fragmented packets into dedicated function
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

From: Andreas Langer <an.langer@gmx.de>

Signed-off-by: Andreas Langer <an.langer@gmx.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/routing.c |   43 ++++------------------
 drivers/staging/batman-adv/unicast.c |   66 ++++++++++++++++++++++++++++++---
 drivers/staging/batman-adv/unicast.h |   10 +----
 3 files changed, 69 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 295e92e..d36c3f9 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -1204,10 +1204,9 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct unicast_frag_packet *unicast_packet;
-	struct orig_node *orig_node;
-	struct frag_packet_list_entry *tmp_frag_entry;
 	int hdr_size = sizeof(struct unicast_frag_packet);
-	unsigned long flags;
+	struct sk_buff *new_skb = NULL;
+	int ret;
 
 	if (check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
@@ -1217,44 +1216,16 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
 
-		spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
-		orig_node = ((struct orig_node *)
-			hash_find(bat_priv->orig_hash, unicast_packet->orig));
+		ret = frag_reassemble_skb(skb, bat_priv, &new_skb);
 
-		if (!orig_node) {
-			pr_debug("couldn't find orig node for fragmentation\n");
-			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
-					       flags);
+		if (ret == NET_RX_DROP)
 			return NET_RX_DROP;
-		}
 
-		orig_node->last_frag_packet = jiffies;
-
-		if (list_empty(&orig_node->frag_list) &&
-			frag_create_buffer(&orig_node->frag_list)) {
-			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
-					       flags);
-			return NET_RX_DROP;
-		}
-
-		tmp_frag_entry =
-			frag_search_packet(&orig_node->frag_list,
-					   unicast_packet);
-
-		if (!tmp_frag_entry) {
-			frag_create_entry(&orig_node->frag_list, skb);
-			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
-					       flags);
+		/* packet was buffered for late merge */
+		if (!new_skb)
 			return NET_RX_SUCCESS;
-		}
 
-		skb = frag_merge_packet(&orig_node->frag_list,
-					tmp_frag_entry, skb);
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
-		if (!skb)
-			return NET_RX_DROP;
-
-		interface_rx(recv_if->soft_iface, skb, hdr_size);
+		interface_rx(recv_if->soft_iface, new_skb, hdr_size);
 		return NET_RX_SUCCESS;
 	}
 
diff --git a/drivers/staging/batman-adv/unicast.c b/drivers/staging/batman-adv/unicast.c
index fef8521..57fe2de 100644
--- a/drivers/staging/batman-adv/unicast.c
+++ b/drivers/staging/batman-adv/unicast.c
@@ -29,9 +29,9 @@
 #include "hard-interface.h"
 
 
-struct sk_buff *frag_merge_packet(struct list_head *head,
-				  struct frag_packet_list_entry *tfp,
-				  struct sk_buff *skb)
+static struct sk_buff *frag_merge_packet(struct list_head *head,
+					 struct frag_packet_list_entry *tfp,
+					 struct sk_buff *skb)
 {
 	struct unicast_frag_packet *up =
 		(struct unicast_frag_packet *)skb->data;
@@ -62,7 +62,7 @@ struct sk_buff *frag_merge_packet(struct list_head *head,
 	return skb;
 }
 
-void frag_create_entry(struct list_head *head, struct sk_buff *skb)
+static void frag_create_entry(struct list_head *head, struct sk_buff *skb)
 {
 	struct frag_packet_list_entry *tfp;
 	struct unicast_frag_packet *up =
@@ -78,7 +78,7 @@ void frag_create_entry(struct list_head *head, struct sk_buff *skb)
 	return;
 }
 
-int frag_create_buffer(struct list_head *head)
+static int frag_create_buffer(struct list_head *head)
 {
 	int i;
 	struct frag_packet_list_entry *tfp;
@@ -99,7 +99,7 @@ int frag_create_buffer(struct list_head *head)
 	return 0;
 }
 
-struct frag_packet_list_entry *frag_search_packet(struct list_head *head,
+static struct frag_packet_list_entry *frag_search_packet(struct list_head *head,
 						 struct unicast_frag_packet *up)
 {
 	struct frag_packet_list_entry *tfp;
@@ -152,6 +152,60 @@ void frag_list_free(struct list_head *head)
 	return;
 }
 
+/* frag_reassemble_skb():
+ * returns NET_RX_DROP if the operation failed - skb is left intact
+ * returns NET_RX_SUCCESS if the fragment was buffered (skb_new will be NULL)
+ * or the skb could be reassembled (skb_new will point to the new packet and
+ * skb was freed)
+ */
+int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			struct sk_buff **new_skb)
+{
+	unsigned long flags;
+	struct orig_node *orig_node;
+	struct frag_packet_list_entry *tmp_frag_entry;
+	int ret = NET_RX_DROP;
+	struct unicast_frag_packet *unicast_packet =
+		(struct unicast_frag_packet *)skb->data;
+
+	*new_skb = NULL;
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	orig_node = ((struct orig_node *)
+		    hash_find(bat_priv->orig_hash, unicast_packet->orig));
+
+	if (!orig_node) {
+		pr_debug("couldn't find originator in orig_hash\n");
+		goto out;
+	}
+
+	orig_node->last_frag_packet = jiffies;
+
+	if (list_empty(&orig_node->frag_list) &&
+	    frag_create_buffer(&orig_node->frag_list)) {
+		pr_debug("couldn't create frag buffer\n");
+		goto out;
+	}
+
+	tmp_frag_entry = frag_search_packet(&orig_node->frag_list,
+					    unicast_packet);
+
+	if (!tmp_frag_entry) {
+		frag_create_entry(&orig_node->frag_list, skb);
+		ret = NET_RX_SUCCESS;
+		goto out;
+	}
+
+	*new_skb = frag_merge_packet(&orig_node->frag_list, tmp_frag_entry,
+				     skb);
+	/* if not, merge failed */
+	if (*new_skb)
+		ret = NET_RX_SUCCESS;
+out:
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+
+	return ret;
+}
+
 static int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			 struct batman_if *batman_if, uint8_t dstaddr[])
 {
diff --git a/drivers/staging/batman-adv/unicast.h b/drivers/staging/batman-adv/unicast.h
index b50d61b..5908b01 100644
--- a/drivers/staging/batman-adv/unicast.h
+++ b/drivers/staging/batman-adv/unicast.h
@@ -25,14 +25,8 @@
 #define FRAG_TIMEOUT 10000	/* purge frag list entrys after time in ms */
 #define FRAG_BUFFER_SIZE 6	/* number of list elements in buffer */
 
-struct sk_buff *frag_merge_packet(struct list_head *head,
-	struct frag_packet_list_entry *tfp,
-	struct sk_buff *skb);
-
-void frag_create_entry(struct list_head *head, struct sk_buff *skb);
-int frag_create_buffer(struct list_head *head);
-struct frag_packet_list_entry *frag_search_packet(struct list_head *head,
-	struct unicast_frag_packet *up);
+int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			struct sk_buff **new_skb);
 void frag_list_free(struct list_head *head);
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
 
-- 
1.7.2.3

