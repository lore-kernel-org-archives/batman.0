Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  5 Jul 2018 16:57:12 +0200
Message-Id: <20180705145712.22287-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix checkpatch warning about
 misspelled "cache"
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

commit a2d4df9b673c ("spelling.txt: add more spellings to spelling.txt")
introduced the spellcheck of "cache" for checkpatch.pl.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 87479c60..3cb82378 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -118,7 +118,7 @@ static int batadv_bla_backbone_table_open(struct inode *inode,
 
 #ifdef CONFIG_BATMAN_ADV_DAT
 /**
- * batadv_dat_cache_open() - Prepare file handler for reads from dat_chache
+ * batadv_dat_cache_open() - Prepare file handler for reads from dat_cache
  * @inode: inode which was opened
  * @file: file handle to be initialized
  *
-- 
2.11.0

