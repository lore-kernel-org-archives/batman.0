From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu,  9 Apr 2009 12:45:59 +0200
Message-Id: <1239273959-7911-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Add compilation support for GNU/kFreeBSD
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Debian recently announced that it added GNU/kFreeBSD as supported
distribution. It consists of an FreeBSD kernel and the usual debian
userspace tools and libraries. It uses the glibc with some extra
(free)bsd libraries to support bsd-only functions like devname and
strlcpy.
batmand should instantly work on this platform if a BSD developer would
port the bsd compatibility layer again to (Open|Free)BSD.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/Makefile  |    5 +++++
 batman/bsd/tun.c |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/batman/Makefile b/batman/Makefile
index 509217d..0f6e61f 100644
--- a/batman/Makefile
+++ b/batman/Makefile
@@ -44,6 +44,11 @@ ifeq ($(UNAME),Darwin)
 OS_C=		$(BSD_C) $(POSIX_C)
 endif
 
+ifeq ($(UNAME),GNU/kFreeBSD)
+OS_C=		$(BSD_C) $(POSIX_C)
+LDFLAGS+=	-lfreebsd -lbsd
+endif
+
 ifeq ($(UNAME),FreeBSD)
 OS_C=		$(BSD_C) $(POSIX_C)
 endif
diff --git a/batman/bsd/tun.c b/batman/bsd/tun.c
index 2629bcd..2c571c0 100644
--- a/batman/bsd/tun.c
+++ b/batman/bsd/tun.c
@@ -71,7 +71,7 @@ static int open_tun_any(char *dev_name, size_t dev_name_size)
 	}
 	return -1;
 }
-#elif defined(__FreeBSD__)
+#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
 static int open_tun_any(char *dev_name, size_t dev_name_size)
 {
 	int fd;
-- 
1.6.2.2

