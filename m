Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: Drop workaround for Debian's make-kpkg
Date: Fri, 31 Jan 2020 13:40:50 +0100
Message-Id: <20200131124050.4984-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The make-kpkg is a Debian specific tool to create a debian kernel package.
It is not really maintained anymore and also not used to build the official
Debian kernel packages.

The correct way to have a kernel package under Debian is either to use the
offical packages from the Debian main repository or to build them using the
Linux make target deb-pkg.

There is no reason to ship this workaround when Debian isn't even shipping
make-kpkg with Debian buster and also not in the current Debian bullseye
development snapshot.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/compat.h b/compat.h
index b915d914..21bacc5d 100644
--- a/compat.h
+++ b/compat.h
@@ -28,15 +28,6 @@
 
 #endif /* LINUX_VERSION_IS_LESS(4, 3, 0) */
 
-#if LINUX_VERSION_IS_LESS(4, 6, 0)
-
-/* workaround for current issues with Debian's make-kpkg */
-#if LINUX_VERSION_IS_GEQ(4, 5, 0)
-#include <uapi/linux/pkt_cls.h>
-#endif
-
-#endif /* LINUX_VERSION_IS_LESS(4, 6, 0) */
-
 #if LINUX_VERSION_IS_LESS(4, 15, 0)
 
 #define batadv_softif_slave_add(__dev, __slave_dev, __extack) \
-- 
2.20.1

