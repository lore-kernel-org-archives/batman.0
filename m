Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 22 Aug 2013 09:21:12 +0200
Message-Id: <1377156073-556-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1377156073-556-1-git-send-email-ordex@autistici.org>
References: <1377156073-556-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: fix ARP header parsing in DAT
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
Cc: Antonio Quartulli <ordex@autistici.org>

In case of VLAN packets flowing into the DAT module, the
parsing routines have to consider the correct header size
when accessing an ARP packet.

Introduced by: 3e26722bc9f248ec4316749fc1957365c0fa5e4b
("batman-adv: make the Distributed ARP Table vlan aware")

Reported-by: Marco Dalla Torre <marco.dallato@gmail.com>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Tested-by: Marco Dalla Torre <marco.dallato@gmail.com>
---
 distributed-arp-table.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index c825d76..6eb1ce3 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -922,11 +922,12 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	if (type != ARPOP_REQUEST)
 		goto out;
 
-	batadv_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REQUEST");
+	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
+		       "Parsing outgoing ARP REQUEST");
 
-	ip_src = batadv_arp_ip_src(skb, 0);
-	hw_src = batadv_arp_hw_src(skb, 0);
-	ip_dst = batadv_arp_ip_dst(skb, 0);
+	ip_src = batadv_arp_ip_src(skb, hdr_size);
+	hw_src = batadv_arp_hw_src(skb, hdr_size);
+	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
 	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
 
@@ -956,7 +957,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		skb_new->protocol = eth_type_trans(skb_new,
 						   bat_priv->soft_iface);
 		bat_priv->stats.rx_packets++;
-		bat_priv->stats.rx_bytes += skb->len + ETH_HLEN;
+		bat_priv->stats.rx_bytes += skb->len + ETH_HLEN + hdr_size;
 		bat_priv->soft_iface->last_rx = jiffies;
 
 		netif_rx(skb_new);
@@ -1069,7 +1070,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	if (type != ARPOP_REPLY)
 		return;
 
-	batadv_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REPLY");
+	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
+		       "Parsing outgoing ARP REPLY");
 
 	hw_src = batadv_arp_hw_src(skb, hdr_size);
 	ip_src = batadv_arp_ip_src(skb, hdr_size);
-- 
1.8.1.5

