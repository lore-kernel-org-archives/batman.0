Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  3 Apr 2013 10:14:20 +0200
Message-Id: <1364976860-13225-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: use the proper header len
	when checking the TTVN
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Unicast packet might be of type either UNICAST or
UNICAST4ADDR.
In the two cases the header size is different, but the
mechanism checking the TTVN field was assuming it to be
always of the same type (UNICAST), so failing to access the
inner Ethernet header in case of UNICAST4ADDR.

Fix this by passing the real header length as argument.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 routing.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/routing.c b/routing.c
index 5ee21ce..572e4f9 100644
--- a/routing.c
+++ b/routing.c
@@ -922,7 +922,7 @@ out:
 }
 
 static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
-				     struct sk_buff *skb) {
+				     struct sk_buff *skb, int hdr_len) {
 	uint8_t curr_ttvn, old_ttvn;
 	struct batadv_orig_node *orig_node;
 	struct ethhdr *ethhdr;
@@ -931,7 +931,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	int is_old_ttvn;
 
 	/* check if there is enough data before accessing it */
-	if (pskb_may_pull(skb, sizeof(*unicast_packet) + ETH_HLEN) < 0)
+	if (pskb_may_pull(skb, hdr_len + ETH_HLEN) < 0)
 		return 0;
 
 	/* create a copy of the skb (in case of for re-routing) to modify it. */
@@ -939,7 +939,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 		return 0;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-	ethhdr = (struct ethhdr *)(skb->data + sizeof(*unicast_packet));
+	ethhdr = (struct ethhdr *)(skb->data + hdr_len);
 
 	/* check if the destination client was served by this node and it is now
 	 * roaming. In this case, it means that the node has got a ROAM_ADV
@@ -1046,8 +1046,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 
 	if (batadv_check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
-
-	if (!batadv_check_unicast_ttvn(bat_priv, skb))
+	if (!batadv_check_unicast_ttvn(bat_priv, skb, hdr_size))
 		return NET_RX_DROP;
 
 	/* packet for me */
@@ -1091,7 +1090,7 @@ int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
 	if (batadv_check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
-	if (!batadv_check_unicast_ttvn(bat_priv, skb))
+	if (!batadv_check_unicast_ttvn(bat_priv, skb, hdr_size))
 		return NET_RX_DROP;
 
 	unicast_packet = (struct batadv_unicast_frag_packet *)skb->data;
-- 
1.8.1.5

