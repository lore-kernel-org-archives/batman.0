Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  2 Aug 2017 16:23:21 +0200
Message-Id: <20170802142322.13376-6-sw@simonwunderlich.de>
In-Reply-To: <20170802142322.13376-1-sw@simonwunderlich.de>
References: <20170802142322.13376-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: fix various spelling mistakes
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Colin Ian King <colin.king@canonical.com>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes in batadv_dbg debug messages and
also in a comment and ensure comment line is not wider than 80
characters

"ourselve" -> "ourselves"
"surpressed" -> "suppressed"
"troughput" -> "throughput"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_ogm.c | 12 ++++++------
 net/batman-adv/send.c      |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 894c96371e41..8be61734fc43 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -200,7 +200,7 @@ static void batadv_v_ogm_send(struct work_struct *work)
 				type = "unknown";
 			}
 
-			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "OGM2 from ourselve on %s surpressed: %s\n",
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "OGM2 from ourselves on %s suppressed: %s\n",
 				   hard_iface->net_dev->name, type);
 
 			batadv_hardif_put(hard_iface);
@@ -683,18 +683,18 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	ogm_throughput = ntohl(ogm_packet->throughput);
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "Received OGM2 packet via NB: %pM, IF: %s [%pM] (from OG: %pM, seqno %u, troughput %u, TTL %u, V %u, tvlv_len %u)\n",
+		   "Received OGM2 packet via NB: %pM, IF: %s [%pM] (from OG: %pM, seqno %u, throughput %u, TTL %u, V %u, tvlv_len %u)\n",
 		   ethhdr->h_source, if_incoming->net_dev->name,
 		   if_incoming->net_dev->dev_addr, ogm_packet->orig,
 		   ntohl(ogm_packet->seqno), ogm_throughput, ogm_packet->ttl,
 		   ogm_packet->version, ntohs(ogm_packet->tvlv_len));
 
-	/* If the troughput metric is 0, immediately drop the packet. No need to
-	 * create orig_node / neigh_node for an unusable route.
+	/* If the throughput metric is 0, immediately drop the packet. No need
+	 * to create orig_node / neigh_node for an unusable route.
 	 */
 	if (ogm_throughput == 0) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Drop packet: originator packet with troughput metric of 0\n");
+			   "Drop packet: originator packet with throughput metric of 0\n");
 		return;
 	}
 
@@ -762,7 +762,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 				type = "unknown";
 			}
 
-			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "OGM2 packet from %pM on %s surpressed: %s\n",
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "OGM2 packet from %pM on %s suppressed: %s\n",
 				   ogm_packet->orig, hard_iface->net_dev->name,
 				   type);
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index d239a9d72ac3..054a65e6eb68 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -911,7 +911,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 				type = "unknown";
 			}
 
-			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "BCAST packet from orig %pM on %s surpressed: %s\n",
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "BCAST packet from orig %pM on %s suppressed: %s\n",
 				   bcast_packet->orig,
 				   hard_iface->net_dev->name, type);
 
-- 
2.11.0

