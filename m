Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 18 Jul 2016 00:15:40 +0200
Message-Id: <1468793741-4606-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Don't allow zero and
	multicast sender address
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

The routing checks are validating the sender mac address. They reject every
sender mac address which is a broadcast. But they also have to reject
zero-mac address and multicast mac addresses.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 610f2c4..b648caf 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -196,8 +196,8 @@ bool batadv_check_management_packet(struct sk_buff *skb,
 	if (!is_broadcast_ether_addr(ethhdr->h_dest))
 		return false;
 
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
+	/* packet with invalid sender address */
+	if (!is_valid_ether_addr(ethhdr->h_source))
 		return false;
 
 	/* create a copy of the skb, if needed, to modify it. */
@@ -357,8 +357,8 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	if (is_broadcast_ether_addr(ethhdr->h_dest))
 		goto out;
 
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
+	/* packet with invalid sender address */
+	if (!is_valid_ether_addr(ethhdr->h_source))
 		goto out;
 
 	/* not for me */
@@ -449,8 +449,8 @@ static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
 	if (is_broadcast_ether_addr(ethhdr->h_dest))
 		return -EBADR;
 
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
+	/* packet with invalid sender address */
+	if (!is_valid_ether_addr(ethhdr->h_source))
 		return -EBADR;
 
 	/* not for me */
@@ -1091,8 +1091,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (!is_broadcast_ether_addr(ethhdr->h_dest))
 		goto out;
 
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
+	/* packet with invalid sender address */
+	if (!is_valid_ether_addr(ethhdr->h_source))
 		goto out;
 
 	/* ignore broadcasts sent by myself */
-- 
2.8.1

