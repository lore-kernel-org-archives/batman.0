Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 May 2016 17:59:34 +0200
Message-Id: <1464019185-8381-4-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1464019185-8381-1-git-send-email-sw@simonwunderlich.de>
References: <1464019185-8381-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH v8 03/14] batman-adv: netlink: add
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

From: Matthias Schiffer <mschiffer@universe-factory.net>

BATADV_CMD_GET_ROUTING_ALGOS is used to get the list of supported routing
algorithms.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
[sven.eckelmann@open-mesh.com: Reduce the number of changes to
BATADV_CMD_GET_ROUTING_ALGOS, fix includes]
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 compat-include/linux/netlink.h  | 18 +++++++++++
 include/uapi/linux/batman_adv.h |  2 ++
 net/batman-adv/bat_algo.c       | 68 +++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/bat_algo.h       |  3 ++
 net/batman-adv/netlink.c        |  9 +++++-
 net/batman-adv/netlink.h        |  3 ++
 6 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
index eb5b7f4..4f2185d 100644
--- a/compat-include/linux/netlink.h
+++ b/compat-include/linux/netlink.h
@@ -24,6 +24,24 @@
 #include <linux/version.h>
 #include_next <linux/netlink.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
+
+#include <net/scm.h>
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
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 7, 0)
 
 #include_next <net/netlink.h>
diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index acb72f8..297a04d 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -73,6 +73,7 @@ enum batadv_nl_attrs {
  * @BATADV_CMD_GET_MESH_INFO: Query basic information about batman-adv device
  * @BATADV_CMD_TP_METER: Start a tp meter session
  * @BATADV_CMD_TP_METER_CANCEL: Cancel a tp meter session
+ * @BATADV_CMD_GET_ROUTING_ALGOS: Query the list of routing algorithms.
  * @__BATADV_CMD_AFTER_LAST: internal use
  * @BATADV_CMD_MAX: highest used command number
  */
@@ -81,6 +82,7 @@ enum batadv_nl_commands {
 	BATADV_CMD_GET_MESH_INFO,
 	BATADV_CMD_TP_METER,
 	BATADV_CMD_TP_METER_CANCEL,
+	BATADV_CMD_GET_ROUTING_ALGOS,
 	/* add new commands above here */
 	__BATADV_CMD_AFTER_LAST,
 	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 610d4de..540b3e0 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -20,12 +20,18 @@
 #include <linux/errno.h>
 #include <linux/list.h>
 #include <linux/moduleparam.h>
+#include <linux/netlink.h>
 #include <linux/printk.h>
 #include <linux/seq_file.h>
+#include <linux/skbuff.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "bat_algo.h"
+#include "netlink.h"
 
 char batadv_routing_algo[20] = "BATMAN_IV";
 static struct hlist_head batadv_algo_list;
@@ -138,3 +144,65 @@ static struct kparam_string batadv_param_string_ra = {
 
 module_param_cb(routing_algo, &batadv_param_ops_ra, &batadv_param_string_ra,
 		0644);
+
+/**
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
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 860d773..3b5b69c 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -22,7 +22,9 @@
 
 #include <linux/types.h>
 
+struct netlink_callback;
 struct seq_file;
+struct sk_buff;
 
 extern char batadv_routing_algo[];
 extern struct list_head batadv_hardif_list;
@@ -31,5 +33,6 @@ void batadv_algo_init(void);
 int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops);
 int batadv_algo_select(struct batadv_priv *bat_priv, char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_algo_dump(struct sk_buff *msg, struct netlink_callback *cb);
 
 #endif /* _NET_BATMAN_ADV_BAT_ALGO_H_ */
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index c25bbb8..ea3f4a2 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -32,13 +32,14 @@
 #include <net/netlink.h>
 #include <uapi/linux/batman_adv.h>
 
+#include "bat_algo.h"
 #include "hard-interface.h"
 #include "soft-interface.h"
 #include "tp_meter.h"
 
 struct sk_buff;
 
-static struct genl_family batadv_netlink_family = {
+struct genl_family batadv_netlink_family = {
 	.id = GENL_ID_GENERATE,
 	.hdrsize = 0,
 	.name = BATADV_NL_NAME,
@@ -399,6 +400,12 @@ static struct genl_ops batadv_netlink_ops[] = {
 		.policy = batadv_netlink_policy,
 		.doit = batadv_netlink_tp_meter_cancel,
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
index 945653a..b399f49 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -21,6 +21,7 @@
 #include "main.h"
 
 #include <linux/types.h>
+#include <net/genetlink.h>
 
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
@@ -29,4 +30,6 @@ int batadv_netlink_tpmeter_notify(struct batadv_priv *bat_priv, const u8 *dst,
 				  u8 result, u32 test_time, u64 total_bytes,
 				  u32 cookie);
 
+extern struct genl_family batadv_netlink_family;
+
 #endif /* _NET_BATMAN_ADV_NETLINK_H_ */
-- 
2.8.1

