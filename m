Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Mar 2019 10:50:50 +0100
Message-Id: <20190317095050.21290-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Adjust name for
 batadv_dat_send_data
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

The send functions in batman-adv are expected to consume the skb when
either the data is queued up for the underlying driver or when some
precondition failed. batadv_dat_send_data didn't do this and instead
created a copy of the skb, modified it and queued the copy up for
transmission. The caller has to take care that the skb is handled correctly
(for example free'd) when batadv_dat_send_data returns.

This unclear behavior already lead to memory leaks in the recent past.
Renaming the function to batadv_dat_forward_data should make it easier to
identify that the data is forwarded but the skb is not actually
send+consumed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Linus Lüssing <linus.luessing@c0d3.blue>

Do you think that would have helped when you've implemented the DAT change?
---
 net/batman-adv/distributed-arp-table.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 310a4f35..b6bad3f6 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -667,7 +667,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
 }
 
 /**
- * batadv_dat_send_data() - send a payload to the selected candidates
+ * batadv_dat_forward_data() - copy and send payload to the selected candidates
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: payload to send
  * @ip: the DHT key
@@ -680,9 +680,9 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
  * Return: true if the packet is sent to at least one candidate, false
  * otherwise.
  */
-static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
-				 struct sk_buff *skb, __be32 ip,
-				 unsigned short vid, int packet_subtype)
+static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb, __be32 ip,
+				    unsigned short vid, int packet_subtype)
 {
 	int i;
 	bool ret = false;
@@ -1277,8 +1277,8 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		ret = true;
 	} else {
 		/* Send the request to the DHT */
-		ret = batadv_dat_send_data(bat_priv, skb, ip_dst, vid,
-					   BATADV_P_DAT_DHT_GET);
+		ret = batadv_dat_forward_data(bat_priv, skb, ip_dst, vid,
+					      BATADV_P_DAT_DHT_GET);
 	}
 out:
 	if (dat_entry)
@@ -1392,8 +1392,10 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node obtained from the ARP reply
 	 */
-	batadv_dat_send_data(bat_priv, skb, ip_src, vid, BATADV_P_DAT_DHT_PUT);
-	batadv_dat_send_data(bat_priv, skb, ip_dst, vid, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_forward_data(bat_priv, skb, ip_src, vid,
+				BATADV_P_DAT_DHT_PUT);
+	batadv_dat_forward_data(bat_priv, skb, ip_dst, vid,
+				BATADV_P_DAT_DHT_PUT);
 }
 
 /**
@@ -1708,8 +1710,10 @@ static void batadv_dat_put_dhcp(struct batadv_priv *bat_priv, u8 *chaddr,
 	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid);
 	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
 
-	batadv_dat_send_data(bat_priv, skb, yiaddr, vid, BATADV_P_DAT_DHT_PUT);
-	batadv_dat_send_data(bat_priv, skb, ip_dst, vid, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_forward_data(bat_priv, skb, yiaddr, vid,
+				BATADV_P_DAT_DHT_PUT);
+	batadv_dat_forward_data(bat_priv, skb, ip_dst, vid,
+				BATADV_P_DAT_DHT_PUT);
 
 	consume_skb(skb);
 
-- 
2.20.1

