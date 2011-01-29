Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Jan 2011 22:47:28 +0100
Message-Id: <1296337660-12376-2-git-send-email-sven@narfation.org>
In-Reply-To: <1296337660-12376-1-git-send-email-sven@narfation.org>
References: <1296337660-12376-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 01/13] batman-adv: Fix kernel panic when
	fetching vis data on a vis server
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Linus Lüssing <linus.luessing@web.de>

The hash_iterate removal introduced a bug leading to a kernel panic when
fetching the vis data on a vis server. That commit forgot to rename one
variable name, which this commit fixes now.

Reported-by: Russell Senior <russell@personaltelco.net>
Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/vis.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/vis.c b/net/batman-adv/vis.c
index cd4c423..f69a374 100644
--- a/net/batman-adv/vis.c
+++ b/net/batman-adv/vis.c
@@ -268,10 +268,10 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 				buff_pos += sprintf(buff + buff_pos, "%pM,",
 						entry->addr);
 
-				for (i = 0; i < packet->entries; i++)
+				for (j = 0; j < packet->entries; j++)
 					buff_pos += vis_data_read_entry(
 							buff + buff_pos,
-							&entries[i],
+							&entries[j],
 							entry->addr,
 							entry->primary);
 
-- 
1.7.2.3

