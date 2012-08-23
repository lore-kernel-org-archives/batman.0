Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 23 Aug 2012 15:10:21 +0200
Message-Id: <1345727427-20805-13-git-send-email-ordex@autistici.org>
In-Reply-To: <1345727427-20805-1-git-send-email-ordex@autistici.org>
References: <1345727427-20805-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 12/18] batman-adv: Drop tt queries with
	foreign dest
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>, b.a.t.m.a.n@lists.open-mesh.org

From: Martin Hundebøll <martin@hundeboll.net>

When enabling promiscuous mode, tt queries for other hosts might be
received. Before this patch, "foreign" tt queries were processed like
any other query and thus forwarded to its destination again and thereby
causing a loop.

This patch adds a check to drop foreign tt queries.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/routing.c |   18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index a79ded5..4961278 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -609,29 +609,17 @@ int batadv_recv_tt_query(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_tt_query_packet *tt_query;
 	uint16_t tt_size;
-	struct ethhdr *ethhdr;
+	int hdr_size = sizeof(*tt_query);
 	char tt_flag;
 	size_t packet_size;
 
-	/* drop packet if it has not necessary minimum size */
-	if (unlikely(!pskb_may_pull(skb,
-				    sizeof(struct batadv_tt_query_packet))))
-		goto out;
+	if (batadv_check_unicast_packet(skb, hdr_size) < 0)
+		return NET_RX_DROP;
 
 	/* I could need to modify it */
 	if (skb_cow(skb, sizeof(struct batadv_tt_query_packet)) < 0)
 		goto out;
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
-
-	/* packet with unicast indication but broadcast recipient */
-	if (is_broadcast_ether_addr(ethhdr->h_dest))
-		goto out;
-
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
-		goto out;
-
 	tt_query = (struct batadv_tt_query_packet *)skb->data;
 
 	switch (tt_query->flags & BATADV_TT_QUERY_TYPE_MASK) {
-- 
1.7.9.4

