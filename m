Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 28 Jun 2012 11:34:10 +0200
Message-Id: <1340876067-28333-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1340876067-28333-1-git-send-email-ordex@autistici.org>
References: <1340876067-28333-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/18] batman-adv: Prefix unicast local
	static functions with batadv_
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

All non-static symbols of batman-adv were prefixed with batadv_ to avoid
collisions with other symbols of the kernel. Other symbols of batman-adv
should use the same prefix to keep the naming scheme consistent.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/unicast.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/unicast.c b/net/batman-adv/unicast.c
index d021055..472436a 100644
--- a/net/batman-adv/unicast.c
+++ b/net/batman-adv/unicast.c
@@ -29,9 +29,10 @@
 #include "hard-interface.h"
 
 
-static struct sk_buff *frag_merge_packet(struct list_head *head,
-					 struct frag_packet_list_entry *tfp,
-					 struct sk_buff *skb)
+static struct sk_buff *
+batadv_frag_merge_packet(struct list_head *head,
+			 struct frag_packet_list_entry *tfp,
+			 struct sk_buff *skb)
 {
 	struct unicast_frag_packet *up =
 		(struct unicast_frag_packet *)skb->data;
@@ -75,7 +76,8 @@ err:
 	return NULL;
 }
 
-static void frag_create_entry(struct list_head *head, struct sk_buff *skb)
+static void batadv_frag_create_entry(struct list_head *head,
+				     struct sk_buff *skb)
 {
 	struct frag_packet_list_entry *tfp;
 	struct unicast_frag_packet *up =
@@ -91,7 +93,7 @@ static void frag_create_entry(struct list_head *head, struct sk_buff *skb)
 	return;
 }
 
-static int frag_create_buffer(struct list_head *head)
+static int batadv_frag_create_buffer(struct list_head *head)
 {
 	int i;
 	struct frag_packet_list_entry *tfp;
@@ -111,8 +113,9 @@ static int frag_create_buffer(struct list_head *head)
 	return 0;
 }
 
-static struct frag_packet_list_entry *frag_search_packet(struct list_head *head,
-					   const struct unicast_frag_packet *up)
+static struct frag_packet_list_entry *
+batadv_frag_search_packet(struct list_head *head,
+			  const struct unicast_frag_packet *up)
 {
 	struct frag_packet_list_entry *tfp;
 	struct unicast_frag_packet *tmp_up = NULL;
@@ -188,22 +191,22 @@ int batadv_frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	orig_node->last_frag_packet = jiffies;
 
 	if (list_empty(&orig_node->frag_list) &&
-	    frag_create_buffer(&orig_node->frag_list)) {
+	    batadv_frag_create_buffer(&orig_node->frag_list)) {
 		pr_debug("couldn't create frag buffer\n");
 		goto out;
 	}
 
-	tmp_frag_entry = frag_search_packet(&orig_node->frag_list,
-					    unicast_packet);
+	tmp_frag_entry = batadv_frag_search_packet(&orig_node->frag_list,
+						   unicast_packet);
 
 	if (!tmp_frag_entry) {
-		frag_create_entry(&orig_node->frag_list, skb);
+		batadv_frag_create_entry(&orig_node->frag_list, skb);
 		ret = NET_RX_SUCCESS;
 		goto out;
 	}
 
-	*new_skb = frag_merge_packet(&orig_node->frag_list, tmp_frag_entry,
-				     skb);
+	*new_skb = batadv_frag_merge_packet(&orig_node->frag_list,
+					    tmp_frag_entry, skb);
 	/* if not, merge failed */
 	if (*new_skb)
 		ret = NET_RX_SUCCESS;
-- 
1.7.9.4

