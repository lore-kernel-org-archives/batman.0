Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 15 Dec 2012 19:09:11 +0800
Message-Id: <1355569751-6668-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove unused variable from
	orig_node struct
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 types.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/types.h b/types.h
index 030ce41..441880a 100644
--- a/types.h
+++ b/types.h
@@ -119,7 +119,6 @@ struct batadv_orig_node {
 	spinlock_t ogm_cnt_lock;
 	/* bcast_seqno_lock protects bcast_bits, last_bcast_seqno */
 	spinlock_t bcast_seqno_lock;
-	spinlock_t tt_list_lock; /* protects tt_list */
 	atomic_t bond_candidates;
 	struct list_head bond_list;
 };
-- 
1.7.10.4

