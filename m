Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 19 Mar 2018 17:37:25 +0100
Message-Id: <20180319163726.10921-5-sw@simonwunderlich.de>
In-Reply-To: <20180319163726.10921-1-sw@simonwunderlich.de>
References: <20180319163726.10921-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: Add missing include for
 EPOLL* constants
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

Fixes: a9a08845e9ac ("vfs: do bulk POLL* -> EPOLL* replacement")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/icmp_socket.c | 1 +
 net/batman-adv/log.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index e91f29c7c638..5daa3d50da17 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -24,6 +24,7 @@
 #include <linux/debugfs.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
+#include <linux/eventpoll.h>
 #include <linux/export.h>
 #include <linux/fcntl.h>
 #include <linux/fs.h>
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index dc9fa37ddd14..cdbe0e5e208b 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -22,6 +22,7 @@
 #include <linux/compiler.h>
 #include <linux/debugfs.h>
 #include <linux/errno.h>
+#include <linux/eventpoll.h>
 #include <linux/export.h>
 #include <linux/fcntl.h>
 #include <linux/fs.h>
-- 
2.11.0

