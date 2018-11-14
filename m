Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 15:07:52 +0100
Message-Id: <20181114140804.18381-5-sw@simonwunderlich.de>
In-Reply-To: <20181114140804.18381-1-sw@simonwunderlich.de>
References: <20181114140804.18381-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 04/16] batman-adv: Improve includes for trace
 functionality
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

The batadv_dbg trace event uses different functionality and datastructures
which are not directly associated with the trace infrastructure. It should
not be expected that the trace headers indirectly provide them and instead
include the required headers directly.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/trace.c | 2 --
 net/batman-adv/trace.h | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/trace.c b/net/batman-adv/trace.c
index 3d57f9981f25..8e1024217cff 100644
--- a/net/batman-adv/trace.c
+++ b/net/batman-adv/trace.c
@@ -16,7 +16,5 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/module.h>
-
 #define CREATE_TRACE_POINTS
 #include "trace.h"
diff --git a/net/batman-adv/trace.h b/net/batman-adv/trace.h
index 3acda26a30ca..104784be94d7 100644
--- a/net/batman-adv/trace.h
+++ b/net/batman-adv/trace.h
@@ -21,7 +21,13 @@
 
 #include "main.h"
 
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/percpu.h>
+#include <linux/printk.h>
 #include <linux/tracepoint.h>
+#include <linux/types.h>
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM batadv
-- 
2.11.0

