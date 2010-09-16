Return-Path: <an.langer@gmx.de>
From: Andreas Langer <an.langer@gmx.de>
Date: Fri, 17 Sep 2010 00:00:06 +0200
Message-Id: <1284674410-15477-2-git-send-email-an.langer@gmx.de>
In-Reply-To: <20100916235908.51ab3bfc@rechenknecht>
References: <20100916235908.51ab3bfc@rechenknecht>
Subject: [B.A.T.M.A.N.] [PATCH 2/6] batman-adv: add frag_ prefix to all
	fragmentation related functions
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

Signed-off-by: Andreas Langer <an.langer at gmx.de>
---
 batman-adv/routing.c |    8 ++++----
 batman-adv/unicast.c |   12 ++++++------
 batman-adv/unicast.h |    8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 603a932..a0936ca 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1245,24 +1245,24 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
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
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 750f10e..23a9373 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -30,9 +30,9 @@
 #include "hard-interface.h"
 
 
-struct sk_buff *merge_frag_packet(struct list_head *head,
-				  struct frag_packet_list_entry *tfp,
-				  struct sk_buff *skb)
+static struct sk_buff *frag_merge_packet(struct list_head *head,
+					 struct frag_packet_list_entry *tfp,
+					 struct sk_buff *skb)
 {
 	struct unicast_frag_packet *up =
 		(struct unicast_frag_packet *)skb->data;
@@ -63,7 +63,7 @@ struct sk_buff *merge_frag_packet(struct list_head *head,
 	return skb;
 }
 
-void create_frag_entry(struct list_head *head, struct sk_buff *skb)
+void frag_create_entry(struct list_head *head, struct sk_buff *skb)
 {
 	struct frag_packet_list_entry *tfp;
 	struct unicast_frag_packet *up =
@@ -79,7 +79,7 @@ void create_frag_entry(struct list_head *head, struct sk_buff *skb)
 	return;
 }
 
-int create_frag_buffer(struct list_head *head)
+int frag_create_buffer(struct list_head *head)
 {
 	int i;
 	struct frag_packet_list_entry *tfp;
@@ -100,7 +100,7 @@ int create_frag_buffer(struct list_head *head)
 	return 0;
 }
 
-struct frag_packet_list_entry *search_frag_packet(struct list_head *head,
+struct frag_packet_list_entry *frag_search_packet(struct list_head *head,
 						 struct unicast_frag_packet *up)
 {
 	struct frag_packet_list_entry *tfp;
diff --git a/batman-adv/unicast.h b/batman-adv/unicast.h
index 7973697..b50d61b 100644
--- a/batman-adv/unicast.h
+++ b/batman-adv/unicast.h
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
1.7.0.4

