Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/4] batman-adv: Drop unused headers in trace.h
Date: Fri, 16 Sep 2022 18:14:52 +0200
Message-Id: <20220916161454.1413154-3-sw@simonwunderlich.de>
In-Reply-To: <20220916161454.1413154-1-sw@simonwunderlich.de>
References: <20220916161454.1413154-1-sw@simonwunderlich.de>
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
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The commit 9abc291812d7 ("batman-adv: tracing: Use the new __vstring()
helper") removed the usage of WARN_ON_ONCE and __dynamic_array in this
file. But it was forgotten to adjust the headers accordingly (dropping the
now no longer used ones).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/trace.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/batman-adv/trace.h b/net/batman-adv/trace.h
index 31c8f922651d..5dd52bc5cabb 100644
--- a/net/batman-adv/trace.h
+++ b/net/batman-adv/trace.h
@@ -9,8 +9,6 @@
 
 #include "main.h"
 
-#include <linux/bug.h>
-#include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/percpu.h>
 #include <linux/printk.h>
-- 
2.30.2

