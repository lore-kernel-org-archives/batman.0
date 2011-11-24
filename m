Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 24 Nov 2011 23:21:13 +0100
Message-Id: <1322173279-18338-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1322173279-18338-1-git-send-email-ordex@autistici.org>
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 1/7] batman-adv: implement an helper
	function to forge unicast packets
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

A new function named prepare_unicast_packet() has been implemented so that it can
do all the needed operations to set up a skb for unicast sending. It is general
enough to be used in every context. Helpful for later developments

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 unicast.c |   36 ++++++++++++++++++++++++------------
 unicast.h |    1 +
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/unicast.c b/unicast.c
index 6f3c659..d49f2cc 100644
--- a/unicast.c
+++ b/unicast.c
@@ -283,6 +283,29 @@ out:
 	return ret;
 }
 
+bool prepare_unicast_packet(struct sk_buff *skb, struct orig_node *orig_node)
+{
+	struct unicast_packet *unicast_packet;
+
+	if (my_skb_head_push(skb, sizeof(*unicast_packet)) < 0)
+		return false;
+
+	unicast_packet = (struct unicast_packet *)skb->data;
+
+	unicast_packet->header.version = COMPAT_VERSION;
+	/* batman packet type: unicast */
+	unicast_packet->header.packet_type = BAT_UNICAST;
+	/* set unicast ttl */
+	unicast_packet->header.ttl = TTL;
+	/* copy the destination for faster routing */
+	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+	/* set the destination tt version number */
+	unicast_packet->ttvn =
+		(uint8_t)atomic_read(&orig_node->last_ttvn);
+
+	return true;
+}
+
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
@@ -315,22 +338,11 @@ find_router:
 	if (!neigh_node)
 		goto out;
 
-	if (my_skb_head_push(skb, sizeof(*unicast_packet)) < 0)
+	if (!prepare_unicast_packet(skb, orig_node))
 		goto out;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
-	unicast_packet->header.version = COMPAT_VERSION;
-	/* batman packet type: unicast */
-	unicast_packet->header.packet_type = BAT_UNICAST;
-	/* set unicast ttl */
-	unicast_packet->header.ttl = TTL;
-	/* copy the destination for faster routing */
-	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
-	/* set the destination tt version number */
-	unicast_packet->ttvn =
-		(uint8_t)atomic_read(&orig_node->last_ttvn);
-
 	if (atomic_read(&bat_priv->fragmentation) &&
 	    data_len + sizeof(*unicast_packet) >
 				neigh_node->if_incoming->net_dev->mtu) {
diff --git a/unicast.h b/unicast.h
index 8fd5535..63d0305 100644
--- a/unicast.h
+++ b/unicast.h
@@ -33,6 +33,7 @@ void frag_list_free(struct list_head *head);
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
 int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 		  struct hard_iface *hard_iface, const uint8_t dstaddr[]);
+bool prepare_unicast_packet(struct sk_buff *skb, struct orig_node *orig_node);
 
 static inline int frag_can_reassemble(const struct sk_buff *skb, int mtu)
 {
-- 
1.7.3.4

