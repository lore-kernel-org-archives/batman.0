Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri,  7 Sep 2018 05:45:55 +0800
Message-Id: <20180906214555.12272-2-mareklindner@neomailbox.ch>
In-Reply-To: <20180906214555.12272-1-mareklindner@neomailbox.ch>
References: <20180906214555.12272-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: fix hardif_neigh
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

The hardif_neigh refcounter is to be decreased by the queued work and
currently is never decreased if the queue_work() call fails.
Fix by checking the queue_work() return value and decrease refcount
if necessary.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bat_v_elp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index e103c759..9f481cfd 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -268,6 +268,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 	struct batadv_priv *bat_priv;
 	struct sk_buff *skb;
 	u32 elp_interval;
+	bool ret;
 
 	bat_v = container_of(work, struct batadv_hard_iface_bat_v, elp_wq.work);
 	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
@@ -329,8 +330,11 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 		 * may sleep and that is not allowed in an rcu protected
 		 * context. Therefore schedule a task for that.
 		 */
-		queue_work(batadv_event_workqueue,
-			   &hardif_neigh->bat_v.metric_work);
+		ret = queue_work(batadv_event_workqueue,
+				 &hardif_neigh->bat_v.metric_work);
+
+		if (!ret)
+			batadv_hardif_neigh_put(hardif_neigh);
 	}
 	rcu_read_unlock();
 
-- 
2.18.0

