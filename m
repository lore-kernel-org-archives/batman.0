Return-Path: <alex.suykov@gmail.com>
Date: Wed, 1 Apr 2015 22:35:50 +0300
From: Alex Suykov <alex.suykov@gmail.com>
Message-ID: <20150401193550.GA24391@vostro>
References: <20150401171821.GA21008@vostro> <2646597.jD5Rzrq2qD@sven-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2646597.jD5Rzrq2qD@sven-desktop>
Subject: Re: [B.A.T.M.A.N.] musl build fixes
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Wed, Apr 01, 2015 at 07:36:10PM +0200, Sven Eckelmann wrote:

> Nacked-by: Sven Eckelmann <sven@narfation.org>
> 
> The __be32, __be16 are from the kernel and used there to check if data was 
> correctly converted from host byte order to big endian (and the other way 
> around). batctl just uses the packet.h from the kernel module.

Ah, I see, I wasn't aware packet.h is shared between batctl and
the batman kernel module.

> See https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-March/012926.html
> for a proposal how to provide headers which are not yet part of linux-libc-dev 
> (linux kernel uapi headers).

It's not that linux headers are not available in musl, they are.
The problem is that musl provides its own standalone <netinet/if_ether.h>
instead of including <linux/if_ether.h>, and if both get included at the same
time, gcc complains about duplicate definitions.

Can you please take a look at the patch below?
That is enough to get a musl build, too, and it keeps packet.h intact.

In glibc and uclibc at least, <netinet/if_ether.h> includes <linux/if_ether.h>,
so those can be interchanged freely, and batctl already depends on netinet/*
headers. With musl, that would break bitwise attribute of course,
but only outside of the kernel, and that would be a musl issue anyway.



 ping.c       | 3 ++-
 tcpdump.c    | 1 +
 tcpdump.h    | 2 +-
 traceroute.c | 3 ++-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/ping.c b/ping.c
index bdca222..9ec6745 100644
--- a/ping.c
+++ b/ping.c
@@ -34,7 +34,8 @@
 #include <stdint.h>
 #include <sys/select.h>
 #include <sys/time.h>
-#include <linux/if_ether.h>
+#include <netinet/if_ether.h>
+#include <linux/types.h>
 
 #include "main.h"
 #include "ping.h"
diff --git a/tcpdump.c b/tcpdump.c
index b994977..cfeb4cc 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -43,6 +43,7 @@
 #include <stdint.h>
 #include <sys/select.h>
 #include <sys/socket.h>
+#include <linux/types.h>
 
 #include "tcpdump.h"
 #include "packet.h"
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
index 4ebfec2..5b58d9d 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -22,16 +22,17 @@
 
 
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
+#include <linux/types.h>
 
 #include "main.h"
 #include "traceroute.h"
-- 
2.0.3

