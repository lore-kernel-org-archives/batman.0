Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed,  3 Jun 2015 16:14:03 +0200
Message-Id: <1433340848-1682-8-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1433340848-1682-1-git-send-email-antonio@meshcoding.com>
References: <1433340848-1682-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 07/12] batman-adv: types,
	Fix comment on bcast_own
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Markus Pargmann <mpa@pengutronix.de>

batadv_orig_bat_iv->bcast_own is actually not a bitfield, it is an
array. Adjust the comment accordingly.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/types.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index e95db42..c1000c0 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -183,9 +183,10 @@ struct batadv_orig_node_vlan {
 
 /**
  * struct batadv_orig_bat_iv - B.A.T.M.A.N. IV private orig_node members
- * @bcast_own: bitfield containing the number of our OGMs this orig_node
- *  rebroadcasted "back" to us (relative to last_real_seqno)
- * @bcast_own_sum: counted result of bcast_own
+ * @bcast_own: set of bitfields (one per hard interface) where each one counts
+ * the number of our OGMs this orig_node rebroadcasted "back" to us  (relative
+ * to last_real_seqno). Every bitfield is BATADV_TQ_LOCAL_WINDOW_SIZE bits long.
+ * @bcast_own_sum: sum of bcast_own
  * @ogm_cnt_lock: lock protecting bcast_own, bcast_own_sum,
  *  neigh_node->bat_iv.real_bits & neigh_node->bat_iv.real_packet_count
  */
-- 
2.4.2

