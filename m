Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 19 Nov 2016 14:35:26 +0100
Message-Id: <20161119133528.1379-7-sw@simonwunderlich.de>
In-Reply-To: <20161119133528.1379-1-sw@simonwunderlich.de>
References: <20161119133528.1379-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/8] batman-adv: Update wifi flags on upper
	link change
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven.eckelmann@open-mesh.com>

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Things like VLANs don't have their link set when they are created. Thus
the wifi flags have to be evaluated later to fix their contents for the
link interface.

Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index ca743a5..61a431a 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -1006,6 +1006,11 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		if (hard_iface == primary_if)
 			batadv_primary_if_update_addr(bat_priv, NULL);
 		break;
+	case NETDEV_CHANGEUPPER:
+		hard_iface->wifi_flags = batadv_wifi_flags_evaluate(net_dev);
+		if (batadv_is_wifi_hardif(hard_iface))
+			hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
+		break;
 	default:
 		break;
 	}
-- 
2.10.2

