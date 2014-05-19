Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 19 May 2014 13:50:08 +0200
Message-Id: <1400500208-4250-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Avoid overoptimization of signal
	related check
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
Cc: Sven Eckelmann <sven@narfation.org>

According to C99, it is not safe to use a simple char for checks because the
compiler may optimizes it away when it only gets modified in a signal handler.
It is also undefined when the signal is modifying an object with static
storage duration not from type volatile sig_atomic_t.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ping.c b/ping.c
index c52ad13..bc5184d 100644
--- a/ping.c
+++ b/ping.c
@@ -44,7 +44,7 @@
 #include "debugfs.h"
 
 
-char is_aborted = 0;
+static volatile sig_atomic_t is_aborted = 0;
 
 
 static void ping_usage(void)
-- 
2.0.0.rc2

