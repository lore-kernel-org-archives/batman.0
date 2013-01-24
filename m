Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 24 Jan 2013 11:38:35 +0100
Message-Id: <1359023915-31358-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix local translation output
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

The last-seen field has to be print for all the entries but the one marked as
no-purge.

Introduced by 15727323d9f8864b2d41930940acc38de987045a
("batman-adv: don't print the last_seen time for bat0 TT local entry")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index fb15b4c..d44672f 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -517,8 +517,8 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 				    BATADV_TT_CLIENT_PENDING ? 'X' : '.'),
 				   (tt_common_entry->flags &
 				    BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
-				   no_purge ? last_seen_secs : 0,
-				   no_purge ? last_seen_msecs : 0);
+				   no_purge ? 0 : last_seen_secs,
+				   no_purge ? 0 : last_seen_msecs);
 		}
 		rcu_read_unlock();
 	}
-- 
1.8.1.1

