Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 11 Mar 2013 23:12:28 +0100
Message-Id: <1363039948-27190-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1363039948-27190-1-git-send-email-ordex@autistici.org>
References: <1363039948-27190-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: verify tt len does not exceed
	packet len
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

batadv_iv_ogm_process() accesses the packet using the tt_num_changes
attribute regardless of the real packet len (assuming the length check
was done before). Therefore a length check is needed to avoid reading
random memory.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_iv_ogm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index a0b253e..a5bb0a7 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1288,7 +1288,8 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 	batadv_ogm_packet = (struct batadv_ogm_packet *)packet_buff;
 
 	/* unpack the aggregated packets and process them one by one */
-	do {
+	while (batadv_iv_ogm_aggr_packet(buff_pos, packet_len,
+					 batadv_ogm_packet->tt_num_changes)) {
 		tt_buff = packet_buff + buff_pos + BATADV_OGM_HLEN;
 
 		batadv_iv_ogm_process(ethhdr, batadv_ogm_packet, tt_buff,
@@ -1299,8 +1300,7 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 
 		packet_pos = packet_buff + buff_pos;
 		batadv_ogm_packet = (struct batadv_ogm_packet *)packet_pos;
-	} while (batadv_iv_ogm_aggr_packet(buff_pos, packet_len,
-					   batadv_ogm_packet->tt_num_changes));
+	}
 
 	kfree_skb(skb);
 	return NET_RX_SUCCESS;
-- 
1.8.1.5

