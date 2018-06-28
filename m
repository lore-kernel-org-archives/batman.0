Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 28 Jun 2018 21:21:41 +0200
Message-Id: <20180628192141.13112-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't redefine EPOLL*
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
Cc: Sven Eckelmann <sven@narfation.org>, Andre Kasper <andre.kasper@gmx.de>

The commit 7e040726850a ("eventpoll.h: add missing epoll event masks") was
backported to a couple of older kernels - including 4.4. The build against
such kernel sources creates a lot of extra warnings about redefinitions of
the different EPOLL* variables.

Just disable the definition of these variables when they are already
defined and drop the ones which are not used by batman-adv.

Reported-by: Andre Kasper <andre.kasper@gmx.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Andre Kasper <andre.kasper@gmx.de>
---
 compat-include/uapi/linux/eventpoll.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/compat-include/uapi/linux/eventpoll.h b/compat-include/uapi/linux/eventpoll.h
index 1828feb4..3cf71a19 100644
--- a/compat-include/uapi/linux/eventpoll.h
+++ b/compat-include/uapi/linux/eventpoll.h
@@ -28,18 +28,13 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 12, 0)
 
+#ifndef EPOLLIN
 #define EPOLLIN		(__force __poll_t)0x00000001
-#define EPOLLPRI	(__force __poll_t)0x00000002
-#define EPOLLOUT	(__force __poll_t)0x00000004
-#define EPOLLERR	(__force __poll_t)0x00000008
-#define EPOLLHUP	(__force __poll_t)0x00000010
-#define EPOLLNVAL	(__force __poll_t)0x00000020
+#endif
+
+#ifndef EPOLLRDNORM
 #define EPOLLRDNORM	(__force __poll_t)0x00000040
-#define EPOLLRDBAND	(__force __poll_t)0x00000080
-#define EPOLLWRNORM	(__force __poll_t)0x00000100
-#define EPOLLWRBAND	(__force __poll_t)0x00000200
-#define EPOLLMSG	(__force __poll_t)0x00000400
-#define EPOLLRDHUP	(__force __poll_t)0x00002000
+#endif
 
 #endif /* < KERNEL_VERSION(4, 12, 0) */
 
-- 
2.18.0

