Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 23 Feb 2015 20:18:50 +0100
Message-Id: <1424719130-2661-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Drop capabilities when not needed
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
Cc: Sven Eckelmann <sven@narfation.org>

The alfred process only requires the capability to bind to a raw socket
(CAP_NET_RAW). It is enough to mark this capability as permitted on program
startup and mark it again as effective whenever a new netsock is initialized.
All other capabilities can be dropped completely.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile  | 24 ++++++++++++++++++
 main.c    | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 netsock.c | 44 +++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8e944c9..4e22d76 100644
--- a/Makefile
+++ b/Makefile
@@ -27,6 +27,9 @@ MANPAGE = man/alfred.8
 CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
 LDLIBS += -lrt
 
+# B.A.T.M.A.N. debugging:
+export CONFIG_ALFRED_CAPABILITIES=y
+
 # disable verbose output
 ifneq ($(findstring $(MAKEFLAGS),s),s)
 ifndef V
@@ -70,6 +73,27 @@ ifneq ($(CONFIG_ALFRED_GPSD),n)
 	GPSD_INSTALL=gpsd-install
 endif
 
+ifneq ($(CONFIG_ALFRED_CAPABILITIES),n)
+  ifeq ($(origin PKG_CONFIG), undefined)
+    PKG_CONFIG = pkg-config
+    ifeq ($(shell which $(PKG_CONFIG) 2>/dev/null),)
+      $(error $(PKG_CONFIG) not found)
+    endif
+  endif
+
+  ifeq ($(origin LIBCAP_CFLAGS) $(origin LIBCAP_LDLIBS), undefined undefined)
+    LIBCAP_NAME ?= libcap
+    ifeq ($(shell $(PKG_CONFIG) --modversion $(LIBCAP_NAME) 2>/dev/null),)
+      $(error No $(LIBCAP_NAME) development libraries found!)
+    endif
+    LIBCAP_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(LIBCAP_NAME))
+    LIBCAP_LDLIBS +=  $(shell $(PKG_CONFIG) --libs $(LIBCAP_NAME))
+  endif
+  CFLAGS += $(LIBCAP_CFLAGS)
+  CPPFLAGS += -DCONFIG_ALFRED_CAPABILITIES
+  LDLIBS += $(LIBCAP_LDLIBS)
+endif
+
 
 # default target
 all: $(BINARY_NAME) $(VIS_ALL) $(GPSD_ALL)
diff --git a/main.c b/main.c
index d298d65..982bd2a 100644
--- a/main.c
+++ b/main.c
@@ -24,6 +24,11 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#ifdef CONFIG_ALFRED_CAPABILITIES
+#include <sys/prctl.h>
+#include <sys/capability.h>
+#include <unistd.h>
+#endif
 #include "alfred.h"
 #include "packet.h"
 #include "list.h"
@@ -60,9 +65,82 @@ static void alfred_usage(void)
 	printf("\n");
 }
 
+static int reduce_capabilities(void)
+{
+	int ret = 0;
+
+#ifdef CONFIG_ALFRED_CAPABILITIES
+	cap_t cap_cur;
+	cap_t cap_new;
+	cap_flag_value_t cap_flag;
+	cap_value_t cap_net_raw = CAP_NET_RAW;
+
+	/* get current process capabilities */
+	cap_cur = cap_get_proc();
+	if (!cap_cur) {
+		perror("cap_get_proc");
+		return -1;
+	}
+
+	/* create new capabilities */
+	cap_new = cap_init();
+	if (!cap_new) {
+		perror("cap_init");
+		cap_free(cap_new);
+		return -1;
+	}
+
+	/* copy capability as non-effictive but permitted */
+	cap_flag = CAP_CLEAR;
+	cap_get_flag(cap_cur, CAP_NET_RAW, CAP_PERMITTED, &cap_flag);
+	if (cap_flag != CAP_CLEAR) {
+		ret = cap_set_flag(cap_new, CAP_PERMITTED, 1, &cap_net_raw,
+				   CAP_SET);
+		if (ret < 0) {
+			perror("cap_set_flag");
+			goto out;
+		}
+	}
+
+	/* set minimal capabilities field */
+	ret = cap_set_proc(cap_new);
+	if (ret < 0) {
+		perror("cap_set_proc");
+		goto out;
+	}
+
+	/* don't drop capabilities with setuid */
+	ret = prctl(PR_SET_KEEPCAPS, 1);
+	if (ret < 0) {
+		perror("prctl PR_SET_KEEPCAPS(1)");
+		goto out;
+	}
+
+	/* drop euid */
+	ret = setuid(getuid());
+	if (ret < 0) {
+		perror("setuid");
+		goto out;
+	}
+
+	/* drop capabilities with setuid */
+	ret = prctl(PR_SET_KEEPCAPS, 0);
+	if (ret < 0) {
+		perror("prctl PR_SET_KEEPCAPS(0)");
+		goto out;
+	}
+
+out:
+	cap_free(cap_new);
+	cap_free(cap_cur);
+#endif
+
+	return ret;
+}
+
 static struct globals *alfred_init(int argc, char *argv[])
 {
-	int opt, opt_ind, i;
+	int opt, opt_ind, i, ret;
 	struct globals *globals;
 	struct option long_options[] = {
 		{"set-data",		required_argument,	NULL,	's'},
@@ -78,6 +156,10 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{NULL,			0,			NULL,	0},
 	};
 
+	ret = reduce_capabilities();
+	if (ret < 0)
+		return NULL;
+
 	globals = &alfred_globals;
 	memset(globals, 0, sizeof(*globals));
 
diff --git a/netsock.c b/netsock.c
index cc2e9a5..592f3e3 100644
--- a/netsock.c
+++ b/netsock.c
@@ -34,6 +34,9 @@
 #include <sys/types.h>
 #include <stdlib.h>
 #include <sys/select.h>
+#ifdef CONFIG_ALFRED_CAPABILITIES
+#include <sys/capability.h>
+#endif
 #include "alfred.h"
 #include "batadv_query.h"
 #include "packet.h"
@@ -165,6 +168,45 @@ int netsock_set_interfaces(struct globals *globals, char *interfaces)
 	return 0;
 }
 
+static int enable_raw_bind_capability(int enable)
+{
+	int ret = 0;
+
+#ifdef CONFIG_ALFRED_CAPABILITIES
+	cap_t cap_cur;
+	cap_flag_value_t cap_flag;
+	cap_value_t cap_net_raw = CAP_NET_RAW;
+
+	if (enable)
+		cap_flag = CAP_SET;
+	else
+		cap_flag = CAP_CLEAR;
+
+	cap_cur = cap_get_proc();
+	if (!cap_cur) {
+		perror("cap_get_proc");
+		return -1;
+	}
+
+	ret = cap_set_flag(cap_cur, CAP_EFFECTIVE, 1, &cap_net_raw, cap_flag);
+	if (ret < 0) {
+		perror("cap_set_flag");
+		goto out;
+	}
+
+	ret = cap_set_proc(cap_cur);
+	if (ret < 0) {
+		perror("cap_set_proc");
+		goto out;
+	}
+
+out:
+	cap_free(cap_cur);
+#endif
+
+	return ret;
+}
+
 static int netsock_open(struct interface *interface)
 {
 	int sock;
@@ -204,11 +246,13 @@ static int netsock_open(struct interface *interface)
 	memcpy(&interface->hwaddr, &ifr.ifr_hwaddr.sa_data, 6);
 	mac_to_ipv6(&interface->hwaddr, &interface->address);
 
+	enable_raw_bind_capability(1);
 	if (setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE, interface->interface,
 		       strlen(interface->interface) + 1)) {
 		perror("can't bind to device");
 		goto err;
 	}
+	enable_raw_bind_capability(0);
 
 	if (bind(sock, (struct sockaddr *)&sin6, sizeof(sin6)) < 0) {
 		perror("can't bind");
-- 
2.1.4

