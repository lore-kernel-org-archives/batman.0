Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  9 Oct 2012 15:00:11 +0200
Message-Id: <1349787611-18102-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix DAT packet counting
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
To: b.a.t.m.a.n@lists.open-mesh.org

DAT packets must be counted before any batadv_dat_snoop_incoming_* invocation
otherwise the code flow can jump the counters increment at all

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/routing.c b/routing.c
index 12af7d3..75615cc 100644
--- a/routing.c
+++ b/routing.c
@@ -1061,6 +1061,10 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 
 	/* packet for me */
 	if (batadv_is_my_mac(unicast_packet->dest)) {
+		if (is4addr)
+			batadv_dat_inc_counter(bat_priv,
+					       unicast_4addr_packet->subtype);
+
 		if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb,
 							  hdr_size))
 			goto rx_success;
@@ -1068,10 +1072,6 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 							hdr_size))
 			goto rx_success;
 
-		if (is4addr)
-			batadv_dat_inc_counter(bat_priv,
-					       unicast_4addr_packet->subtype);
-
 		batadv_interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size,
 				    NULL);
 
-- 
1.7.12

