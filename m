Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Thu,  5 Jul 2012 11:34:27 +0200
Message-Id: <1341480868-25908-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Move
	batadv_check_unicast_packet()
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

batadv_check_unicast_packet() is needed in batadv_recv_tt_query(), so
move the former to before the latter.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 routing.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/routing.c b/routing.c
index bc2b88b..30d7605 100644
--- a/routing.c
+++ b/routing.c
@@ -579,6 +579,31 @@ batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
 	return router;
 }
 
+static int batadv_check_unicast_packet(struct sk_buff *skb, int hdr_size)
+{
+	struct ethhdr *ethhdr;
+
+	/* drop packet if it has not necessary minimum size */
+	if (unlikely(!pskb_may_pull(skb, hdr_size)))
+		return -1;
+
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* packet with unicast indication but broadcast recipient */
+	if (is_broadcast_ether_addr(ethhdr->h_dest))
+		return -1;
+
+	/* packet with broadcast sender address */
+	if (is_broadcast_ether_addr(ethhdr->h_source))
+		return -1;
+
+	/* not for me */
+	if (!batadv_is_my_mac(ethhdr->h_dest))
+		return -1;
+
+	return 0;
+}
+
 int batadv_recv_tt_query(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
@@ -819,31 +844,6 @@ err:
 	return NULL;
 }
 
-static int batadv_check_unicast_packet(struct sk_buff *skb, int hdr_size)
-{
-	struct ethhdr *ethhdr;
-
-	/* drop packet if it has not necessary minimum size */
-	if (unlikely(!pskb_may_pull(skb, hdr_size)))
-		return -1;
-
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
-
-	/* packet with unicast indication but broadcast recipient */
-	if (is_broadcast_ether_addr(ethhdr->h_dest))
-		return -1;
-
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
-		return -1;
-
-	/* not for me */
-	if (!batadv_is_my_mac(ethhdr->h_dest))
-		return -1;
-
-	return 0;
-}
-
 static int batadv_route_unicast_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if)
 {
-- 
1.7.11.1

