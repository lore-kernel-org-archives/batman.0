Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Jun 2016 10:43:20 +0200
Message-Id: <1465721000-9174-2-git-send-email-sven@narfation.org>
In-Reply-To: <1465721000-9174-1-git-send-email-sven@narfation.org>
References: <1465721000-9174-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Use broadcast as fallback
	for gateway replies
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

The replies from gateway server to gateway client are usually sent via
unicast packets. This only works when the destination address for the reply
is already known to the translation table. But usually the gateway replies
are in response to the first known contact from a device to the gateway
server. So it can happen that the TT entry was not yet created.

The gateway server has therefore use broadcast as fallback when the entry
is not yet known. This makes the first responses from a DHCP server to a
DHCP client more robust.

Fixes: 2d5b555644b2 ("batman-adv: send every DHCP packet as bat-unicast")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 216ac03..5829695 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -297,6 +297,18 @@ send:
 			if (forw_mode == BATADV_FORW_SINGLE)
 				do_bcast = false;
 		}
+
+		/* DHCP to from server to client should use unicast when TT
+		 * entry is available and use broadcast as fallback
+		 */
+		if (!mcast_single_orig && dhcp_rcp == BATADV_DHCP_TO_CLIENT) {
+			mcast_single_orig = batadv_transtable_search(bat_priv,
+								     NULL,
+								     dst_hint,
+								     vid);
+			if (!mcast_single_orig)
+				do_bcast = true;
+		}
 	}
 
 	batadv_skb_set_priority(skb, 0);
-- 
2.8.1

