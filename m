Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 15 Sep 2012 23:51:46 +0200
Message-Id: <1347745906-12749-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix symmetry check / route
	flapping in multi interface setups
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

If receiving an OGM from a neighbor other than the currently selected
and if it has the same TQ then we are supposed to switch if this
neighbor provides a more symmetric link than the currently selected one.

However this symmetry check currently is broken if the interface of the
neighbor we received the OGM from and the one of the currently selected
neighbor differ: We are currently trying to determine the symmetry of the
link towards the selected router via the link we received the OGM from
instead of just checking via the link towards the currently selected
router.

This leads to way more route switches than necessary and can lead to
permanent route flapping in many common multi interface setups.

This patch fixes this issue by using the right interface for this
symmetry check.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
This fixes the route flapping observed in ticket 163 (but unfortunately
doesn't fix the main issue of this ticket, the starving routes, yet).

 bat_iv_ogm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 7f0adad..2c6b560 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -743,7 +743,8 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	if (router && (neigh_node->tq_avg == router->tq_avg)) {
 		orig_node_tmp = router->orig_node;
 		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
-		sum_orig = orig_node_tmp->bcast_own_sum[if_incoming->if_num];
+		sum_orig = orig_node_tmp->
+				bcast_own_sum[router->if_incoming->if_num];
 		spin_unlock_bh(&orig_node_tmp->ogm_cnt_lock);
 
 		orig_node_tmp = neigh_node->orig_node;
-- 
1.7.10.4

