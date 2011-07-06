Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed,  6 Jul 2011 17:03:57 +0200
Message-Id: <1309964637-23767-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: avoid uninitialized variable when
	compiling bisect
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Reported-by: Max Ip <ipmax2011@googlemail.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bisect.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index f6f171e..d3789aa 100644
--- a/bisect.c
+++ b/bisect.c
@@ -194,7 +194,7 @@ static int routing_table_new(char *orig, char *next_hop, char *old_next_hop, cha
 	struct seqno_event *seqno_event;
 	struct rt_table *rt_table, *prev_rt_table = NULL;
 	struct rt_hist *rt_hist;
-	int i, j;
+	int i, j = -1;
 
 	if (!curr_bat_node) {
 		fprintf(stderr, "Routing table change without preceding OGM - skipping");
@@ -331,7 +331,6 @@ static int routing_table_new(char *orig, char *next_hop, char *old_next_hop, cha
 	}
 
 	if (prev_rt_table) {
-		j = -1;
 		for (i = 0; i < prev_rt_table->num_entries; i++) {
 			/* if we have a previously deleted item don't copy it over */
 			if (prev_rt_table->entries[i].flags == RT_FLAG_DELETE) {
-- 
1.7.5.3

