Return-Path: <alex.suykov@gmail.com>
Date: Mon, 6 Apr 2015 17:29:13 +0300
From: Alex Suykov <alex.suykov@gmail.com>
Message-ID: <0516b7e4ce841146f759473be197ce252878f8ec.1428329893.git.alex.suykov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1428329893.git.alex.suykov@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH v2 2/2] batctl: use netinet/if_ether.h
 instead of linux/if_ether.h
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

musl does not allow including netinet/* and linux/* headers together.
batctl includes netinet/if_ether.h indirectly via net/ethernet.h,
so netinet/if_ether.h must be used instead of linux/if_ether.h.

Signed-off-by: Alex Suykov <alex.suykov at gmail.com>
---
v2: updated to work with #include <linux/types.h> in packet.h introduced by
https://lists.open-mesh.org:443/pipermail/b.a.t.m.a.n/2015-April/012961.html
and ported to batctl by patch 1/2 in this set.

 ping.c       | 2 +-
 tcpdump.h    | 2 +-
 traceroute.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ping.c b/ping.c
index bdca222..7880a82 100644
--- a/ping.c
+++ b/ping.c
@@ -34,7 +34,7 @@
 #include <stdint.h>
 #include <sys/select.h>
 #include <sys/time.h>
-#include <linux/if_ether.h>
+#include <netinet/if_ether.h>
 
 #include "main.h"
 #include "ping.h"
diff --git a/tcpdump.h b/tcpdump.h
index 5d936f2..3c9126c 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -23,7 +23,7 @@
 #define _BATCTL_TCPDUMP_H
 
 #include <netpacket/packet.h>
-#include <linux/if_ether.h>
+#include <netinet/if_ether.h>
 #include <net/if_arp.h>
 #include <sys/types.h>
 #include "main.h"
diff --git a/traceroute.c b/traceroute.c
index 4ebfec2..373fe90 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -22,13 +22,13 @@
 
 
 #include <netinet/in.h>
+#include <netinet/if_ether.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <linux/if_ether.h>
 #include <stddef.h>
 #include <sys/select.h>
 #include <sys/time.h>
-- 
2.0.3

