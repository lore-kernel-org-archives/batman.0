Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Sat,  5 May 2012 17:51:53 +0200
Message-Id: <7f84c7e913b9a0c9a22cc19864c6b7d9e2a347de.1336233103.git.mschiffer@universe-factory.net>
In-Reply-To: <4FA54C09.6000303@universe-factory.net>
References: <4FA54C09.6000303@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix visualization output
	without neighbors on the primary interface
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

The primary entry and the corresponding secondary entries are missing when there
are no neighbors on the primary interface. This also causes the TT entries to
miss and makes nodes with multiply secondary interface fall apart since there
is no way to see they are related without a primary entry.

Fix this by always emitting a primary entry.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 vis.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/vis.c b/vis.c
index cec216f..c515927 100644
--- a/vis.c
+++ b/vis.c
@@ -207,7 +207,6 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 	int vis_server = atomic_read(&bat_priv->vis_mode);
 	size_t buff_pos, buf_size;
 	char *buff;
-	int compare;
 
 	primary_if = primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -228,14 +227,18 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 			entries = (struct vis_info_entry *)
 				((char *)packet + sizeof(*packet));
 
+			vis_data_insert_interface(packet->vis_orig,
+						  &vis_if_list, true);
+
 			for (j = 0; j < packet->entries; j++) {
 				if (entries[j].quality == 0)
 					continue;
-				compare =
-				 compare_eth(entries[j].src, packet->vis_orig);
+				if (compare_eth(entries[j].src,
+						packet->vis_orig))
+					continue;
 				vis_data_insert_interface(entries[j].src,
 							  &vis_if_list,
-							  compare);
+							  false);
 			}
 
 			hlist_for_each_entry(entry, pos, &vis_if_list, list) {
@@ -276,14 +279,18 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 			entries = (struct vis_info_entry *)
 				((char *)packet + sizeof(*packet));
 
+			vis_data_insert_interface(packet->vis_orig,
+						  &vis_if_list, true);
+
 			for (j = 0; j < packet->entries; j++) {
 				if (entries[j].quality == 0)
 					continue;
-				compare =
-				 compare_eth(entries[j].src, packet->vis_orig);
+				if (compare_eth(entries[j].src,
+						packet->vis_orig))
+					continue;
 				vis_data_insert_interface(entries[j].src,
 							  &vis_if_list,
-							  compare);
+							  false);
 			}
 
 			hlist_for_each_entry(entry, pos, &vis_if_list, list) {
-- 
1.7.10.1

