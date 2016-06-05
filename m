Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  5 Jun 2016 20:47:02 +0200
Message-Id: <1465152428-17299-4-git-send-email-sven@narfation.org>
In-Reply-To: <1465152428-17299-1-git-send-email-sven@narfation.org>
References: <1465152428-17299-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/10] alfred: Add CAP_NET_ADMIN capabilities
	for netlink
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

The batman_adv netlink family requires CAP_NET_ADMIN capabilities to query
the debugging tables.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README         |  8 ++++----
 batadv_query.c |  3 +++
 main.c         | 12 ++++++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 2a015b8..bc1c3bc 100644
--- a/README
+++ b/README
@@ -277,11 +277,11 @@ Operations requiring special capabilities:
  * accessing the debugfs filesystem
 
 The first operation can still be executed when the admin grants the special
-capability CAP_NET_RAW to anyone executing the alfred binary. The unix socket
-can also be moved using the parameter '-u' to a different directory which can
-be accessed by the user.
+capability CAP_NET_RAW+CAP_NET_ADMIN to anyone executing the alfred binary.
+The unix socket can also be moved using the parameter '-u' to a different
+directory which can be accessed by the user.
 
- $ sudo setcap cap_net_raw+ep alfred
+ $ sudo setcap cap_net_admin,cap_net_raw+ep alfred
  $ ./alfred -u alfred.sock -i eth0
 
 The user running alfred must still be in a group which is allowed to access
diff --git a/batadv_query.c b/batadv_query.c
index a5fa565..d917242 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -29,6 +29,9 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#ifdef CONFIG_ALFRED_CAPABILITIES
+#include <sys/capability.h>
+#endif
 #include <sys/types.h>
 #include "debugfs.h"
 
diff --git a/main.c b/main.c
index 52dca97..9cab705 100644
--- a/main.c
+++ b/main.c
@@ -77,6 +77,7 @@ static int reduce_capabilities(void)
 	cap_t cap_new;
 	cap_flag_value_t cap_flag;
 	cap_value_t cap_net_raw = CAP_NET_RAW;
+	cap_value_t cap_net_admin = CAP_NET_ADMIN;
 
 	/* get current process capabilities */
 	cap_cur = cap_get_proc();
@@ -105,6 +106,17 @@ static int reduce_capabilities(void)
 		}
 	}
 
+	cap_flag = CAP_CLEAR;
+	cap_get_flag(cap_cur, CAP_NET_ADMIN, CAP_PERMITTED, &cap_flag);
+	if (cap_flag != CAP_CLEAR) {
+		ret = cap_set_flag(cap_new, CAP_PERMITTED, 1, &cap_net_admin,
+				   CAP_SET);
+		if (ret < 0) {
+			perror("cap_set_flag");
+			goto out;
+		}
+	}
+
 	/* set minimal capabilities field */
 	ret = cap_set_proc(cap_new);
 	if (ret < 0) {
-- 
2.8.1

