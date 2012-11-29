Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 29 Nov 2012 01:54:22 +0100
Message-Id: <1354150462-4253-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: don't print the last_seen time
	for bat0 TT local entry
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

bat0 MAC address will never deleted from the local translation table, therefore
printing its last_Seen time is useless and will also produce ugly output and
eventually a variable overflow.

This was introduced by 59cb0861498776c62bd17584c31f34477fa301a0 ("batman-adv:
improve local translation table output")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 1335294..0b29119 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -478,6 +478,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	int last_seen_secs;
 	int last_seen_msecs;
 	unsigned long last_seen_jiffies;
+	bool no_purge;
 
 	primary_if = batadv_seq_print_text_primary_if_get(seq);
 	if (!primary_if)
@@ -504,19 +505,22 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 			last_seen_secs = last_seen_msecs / 1000;
 			last_seen_msecs = last_seen_msecs % 1000;
 
+			no_purge = tt_common_entry->flags &
+				   BATADV_TT_CLIENT_NOPURGE;
+
 			seq_printf(seq, " * %pM [%c%c%c%c%c] %3u.%03u\n",
 				   tt_common_entry->addr,
 				   (tt_common_entry->flags &
 				    BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
-				   (tt_common_entry->flags &
-				    BATADV_TT_CLIENT_NOPURGE ? 'P' : '.'),
+				   no_purge ? 'P' : '.',
 				   (tt_common_entry->flags &
 				    BATADV_TT_CLIENT_NEW ? 'N' : '.'),
 				   (tt_common_entry->flags &
 				    BATADV_TT_CLIENT_PENDING ? 'X' : '.'),
 				   (tt_common_entry->flags &
 				    BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
-				   last_seen_secs, last_seen_msecs);
+				   no_purge ? last_seen_secs : 0,
+				   no_purge ? last_seen_msecs : 0);
 		}
 		rcu_read_unlock();
 	}
-- 
1.8.0

