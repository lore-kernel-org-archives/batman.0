Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon,  5 Dec 2011 04:01:51 +0800
Message-Id: <1323028911-13495-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: simplify bat_ogm_receive API call
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Most of the values in that call are derived from the skb, so we can hand
over the skb instead.

Reported-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c |   11 +++++++----
 bat_ogm.h    |    3 +--
 routing.c    |    4 +---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index d60e1ba..3402fa5 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1140,13 +1140,16 @@ out:
 	orig_node_free_ref(orig_node);
 }
 
-void bat_ogm_receive(const struct ethhdr *ethhdr, unsigned char *packet_buff,
-		     int packet_len, struct hard_iface *if_incoming)
+void bat_ogm_receive(struct hard_iface *if_incoming, struct sk_buff *skb)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
-	int buff_pos = 0;
-	unsigned char *tt_buff;
+	struct ethhdr *ethhdr;
+	int buff_pos = 0, packet_len;
+	unsigned char *tt_buff, *packet_buff;
 
+	packet_len = skb_headlen(skb);
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	packet_buff = skb->data;
 	batman_ogm_packet = (struct batman_ogm_packet *)packet_buff;
 
 	/* unpack the aggregated packets and process them one by one */
diff --git a/bat_ogm.h b/bat_ogm.h
index 69329c1..47edfde 100644
--- a/bat_ogm.h
+++ b/bat_ogm.h
@@ -29,7 +29,6 @@ void bat_ogm_init_primary(struct hard_iface *hard_iface);
 void bat_ogm_update_mac(struct hard_iface *hard_iface);
 void bat_ogm_schedule(struct hard_iface *hard_iface, int tt_num_changes);
 void bat_ogm_emit(struct forw_packet *forw_packet);
-void bat_ogm_receive(const struct ethhdr *ethhdr, unsigned char *packet_buff,
-		     int packet_len, struct hard_iface *if_incoming);
+void bat_ogm_receive(struct hard_iface *if_incoming, struct sk_buff *skb);
 
 #endif /* _NET_BATMAN_ADV_OGM_H_ */
diff --git a/routing.c b/routing.c
index 4363d19..5bc41c8 100644
--- a/routing.c
+++ b/routing.c
@@ -272,9 +272,7 @@ int recv_bat_ogm_packet(struct sk_buff *skb, struct hard_iface *hard_iface)
 	if (skb_linearize(skb) < 0)
 		return NET_RX_DROP;
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
-
-	bat_ogm_receive(ethhdr, skb->data, skb_headlen(skb), hard_iface);
+	bat_ogm_receive(hard_iface, skb);
 
 	kfree_skb(skb);
 	return NET_RX_SUCCESS;
-- 
1.7.5.4

