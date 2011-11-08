Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  8 Nov 2011 12:34:16 +0100
Message-Id: <1320752062-21776-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1320752062-21776-1-git-send-email-ordex@autistici.org>
References: <1320752062-21776-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/7] batman-adv: implement an helper
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

* label "prepare_packet:" restored to "find_router:" in unicast.c
* restored wrongly removed blank line


 unicast.c |   43 ++++++++++++++++++++++++++++++-------------
 unicast.h |    2 ++
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/unicast.c b/unicast.c
index 07d1c1d..cbadc21 100644
--- a/unicast.c
+++ b/unicast.c
@@ -283,6 +283,33 @@ out:
 	return ret;
 }
 
+struct sk_buff *prepare_unicast_packet(struct sk_buff *skb,
+				       struct orig_node *orig_node)
+{
+	struct unicast_packet *unicast_packet;
+
+	if (my_skb_head_push(skb, sizeof(*unicast_packet)) < 0)
+		goto out;
+
+	unicast_packet = (struct unicast_packet *)skb->data;
+
+	unicast_packet->version = COMPAT_VERSION;
+	/* batman packet type: unicast */
+	unicast_packet->packet_type = BAT_UNICAST;
+	/* set unicast ttl */
+	unicast_packet->ttl = TTL;
+	/* copy the destination for faster routing */
+	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+	/* set the destination tt version number */
+	unicast_packet->ttvn =
+		(uint8_t)atomic_read(&orig_node->last_ttvn);
+
+	return skb;
+out:
+	kfree(skb);
+	return NULL;
+}
+
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
@@ -315,22 +342,12 @@ find_router:
 	if (!neigh_node)
 		goto out;
 
-	if (my_skb_head_push(skb, sizeof(*unicast_packet)) < 0)
+	skb = prepare_unicast_packet(skb, orig_node);
+	if (!skb)
 		goto out;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
-	unicast_packet->version = COMPAT_VERSION;
-	/* batman packet type: unicast */
-	unicast_packet->packet_type = BAT_UNICAST;
-	/* set unicast ttl */
-	unicast_packet->ttl = TTL;
-	/* copy the destination for faster routing */
-	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
-	/* set the destination tt version number */
-	unicast_packet->ttvn =
-		(uint8_t)atomic_read(&orig_node->last_ttvn);
-
 	if (atomic_read(&bat_priv->fragmentation) &&
 	    data_len + sizeof(*unicast_packet) >
 				neigh_node->if_incoming->net_dev->mtu) {
@@ -350,7 +367,7 @@ out:
 		neigh_node_free_ref(neigh_node);
 	if (orig_node)
 		orig_node_free_ref(orig_node);
-	if (ret == 1)
+	if (ret == 1 && skb)
 		kfree_skb(skb);
 	return ret;
 }
diff --git a/unicast.h b/unicast.h
index 8fd5535..f53a735 100644
--- a/unicast.h
+++ b/unicast.h
@@ -33,6 +33,8 @@ void frag_list_free(struct list_head *head);
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
 int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 		  struct hard_iface *hard_iface, const uint8_t dstaddr[]);
+struct sk_buff *prepare_unicast_packet(struct sk_buff *skb,
+				       struct orig_node *orig_node);
 
 static inline int frag_can_reassemble(const struct sk_buff *skb, int mtu)
 {
-- 
1.7.3.4

