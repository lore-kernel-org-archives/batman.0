Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:46 +0100
Message-Id: <1290383767-32602-9-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 08/29] Staging: batman-adv: add frag_ prefix
	to all fragmentation related functions
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
 drivers/staging/batman-adv/routing.c |    8 ++++----
 drivers/staging/batman-adv/unicast.c |    8 ++++----
 drivers/staging/batman-adv/unicast.h |    8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 657b69e..295e92e 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -1231,24 +1231,24 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		orig_node->last_frag_packet = jiffies;
 
 		if (list_empty(&orig_node->frag_list) &&
-			create_frag_buffer(&orig_node->frag_list)) {
+			frag_create_buffer(&orig_node->frag_list)) {
 			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
 					       flags);
 			return NET_RX_DROP;
 		}
 
 		tmp_frag_entry =
-			search_frag_packet(&orig_node->frag_list,
+			frag_search_packet(&orig_node->frag_list,
 					   unicast_packet);
 
 		if (!tmp_frag_entry) {
-			create_frag_entry(&orig_node->frag_list, skb);
+			frag_create_entry(&orig_node->frag_list, skb);
 			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
 					       flags);
 			return NET_RX_SUCCESS;
 		}
 
-		skb = merge_frag_packet(&orig_node->frag_list,
+		skb = frag_merge_packet(&orig_node->frag_list,
 					tmp_frag_entry, skb);
 		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 		if (!skb)
diff --git a/drivers/staging/batman-adv/unicast.c b/drivers/staging/batman-adv/unicast.c
index 58bf2b6..fef8521 100644
--- a/drivers/staging/batman-adv/unicast.c
+++ b/drivers/staging/batman-adv/unicast.c
@@ -29,7 +29,7 @@
 #include "hard-interface.h"
 
 
-struct sk_buff *merge_frag_packet(struct list_head *head,
+struct sk_buff *frag_merge_packet(struct list_head *head,
 				  struct frag_packet_list_entry *tfp,
 				  struct sk_buff *skb)
 {
@@ -62,7 +62,7 @@ struct sk_buff *merge_frag_packet(struct list_head *head,
 	return skb;
 }
 
-void create_frag_entry(struct list_head *head, struct sk_buff *skb)
+void frag_create_entry(struct list_head *head, struct sk_buff *skb)
 {
 	struct frag_packet_list_entry *tfp;
 	struct unicast_frag_packet *up =
@@ -78,7 +78,7 @@ void create_frag_entry(struct list_head *head, struct sk_buff *skb)
 	return;
 }
 
-int create_frag_buffer(struct list_head *head)
+int frag_create_buffer(struct list_head *head)
 {
 	int i;
 	struct frag_packet_list_entry *tfp;
@@ -99,7 +99,7 @@ int create_frag_buffer(struct list_head *head)
 	return 0;
 }
 
-struct frag_packet_list_entry *search_frag_packet(struct list_head *head,
+struct frag_packet_list_entry *frag_search_packet(struct list_head *head,
 						 struct unicast_frag_packet *up)
 {
 	struct frag_packet_list_entry *tfp;
diff --git a/drivers/staging/batman-adv/unicast.h b/drivers/staging/batman-adv/unicast.h
index 7973697..b50d61b 100644
--- a/drivers/staging/batman-adv/unicast.h
+++ b/drivers/staging/batman-adv/unicast.h
@@ -25,13 +25,13 @@
 #define FRAG_TIMEOUT 10000	/* purge frag list entrys after time in ms */
 #define FRAG_BUFFER_SIZE 6	/* number of list elements in buffer */
 
-struct sk_buff *merge_frag_packet(struct list_head *head,
+struct sk_buff *frag_merge_packet(struct list_head *head,
 	struct frag_packet_list_entry *tfp,
 	struct sk_buff *skb);
 
-void create_frag_entry(struct list_head *head, struct sk_buff *skb);
-int create_frag_buffer(struct list_head *head);
-struct frag_packet_list_entry *search_frag_packet(struct list_head *head,
+void frag_create_entry(struct list_head *head, struct sk_buff *skb);
+int frag_create_buffer(struct list_head *head);
+struct frag_packet_list_entry *frag_search_packet(struct list_head *head,
 	struct unicast_frag_packet *up);
 void frag_list_free(struct list_head *head);
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
-- 
1.7.2.3

