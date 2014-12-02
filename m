Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:37 +0100
Message-Id: <1417519009-20699-20-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 19/31] batman-adv: iv_ogm_aggregate_new,
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

It is just a bit easier to put the error handling at one place and let
multiple error paths use the same calls.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 bat_iv_ogm.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 232cd9ab3e6e..1f3ed3173005 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -647,14 +647,11 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
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
 
@@ -699,6 +692,11 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 			   send_time - jiffies);
 
 	return;
+out_free_forw_packet:
+	kfree(forw_packet_aggr);
+out_nomem:
+	if (!own_packet)
+		atomic_inc(&bat_priv->batman_queue_left);
 out:
 	batadv_hardif_free_ref(if_outgoing);
 out_free_incoming:
-- 
2.1.3

