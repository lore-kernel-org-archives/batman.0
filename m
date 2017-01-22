Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 22 Jan 2017 21:40:40 +0100
Message-Id: <20170122204043.29668-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: compat: workaround for
	issues with make-kpkg for 4.5 kernels
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

Currently, batman-adv fails to build for 4.5 kernel headers provided by
Debian's make-kpkg. "make" complains with:

"include/net/sch_generic.h:413:2: error: implicit declaration of
function ‘G_TC_AT’ [-Werror=implicit-function-declaration]"

And:

"include/net/sch_generic.h:413:33: error: ‘AT_INGRESS’ undeclared (first
use in this function)"

The issue seems to be that make-kpkg creates two pkt_cls.h with the same
include guard but differing contents, "uapi/linux/pkt_cls.h" and
"linux/pkt_cls.h". The latter has its "#ifdef __KERNEL__" section
stripped and therefore misses the needed defines.

Depending on the include order, the batman-adv might fail.

This commit provides a workaround by ensuring that the full-blown
uapi variant is included first.

Eventually, the issue should be fixed in make-kpkg and this commit
reverted (no response from the make-kpkg Debian maintainer yet).

For future reference and updates:
* https://www.open-mesh.org/issues/322

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 compat.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/compat.h b/compat.h
index d61a30e..8e23911 100644
--- a/compat.h
+++ b/compat.h
@@ -164,4 +164,13 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(4, 3, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0)
+
+/* workaround for current issues with Debian's make-kpkg */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 5, 0)
+#include <uapi/linux/pkt_cls.h>
+#endif
+
+#endif /* < KERNEL_VERSION(4, 6, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
2.1.4

