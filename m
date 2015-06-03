Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed,  3 Jun 2015 16:13:57 +0200
Message-Id: <1433340848-1682-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1433340848-1682-1-git-send-email-antonio@meshcoding.com>
References: <1433340848-1682-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 01/12] batman-adv: iv_ogm_aggregate_new,
	simplify error handling
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Markus Pargmann <mpa@pengutronix.de>

It is just a bit easier to put the error handling at one place and let
multiple error paths use the same calls.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/bat_iv_ogm.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index c5ba7a7..190a642 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -642,19 +642,16 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 		if (!batadv_atomic_dec_not_zero(&bat_priv->batman_queue_left)) {
 			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 				   "batman packet queue full\n");
-			goto out;
+			goto out_free_outgoing;
 		}
 	}
 
 	forw_packet_aggr = kmalloc(sizeof(*forw_packet_aggr), GFP_ATOMIC);
-	if (!forw_packet_aggr) {
-		if (!own_packet)
-			atomic_inc(&bat_priv->batman_queue_left);
-		goto out;
-	}
+	if (!forw_packet_aggr)
+		goto out_nomem;
 
-	if ((atomic_read(&bat_priv->aggregated_ogms)) &&
-	    (packet_len < BATADV_MAX_AGGREGATION_BYTES))
+	if (atomic_read(&bat_priv->aggregated_ogms) &&
+	    packet_len < BATADV_MAX_AGGREGATION_BYTES)
 		skb_size = BATADV_MAX_AGGREGATION_BYTES;
 	else
 		skb_size = packet_len;
@@ -662,12 +659,8 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	skb_size += ETH_HLEN;
 
 	forw_packet_aggr->skb = netdev_alloc_skb_ip_align(NULL, skb_size);
-	if (!forw_packet_aggr->skb) {
-		if (!own_packet)
-			atomic_inc(&bat_priv->batman_queue_left);
-		kfree(forw_packet_aggr);
-		goto out;
-	}
+	if (!forw_packet_aggr->skb)
+		goto out_free_forw_packet;
 	forw_packet_aggr->skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(forw_packet_aggr->skb, ETH_HLEN);
 
@@ -699,7 +692,12 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 			   send_time - jiffies);
 
 	return;
-out:
+out_free_forw_packet:
+	kfree(forw_packet_aggr);
+out_nomem:
+	if (!own_packet)
+		atomic_inc(&bat_priv->batman_queue_left);
+out_free_outgoing:
 	batadv_hardif_free_ref(if_outgoing);
 out_free_incoming:
 	batadv_hardif_free_ref(if_incoming);
-- 
2.4.2

