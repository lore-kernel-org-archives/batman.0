Return-Path: <ordex@ritirata.org>
From: Antonio Quartulli <ordex@ritirata.org>
Date: Tue, 21 Dec 2010 03:03:09 +0100
Message-Id: <1292896989-23680-1-git-send-email-ordex@ritirata.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Modifing hna_local_fill_buffer()
	return value
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

 After changeset 1888, the return value of hna_local_fill_buffer() has
 not been changed to _count_. In this way an eroneous num_hna was
 calculated before sending the new OGM packet.

---
 translation-table.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index a19e16c..a633b5a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -162,7 +162,7 @@ int hna_local_fill_buffer(struct bat_priv *bat_priv,
 		atomic_set(&bat_priv->hna_local_changed, 0);
 
 	spin_unlock_bh(&bat_priv->hna_lhash_lock);
-	return i;
+	return count;
 }
 
 int hna_local_seq_print_text(struct seq_file *seq, void *offset)
-- 
1.7.2.2

