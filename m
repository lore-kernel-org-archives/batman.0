Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 17 May 2016 16:13:11 +0200
Message-Id: <1463494399-26405-4-git-send-email-andrew@lunn.ch>
In-Reply-To: <1463494399-26405-1-git-send-email-andrew@lunn.ch>
References: <1463494399-26405-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH v7 03/11] batman-adv: netlink: add
	routing_algo query
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

From: Matthias Schiffer <mschiffer@universe-factory.net>

BATADV_CMD_GET_ROUTING_ALGOS is used to get the list of supported routing
algorithms.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
[sven.eckelmann@open-mesh.com: Reduce the number of changes to
BATADV_CMD_GET_ROUTING_ALGOS]
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
 compat-include/linux/netlink.h  | 45 ++++++++++++++++++++++++++++
 include/uapi/linux/batman_adv.h |  2 ++
 net/batman-adv/main.c           | 66 +++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/main.h           |  2 ++
 net/batman-adv/netlink.c        | 10 +++++--
 net/batman-adv/netlink.h        |  9 ++++++
 6 files changed, 132 insertions(+), 2 deletions(-)
 create mode 100644 compat-include/linux/netlink.h

diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
new file mode 100644
index 0000000..4d0eb5b
--- /dev/null
+++ b/compat-include/linux/netlink.h
@@ -0,0 +1,45 @@
+/* Copyright (C) 2007-2016 B.A.T.M.A.N. contributors:
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
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_
+
+#include <linux/version.h>
+#include_next <linux/netlink.h>
+
+#include <net/scm.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
+
+struct batadv_netlink_skb_parms {
+	struct ucred		creds;		/* Skb credentials	*/
+	union {
+		__u32		portid;
+		__u32		pid;
+	};
+	__u32			dst_group;
+};
+
+#undef NETLINK_CB
+#define NETLINK_CB(skb) (*(struct batadv_netlink_skb_parms *)&((skb)->cb))
+
+#endif /* < KERNEL_VERSION(3, 7, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_ */
diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index a908140..d2a9740 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -57,12 +57,14 @@ enum batadv_nl_attrs {
  *
  * @BATADV_CMD_UNSPEC: unspecified command to catch errors
  * @BATADV_CMD_GET_MESH_INFO: Query basic information about batman-adv device
+ * @BATADV_CMD_GET_ROUTING_ALGOS: Query the list of routing algorithms.
  * @__BATADV_CMD_AFTER_LAST: internal use
  * @BATADV_CMD_MAX: highest used command number
  */
 enum batadv_nl_commands {
 	BATADV_CMD_UNSPEC,
 	BATADV_CMD_GET_MESH_INFO,
+	BATADV_CMD_GET_ROUTING_ALGOS,
 	/* add new commands above here */
 	__BATADV_CMD_AFTER_LAST,
 	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e78b318..fe03721 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -35,6 +35,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/pkt_sched.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -46,7 +47,10 @@
 #include <linux/string.h>
 #include <linux/workqueue.h>
 #include <net/dsfield.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <net/rtnetlink.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "bat_algo.h"
 #include "bridge_loop_avoidance.h"
@@ -612,6 +616,68 @@ int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
 }
 
 /**
+ * batadv_algo_dump_entry - fill in information about one supported routing
+ *  algorithm
+ * @msg: netlink message to be sent back
+ * @portid: Port to reply to
+ * @seq: Sequence number of message
+ * @bat_algo_ops: Algorithm to be dumped
+ *
+ * Return: Error number, or 0 on success
+ */
+static int batadv_algo_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+				  struct batadv_algo_ops *bat_algo_ops)
+{
+	void *hdr;
+
+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
+			  NLM_F_MULTI, BATADV_CMD_GET_ROUTING_ALGOS);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_string(msg, BATADV_ATTR_ALGO_NAME, bat_algo_ops->name))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+	return 0;
+
+ nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+/**
+ * batadv_algo_dump - fill in information about supported routing
+ *  algorithms
+ * @msg: netlink message to be sent back
+ * @cb: Parameters to the netlink request
+ *
+ * Return: Length of reply message.
+ */
+int batadv_algo_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	int portid = NETLINK_CB(cb->skb).portid;
+	struct batadv_algo_ops *bat_algo_ops;
+	int skip = cb->args[0];
+	int i = 0;
+
+	hlist_for_each_entry(bat_algo_ops, &batadv_algo_list, list) {
+		if (i++ < skip)
+			continue;
+
+		if (batadv_algo_dump_entry(msg, portid, cb->nlh->nlmsg_seq,
+					   bat_algo_ops)) {
+			i--;
+			break;
+		}
+	}
+
+	cb->args[0] = i;
+
+	return msg->len;
+}
+
+/**
  * batadv_skb_crc32 - calculate CRC32 of the whole packet and skip bytes in
  *  the header
  * @skb: skb pointing to fragmented socket buffers
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 832df0f..ea2ed80 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -191,6 +191,7 @@ enum batadv_uev_type {
 #include "types.h"
 
 struct batadv_ogm_packet;
+struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 
@@ -221,6 +222,7 @@ void batadv_recv_handler_unregister(u8 packet_type);
 int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops);
 int batadv_algo_select(struct batadv_priv *bat_priv, char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_algo_dump(struct sk_buff *msg, struct netlink_callback *cb);
 __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr);
 
 /**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 54724b7..717d7d0 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -25,8 +25,8 @@
 #include <linux/init.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
-#include <linux/stddef.h>
 #include <linux/printk.h>
+#include <linux/stddef.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <uapi/linux/batman_adv.h>
@@ -36,7 +36,7 @@
 
 struct sk_buff;
 
-static struct genl_family batadv_netlink_family = {
+struct genl_family batadv_netlink_family = {
 	.id = GENL_ID_GENERATE,
 	.hdrsize = 0,
 	.name = BATADV_NL_NAME,
@@ -170,6 +170,12 @@ static struct genl_ops batadv_netlink_ops[] = {
 		.policy = batadv_netlink_policy,
 		.doit = batadv_netlink_get_mesh_info,
 	},
+	{
+		.cmd = BATADV_CMD_GET_ROUTING_ALGOS,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.dumpit = batadv_algo_dump,
+	},
 };
 
 /**
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index fa152a8..0e4f134 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -18,7 +18,16 @@
 #ifndef _NET_BATMAN_ADV_NETLINK_H_
 #define _NET_BATMAN_ADV_NETLINK_H_
 
+#include <linux/compiler.h>
+#include <linux/genetlink.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
+
+struct nlmsghdr;
+
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
 
+extern struct genl_family batadv_netlink_family;
+
 #endif /* _NET_BATMAN_ADV_NETLINK_H_ */
-- 
2.8.0.rc3

