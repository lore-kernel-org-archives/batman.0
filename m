Return-Path: <martin@linuxlounge.net>
From: Martin Weinelt <martin@linuxlounge.net>
Subject: [PATCH] batman-adv: fix memory leak in in batadv_dat_put_dhcp
Date: Wed,  6 Feb 2019 15:39:14 +0100
Message-Id: <20190206143914.4290-1-martin@linuxlounge.net>
Content-Transfer-Encoding: 8bit
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
Cc: Martin Weinelt <martin@linuxlounge.net>, linus.luessing@c0d3.blue

Consume the skb to avoid leaking memory.

Fixes: 1fd1ce2d383f ("batman-adv: Snoop DHCPACKs for DAT")
Signed-off-by: Martin Weinelt <martin@linuxlounge.net>
---
 net/batman-adv/distributed-arp-table.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 899ab051..310a4f35 100644
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
2.20.1

