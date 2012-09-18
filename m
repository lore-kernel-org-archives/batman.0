Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Tue, 18 Sep 2012 03:01:08 +0200
Message-Id: <1347930068-7045-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <20120916101250.GA7087@ritirata.org>
References: <20120916101250.GA7087@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Fix symmetry check / route
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
 bat_iv_ogm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 7f0adad..a92a663 100644
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
@@ -743,7 +744,8 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	if (router && (neigh_node->tq_avg == router->tq_avg)) {
 		orig_node_tmp = router->orig_node;
 		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
-		sum_orig = orig_node_tmp->bcast_own_sum[if_incoming->if_num];
+		if_num = router->if_incoming->if_num;
+		sum_orig = orig_node_tmp->bcast_own_sum[if_num];
 		spin_unlock_bh(&orig_node_tmp->ogm_cnt_lock);
 
 		orig_node_tmp = neigh_node->orig_node;
-- 
1.7.10.4

