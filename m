Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  9 Nov 2016 23:25:59 +0100
Message-Id: <20161109222606.29039-11-sw@simonwunderlich.de>
In-Reply-To: <20161109222606.29039-1-sw@simonwunderlich.de>
References: <20161109222606.29039-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 10/17] batman-adv: Count all non-success TX
	packets as dropped
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

A failure during the submission also causes dropped packets.
batadv_interface_tx should therefore also increase the DROPPED counter for
these returns.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 2f0304e..7b3494a 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -386,7 +386,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 			ret = batadv_send_skb_via_tt(bat_priv, skb, dst_hint,
 						     vid);
 		}
-		if (ret == NET_XMIT_DROP)
+		if (ret != NET_XMIT_SUCCESS)
 			goto dropped_freed;
 	}
 
-- 
2.10.1

