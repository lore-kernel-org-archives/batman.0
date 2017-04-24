Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 24 Apr 2017 22:03:31 +0200
Message-Id: <20170424200331.21660-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: compat: fix compilation for
	kernels >= 4.11 on Debian
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
Cc: Manoj Srivastava <srivasta@debian.org>, "Dmitry V . Levin" <ldv@altlinux.org>

This patch is a workaround for the following issue:

[...]/batman-adv/build/net/batman-adv/../../../compat-sources/net/core/skbuff.o
./include/linux/if.h:27:11: error: unable to open 'sys/socket.h'
In file included from ./include/linux/compat.h:16:0,
                 from ./include/linux/ethtool.h:16,
                 from [...]/batman-adv/build/../compat-include/linux/ethtool.h:25,
                 from ./include/linux/netdevice.h:42,
                 from [...]/batman-adv/build/../compat-include/linux/netdevice.h:25,
                 from ./include/linux/icmpv6.h:12,
                 from ./include/linux/ipv6.h:82,
                 from [...]/batman-adv/build/net/batman-adv/../../../compat-sources/net/core/skbuff.c:36:
./include/linux/if.h:27:54: fatal error: sys/socket.h: No such file or directory
 #include <sys/socket.h>   /* for struct sockaddr.  */

It seems to occur since:

  "uapi: fix linux/if.h userspace compilation errors"
  (2618be7dcc, Linux 4.11-rc1)

Simply including an empty sys/socket.h makes the kernel module compile
again. (The #ifndef __KERNEL__, which kernel-package / make-kpkg
stripped, should have removed this include for kernel modules anyway.)

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

Fixes:
- https://www.open-mesh.org/issues/333
---
 compat-include/sys/socket.h | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 compat-include/sys/socket.h

diff --git a/compat-include/sys/socket.h b/compat-include/sys/socket.h
new file mode 100644
index 0000000..8722e57
--- /dev/null
+++ b/compat-include/sys/socket.h
@@ -0,0 +1,3 @@
+/*
+ * Workaround for Debian's kernel-package
+ */
-- 
2.1.4

