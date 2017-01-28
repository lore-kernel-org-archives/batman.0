Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 28 Jan 2017 11:56:51 +0100
Message-Id: <20170128105651.3061-3-sw@simonwunderlich.de>
In-Reply-To: <20170128105651.3061-1-sw@simonwunderlich.de>
References: <20170128105651.3061-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix includes for
	IS_ERR/ERR_PTR
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

IS_ERR/ERR_PTR are not defined in linux/device.h but in linux/err.h. The
files using these macros therefore have to include the correct one.

Reported-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/debugfs.c  | 2 +-
 net/batman-adv/tp_meter.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 5406148b9497..e32ad47c6efd 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -19,7 +19,7 @@
 #include "main.h"
 
 #include <linux/debugfs.h>
-#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/fs.h>
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 07f64b60b528..c94ebdecdc3d 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -23,7 +23,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
-#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/etherdevice.h>
 #include <linux/fs.h>
 #include <linux/if_ether.h>
-- 
2.11.0

