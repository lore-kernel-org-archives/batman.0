Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Jul 2016 22:44:10 +0200
Message-Id: <1468961051-6447-3-git-send-email-sven@narfation.org>
In-Reply-To: <3501586.3dVhjbZHzy@sven-edge>
References: <3501586.3dVhjbZHzy@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batctl: Add helper to generate instant
	random bytes
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

Linux provides different ways to get instant random bytes. These are not
all supported on all systems and thus a fallback may have to be used.
Abstract all this in a single function which can be used from different
parts of the code.

The current implementations are

 * get random data from urandom pool via SYS_getrandom syscall
 * get random data from reading /dev/urandom
 * fallback to per-program prng initialized via the current time (seconds +
   nanoseconds)

All are tried in this order in hope to get a high quality random number
source before falling back to some really low quality one.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 functions.h |  2 ++
 2 files changed, 67 insertions(+)

diff --git a/functions.c b/functions.c
index bc4f9f8..d9f93c2 100644
--- a/functions.c
+++ b/functions.c
@@ -41,6 +41,7 @@
 #include <linux/if_link.h>
 #include <linux/rtnetlink.h>
 #include <linux/neighbour.h>
+#include <sys/syscall.h>
 #include <errno.h>
 #include <net/if.h>
 #include <netlink/socket.h>
@@ -1071,3 +1072,67 @@ int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface)
 
 	return EXIT_SUCCESS;
 }
+
+static int get_random_bytes_syscall(void *buf __unused, size_t buflen __unused)
+{
+#ifdef SYS_getrandom
+	return syscall(SYS_getrandom, buf, buflen, 0);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static int get_random_bytes_urandom(void *buf, size_t buflen)
+{
+	int fd;
+	ssize_t r;
+
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0)
+		return -EOPNOTSUPP;
+
+	r = read(fd, buf, buflen);
+	close(fd);
+	if (r < 0)
+		return -EOPNOTSUPP;
+
+	if ((size_t)r != buflen)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int get_random_bytes_fallback(void *buf, size_t buflen)
+{
+	struct timespec now;
+	static int initialized = 0;
+	size_t i;
+	uint8_t *bufc = buf;
+
+	/* this is not a good source for randomness */
+	if (!initialized) {
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		srand(now.tv_sec ^ now.tv_nsec);
+		initialized = 1;
+	}
+
+	for (i = 0; i < buflen; i++)
+		bufc[i] = rand() & 0xff;
+
+	return 0;
+}
+
+void get_random_bytes(void *buf, size_t buflen)
+{
+	int ret;
+
+	ret = get_random_bytes_syscall(buf, buflen);
+	if (ret != -EOPNOTSUPP)
+		return;
+
+	ret = get_random_bytes_urandom(buf, buflen);
+	if (ret != -EOPNOTSUPP)
+		return;
+
+	get_random_bytes_fallback(buf, buflen);
+}
diff --git a/functions.h b/functions.h
index e413d6b..95cd6cf 100644
--- a/functions.h
+++ b/functions.h
@@ -53,6 +53,8 @@ int netlink_simple_request(struct nl_msg *msg);
 int check_mesh_iface(char *mesh_iface);
 int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface);
 
+void get_random_bytes(void *buf, size_t buflen);
+
 int print_routing_algos(void);
 extern char *line_ptr;
 
-- 
2.8.1

