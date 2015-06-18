Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 18 Jun 2015 18:53:21 +0200
Message-Id: <1434646404-19291-3-git-send-email-sven@narfation.org>
In-Reply-To: <1434646404-19291-1-git-send-email-sven@narfation.org>
References: <1434646404-19291-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: Add missing include for
	clear_/set_bit in MCAST
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

201a54ba710a ("batman-adv: Make MCAST capability changes atomic") started
to use clear_bit and set_bit but did not add the include for these
functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 2fa9983..b8002a5 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -19,6 +19,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-- 
2.1.4

