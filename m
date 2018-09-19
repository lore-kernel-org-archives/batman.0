Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 19 Sep 2018 14:22:03 +0200
Message-Id: <20180919122213.23108-2-sw@simonwunderlich.de>
In-Reply-To: <20180919122213.23108-1-sw@simonwunderlich.de>
References: <20180919122213.23108-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 01/11] batman-adv: Avoid probe ELP
 information leak
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The probe ELPs for WiFi interfaces are expanded to contain at least
BATADV_ELP_MIN_PROBE_SIZE bytes. This is usually a lot more than the
number of bytes which the template ELP packet requires.

These extra padding bytes were not initialized and thus could contain data
which were previously stored at the same location. It is therefore required
to set it to some predefined or random values to avoid leaking private
information from the system transmitting these kind of packets.

Fixes: e4623c913508 ("batman-adv: Avoid probe ELP information leak")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 71c20c1d4002..e103c759b7ab 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -241,7 +241,7 @@ batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
 		 * the packet to be exactly of that size to make the link
 		 * throughput estimation effective.
 		 */
-		skb_put(skb, probe_len - hard_iface->bat_v.elp_skb->len);
+		skb_put_zero(skb, probe_len - hard_iface->bat_v.elp_skb->len);
 
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Sending unicast (probe) ELP packet on interface %s to %pM\n",
-- 
2.11.0

