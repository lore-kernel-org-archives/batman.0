Return-Path: <zhangshaokun@hisilicon.com>
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH] batman-adv: Remove the repeated declaration
Date: Fri, 28 May 2021 17:56:25 +0800
Message-ID: <1622195785-55920-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>

Function 'batadv_bla_claim_dump' is declared twice, so remove the
repeated declaration.

Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Antonio Quartulli <a@unstable.cc>
Cc: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 net/batman-adv/bridge_loop_avoidance.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 5c22955bb9d5..8673a265995f 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -52,7 +52,6 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 void batadv_bla_status_update(struct net_device *net_dev);
 int batadv_bla_init(struct batadv_priv *bat_priv);
 void batadv_bla_free(struct batadv_priv *bat_priv);
-int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb);
 #ifdef CONFIG_BATMAN_ADV_DAT
 bool batadv_bla_check_claim(struct batadv_priv *bat_priv, u8 *addr,
 			    unsigned short vid);
-- 
2.7.4

