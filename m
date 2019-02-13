Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Feb 2019 10:55:04 +0100
Message-Id: <20190213095524.10147-2-sw@simonwunderlich.de>
In-Reply-To: <20190213095524.10147-1-sw@simonwunderlich.de>
References: <20190213095524.10147-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 01/21] batman-adv: fix memory leak in in
 batadv_dat_put_dhcp
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Martin Weinelt <martin@linuxlounge.net>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Martin Weinelt <martin@linuxlounge.net>

batadv_dat_put_dhcp is creating a new ARP packet via
batadv_dat_arp_create_reply and tries to forward it via
batadv_dat_send_data to different peers in the DHT. The original skb is not
consumed by batadv_dat_send_data and thus has to be consumed by the caller.

Fixes: b61ec31c8575 ("batman-adv: Snoop DHCPACKs for DAT")
Signed-off-by: Martin Weinelt <martin@linuxlounge.net>
[sven@narfation.org: add commit message]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 899ab051ffce..310a4f353008 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1711,6 +1711,8 @@ static void batadv_dat_put_dhcp(struct batadv_priv *bat_priv, u8 *chaddr,
 	batadv_dat_send_data(bat_priv, skb, yiaddr, vid, BATADV_P_DAT_DHT_PUT);
 	batadv_dat_send_data(bat_priv, skb, ip_dst, vid, BATADV_P_DAT_DHT_PUT);
 
+	consume_skb(skb);
+
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
 		   "Snooped from outgoing DHCPACK (server address): %pI4, %pM (vid: %i)\n",
 		   &ip_dst, hw_dst, batadv_print_vid(vid));
-- 
2.11.0

