Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] alfred: vis: Add missing include for ifinfomsg
Date: Thu,  1 Aug 2019 15:54:32 +0200
Message-Id: <20190801135432.28244-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Fixes: 0fc6e6674428 ("alfred: vis: Retrieve hardif status via generic netlink")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vis/vis.c b/vis/vis.c
index 9474563..8df3056 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -10,6 +10,7 @@
 #include <dirent.h>
 #include <errno.h>
 #include <getopt.h>
+#include <linux/rtnetlink.h>
 #include <net/if.h>
 #include <netinet/in.h>
 #include <signal.h>
-- 
2.20.1

