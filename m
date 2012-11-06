Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  6 Nov 2012 14:14:01 +0100
Message-Id: <1352207643-11274-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: print the CRC together with
	the translation tables
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

To simplify debugging operations, it is better to print the related
CRC together with the translation table (local CRC for the local
table and global CRC for each entry in the global table)

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

** this patches are based on top of master

 translation-table.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 6fecb94..b14f418 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -481,8 +481,9 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	seq_printf(seq,
-		   "Locally retrieved addresses (from %s) announced via TT (TTVN: %u):\n",
-		   net_dev->name, (uint8_t)atomic_read(&bat_priv->tt.vn));
+		   "Locally retrieved addresses (from %s) announced via TT (TTVN: %u CRC: %#.4x):\n",
+		   net_dev->name, (uint8_t)atomic_read(&bat_priv->tt.vn),
+		   bat_priv->tt.local_crc);
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -968,10 +969,11 @@ batadv_tt_global_print_entry(struct batadv_tt_global_entry *tt_global_entry,
 	best_entry = batadv_transtable_best_orig(tt_global_entry);
 	if (best_entry) {
 		last_ttvn = atomic_read(&best_entry->orig_node->last_ttvn);
-		seq_printf(seq,	" %c %pM  (%3u) via %pM     (%3u)   [%c%c%c]\n",
+		seq_printf(seq,
+			   " %c %pM  (%3u) via %pM     (%3u)   (%#.4x) [%c%c%c]\n",
 			   '*', tt_global_entry->common.addr,
 			   best_entry->ttvn, best_entry->orig_node->orig,
-			   last_ttvn,
+			   last_ttvn, best_entry->orig_node->tt_crc,
 			   (flags & BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
 			   (flags & BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
 			   (flags & BATADV_TT_CLIENT_TEMP ? 'T' : '.'));
@@ -1013,8 +1015,9 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq,
 		   "Globally announced TT entries received via the mesh %s\n",
 		   net_dev->name);
-	seq_printf(seq, "       %-13s %s       %-15s %s %s\n",
-		   "Client", "(TTVN)", "Originator", "(Curr TTVN)", "Flags");
+	seq_printf(seq, "       %-13s %s       %-15s %s (%-6s) %s\n",
+		   "Client", "(TTVN)", "Originator", "(Curr TTVN)", "CRC",
+		   "Flags");
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
-- 
1.8.0

