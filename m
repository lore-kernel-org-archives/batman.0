Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:43 +0100
Message-Id: <1417519009-20699-26-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 25/31] batman-adv: types,
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

batadv_orig_bat_iv->bcast_own is actually not a bitfield, it is an
array. Adjust the comment accordingly.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 types.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/types.h b/types.h
index 462a70c0db8f..cd331974321b 100644
--- a/types.h
+++ b/types.h
@@ -181,9 +181,10 @@ struct batadv_orig_node_vlan {
 
 /**
  * struct batadv_orig_bat_iv - B.A.T.M.A.N. IV private orig_node members
- * @bcast_own: bitfield containing the number of our OGMs this orig_node
- *  rebroadcasted "back" to us (relative to last_real_seqno)
- * @bcast_own_sum: counted result of bcast_own
+ * @bcast_own: array containing the number of our OGMs this orig_node
+ *  rebroadcasted "back" to us (relative to last_real_seqno) on each hard
+ *  interface
+ * @bcast_own_sum: sum of bcast_own
  * @ogm_cnt_lock: lock protecting bcast_own, bcast_own_sum,
  *  neigh_node->bat_iv.real_bits & neigh_node->bat_iv.real_packet_count
  */
-- 
2.1.3

