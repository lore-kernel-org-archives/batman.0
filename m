Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jul 2016 21:04:01 +0200
Message-Id: <1468782245-12985-2-git-send-email-sven@narfation.org>
In-Reply-To: <1468782245-12985-1-git-send-email-sven@narfation.org>
References: <1468782245-12985-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/6] batman-adv: Count all non-success TX
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
To: b.a.t.m.a.n@lists.open-mesh.org

A failure during the submission also causes dropped packets.
batadv_interface_tx should therefore also increase the DROPPED counter for
these returns.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index cb5b966..5cf41e7 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -365,7 +365,7 @@ send:
 			ret = batadv_send_skb_via_tt(bat_priv, skb, dst_hint,
 						     vid);
 		}
-		if (ret == NET_XMIT_DROP)
+		if (ret != NET_XMIT_SUCCESS)
 			goto dropped_freed;
 	}
 
-- 
2.8.1

