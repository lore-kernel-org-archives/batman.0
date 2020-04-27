Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 3/5] batman-adv: trace: Drop unneeded types.h include
Date: Mon, 27 Apr 2020 17:06:05 +0200
Message-Id: <20200427150607.31401-4-sw@simonwunderlich.de>
In-Reply-To: <20200427150607.31401-1-sw@simonwunderlich.de>
References: <20200427150607.31401-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The commit 04ae87a52074 ("ftrace: Rework event_create_dir()") restructured
various macros in the ftrace framework. These changes also had the nice
side effect that the linux/types.h include is no longer necessary to define
some of the types used by these macros.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/trace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/trace.h b/net/batman-adv/trace.h
index f631b1e01b89..a87547570b4e 100644
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

