Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 15:07:56 +0100
Message-Id: <20181114140804.18381-9-sw@simonwunderlich.de>
In-Reply-To: <20181114140804.18381-1-sw@simonwunderlich.de>
References: <20181114140804.18381-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 08/16] batman-adv: Add inconsistent hardif
 netlink dump detection
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The netlink dump functionality transfers a large number of entries from the
kernel to userspace. It is rather likely that the transfer has to
interrupted and later continued. During that time, it can happen that
either new entries are added or removed. The userspace could than either
receive some entries multiple times or miss entries.

Commit 670dc2833d14 ("netlink: advertise incomplete dumps") introduced a
mechanism to inform userspace about this problem. Userspace can then decide
whether it is necessary or not to retry dumping the information again.

The netlink dump functions have to be switched to exclusive locks to avoid
changes while the current message is prepared. And an external generation
sequence counter is introduced which tracks all modifications of the list.

Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c |  3 +++
 net/batman-adv/main.c           |  1 +
 net/batman-adv/main.h           |  1 +
 net/batman-adv/netlink.c        | 24 ++++++++++++++----------
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 781c5b6e6e8e..508f4416dfc9 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -951,6 +951,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	batadv_check_known_mac_addr(hard_iface->net_dev);
 	kref_get(&hard_iface->refcount);
 	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
+	batadv_hardif_generation++;
 
 	return hard_iface;
 
@@ -993,6 +994,7 @@ void batadv_hardif_remove_interfaces(void)
 	list_for_each_entry_safe(hard_iface, hard_iface_tmp,
 				 &batadv_hardif_list, list) {
 		list_del_rcu(&hard_iface->list);
+		batadv_hardif_generation++;
 		batadv_hardif_remove_interface(hard_iface);
 	}
 	rtnl_unlock();
@@ -1054,6 +1056,7 @@ static int batadv_hard_if_event(struct notifier_block *this,
 	case NETDEV_UNREGISTER:
 	case NETDEV_PRE_TYPE_CHANGE:
 		list_del_rcu(&hard_iface->list);
+		batadv_hardif_generation++;
 
 		batadv_hardif_remove_interface(hard_iface);
 		break;
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index c75e47826949..d1ed839fd32b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -74,6 +74,7 @@
  * list traversals just rcu-locked
  */
 struct list_head batadv_hardif_list;
+unsigned int batadv_hardif_generation;
 static int (*batadv_rx_handler[256])(struct sk_buff *skb,
 				     struct batadv_hard_iface *recv_if);
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index b68a41190eb0..b572066325e4 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -247,6 +247,7 @@ static inline int batadv_print_vid(unsigned short vid)
 }
 
 extern struct list_head batadv_hardif_list;
+extern unsigned int batadv_hardif_generation;
 
 extern unsigned char batadv_broadcast_addr[];
 extern struct workqueue_struct *batadv_event_workqueue;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 0d9459b69bdb..2dc3304cee54 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -29,11 +29,11 @@
 #include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/printk.h>
-#include <linux/rculist.h>
-#include <linux/rcupdate.h>
+#include <linux/rtnetlink.h>
 #include <linux/skbuff.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -445,23 +445,27 @@ batadv_netlink_tp_meter_cancel(struct sk_buff *skb, struct genl_info *info)
  * batadv_netlink_dump_hardif_entry() - Dump one hard interface into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
- * @seq: Sequence number of netlink message
+ * @cb: Control block containing additional options
  * @hard_iface: Hard interface to dump
  *
  * Return: error code, or 0 on success
  */
 static int
-batadv_netlink_dump_hardif_entry(struct sk_buff *msg, u32 portid, u32 seq,
+batadv_netlink_dump_hardif_entry(struct sk_buff *msg, u32 portid,
+				 struct netlink_callback *cb,
 				 struct batadv_hard_iface *hard_iface)
 {
 	struct net_device *net_dev = hard_iface->net_dev;
 	void *hdr;
 
-	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family, NLM_F_MULTI,
+	hdr = genlmsg_put(msg, portid, cb->nlh->nlmsg_seq,
+			  &batadv_netlink_family, NLM_F_MULTI,
 			  BATADV_CMD_GET_HARDIFS);
 	if (!hdr)
 		return -EMSGSIZE;
 
+	genl_dump_check_consistent(cb, hdr);
+
 	if (nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX,
 			net_dev->ifindex) ||
 	    nla_put_string(msg, BATADV_ATTR_HARD_IFNAME,
@@ -498,7 +502,6 @@ batadv_netlink_dump_hardifs(struct sk_buff *msg, struct netlink_callback *cb)
 	struct batadv_hard_iface *hard_iface;
 	int ifindex;
 	int portid = NETLINK_CB(cb->skb).portid;
-	int seq = cb->nlh->nlmsg_seq;
 	int skip = cb->args[0];
 	int i = 0;
 
@@ -516,23 +519,24 @@ batadv_netlink_dump_hardifs(struct sk_buff *msg, struct netlink_callback *cb)
 		return -ENODEV;
 	}
 
-	rcu_read_lock();
+	rtnl_lock();
+	cb->seq = batadv_hardif_generation << 1 | 1;
 
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+	list_for_each_entry(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->soft_iface != soft_iface)
 			continue;
 
 		if (i++ < skip)
 			continue;
 
-		if (batadv_netlink_dump_hardif_entry(msg, portid, seq,
+		if (batadv_netlink_dump_hardif_entry(msg, portid, cb,
 						     hard_iface)) {
 			i--;
 			break;
 		}
 	}
 
-	rcu_read_unlock();
+	rtnl_unlock();
 
 	dev_put(soft_iface);
 
-- 
2.11.0

