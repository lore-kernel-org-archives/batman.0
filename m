Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 14 Aug 2015 22:57:06 +0200
Message-Id: <1439585834-26564-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1439585834-26564-1-git-send-email-antonio@meshcoding.com>
References: <1439585834-26564-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 02/10] batman-adv: Avoid u32 overflow during
	gateway select
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
Cc: Ruben Wisniewsi <ruben@vfn-nrw.de>, Marek Lindner <mareklindner@neomailbox.ch>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>

From: Ruben Wisniewski <ruben@freifunk-nrw.de>

The gateway selection based on fast connections is using a single value
calculated from the average tq (0-255) and the download bandwidth (in
100Kibit). The formula for the first step (tq ** 2 * 10000 * bandwidth)
tends to overflow a u32 with low bandwidth settings like 50 [100KiBit]
and a tq value of over 92.

Changing this to a 64 bit unsigned integer allows to support a
bandwidth_down with up to ~2.8e10 [100KiBit] and a perfect tq of 255. This
is ~6.6 times higher than the maximum possible value of the gateway
announcement TVLV.

This problem only affects the non-default gw_sel_class 1.

Signed-off-by: Ruben Wisniewsi <ruben@vfn-nrw.de>
[sven@narfation.org: rewritten commit message]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/gateway_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index e1e1f31..4ac24d8 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -153,7 +153,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 	struct batadv_neigh_node *router;
 	struct batadv_neigh_ifinfo *router_ifinfo;
 	struct batadv_gw_node *gw_node, *curr_gw = NULL;
-	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
+	uint64_t max_gw_factor = 0, tmp_gw_factor = 0;
 	uint8_t max_tq = 0;
 	uint8_t tq_avg;
 	struct batadv_orig_node *orig_node;
-- 
2.5.0

