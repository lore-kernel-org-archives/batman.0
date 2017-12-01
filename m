Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  1 Dec 2017 11:47:55 +0100
Message-Id: <20171201104756.4476-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: setup_timer() ->
 timer_setup()
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

From: Kees Cook <keescook@chromium.org>

This converts all remaining cases of the old setup_timer() API into using
timer_setup(), where the callback argument is the structure already
holding the struct timer_list. These should have no behavioral changes,
since they just change which pointer is passed into the callback with
the same available pointers after conversion.

Signed-off-by: Kees Cook <keescook@chromium.org>
[sven@narfation.org: removed spatch and examples, added compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/timer.h | 59 ++++++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/tp_meter.c    | 14 +++++------
 2 files changed, 65 insertions(+), 8 deletions(-)
 create mode 100644 compat-include/linux/timer.h

diff --git a/compat-include/linux/timer.h b/compat-include/linux/timer.h
new file mode 100644
index 0000000..750b6ae
--- /dev/null
+++ b/compat-include/linux/timer.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
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
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_TIMER_H
+#define _NET_BATMAN_ADV_COMPAT_LINUX_TIMER_H
+
+#include <linux/version.h>
+#include_next <linux/timer.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
+
+#define __setup_timer(_timer, _fn, _data, _flags) \
+	do { \
+		init_timer(_timer); \
+		(_timer)->function = (_fn); \
+		(_timer)->data = (_data); \
+	} while (0)
+
+#endif /* < KERNEL_VERSION(3, 7, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 14, 0)
+
+#define TIMER_DATA_TYPE		unsigned long
+#define TIMER_FUNC_TYPE		void (*)(TIMER_DATA_TYPE)
+
+static inline void timer_setup(struct timer_list *timer,
+			       void (*callback)(struct timer_list *),
+			       unsigned int flags)
+{
+	__setup_timer(timer, (TIMER_FUNC_TYPE)callback,
+		      (TIMER_DATA_TYPE)timer, flags);
+}
+
+#define from_timer(var, callback_timer, timer_fieldname) \
+	container_of(callback_timer, typeof(*var), timer_fieldname)
+
+#endif /* < KERNEL_VERSION(4, 14, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_TIMER_H */
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 4b90033..15cd213 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -488,9 +488,9 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
  * Switch to Slow Start, set the ss_threshold to half of the current cwnd and
  * reset the cwnd to 3*MSS
  */
-static void batadv_tp_sender_timeout(unsigned long arg)
+static void batadv_tp_sender_timeout(struct timer_list *t)
 {
-	struct batadv_tp_vars *tp_vars = (struct batadv_tp_vars *)arg;
+	struct batadv_tp_vars *tp_vars = from_timer(tp_vars, t, timer);
 	struct batadv_priv *bat_priv = tp_vars->bat_priv;
 
 	if (atomic_read(&tp_vars->sending) == 0)
@@ -1020,8 +1020,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	atomic64_set(&tp_vars->tot_sent, 0);
 
 	kref_get(&tp_vars->refcount);
-	setup_timer(&tp_vars->timer, batadv_tp_sender_timeout,
-		    (unsigned long)tp_vars);
+	timer_setup(&tp_vars->timer, batadv_tp_sender_timeout, 0);
 
 	tp_vars->bat_priv = bat_priv;
 	tp_vars->start_time = jiffies;
@@ -1109,9 +1108,9 @@ static void batadv_tp_reset_receiver_timer(struct batadv_tp_vars *tp_vars)
  *  reached without received ack
  * @arg: address of the related tp_vars
  */
-static void batadv_tp_receiver_shutdown(unsigned long arg)
+static void batadv_tp_receiver_shutdown(struct timer_list *t)
 {
-	struct batadv_tp_vars *tp_vars = (struct batadv_tp_vars *)arg;
+	struct batadv_tp_vars *tp_vars = from_timer(tp_vars, t, timer);
 	struct batadv_tp_unacked *un, *safe;
 	struct batadv_priv *bat_priv;
 
@@ -1373,8 +1372,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
 
 	kref_get(&tp_vars->refcount);
-	setup_timer(&tp_vars->timer, batadv_tp_receiver_shutdown,
-		    (unsigned long)tp_vars);
+	timer_setup(&tp_vars->timer, batadv_tp_receiver_shutdown, 0);
 
 	batadv_tp_reset_receiver_timer(tp_vars);
 
-- 
2.11.0

