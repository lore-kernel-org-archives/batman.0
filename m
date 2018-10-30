Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 30 Oct 2018 22:01:23 +0100
Message-Id: <20181030210130.18152-3-sven@narfation.org>
In-Reply-To: <20181030210130.18152-1-sven@narfation.org>
References: <20181030210130.18152-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/9] batman-adv: Add inconsistent gateway
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
To: b.a.t.m.a.n@lists.open-mesh.org

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
---
 net/batman-adv/bat_iv_ogm.c     | 24 +++++++++++++++---------
 net/batman-adv/bat_v.c          | 26 +++++++++++++++++---------
 net/batman-adv/gateway_client.c |  3 +++
 net/batman-adv/main.c           |  2 ++
 net/batman-adv/types.h          |  5 ++++-
 5 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index d2227091..b9e2d1c8 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2585,13 +2585,14 @@ static void batadv_iv_gw_print(struct batadv_priv *bat_priv,
  * batadv_iv_gw_dump_entry() - Dump a gateway into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
- * @seq: Sequence number of netlink message
+ * @cb: Control block containing additional options
  * @bat_priv: The bat priv with all the soft interface information
  * @gw_node: Gateway to be dumped
  *
  * Return: Error code, or 0 on success
  */
-static int batadv_iv_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+static int batadv_iv_gw_dump_entry(struct sk_buff *msg, u32 portid,
+				   struct netlink_callback *cb,
 				   struct batadv_priv *bat_priv,
 				   struct batadv_gw_node *gw_node)
 {
@@ -2611,13 +2612,16 @@ static int batadv_iv_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 
 	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 
-	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
-			  NLM_F_MULTI, BATADV_CMD_GET_GATEWAYS);
+	hdr = genlmsg_put(msg, portid, cb->nlh->nlmsg_seq,
+			  &batadv_netlink_family, NLM_F_MULTI,
+			  BATADV_CMD_GET_GATEWAYS);
 	if (!hdr) {
 		ret = -ENOBUFS;
 		goto out;
 	}
 
+	genl_dump_check_consistent(cb, hdr);
+
 	ret = -EMSGSIZE;
 
 	if (curr_gw == gw_node)
@@ -2668,13 +2672,15 @@ static void batadv_iv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb,
 	int idx_skip = cb->args[0];
 	int idx = 0;
 
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.gateway_list, list) {
+	spin_lock_bh(&bat_priv->gw.list_lock);
+	cb->seq = bat_priv->gw.generation << 1 | 1;
+
+	hlist_for_each_entry(gw_node, &bat_priv->gw.gateway_list, list) {
 		if (idx++ < idx_skip)
 			continue;
 
-		if (batadv_iv_gw_dump_entry(msg, portid, cb->nlh->nlmsg_seq,
-					    bat_priv, gw_node)) {
+		if (batadv_iv_gw_dump_entry(msg, portid, cb, bat_priv,
+					    gw_node)) {
 			idx_skip = idx - 1;
 			goto unlock;
 		}
@@ -2682,7 +2688,7 @@ static void batadv_iv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb,
 
 	idx_skip = idx;
 unlock:
-	rcu_read_unlock();
+	spin_unlock_bh(&bat_priv->gw.list_lock);
 
 	cb->args[0] = idx_skip;
 }
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 6baec4e6..90e33f84 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -27,11 +27,13 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
+#include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
+#include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
@@ -915,13 +917,14 @@ static void batadv_v_gw_print(struct batadv_priv *bat_priv,
  * batadv_v_gw_dump_entry() - Dump a gateway into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
- * @seq: Sequence number of netlink message
+ * @cb: Control block containing additional options
  * @bat_priv: The bat priv with all the soft interface information
  * @gw_node: Gateway to be dumped
  *
  * Return: Error code, or 0 on success
  */
-static int batadv_v_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+static int batadv_v_gw_dump_entry(struct sk_buff *msg, u32 portid,
+				  struct netlink_callback *cb,
 				  struct batadv_priv *bat_priv,
 				  struct batadv_gw_node *gw_node)
 {
@@ -941,13 +944,16 @@ static int batadv_v_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 
 	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 
-	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
-			  NLM_F_MULTI, BATADV_CMD_GET_GATEWAYS);
+	hdr = genlmsg_put(msg, portid, cb->nlh->nlmsg_seq,
+			  &batadv_netlink_family, NLM_F_MULTI,
+			  BATADV_CMD_GET_GATEWAYS);
 	if (!hdr) {
 		ret = -ENOBUFS;
 		goto out;
 	}
 
+	genl_dump_check_consistent(cb, hdr);
+
 	ret = -EMSGSIZE;
 
 	if (curr_gw == gw_node) {
@@ -1018,13 +1024,15 @@ static void batadv_v_gw_dump(struct sk_buff *msg, struct netlink_callback *cb,
 	int idx_skip = cb->args[0];
 	int idx = 0;
 
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.gateway_list, list) {
+	spin_lock_bh(&bat_priv->gw.list_lock);
+	cb->seq = bat_priv->gw.generation << 1 | 1;
+
+	hlist_for_each_entry(gw_node, &bat_priv->gw.gateway_list, list) {
 		if (idx++ < idx_skip)
 			continue;
 
-		if (batadv_v_gw_dump_entry(msg, portid, cb->nlh->nlmsg_seq,
-					   bat_priv, gw_node)) {
+		if (batadv_v_gw_dump_entry(msg, portid, cb, bat_priv,
+					   gw_node)) {
 			idx_skip = idx - 1;
 			goto unlock;
 		}
@@ -1032,7 +1040,7 @@ static void batadv_v_gw_dump(struct sk_buff *msg, struct netlink_callback *cb,
 
 	idx_skip = idx;
 unlock:
-	rcu_read_unlock();
+	spin_unlock_bh(&bat_priv->gw.list_lock);
 
 	cb->args[0] = idx_skip;
 }
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 140c61a3..9d8e5eda 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -377,6 +377,7 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 
 	kref_get(&gw_node->refcount);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw.gateway_list);
+	bat_priv->gw.generation++;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Found new gateway %pM -> gw bandwidth: %u.%u/%u.%u MBit\n",
@@ -472,6 +473,7 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 		if (!hlist_unhashed(&gw_node->list)) {
 			hlist_del_init_rcu(&gw_node->list);
 			batadv_gw_node_put(gw_node);
+			bat_priv->gw.generation++;
 		}
 		spin_unlock_bh(&bat_priv->gw.list_lock);
 
@@ -518,6 +520,7 @@ void batadv_gw_node_free(struct batadv_priv *bat_priv)
 				  &bat_priv->gw.gateway_list, list) {
 		hlist_del_init_rcu(&gw_node->list);
 		batadv_gw_node_put(gw_node);
+		bat_priv->gw.generation++;
 	}
 	spin_unlock_bh(&bat_priv->gw.list_lock);
 }
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 69c0d85b..c75e4782 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -186,6 +186,8 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	INIT_HLIST_HEAD(&bat_priv->softif_vlan_list);
 	INIT_HLIST_HEAD(&bat_priv->tp_list);
 
+	bat_priv->gw.generation = 0;
+
 	ret = batadv_v_mesh_init(bat_priv);
 	if (ret < 0)
 		goto err;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 45b5592d..cbe17da3 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1096,12 +1096,15 @@ struct batadv_priv_gw {
 	/** @gateway_list: list of available gateway nodes */
 	struct hlist_head gateway_list;
 
-	/** @list_lock: lock protecting gateway_list & curr_gw */
+	/** @list_lock: lock protecting gateway_list, curr_gw, generation */
 	spinlock_t list_lock;
 
 	/** @curr_gw: pointer to currently selected gateway node */
 	struct batadv_gw_node __rcu *curr_gw;
 
+	/** @generation: current (generation) sequence number */
+	unsigned int generation;
+
 	/**
 	 * @mode: gateway operation: off, client or server (see batadv_gw_modes)
 	 */
-- 
2.19.1

