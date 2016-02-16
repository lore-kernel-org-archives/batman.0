Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Tue, 16 Feb 2016 10:47:07 +0100
Message-Id: <1455616027-22089-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix integer overflow in
	batadv_iv_ogm_calc_tq
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

The undefined behavior sanatizer detected an signed integer overflow in a
setup with near perfect link quality

    UBSAN: Undefined behaviour in net/batman-adv/bat_iv_ogm.c:1246:25
    signed integer overflow:
    8713350 * 255 cannot be represented in type 'int'

The problems happens because the calculation of mixed unsigned and signed
integers resulted in an integer multiplication.

      batadv_ogm_packet::tq (u8 255)
    * tq_own (u8 255)
    * tq_asym_penalty (int 134; max 255)
    * tq_iface_penalty (int 255; max 255)

The tq_iface_penalty, tq_asym_penalty and inv_asym_penalty can just be
changed to unsigned int because they are not expected to become negative.

Fixes: 46e44fdb96ef ("batman-adv: add WiFi penalty")
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
 net/batman-adv/bat_iv_ogm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index cb2d1b9..b71b57e 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1147,9 +1147,10 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	u8 total_count;
 	u8 orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
 	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
-	int tq_asym_penalty, inv_asym_penalty, if_num, ret = 0;
+	int if_num, ret = 0;
+	unsigned int tq_asym_penalty, inv_asym_penalty;
 	unsigned int combined_tq;
-	int tq_iface_penalty;
+	unsigned int tq_iface_penalty;
 
 	/* find corresponding one hop neighbor */
 	rcu_read_lock();
-- 
2.7.0

