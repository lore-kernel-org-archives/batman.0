Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Jun 2014 18:33:43 +0200
Message-Id: <1402590823-3605-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Force \0 termination of string in
	bisect_iv
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

This is a part of patch 4faf653307789150f1d40383e95c85a086630378 ("batctl:
Force null termination of string after strncpy") but was forgotten before it
was submitted to the maintainers.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bisect_iv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bisect_iv.c b/bisect_iv.c
index e5efb89..b748813 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -365,6 +365,7 @@ static int routing_table_new(char *orig, char *next_hop, char *old_next_hop, cha
 	if ((rt_table->num_entries == 1) || (rt_table->num_entries != j + 1)) {
 		i = rt_table->num_entries;
 		strncpy(rt_table->entries[i - 1].orig, orig, NAME_LEN);
+		rt_table->entries[i - 1].orig[NAME_LEN - 1] = '\0';
 		rt_table->entries[i - 1].next_hop = next_hop_node;
 		rt_table->entries[i - 1].flags = rt_flag;
 	}
-- 
2.0.0

