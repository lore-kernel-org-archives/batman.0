Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  6 Aug 2016 16:59:36 +0200
Message-Id: <1470495578-20476-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 1/3] batman-adv: Disallow zero and mcast
	src address for data frames
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

The routing checks are validating the source mac address of the outer
ethernet header. They reject every source mac address which is a broadcast
address. But they also have to reject and multicast mac addresses.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - clarify in commit message that only the outer ethernet header is
   affected
   (thanks Linus)
 - split in patch 1/2
 - Allow zero mac address as source address in outer header as requested by
   Linus
---
 net/batman-adv/routing.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 610f2c4..913ab51 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -357,8 +357,8 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	if (is_broadcast_ether_addr(ethhdr->h_dest))
 		goto out;
 
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
+	/* packet with broadcast/multicast sender address */
+	if (is_multicast_ether_addr(ethhdr->h_source))
 		goto out;
 
 	/* not for me */
@@ -449,8 +449,8 @@ static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
 	if (is_broadcast_ether_addr(ethhdr->h_dest))
 		return -EBADR;
 
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
+	/* packet with broadcast/multicast sender address */
+	if (is_multicast_ether_addr(ethhdr->h_source))
 		return -EBADR;
 
 	/* not for me */
@@ -1091,8 +1091,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (!is_broadcast_ether_addr(ethhdr->h_dest))
 		goto out;
 
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
+	/* packet with broadcast/multicast sender address */
+	if (is_multicast_ether_addr(ethhdr->h_source))
 		goto out;
 
 	/* ignore broadcasts sent by myself */
-- 
2.8.1

