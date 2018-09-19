Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 19 Sep 2018 14:22:11 +0200
Message-Id: <20180919122213.23108-10-sw@simonwunderlich.de>
In-Reply-To: <20180919122213.23108-1-sw@simonwunderlich.de>
References: <20180919122213.23108-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 09/11] batman-adv: fix backbone_gw refcount
 on queue_work() failure
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Marek Lindner <mareklindner@neomailbox.ch>

The backbone_gw refcounter is to be decreased by the queued work and
currently is never decreased if the queue_work() call fails.
Fix by checking the queue_work() return value and decrease refcount
if necessary.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index ff9659af6b91..5f1aeeded0e3 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1772,6 +1772,7 @@ batadv_bla_loopdetect_check(struct batadv_priv *bat_priv, struct sk_buff *skb,
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
 	struct ethhdr *ethhdr;
+	bool ret;
 
 	ethhdr = eth_hdr(skb);
 
@@ -1795,8 +1796,13 @@ batadv_bla_loopdetect_check(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	if (unlikely(!backbone_gw))
 		return true;
 
-	queue_work(batadv_event_workqueue, &backbone_gw->report_work);
-	/* backbone_gw is unreferenced in the report work function function */
+	ret = queue_work(batadv_event_workqueue, &backbone_gw->report_work);
+
+	/* backbone_gw is unreferenced in the report work function function
+	 * if queue_work() call was successful
+	 */
+	if (!ret)
+		batadv_backbone_gw_put(backbone_gw);
 
 	return true;
 }
-- 
2.11.0

