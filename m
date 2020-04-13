Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: trace: Drop unneeded types.h include
Date: Mon, 13 Apr 2020 20:26:07 +0200
Message-Id: <20200413182607.21802-1-sven@narfation.org>
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

The commit 04ae87a52074 ("ftrace: Rework event_create_dir()") restructured
various macros in the ftrace framework. These changes also had the nice
side effect that the linux/types.h include is no longer necessary to define
some of the types used by these macros.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/trace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/trace.h b/net/batman-adv/trace.h
index f631b1e0..a8754757 100644
--- a/net/batman-adv/trace.h
+++ b/net/batman-adv/trace.h
@@ -15,7 +15,6 @@
 #include <linux/percpu.h>
 #include <linux/printk.h>
 #include <linux/tracepoint.h>
-#include <linux/types.h>
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM batadv
-- 
2.20.1

