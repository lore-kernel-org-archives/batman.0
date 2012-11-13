Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 13 Nov 2012 10:15:33 +0100
Message-Id: <1352798139-19458-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1352798139-19458-1-git-send-email-ordex@autistici.org>
References: <1352798139-19458-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 05/11] batman-adv: allow bla traffic only
	after first worker period
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>

When adding a backbone gateway for the first time, it might not yet
be known in the backbone, and therefore we should not forward
broadcasts yet. This behaviour is the same as when sending a request
to another backbone gw because of a CRC mismatch. The backbone gw
will operate normal after the next periodic bla work.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index d1a817f..77ee47e 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -414,9 +414,14 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, uint8_t *orig,
 		batadv_orig_node_free_ref(orig_node);
 	}
 
-	if (own_backbone)
+	if (own_backbone) {
 		batadv_bla_send_announce(bat_priv, entry);
 
+		/* this will be decreased in the worker thread */
+		atomic_inc(&entry->request_sent);
+		atomic_inc(&bat_priv->bla.num_requests);
+	}
+
 	return entry;
 }
 
@@ -1150,6 +1155,19 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 			backbone_gw->lasttime = jiffies;
 
 			batadv_bla_send_announce(bat_priv, backbone_gw);
+
+			/* request_sent is only set after creation to avoid
+			 * problems when we are not yet known as backbone gw
+			 * in the backbone.
+			 *
+			 * We can reset this now and allow traffic again.
+			 */
+
+			if (atomic_read(&backbone_gw->request_sent) == 0)
+				continue;
+
+			atomic_dec(&backbone_gw->bat_priv->bla.num_requests);
+			atomic_set(&backbone_gw->request_sent, 0);
 		}
 		rcu_read_unlock();
 	}
-- 
1.8.0

