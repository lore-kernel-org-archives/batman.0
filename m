Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 18 Jun 2015 18:53:24 +0200
Message-Id: <1434646404-19291-6-git-send-email-sven@narfation.org>
In-Reply-To: <1434646404-19291-1-git-send-email-sven@narfation.org>
References: <1434646404-19291-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: Add missing include for
	clear_/set_bit in TT
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

a51fa16ecf3f ("batman-adv: Make TT capability changes atomic") started to
use use clear_bit and set_bit but did not add the include for these
functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 3aca026..ed3ede3 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -19,6 +19,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/compiler.h>
-- 
2.1.4

