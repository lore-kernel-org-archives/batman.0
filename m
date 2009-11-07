Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  7 Nov 2009 13:51:54 +0100
Message-Id: <1257598314-21493-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Remove unknown escape string \{
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net


Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/proc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
index 792a006..aac3df7 100644
--- a/batman-adv-kernelland/proc.c
+++ b/batman-adv-kernelland/proc.c
@@ -541,7 +541,7 @@ static int proc_vis_read(struct seq_file *seq, void *offset)
 		if (current_format == DOT_DRAW) {
 
 			addr_to_string(tmp_addr_str, info->packet.vis_orig);
-			seq_printf(seq, "\tsubgraph \"cluster_%s\" \{\n", tmp_addr_str);
+			seq_printf(seq, "\tsubgraph \"cluster_%s\" {\n", tmp_addr_str);
 			while (if_entries != NULL) {
 
 				addr_to_string(tmp_addr_str, if_entries->addr);
-- 
1.6.5.2

