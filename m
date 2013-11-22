Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 22 Nov 2013 13:30:24 +0100
Message-Id: <1385123427-15460-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: fix multiline comment
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

This problem was introduced by commit
9bb33b8d88e318c4879d37d06ad28e3e018b9036
("batman-adv: split tq information in neigh_node struct")

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 main.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/main.h b/main.h
index 09cdebb..d154d4d 100644
--- a/main.h
+++ b/main.h
@@ -71,7 +71,8 @@
 
 /* default interface for multi interface operation. The default interface is
  * used for communication which originated locally (i.e. is not forwarded)
- * or where special forwarding is not desired/necessary. */
+ * or where special forwarding is not desired/necessary.
+ */
 #define BATADV_IF_DEFAULT	((struct batadv_hard_iface *)NULL)
 
 #define BATADV_NUM_WORDS BITS_TO_LONGS(BATADV_TQ_LOCAL_WINDOW_SIZE)
-- 
1.7.10.4

