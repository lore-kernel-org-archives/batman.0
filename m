Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 12 Sep 2010 23:21:56 +0200
Message-Id: <1284326516-30540-6-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284326516-30540-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284326516-30540-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/5] Staging: batman-adv: check kmalloc()
	return value
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
Cc: Vasiliy Kulikov <segooon@gmail.com>, b.a.t.m.a.n@lists.open-mesh.net, Marek Lindner <lindner_marek@yahoo.de>

From: Vasiliy Kulikov <segooon@gmail.com>

kmalloc() may fail, if so drop current packet.

Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
[sven.eckelmann@gmx.de: Removed new introduced deadlock]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/routing.c |    8 ++++++--
 drivers/staging/batman-adv/unicast.c |    8 ++++++--
 drivers/staging/batman-adv/unicast.h |    2 +-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index e12fd99..2cf8cf9 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -1232,8 +1232,12 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 		orig_node->last_frag_packet = jiffies;
 
-		if (list_empty(&orig_node->frag_list))
-			create_frag_buffer(&orig_node->frag_list);
+		if (list_empty(&orig_node->frag_list) &&
+			create_frag_buffer(&orig_node->frag_list)) {
+			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
+					       flags);
+			return NET_RX_DROP;
+		}
 
 		tmp_frag_entry =
 			search_frag_packet(&orig_node->frag_list,
diff --git a/drivers/staging/batman-adv/unicast.c b/drivers/staging/batman-adv/unicast.c
index f951abc..0dac50d 100644
--- a/drivers/staging/batman-adv/unicast.c
+++ b/drivers/staging/batman-adv/unicast.c
@@ -78,7 +78,7 @@ void create_frag_entry(struct list_head *head, struct sk_buff *skb)
 	return;
 }
 
-void create_frag_buffer(struct list_head *head)
+int create_frag_buffer(struct list_head *head)
 {
 	int i;
 	struct frag_packet_list_entry *tfp;
@@ -86,13 +86,17 @@ void create_frag_buffer(struct list_head *head)
 	for (i = 0; i < FRAG_BUFFER_SIZE; i++) {
 		tfp = kmalloc(sizeof(struct frag_packet_list_entry),
 			GFP_ATOMIC);
+		if (!tfp) {
+			frag_list_free(head);
+			return -ENOMEM;
+		}
 		tfp->skb = NULL;
 		tfp->seqno = 0;
 		INIT_LIST_HEAD(&tfp->list);
 		list_add(&tfp->list, head);
 	}
 
-	return;
+	return 0;
 }
 
 struct frag_packet_list_entry *search_frag_packet(struct list_head *head,
diff --git a/drivers/staging/batman-adv/unicast.h b/drivers/staging/batman-adv/unicast.h
index 1d5cbeb..7973697 100644
--- a/drivers/staging/batman-adv/unicast.h
+++ b/drivers/staging/batman-adv/unicast.h
@@ -30,7 +30,7 @@ struct sk_buff *merge_frag_packet(struct list_head *head,
 	struct sk_buff *skb);
 
 void create_frag_entry(struct list_head *head, struct sk_buff *skb);
-void create_frag_buffer(struct list_head *head);
+int create_frag_buffer(struct list_head *head);
 struct frag_packet_list_entry *search_frag_packet(struct list_head *head,
 	struct unicast_frag_packet *up);
 void frag_list_free(struct list_head *head);
-- 
1.7.2.3

