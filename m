Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v3 2/2] batman-adv: BATMAN_V: aggregate OGMv2 packets
Date: Sun,  4 Aug 2019 20:54:54 +0200
Message-Id: <20190804185454.975-3-linus.luessing@c0d3.blue>
In-Reply-To: <20190804185454.975-1-linus.luessing@c0d3.blue>
References: <20190804185454.975-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Instead of transmitting individual OGMv2 packets from the aggregation
queue merge those OGMv2 packets into a single one and transmit this
aggregate instead.

This reduces overhead as it saves an ethernet header and a transmission
per aggregated OGMv2 packet.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/bat_v_ogm.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index f517423a..1d540504 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -191,18 +191,44 @@ static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
  * batadv_v_ogm_aggr_send() - flush & send aggregation queue
  * @hard_iface: the interface with the aggregation queue to flush
  *
+ * Aggregates all OGMv2 packets currently in the aggregation queue into a
+ * single OGMv2 packet and transmits this aggregate.
+ *
+ * The aggregation queue is empty after this call.
+ *
  * Caller needs to hold the hard_iface->bat_v.aggr_list_lock.
  */
 static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
 {
+	unsigned int aggr_len = hard_iface->bat_v.aggr_len;
+	struct sk_buff *skb_aggr;
+	unsigned int ogm_len;
 	struct sk_buff *skb;
 
 	lockdep_assert_held(&hard_iface->bat_v.aggr_list_lock);
 
+	if (!aggr_len)
+		return;
+
+	skb_aggr = dev_alloc_skb(aggr_len + ETH_HLEN + NET_IP_ALIGN);
+	if (!skb_aggr) {
+		batadv_v_ogm_aggr_list_free(hard_iface);
+		return;
+	}
+
+	skb_reserve(skb_aggr, ETH_HLEN + NET_IP_ALIGN);
+	skb_reset_network_header(skb_aggr);
+
 	while ((skb = skb_dequeue(&hard_iface->bat_v.aggr_list))) {
 		hard_iface->bat_v.aggr_len -= batadv_v_ogm_len(skb);
-		batadv_v_ogm_send_to_if(skb, hard_iface);
+
+		ogm_len = batadv_v_ogm_len(skb);
+		skb_put_data(skb_aggr, skb->data, ogm_len);
+
+		consume_skb(skb);
 	}
+
+	batadv_v_ogm_send_to_if(skb_aggr, hard_iface);
 }
 
 /**
-- 
2.22.0

