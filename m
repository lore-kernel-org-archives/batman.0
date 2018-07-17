Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 17 Jul 2018 17:26:46 +0200
Message-Id: <20180717152649.32282-5-sw@simonwunderlich.de>
In-Reply-To: <20180717152649.32282-1-sw@simonwunderlich.de>
References: <20180717152649.32282-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/7] batman-adv: fix checkpatch warning about
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

commit a2d4df9b673c ("spelling.txt: add more spellings to spelling.txt")
introduced the spellcheck of "cache" for checkpatch.pl.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 4229b01ac7b5..95a94160baf8 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -117,7 +117,7 @@ static int batadv_bla_backbone_table_open(struct inode *inode,
 
 #ifdef CONFIG_BATMAN_ADV_DAT
 /**
- * batadv_dat_cache_open() - Prepare file handler for reads from dat_chache
+ * batadv_dat_cache_open() - Prepare file handler for reads from dat_cache
  * @inode: inode which was opened
  * @file: file handle to be initialized
  *
-- 
2.11.0

