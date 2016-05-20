Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 20 May 2016 20:42:19 +0200
Message-Id: <1463769739-3598-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove unused vid local variable
	in tt seq print
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

From: Simon Wunderlich <sw@simonwunderlich.de>

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index bfb90b6..fff1f38 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1006,7 +1006,6 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
-	unsigned short vid;
 	u32 i;
 	int last_seen_secs;
 	int last_seen_msecs;
@@ -1033,7 +1032,6 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 			tt_local = container_of(tt_common_entry,
 						struct batadv_tt_local_entry,
 						common);
-			vid = tt_common_entry->vid;
 			last_seen_jiffies = jiffies - tt_local->last_seen;
 			last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
 			last_seen_secs = last_seen_msecs / 1000;
-- 
2.8.1

