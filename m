Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 18 Jun 2017 09:59:28 +0200
Message-Id: <20170618075928.27964-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove variable deprecated by
 skb_put_data
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

skb_put_data makes it unnecessary to store the skb_put return value to copy
some data to the packet. The returned pointer of skb_put_data should
therefore not stored by functions which previously only used it to copy
some data.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch belongs to the series
 https://patchwork.open-mesh.org/project/b.a.t.m.a.n./list/?series=11
It must not be squashed in the "batman-adv: introduce and use skb_put_data()"
because it is already part of net-next and we must port the change in our
patch in a separate pull request.

 net/batman-adv/bat_iv_ogm.c | 4 +---
 net/batman-adv/bat_v_ogm.c  | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index a3501173..8769fa1b 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -729,11 +729,9 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
 				    const unsigned char *packet_buff,
 				    int packet_len, bool direct_link)
 {
-	unsigned char *skb_buff;
 	unsigned long new_direct_link_flag;
 
-	skb_buff = skb_put_data(forw_packet_aggr->skb, packet_buff,
-				packet_len);
+	skb_put_data(forw_packet_aggr->skb, packet_buff, packet_len);
 	forw_packet_aggr->packet_len += packet_len;
 	forw_packet_aggr->num_packets++;
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 1e3dc374..894c9637 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -137,7 +137,7 @@ static void batadv_v_ogm_send(struct work_struct *work)
 	struct batadv_priv *bat_priv;
 	struct batadv_ogm2_packet *ogm_packet;
 	struct sk_buff *skb, *skb_tmp;
-	unsigned char *ogm_buff, *pkt_buff;
+	unsigned char *ogm_buff;
 	int ogm_buff_len;
 	u16 tvlv_len = 0;
 	int ret;
@@ -166,7 +166,7 @@ static void batadv_v_ogm_send(struct work_struct *work)
 		goto reschedule;
 
 	skb_reserve(skb, ETH_HLEN);
-	pkt_buff = skb_put_data(skb, ogm_buff, ogm_buff_len);
+	skb_put_data(skb, ogm_buff, ogm_buff_len);
 
 	ogm_packet = (struct batadv_ogm2_packet *)skb->data;
 	ogm_packet->seqno = htonl(atomic_read(&bat_priv->bat_v.ogm_seqno));
-- 
2.11.0

