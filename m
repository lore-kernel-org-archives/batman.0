Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 25 Jun 2012 08:54:30 +0200
Message-Id: <1340607284-29950-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1340607284-29950-1-git-send-email-ordex@autistici.org>
References: <1340607284-29950-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 06/20] batman-adv: Prefix unicast static
	inline functions with batadv_
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
 net/batman-adv/routing.c |    3 ++-
 net/batman-adv/unicast.h |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 0888f1e..3eb4a2e 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -869,7 +869,8 @@ static int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	}
 
 	if (unicast_packet->header.packet_type == BAT_UNICAST_FRAG &&
-	    frag_can_reassemble(skb, neigh_node->if_incoming->net_dev->mtu)) {
+	    batadv_frag_can_reassemble(skb,
+				       neigh_node->if_incoming->net_dev->mtu)) {
 
 		ret = batadv_frag_reassemble_skb(skb, bat_priv, &new_skb);
 
diff --git a/net/batman-adv/unicast.h b/net/batman-adv/unicast.h
index 87f8f89..9257b83 100644
--- a/net/batman-adv/unicast.h
+++ b/net/batman-adv/unicast.h
@@ -33,7 +33,7 @@ int batadv_frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			 struct hard_iface *hard_iface,
 			 const uint8_t dstaddr[]);
 
-static inline int frag_can_reassemble(const struct sk_buff *skb, int mtu)
+static inline int batadv_frag_can_reassemble(const struct sk_buff *skb, int mtu)
 {
 	const struct unicast_frag_packet *unicast_packet;
 	int uneven_correction = 0;
-- 
1.7.9.4

