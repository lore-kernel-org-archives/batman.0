Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 23 Sep 2012 17:16:03 +0800
Message-Id: <1348391763-16924-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201209231715.28695.lindner_marek@yahoo.de>
References: <201209231715.28695.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Fix symmetry check / route
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

From: Linus Lüssing <linus.luessing@web.de>

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
 bat_iv_ogm.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 7f0adad..75403a4 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -657,6 +657,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *router = NULL;
 	struct batadv_orig_node *orig_node_tmp;
 	struct hlist_node *node;
+	int if_num;
 	uint8_t sum_orig, sum_neigh;
 	uint8_t *neigh_addr;
 	uint8_t tq_avg;
@@ -743,12 +744,14 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	if (router && (neigh_node->tq_avg == router->tq_avg)) {
 		orig_node_tmp = router->orig_node;
 		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
-		sum_orig = orig_node_tmp->bcast_own_sum[if_incoming->if_num];
+		if_num = router->if_incoming->if_num;
+		sum_orig = orig_node_tmp->bcast_own_sum[if_num];
 		spin_unlock_bh(&orig_node_tmp->ogm_cnt_lock);
 
 		orig_node_tmp = neigh_node->orig_node;
 		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
-		sum_neigh = orig_node_tmp->bcast_own_sum[if_incoming->if_num];
+		if_num = neigh_node->if_incoming->if_num;
+		sum_neigh = orig_node_tmp->bcast_own_sum[if_num];
 		spin_unlock_bh(&orig_node_tmp->ogm_cnt_lock);
 
 		if (sum_orig >= sum_neigh)
-- 
1.7.9.1

