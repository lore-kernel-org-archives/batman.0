Return-Path: <yuzhe@nfschina.com>
From: Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] batman-adv: remove unnecessary type castings
Date: Mon, 25 Apr 2022 04:36:35 -0700
Message-Id: <20220425113635.1609532-1-yuzhe@nfschina.com>
In-Reply-To: <20220421154829.9775-1-yuzhe@nfschina.com>
References: <20220421154829.9775-1-yuzhe@nfschina.com>
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
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, liqiong@nfschina.com, kernel-janitors@vger.kernel.org, Yu Zhe <yuzhe@nfschina.com>

remove unnecessary void* type castings.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 net/batman-adv/translation-table.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8478034d3abf..cbf96eebf05b 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
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
2.25.1

