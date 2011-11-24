Return-Path: <daniele.furlan@gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Date: Thu, 24 Nov 2011 14:06:01 +0100
Message-Id: <1322139961-12706-1-git-send-email-daniele.furlan@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH] Remove useless condition
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

---
 bat_iv_ogm.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index d60e1ba..e4bd54e 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -772,8 +772,7 @@ static int bat_ogm_calc_tq(struct orig_node *orig_node,
 
 	/* if we have too few packets (too less data) we set tq_own to zero */
 	/* if we receive too few packets it is not considered bidirectional */
-	if ((total_count < TQ_LOCAL_BIDRECT_SEND_MINIMUM) ||
-	    (neigh_rq_count < TQ_LOCAL_BIDRECT_RECV_MINIMUM))
+	if (total_count < TQ_LOCAL_BIDRECT_SEND_MINIMUM)
 		tq_own = 0;
 	else
 		/* neigh_node->real_packet_count is never zero as we
-- 
1.7.1

