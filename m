Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/2] batman-adv: remove unnecessary type castings
Date: Sun,  8 May 2022 15:26:16 +0200
Message-Id: <20220508132616.21232-3-sw@simonwunderlich.de>
In-Reply-To: <20220508132616.21232-1-sw@simonwunderlich.de>
References: <20220508132616.21232-1-sw@simonwunderlich.de>
MIME-Version: 1.0
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
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Yu Zhe <yuzhe@nfschina.com>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Yu Zhe <yuzhe@nfschina.com>

remove unnecessary void* type castings.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
[sven@narfation.org: Fix missing const in batadv_choose* functions]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c |  4 ++--
 net/batman-adv/translation-table.c     | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 7f8a14d99cdb..37ce6cfb3520 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -65,7 +65,7 @@ batadv_bla_send_announce(struct batadv_priv *bat_priv,
  */
 static inline u32 batadv_choose_claim(const void *data, u32 size)
 {
-	struct batadv_bla_claim *claim = (struct batadv_bla_claim *)data;
+	const struct batadv_bla_claim *claim = data;
 	u32 hash = 0;
 
 	hash = jhash(&claim->addr, sizeof(claim->addr), hash);
@@ -86,7 +86,7 @@ static inline u32 batadv_choose_backbone_gw(const void *data, u32 size)
 	const struct batadv_bla_backbone_gw *gw;
 	u32 hash = 0;
 
-	gw = (struct batadv_bla_backbone_gw *)data;
+	gw = data;
 	hash = jhash(&gw->orig, sizeof(gw->orig), hash);
 	hash = jhash(&gw->vid, sizeof(gw->vid), hash);
 
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8478034d3abf..01d30c1e412c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -103,10 +103,10 @@ static bool batadv_compare_tt(const struct hlist_node *node, const void *data2)
  */
 static inline u32 batadv_choose_tt(const void *data, u32 size)
 {
-	struct batadv_tt_common_entry *tt;
+	const struct batadv_tt_common_entry *tt;
 	u32 hash = 0;
 
-	tt = (struct batadv_tt_common_entry *)data;
+	tt = data;
 	hash = jhash(&tt->addr, ETH_ALEN, hash);
 	hash = jhash(&tt->vid, sizeof(tt->vid), hash);
 
@@ -2766,7 +2766,7 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 	u32 i;
 
 	tt_tot = batadv_tt_entries(tt_len);
-	tt_change = (struct batadv_tvlv_tt_change *)tvlv_buff;
+	tt_change = tvlv_buff;
 
 	if (!valid_cb)
 		return;
@@ -3994,7 +3994,7 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	if (tvlv_value_len < sizeof(*tt_data))
 		return;
 
-	tt_data = (struct batadv_tvlv_tt_data *)tvlv_value;
+	tt_data = tvlv_value;
 	tvlv_value_len -= sizeof(*tt_data);
 
 	num_vlan = ntohs(tt_data->num_vlan);
@@ -4037,7 +4037,7 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 	if (tvlv_value_len < sizeof(*tt_data))
 		return NET_RX_SUCCESS;
 
-	tt_data = (struct batadv_tvlv_tt_data *)tvlv_value;
+	tt_data = tvlv_value;
 	tvlv_value_len -= sizeof(*tt_data);
 
 	tt_vlan_len = sizeof(struct batadv_tvlv_tt_vlan_data);
@@ -4129,7 +4129,7 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 		goto out;
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_ROAM_ADV_RX);
-	roaming_adv = (struct batadv_tvlv_roam_adv *)tvlv_value;
+	roaming_adv = tvlv_value;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received ROAMING_ADV from %pM (client %pM)\n",
-- 
2.30.2

