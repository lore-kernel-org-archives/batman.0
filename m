Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Mar 2016 12:40:55 +0100
Message-Id: <1458474055-9857-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: Update compatible kernel
	version number
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

batman-adv currently only builds against official kernels >= 3.2. Older
kernels (>= 2.6.29) have only incomplete compat(-include) support which
will not be extended anymore.

The next release will also share mostly the same code as kernel 4.6 and
thus by definition is compatible with Linux 4.6.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README.external | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.external b/README.external
index 833ece7..b89ce36 100644
--- a/README.external
+++ b/README.external
@@ -6,7 +6,7 @@ and as external module. The external  module   allows   to    get
 new    features without  upgrading  to  a  newer  kernel  version
 and to get batman-adv specific bugfixes  for  kernels  that   are
 not   supported   anymore.  It compiles  against  and should work
-with Linux 2.6.29 -   4.5.  Supporting  older  versions  is  not
+with Linux 3.2 -   4.6.  Supporting   older   versions   is   not
 planned,  but it's probably easy to backport it. If you work on a
 backport, feel free to contact us.  :-)
 
-- 
2.8.0.rc3

