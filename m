Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:07:48 +0100
Message-Id: <20170122120749.27932-3-sven@narfation.org>
In-Reply-To: <2527763.cX7mnL5d4j@sven-edge>
References: <2527763.cX7mnL5d4j@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batctl: ping: Use sig_atomic_t variable
	to stop ping
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

The variable used in the signal handlers of ping is currently only a
char. It is shared with the main routine which checks if the ping should be
stopped or not. But the standard defines that such a variable must be
volatile sig_atomic_t or a lock-free atomic object.

The volatile definition avoids that the compiler must not assume that this
object can be cached. sig_atomic_t will make sure that this object is
atomically accessible in asynchronous interrupts. Not using these types
could result in an "unstoppable" ping.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ping.c b/ping.c
index 4fef663..7e5c6fc 100644
--- a/ping.c
+++ b/ping.c
@@ -45,7 +45,7 @@
 #include "icmp_helper.h"
 
 
-char is_aborted = 0;
+static volatile sig_atomic_t is_aborted = 0;
 
 
 static void ping_usage(void)
-- 
2.11.0

