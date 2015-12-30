Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 30 Dec 2015 19:35:36 +0100
Message-Id: <1451500536-32028-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Fix typo "preferrably"
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 man/batctl.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/batctl.8 b/man/batctl.8
index 73d15e7..e804a08 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -186,7 +186,7 @@ Example 3: 16 or 0x0F
 .IP
 The batman-adv kernel module comes with a variety of debug tables containing various information about the state of the mesh
 seen by each individual node. These tables are exported via debugfs and easily accessible via batctl. You will need debugfs
-support compiled into your kernel and preferrably have mounted the debugfs to a well-known mountpoint. If debugfs is not
+support compiled into your kernel and preferably have mounted the debugfs to a well-known mountpoint. If debugfs is not
 mounted batctl will attempt to do this step for you.
 
 All of the debug tables support the following options:
-- 
2.6.4

