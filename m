Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon,  1 Feb 2016 14:34:34 +0800
Message-Id: <1454308474-23211-3-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1454308474-23211-1-git-send-email-mareklindner@neomailbox.ch>
References: <1454308474-23211-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCHv2 next 3/3] batman-adv: fix misleading
	default throughput warning
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

BATADV_THROUGHPUT_DEFAULT_VALUE is expressed in multiples of 100kbps. Make
sure the warning text converts it properly.

Fixes: 5c324517 ("ELP - compute the metric based on the estimated throughput")

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bat_v_elp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 461a765..2a6a9a2 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -129,9 +129,10 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 default_throughput:
 	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT)) {
 		batadv_info(hard_iface->soft_iface,
-			    "WiFi driver or ethtool info does not provide information about link speeds on interface %s, therefore defaulting to hardcoded throughput values of %d kbit/s. Consider overriding the throughput manually or checking your driver.\n",
+			    "WiFi driver or ethtool info does not provide information about link speeds on interface %s, therefore defaulting to hardcoded throughput values of %u.%1u Mbps. Consider overriding the throughput manually or checking your driver.\n",
 			    hard_iface->net_dev->name,
-			    BATADV_THROUGHPUT_DEFAULT_VALUE / 10);
+			    BATADV_THROUGHPUT_DEFAULT_VALUE / 10,
+			    BATADV_THROUGHPUT_DEFAULT_VALUE % 10);
 		hard_iface->bat_v.flags |= BATADV_WARNING_DEFAULT;
 	}
 
-- 
2.7.0

