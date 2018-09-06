Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri,  7 Sep 2018 05:45:54 +0800
Message-Id: <20180906214555.12272-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: fix backbone_gw
 refcount on queue_work() failure
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

The backbone_gw refcounter is to be decreased by the queued work and
currently is never decreased if the queue_work() call fails.
Fix by checking the queue_work() return value and decrease refcount
if necessary.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bridge_loop_avoidance.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index a2de5a44..58c093ca 100644
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
2.18.0

