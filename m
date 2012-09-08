Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat,  8 Sep 2012 18:02:54 +0200
Message-Id: <1347120174-29589-2-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1347120174-29589-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1347120174-29589-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: allow bla traffic only after
	first worker period
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

When adding a backbone gateway for the first time, it might not yet
be known in the backbone, and therefore we should not forward
broadcasts yet. This behaviour is the same as when sending a request
to another backbone gw because of a CRC mismatch. The backbone gw
will operate normal after the next periodic bla work.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index c522bdf..073dd15 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -410,9 +410,14 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, uint8_t *orig,
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
 
@@ -1146,6 +1151,18 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 			backbone_gw->lasttime = jiffies;
 
 			batadv_bla_send_announce(bat_priv, backbone_gw);
+
+			/* request_sent is only set after creation to avoid
+			 * problems when we are not yet known as backbone gw
+			 * in the backbone.
+			 *
+			 * We can reset this now and allow traffic again. */
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
1.7.10

