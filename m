Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 18 Apr 2013 04:56:03 +0800
Message-Id: <1366232163-26251-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: do not print orig nodes without
	nc neighbors on nc table print
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 network-coding.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/network-coding.c b/network-coding.c
index c93df9e..b1c733a 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1760,6 +1760,13 @@ int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 		/* For each orig_node in this bin */
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
+			/* no need to print the orig node if it does not have
+			 * network coding neighbors
+			 */
+			if (list_empty(&orig_node->in_coding_list) &&
+			    list_empty(&orig_node->out_coding_list))
+				continue;
+
 			seq_printf(seq, "Node:      %pM\n", orig_node->orig);
 
 			seq_puts(seq, " Ingoing:  ");
-- 
1.7.10.4

