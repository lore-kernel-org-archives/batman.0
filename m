Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon,  4 Jul 2016 15:02:54 +0200
Message-Id: <1467637379-6089-7-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1467637379-6089-1-git-send-email-sw@simonwunderlich.de>
References: <1467637379-6089-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 06/11] batman-adv: Fix bat_(iv|v) function
	declaration header
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

The bat_algo.h had some functions declared which were not part of the
bat_algo.c file. These are instead stored in bat_v.c and bat_iv_ogm.c. The
declaration should therefore be also in bat_v.h and bat_iv_ogm,h to make
them easier to find.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_algo.h          | 31 -----------------------
 net/batman-adv/bat_iv_ogm.c        |  3 ++-
 net/batman-adv/bat_iv_ogm.h        | 25 ++++++++++++++++++
 net/batman-adv/bat_v.c             |  3 ++-
 net/batman-adv/bat_v.h             | 52 ++++++++++++++++++++++++++++++++++++++
 net/batman-adv/hard-interface.c    |  2 +-
 net/batman-adv/main.c              |  2 ++
 net/batman-adv/routing.c           |  1 -
 net/batman-adv/translation-table.c |  1 -
 9 files changed, 84 insertions(+), 36 deletions(-)
 create mode 100644 net/batman-adv/bat_iv_ogm.h
 create mode 100644 net/batman-adv/bat_v.h

diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 8c7e761..860d773 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -24,8 +24,6 @@
 
 struct seq_file;
 
-int batadv_iv_init(void);
-
 extern char batadv_routing_algo[];
 extern struct list_head batadv_hardif_list;
 
@@ -34,33 +32,4 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops);
 int batadv_algo_select(struct batadv_priv *bat_priv, char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
 
-#ifdef CONFIG_BATMAN_ADV_BATMAN_V
-
-int batadv_v_init(void);
-void batadv_v_hardif_init(struct batadv_hard_iface *hardif);
-int batadv_v_mesh_init(struct batadv_priv *bat_priv);
-void batadv_v_mesh_free(struct batadv_priv *bat_priv);
-
-#else
-
-static inline int batadv_v_init(void)
-{
-	return 0;
-}
-
-static inline void batadv_v_hardif_init(struct batadv_hard_iface *hardif)
-{
-}
-
-static inline int batadv_v_mesh_init(struct batadv_priv *bat_priv)
-{
-	return 0;
-}
-
-static inline void batadv_v_mesh_free(struct batadv_priv *bat_priv)
-{
-}
-
-#endif /* CONFIG_BATMAN_ADV_BATMAN_V */
-
 #endif /* _NET_BATMAN_ADV_BAT_ALGO_H_ */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 805532a..e2d8848 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -15,7 +15,7 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "bat_algo.h"
+#include "bat_iv_ogm.h"
 #include "main.h"
 
 #include <linux/atomic.h>
@@ -49,6 +49,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+#include "bat_algo.h"
 #include "bitarray.h"
 #include "hard-interface.h"
 #include "hash.h"
diff --git a/net/batman-adv/bat_iv_ogm.h b/net/batman-adv/bat_iv_ogm.h
new file mode 100644
index 0000000..b9f3550
--- /dev/null
+++ b/net/batman-adv/bat_iv_ogm.h
@@ -0,0 +1,25 @@
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _BATMAN_ADV_BATADV_IV_OGM_H_
+#define _BATMAN_ADV_BATADV_IV_OGM_H_
+
+#include "main.h"
+
+int batadv_iv_init(void);
+
+#endif /* _BATMAN_ADV_BATADV_IV_OGM_H_ */
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index c2fea81..7231440 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -15,7 +15,7 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "bat_algo.h"
+#include "bat_v.h"
 #include "main.h"
 
 #include <linux/atomic.h>
@@ -31,6 +31,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+#include "bat_algo.h"
 #include "bat_v_elp.h"
 #include "bat_v_ogm.h"
 #include "hard-interface.h"
diff --git a/net/batman-adv/bat_v.h b/net/batman-adv/bat_v.h
new file mode 100644
index 0000000..83b7763
--- /dev/null
+++ b/net/batman-adv/bat_v.h
@@ -0,0 +1,52 @@
+/* Copyright (C) 2011-2016  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Linus Lüssing
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _NET_BATMAN_ADV_BAT_V_H_
+#define _NET_BATMAN_ADV_BAT_V_H_
+
+#include "main.h"
+
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+
+int batadv_v_init(void);
+void batadv_v_hardif_init(struct batadv_hard_iface *hardif);
+int batadv_v_mesh_init(struct batadv_priv *bat_priv);
+void batadv_v_mesh_free(struct batadv_priv *bat_priv);
+
+#else
+
+static inline int batadv_v_init(void)
+{
+	return 0;
+}
+
+static inline void batadv_v_hardif_init(struct batadv_hard_iface *hardif)
+{
+}
+
+static inline int batadv_v_mesh_init(struct batadv_priv *bat_priv)
+{
+	return 0;
+}
+
+static inline void batadv_v_mesh_free(struct batadv_priv *bat_priv)
+{
+}
+
+#endif /* CONFIG_BATMAN_ADV_BATMAN_V */
+
+#endif /* _NET_BATMAN_ADV_BAT_V_H_ */
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index ad2c37c..70841c1 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -37,7 +37,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
-#include "bat_algo.h"
+#include "bat_v.h"
 #include "bridge_loop_avoidance.h"
 #include "debugfs.h"
 #include "distributed-arp-table.h"
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 05e559c..eab9d1b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -46,6 +46,8 @@
 #include <net/rtnetlink.h>
 
 #include "bat_algo.h"
+#include "bat_iv_ogm.h"
+#include "bat_v.h"
 #include "bridge_loop_avoidance.h"
 #include "debugfs.h"
 #include "distributed-arp-table.h"
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index a5b53a3..5833ab3 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -34,7 +34,6 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 
-#include "bat_algo.h"
 #include "bitarray.h"
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 53458d6..48ce788 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -44,7 +44,6 @@
 #include <linux/string.h>
 #include <linux/workqueue.h>
 
-#include "bat_algo.h"
 #include "bridge_loop_avoidance.h"
 #include "hard-interface.h"
 #include "hash.h"
-- 
2.8.1

