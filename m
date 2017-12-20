Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 20 Dec 2017 12:01:13 +0100
Message-Id: <20171220110124.13117-9-sw@simonwunderlich.de>
In-Reply-To: <20171220110124.13117-1-sw@simonwunderlich.de>
References: <20171220110124.13117-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 08/19] batman-adv: include build_bug.h for
 BUILD_BUG_ON define
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

commit bc6245e5efd7 ("bug: split BUILD_BUG stuff out into
<linux/build_bug.h>") added a new header for BUILD_BUG_ON. It should
therefore be included instead of linux/bug.h

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c              | 2 +-
 net/batman-adv/tp_meter.c          | 2 +-
 net/batman-adv/translation-table.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 0c3664aa6a58..6f6c500e8aa8 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -19,7 +19,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
-#include <linux/bug.h>
+#include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/crc32c.h>
 #include <linux/errno.h>
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index e33f64f0fcb8..fe9eb2970ec9 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -20,7 +20,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
-#include <linux/bug.h>
+#include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index db40ca6243b3..27a0c34a5ad0 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -21,7 +21,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bitops.h>
-#include <linux/bug.h>
+#include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
-- 
2.11.0

