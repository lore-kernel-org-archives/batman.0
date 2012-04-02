Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Mon,  2 Apr 2012 14:48:15 +0200
Message-Id: <1333370896-11295-2-git-send-email-martin@hundeboll.net>
In-Reply-To: <1333370896-11295-1-git-send-email-martin@hundeboll.net>
References: <1333370896-11295-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Add interface to keep stats
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

For debugging batman-adv and measuring events, counters may be added to
the new bat_stats structure in types.h. Counters are incremented by
calling bat_stats_update() and passing one or more flags.

The stats are exported in the bat_stats file in debugfs and are cleared
by reading the bat_stats_clear file.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 Makefile               |    2 +
 Makefile.kbuild        |    1 +
 bat_debugfs.c          |   17 +++++++
 bat_stats.c            |  132 ++++++++++++++++++++++++++++++++++++++++++++++++
 bat_stats.h            |   60 ++++++++++++++++++++++
 gen-compat-autoconf.sh |    1 +
 main.c                 |    6 +++
 types.h                |   20 ++++++++
 8 files changed, 239 insertions(+)
 create mode 100644 bat_stats.c
 create mode 100644 bat_stats.h

diff --git a/Makefile b/Makefile
index ac84fba..0a4b2db 100644
--- a/Makefile
+++ b/Makefile
@@ -25,6 +25,8 @@ export CONFIG_BATMAN_ADV_DEBUG=n
 export CONFIG_BATMAN_ADV_BLA=y
 # B.A.T.M.A.N. distributed ARP table:
 export CONFIG_BATMAN_ADV_DAT=y
+# B.A.T.M.A.N. rx/tx statistics:
+export CONFIG_BATMAN_ADV_STATS=y
 
 PWD:=$(shell pwd)
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
diff --git a/Makefile.kbuild b/Makefile.kbuild
index ad002cd..37731b3 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -21,6 +21,7 @@
 obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
 batman-adv-y += bat_debugfs.o
 batman-adv-y += bat_iv_ogm.o
+batman-adv-$(CONFIG_BATMAN_ADV_STATS) += bat_stats.o
 batman-adv-y += bat_sysfs.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
diff --git a/bat_debugfs.c b/bat_debugfs.c
index 3b588f8..64e19ad 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -33,6 +33,7 @@
 #include "vis.h"
 #include "icmp_socket.h"
 #include "bridge_loop_avoidance.h"
+#include "bat_stats.h"
 
 static struct dentry *bat_debugfs;
 
@@ -265,6 +266,18 @@ static int vis_data_open(struct inode *inode, struct file *file)
 	return single_open(file, vis_seq_print_text, net_dev);
 }
 
+static int bat_stats_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, bat_stats_show, net_dev);
+}
+
+static int bat_stats_clear_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, bat_stats_clear, net_dev);
+}
+
 struct bat_debuginfo {
 	struct attribute attr;
 	const struct file_operations fops;
@@ -291,6 +304,8 @@ static BAT_DEBUGINFO(bla_claim_table, S_IRUGO, bla_claim_table_open);
 #endif
 static BAT_DEBUGINFO(transtable_local, S_IRUGO, transtable_local_open);
 static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
+static BAT_DEBUGINFO(bat_stats, S_IRUGO, bat_stats_open);
+static BAT_DEBUGINFO(bat_stats_clear, S_IRUGO, bat_stats_clear_open);
 
 static struct bat_debuginfo *mesh_debuginfos[] = {
 	&bat_debuginfo_originators,
@@ -301,6 +316,8 @@ static struct bat_debuginfo *mesh_debuginfos[] = {
 #endif
 	&bat_debuginfo_transtable_local,
 	&bat_debuginfo_vis_data,
+	&bat_debuginfo_bat_stats,
+	&bat_debuginfo_bat_stats_clear,
 	NULL,
 };
 
diff --git a/bat_stats.c b/bat_stats.c
new file mode 100644
index 0000000..d95fb02
--- /dev/null
+++ b/bat_stats.c
@@ -0,0 +1,132 @@
+/*
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+ *
+ * Martin Hundebøll, Jeppe Ledet-Pedersen
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include "main.h"
+#include "bat_stats.h"
+
+/* Update one or more stat counters by passing the appropriate flags. */
+void bat_stats_update(struct bat_priv *bat_priv, uint32_t flags)
+{
+	if (bat_priv && flags) {
+		write_seqlock(&bat_priv->bat_stats->lock);
+		if (flags & BAT_STAT_XMIT)
+			atomic_inc(&bat_priv->bat_stats->transmitted);
+		if (flags & BAT_STAT_RECV)
+			atomic_inc(&bat_priv->bat_stats->received);
+		if (flags & BAT_STAT_FORWARD)
+			atomic_inc(&bat_priv->bat_stats->forwarded);
+		if (flags & BAT_STAT_CODE)
+			atomic_inc(&bat_priv->bat_stats->coded);
+		if (flags & BAT_STAT_DECODE)
+			atomic_inc(&bat_priv->bat_stats->decoded);
+		if (flags & BAT_STAT_DECODE_FAIL)
+			atomic_inc(&bat_priv->bat_stats->decode_failed);
+		if (flags & BAT_STAT_RECODE)
+			atomic_inc(&bat_priv->bat_stats->recoded);
+		if (flags & BAT_STAT_OVERHEARD)
+			atomic_inc(&bat_priv->bat_stats->overheard);
+		write_sequnlock(&bat_priv->bat_stats->lock);
+	}
+}
+
+/* debugfs function to list statistics */
+int bat_stats_show(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct bat_stats *stats = bat_priv->bat_stats;
+	seqlock_t *lock = &stats->lock;
+	int transmitted, received, forwarded, coded, decoded, decode_failed,
+	    recoded, overheard;
+	unsigned long sval;
+
+	do {
+		sval = read_seqbegin(lock);
+		transmitted   = atomic_read(&stats->transmitted);
+		received      = atomic_read(&stats->received);
+		forwarded     = atomic_read(&stats->forwarded);
+		coded         = atomic_read(&stats->coded);
+		decoded       = atomic_read(&stats->decoded);
+		decode_failed = atomic_read(&stats->decode_failed);
+		recoded       = atomic_read(&stats->recoded);
+		overheard     = atomic_read(&stats->overheard);
+	} while (read_seqretry(lock, sval));
+
+	seq_printf(seq, "Transmitted:  %d\n", transmitted);
+	seq_printf(seq, "Received:     %d\n", received);
+	seq_printf(seq, "Forwarded:    %d\n", forwarded);
+	seq_printf(seq, "Coded:        %d\n", coded);
+	seq_printf(seq, "Recoded:      %d\n", recoded);
+	seq_printf(seq, "Decoded:      %d\n", decoded);
+	seq_printf(seq, "Failed:       %d\n", decode_failed);
+	seq_printf(seq, "Overheard:    %d\n", overheard);
+
+	return 0;
+}
+
+/* Reset stat counters */
+static void _bat_stats_clear(struct bat_priv *bat_priv)
+{
+	write_seqlock(&bat_priv->bat_stats->lock);
+	atomic_set(&bat_priv->bat_stats->transmitted, 0);
+	atomic_set(&bat_priv->bat_stats->received, 0);
+	atomic_set(&bat_priv->bat_stats->forwarded, 0);
+	atomic_set(&bat_priv->bat_stats->coded, 0);
+	atomic_set(&bat_priv->bat_stats->decoded, 0);
+	atomic_set(&bat_priv->bat_stats->decode_failed, 0);
+	atomic_set(&bat_priv->bat_stats->recoded, 0);
+	atomic_set(&bat_priv->bat_stats->overheard, 0);
+	write_sequnlock(&bat_priv->bat_stats->lock);
+}
+
+/* Callback function to debugfs */
+int bat_stats_clear(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	_bat_stats_clear(bat_priv);
+
+	return 0;
+}
+
+/* Initialize stat counters */
+int bat_stats_init(struct bat_priv *bat_priv)
+{
+	if (bat_priv->bat_stats)
+		return 0;
+
+	bat_priv->bat_stats = kmalloc(sizeof(*bat_priv->bat_stats), GFP_ATOMIC);
+	if (!bat_priv->bat_stats)
+		return -1;
+
+	seqlock_init(&bat_priv->bat_stats->lock);
+	_bat_stats_clear(bat_priv);
+
+	return 0;
+}
+
+void bat_stats_free(struct bat_priv *bat_priv)
+{
+	if (!bat_priv->bat_stats)
+		return;
+
+	kfree(bat_priv->bat_stats);
+}
diff --git a/bat_stats.h b/bat_stats.h
new file mode 100644
index 0000000..34cd1ae
--- /dev/null
+++ b/bat_stats.h
@@ -0,0 +1,60 @@
+/*
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+ *
+ * Martin Hundebøll, Jeppe Ledet-Pedersen
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#ifndef _NET_BATMAN_ADV_STATS_H_
+#define _NET_BATMAN_ADV_STATS_H_
+
+#define BAT_STAT_XMIT		(1 << 1)
+#define BAT_STAT_RECV		(1 << 2)
+#define BAT_STAT_FORWARD	(1 << 3)
+#define BAT_STAT_CODE		(1 << 4)
+#define BAT_STAT_DECODE		(1 << 5)
+#define BAT_STAT_DECODE_FAIL	(1 << 6)
+#define BAT_STAT_RECODE		(1 << 7)
+#define BAT_STAT_OVERHEARD	(1 << 8)
+
+#ifdef CONFIG_BATMAN_ADV_STATS
+
+int bat_stats_show(struct seq_file *seq, void *offset);
+int bat_stats_clear(struct seq_file *seq, void *offset);
+int bat_stats_init(struct bat_priv *bat_priv);
+void bat_stats_free(struct bat_priv *bat_priv);
+void bat_stats_update(struct bat_priv *bat_priv, uint32_t flags);
+
+#else /* CONFIG_BATMAN_ADV_STATS */
+
+static inline int bat_stats_show(struct seq_file *seq, void *offset)
+{
+	return 0;
+}
+
+static inline int bat_stats_clear(struct seq_file *seq, void *offset)
+{
+	return 0;
+}
+
+#define bat_stats_init(...)	(0)
+#define bat_stats_free(...)	{}
+#define bat_stats_update(...)	{}
+
+#endif /* CONFIG_BATMAN_ADV_STATS */
+
+#endif /* _NET_BATMAN_ADV_STATS_H_ */
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 7ea42aa..98b66a0 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -39,6 +39,7 @@ gen_config() {
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_STATS' ${CONFIG_BATMAN_ADV_STATS:="n"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
 diff "${TMP}" "${TARGET}" > /dev/null 2>&1 || cp "${TMP}" "${TARGET}"
diff --git a/main.c b/main.c
index 0757c2d..5251716 100644
--- a/main.c
+++ b/main.c
@@ -34,6 +34,7 @@
 #include "vis.h"
 #include "hash.h"
 #include "bat_algo.h"
+#include "bat_stats.h"
 
 
 /* List manipulations on hardif_list have to be rtnl_lock()'ed,
@@ -124,6 +125,9 @@ int mesh_init(struct net_device *soft_iface)
 	if (bla_init(bat_priv) < 1)
 		goto err;
 
+	if (bat_stats_init(bat_priv) < 0)
+		goto err;
+
 	atomic_set(&bat_priv->gw_reselect, 0);
 	atomic_set(&bat_priv->mesh_state, MESH_ACTIVE);
 	goto end;
@@ -153,6 +157,8 @@ void mesh_free(struct net_device *soft_iface)
 
 	bla_free(bat_priv);
 
+	bat_stats_free(bat_priv);
+
 	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
 }
 
diff --git a/types.h b/types.h
index 15f538a..41b2217 100644
--- a/types.h
+++ b/types.h
@@ -240,6 +240,7 @@ struct bat_priv {
 #endif
 	struct vis_info *my_vis_info;
 	struct bat_algo_ops *bat_algo_ops;
+	struct bat_stats *bat_stats;
 };
 
 struct socket_client {
@@ -415,4 +416,23 @@ struct dht_candidate {
 	struct orig_node *orig_node;
 };
 
+struct bat_stats {
+	seqlock_t lock;			/* seqlock for fast write operation */
+	struct timespec timestamp;	/* Timestamp of data */
+
+	/* Generic node stats */
+	atomic_t transmitted;		/* Packets transmitted */
+	atomic_t received;		/* Packets received */
+
+	/* Relay node stats */
+	atomic_t forwarded;		/* Packets forwarded */
+	atomic_t coded;			/* Packets coded */
+	atomic_t recoded;		/* Decoded packets coded */
+
+	/* End node stats */
+	atomic_t decoded;		/* Packets decoded */
+	atomic_t decode_failed;		/* Packets that failed to be decoded */
+	atomic_t overheard;		/* Received, but overheard, packets */
+};
+
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
-- 
1.7.9.5

