Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 03/10] batman-adv: Add missing include for atomic functions
Date: Fri, 28 Jun 2019 15:55:57 +0200
Message-Id: <20190628135604.11581-4-sw@simonwunderlich.de>
In-Reply-To: <20190628135604.11581-1-sw@simonwunderlich.de>
References: <20190628135604.11581-1-sw@simonwunderlich.de>
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

main.h is using atomic_add_unless and log.h atomic_read. The main
header linux/atomic.h should be included for these files.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/log.h  | 1 +
 net/batman-adv/main.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 5504637e63d8..741cfa3719ff 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -9,6 +9,7 @@
 
 #include "main.h"
 
+#include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/printk.h>
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 11d051dbbda4..821a7de45256 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -205,6 +205,7 @@ enum batadv_uev_type {
 
 /* Kernel headers */
 
+#include <linux/atomic.h>
 #include <linux/compiler.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
-- 
2.11.0

