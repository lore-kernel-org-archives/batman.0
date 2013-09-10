Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 Sep 2013 23:12:00 +0200
Message-Id: <1378847522-13776-10-git-send-email-sven@narfation.org>
In-Reply-To: <1378847522-13776-1-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 09/11] batctl: Fix type of new neighbor
	buffer in _seqno_trace_neigh_add
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
Cc: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bisect_iv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect_iv.c b/bisect_iv.c
index eadf427..917ffec 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1041,7 +1041,7 @@ static void seqno_trace_print(struct list_head_first *trace_list, char *trace_or
 static int _seqno_trace_neigh_add(struct seqno_trace_neigh *seqno_trace_mom,
 					struct seqno_trace_neigh *seqno_trace_child)
 {
-	struct seqno_trace_neigh *data_ptr;
+	struct seqno_trace_neigh **data_ptr;
 
 	data_ptr = malloc((seqno_trace_mom->num_neighbors + 1) * sizeof(struct seqno_trace_neigh *));
 	if (!data_ptr)
@@ -1054,7 +1054,7 @@ static int _seqno_trace_neigh_add(struct seqno_trace_neigh *seqno_trace_mom,
 	}
 
 	seqno_trace_mom->num_neighbors++;
-	seqno_trace_mom->seqno_trace_neigh = (void *)data_ptr;
+	seqno_trace_mom->seqno_trace_neigh = data_ptr;
 	seqno_trace_mom->seqno_trace_neigh[seqno_trace_mom->num_neighbors - 1] = seqno_trace_child;
 	return 1;
 }
-- 
1.8.4.rc3

