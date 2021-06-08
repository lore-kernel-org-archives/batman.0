Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 07/11] batman-adv: Fix spelling mistakes
Date: Tue,  8 Jun 2021 17:26:56 +0200
Message-Id: <20210608152700.30315-8-sw@simonwunderlich.de>
In-Reply-To: <20210608152700.30315-1-sw@simonwunderlich.de>
References: <20210608152700.30315-1-sw@simonwunderlich.de>
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Zheng Yongjun <zhengyongjun3@huawei.com>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Zheng Yongjun <zhengyongjun3@huawei.com>

Fix some spelling mistakes in comments:
containg  ==> containing
dont  ==> don't
datas  ==> data
brodcast  ==> broadcast

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 4 ++--
 net/batman-adv/hard-interface.c        | 2 +-
 net/batman-adv/hash.h                  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 7dc133cfc363..63d42dcc9324 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -395,7 +395,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
 		break;
 	case BATADV_CLAIM_TYPE_ANNOUNCE:
 		/* announcement frame
-		 * set HW SRC to the special mac containg the crc
+		 * set HW SRC to the special mac containing the crc
 		 */
 		ether_addr_copy(hw_src, mac);
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
@@ -1040,7 +1040,7 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 	/* lets see if this originator is in our mesh */
 	orig_node = batadv_orig_hash_find(bat_priv, backbone_addr);
 
-	/* dont accept claims from gateways which are not in
+	/* don't accept claims from gateways which are not in
 	 * the same mesh or group.
 	 */
 	if (!orig_node)
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 4a6a25d551a8..b99f64f483fc 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -403,7 +403,7 @@ int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
 		goto out;
 	}
 
-	/* >1 neighbors -> (re)brodcast */
+	/* >1 neighbors -> (re)broadcast */
 	if (rcu_dereference(hlist_next_rcu(first)))
 		goto out;
 
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 46696759f194..fb251c385a1b 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -18,7 +18,7 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
-/* callback to a compare function.  should compare 2 element datas for their
+/* callback to a compare function.  should compare 2 element data for their
  * keys
  *
  * Return: true if same and false if not same
-- 
2.20.1

