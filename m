Return-Path: <elfring@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <512d2e7c-0967-9303-2b68-6c9ef53d6ed2@users.sourceforge.net>
Message-ID: <0813673a-a824-5fd7-7388-65d3af475002@users.sourceforge.net>
Date: Sat, 6 May 2017 18:15:36 +0200
MIME-Version: 1.0
In-Reply-To: <512d2e7c-0967-9303-2b68-6c9ef53d6ed2@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Combine two seq_puts() calls
 into one call in batadv_nc_nodes_seq_print_text()
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 6 May 2017 17:57:36 +0200

A bit of text was put into a sequence by two separate function calls.
Print the same data by a single function call instead.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 net/batman-adv/network-coding.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index e1f6fc72fe3e..3604d7899e2c 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1935,9 +1935,7 @@ int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 						list)
 				seq_printf(seq, "%pM ",
 					   nc_node->addr);
-			seq_puts(seq, "\n");
-
-			seq_puts(seq, " Outgoing: ");
+			seq_puts(seq, "\n Outgoing: ");
 			/* For out_nc_node to this orig_node */
 			list_for_each_entry_rcu(nc_node,
 						&orig_node->out_coding_list,
-- 
2.12.2

