Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 21 Aug 2016 05:25:33 +0200
Message-Id: <20160821032534.11074-2-linus.luessing@c0d3.blue>
In-Reply-To: <20160821032534.11074-1-linus.luessing@c0d3.blue>
References: <20160821032534.11074-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: elp: skb network header API
	instead of skb->data access
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

Instead of playing with skb attributes directly, let's use the
appropriate, more descriptive API instead.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/bat_v_elp.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index ea463bf..af414b0 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -263,7 +263,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 	if (!skb)
 		goto restart_timer;
 
-	elp_packet = (struct batadv_elp_packet *)skb->data;
+	elp_packet = (struct batadv_elp_packet *)skb_network_header(skb);
 	elp_packet->seqno = htonl(atomic_read(&hard_iface->bat_v.elp_seqno));
 	elp_interval = atomic_read(&hard_iface->bat_v.elp_interval);
 	elp_packet->elp_interval = htonl(elp_interval);
@@ -323,19 +323,23 @@ out:
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_elp_packet *elp_packet;
+	struct sk_buff *skb;
 	u32 random_seqno;
 	size_t size;
 	int res = -ENOMEM;
 
 	size = ETH_HLEN + NET_IP_ALIGN + BATADV_ELP_HLEN;
-	hard_iface->bat_v.elp_skb = dev_alloc_skb(size);
-	if (!hard_iface->bat_v.elp_skb)
+	skb = dev_alloc_skb(size);
+	hard_iface->bat_v.elp_skb = skb;
+
+	if (!skb)
 		goto out;
 
 	skb_reserve(hard_iface->bat_v.elp_skb, ETH_HLEN + NET_IP_ALIGN);
+	skb_reset_network_header(skb);
 	skb_put(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
-	elp_packet = (struct batadv_elp_packet *)
-			hard_iface->bat_v.elp_skb->data;
+
+	elp_packet = (struct batadv_elp_packet *)skb_network_header(skb);
 	memset(elp_packet, 0, BATADV_ELP_HLEN);
 
 	elp_packet->packet_type = BATADV_ELP;
@@ -392,7 +396,7 @@ void batadv_v_elp_iface_activate(struct batadv_hard_iface *primary_iface,
 		return;
 
 	skb = hard_iface->bat_v.elp_skb;
-	elp_packet = (struct batadv_elp_packet *)skb->data;
+	elp_packet = (struct batadv_elp_packet *)skb_network_header(skb);
 	ether_addr_copy(elp_packet->orig,
 			primary_iface->net_dev->dev_addr);
 }
@@ -506,7 +510,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	if (strcmp(bat_priv->bat_algo_ops->name, "BATMAN_V") != 0)
 		return NET_RX_DROP;
 
-	elp_packet = (struct batadv_elp_packet *)skb->data;
+	elp_packet = (struct batadv_elp_packet *)skb_network_header(skb);
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Received ELP packet from %pM seqno %u ORIG: %pM\n",
-- 
2.1.4

