Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Oct 2018 11:30:30 +0200
Message-Id: <20181021093032.19928-4-sven@narfation.org>
In-Reply-To: <20181021093032.19928-1-sven@narfation.org>
References: <20181021093032.19928-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: Improve includes for trace
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
To: b.a.t.m.a.n@lists.open-mesh.org

The batadv_dbg trace event uses different functionality and datastructures
which are not directly associated with the trace infrastructure. It should
not be expected that the trace headers indirectly provide them and instead
include the required headers directly.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/trace.c | 2 --
 net/batman-adv/trace.h | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/trace.c b/net/batman-adv/trace.c
index 3d57f998..8e102421 100644
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
index 3acda26a..104784be 100644
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
2.19.1

