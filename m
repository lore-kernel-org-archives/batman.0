Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sun, 25 Sep 2016 08:46:36 +0800
Message-Id: <20160925004636.11334-1-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove unsed argument from
	batadv_dbg_arp() function
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
Cc: Antonio Quartulli <a@unstable.cc>

The argument "type" passed to the batadv_dbg_arp() function is
never used. Remove it.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/distributed-arp-table.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index e257efd..cbb4f32 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -369,12 +369,11 @@ out:
  * batadv_dbg_arp - print a debug message containing all the ARP packet details
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: ARP packet
- * @type: ARP type
  * @hdr_size: size of the possible header before the ARP packet
  * @msg: message to print together with the debugging information
  */
 static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
-			   u16 type, int hdr_size, char *msg)
+			   int hdr_size, char *msg)
 {
 	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
 	struct batadv_bcast_packet *bcast_pkt;
@@ -441,7 +440,7 @@ static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
 #else
 
 static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
-			   u16 type, int hdr_size, char *msg)
+			   int hdr_size, char *msg)
 {
 }
 
@@ -983,8 +982,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	if (type != ARPOP_REQUEST)
 		goto out;
 
-	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
-		       "Parsing outgoing ARP REQUEST");
+	batadv_dbg_arp(bat_priv, skb, hdr_size, "Parsing outgoing ARP REQUEST");
 
 	ip_src = batadv_arp_ip_src(skb, hdr_size);
 	hw_src = batadv_arp_hw_src(skb, hdr_size);
@@ -1075,8 +1073,7 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	ip_src = batadv_arp_ip_src(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
-	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
-		       "Parsing incoming ARP REQUEST");
+	batadv_dbg_arp(bat_priv, skb, hdr_size, "Parsing incoming ARP REQUEST");
 
 	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
 
@@ -1149,8 +1146,7 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	if (type != ARPOP_REPLY)
 		return;
 
-	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
-		       "Parsing outgoing ARP REPLY");
+	batadv_dbg_arp(bat_priv, skb, hdr_size, "Parsing outgoing ARP REPLY");
 
 	hw_src = batadv_arp_hw_src(skb, hdr_size);
 	ip_src = batadv_arp_ip_src(skb, hdr_size);
@@ -1195,8 +1191,7 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	if (type != ARPOP_REPLY)
 		goto out;
 
-	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
-		       "Parsing incoming ARP REPLY");
+	batadv_dbg_arp(bat_priv, skb, hdr_size, "Parsing incoming ARP REPLY");
 
 	hw_src = batadv_arp_hw_src(skb, hdr_size);
 	ip_src = batadv_arp_ip_src(skb, hdr_size);
-- 
2.10.0

