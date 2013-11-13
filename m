Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 13 Nov 2013 17:38:02 +0100
Message-Id: <1384360685-366-4-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1384360685-366-1-git-send-email-antonio@meshcoding.com>
References: <1384360685-366-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 3/6] batman-adv: print the new
	BATADV_TT_CLIENT_ISOLA flag
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Print the new BATADV_TT_CLIENT_ISOLA flag properly in the
Local and Global Translation Table output.

The character 'I' is used in the flags column to indicate
that the entry is marked as isolated.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 translation-table.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index ff15099..a18f0d8 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -881,7 +881,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq,
 		   "Locally retrieved addresses (from %s) announced via TT (TTVN: %u):\n",
 		   net_dev->name, (uint8_t)atomic_read(&bat_priv->tt.vn));
-	seq_printf(seq, "       %-13s  %s %-7s %-9s (%-10s)\n", "Client", "VID",
+	seq_printf(seq, "       %-13s  %s %-8s %-9s (%-10s)\n", "Client", "VID",
 		   "Flags", "Last seen", "CRC");
 
 	for (i = 0; i < hash->size; i++) {
@@ -909,7 +909,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 			}
 
 			seq_printf(seq,
-				   " * %pM %4i [%c%c%c%c%c] %3u.%03u   (%#.8x)\n",
+				   " * %pM %4i [%c%c%c%c%c%c] %3u.%03u   (%#.8x)\n",
 				   tt_common_entry->addr,
 				   BATADV_PRINT_VID(tt_common_entry->vid),
 				   (tt_common_entry->flags &
@@ -921,6 +921,8 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 				    BATADV_TT_CLIENT_PENDING ? 'X' : '.'),
 				   (tt_common_entry->flags &
 				    BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
+				   (tt_common_entry->flags &
+				    BATADV_TT_CLIENT_ISOLA ? 'I' : '.'),
 				   no_purge ? 0 : last_seen_secs,
 				   no_purge ? 0 : last_seen_msecs,
 				   vlan->tt.crc);
@@ -1453,13 +1455,14 @@ batadv_tt_global_print_entry(struct batadv_priv *bat_priv,
 
 		last_ttvn = atomic_read(&best_entry->orig_node->last_ttvn);
 		seq_printf(seq,
-			   " %c %pM %4i   (%3u) via %pM     (%3u)   (%#.8x) [%c%c%c]\n",
+			   " %c %pM %4i   (%3u) via %pM     (%3u)   (%#.8x) [%c%c%c%c]\n",
 			   '*', tt_global_entry->common.addr,
 			   BATADV_PRINT_VID(tt_global_entry->common.vid),
 			   best_entry->ttvn, best_entry->orig_node->orig,
 			   last_ttvn, vlan->tt.crc,
 			   (flags & BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
 			   (flags & BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
+			   (flags & BATADV_TT_CLIENT_ISOLA ? 'I' : '.'),
 			   (flags & BATADV_TT_CLIENT_TEMP ? 'T' : '.'));
 
 		batadv_orig_node_vlan_free_ref(vlan);
@@ -1484,13 +1487,14 @@ print_list:
 
 		last_ttvn = atomic_read(&orig_entry->orig_node->last_ttvn);
 		seq_printf(seq,
-			   " %c %pM %4d   (%3u) via %pM     (%3u)   (%#.8x) [%c%c%c]\n",
+			   " %c %pM %4d   (%3u) via %pM     (%3u)   (%#.8x) [%c%c%c%c]\n",
 			   '+', tt_global_entry->common.addr,
 			   BATADV_PRINT_VID(tt_global_entry->common.vid),
 			   orig_entry->ttvn, orig_entry->orig_node->orig,
 			   last_ttvn, vlan->tt.crc,
 			   (flags & BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
 			   (flags & BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
+			   (flags & BATADV_TT_CLIENT_ISOLA ? 'I' : '.'),
 			   (flags & BATADV_TT_CLIENT_TEMP ? 'T' : '.'));
 
 		batadv_orig_node_vlan_free_ref(vlan);
-- 
1.8.4.3

