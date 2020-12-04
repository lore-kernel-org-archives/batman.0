Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/8] batman-adv: Allow selection of routing algorithm over rtnetlink
Date: Fri,  4 Dec 2020 16:46:27 +0100
Message-Id: <20201204154631.21063-5-sw@simonwunderlich.de>
In-Reply-To: <20201204154631.21063-1-sw@simonwunderlich.de>
References: <20201204154631.21063-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

A batadv net_device is associated to a B.A.T.M.A.N. routing algorithm. This
algorithm has to be selected before the interface is initialized and cannot
be changed after that. The only way to select this algorithm was a module
parameter which specifies the default algorithm used during the creation of
the net_device.

This module parameter is writeable over
/sys/module/batman_adv/parameters/routing_algo and thus allows switching of
the routing algorithm:

1. change routing_algo parameter
2. create new batadv net_device

But this is not race free because another process can be scheduled between
1 + 2 and in that time frame change the routing_algo parameter again.

It is much cleaner to directly provide this information inside the
rtnetlink's RTM_NEWLINK message. The two processes would be (in regards of
the creation parameter of their batadv interfaces) be isolated. This also
eases the integration of batadv devices inside tools like network-manager
or systemd-networkd which are not expecting to operate on /sys before a new
net_device is created.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/bat_algo.c       | 10 ++++++++--
 net/batman-adv/bat_algo.h       |  3 ++-
 net/batman-adv/soft-interface.c | 31 ++++++++++++++++++++++++++++---
 4 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index b05399d8a127..bdb317faa1dc 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -685,6 +685,12 @@ enum batadv_ifla_attrs {
 	 */
 	IFLA_BATADV_UNSPEC,
 
+	/**
+	 * @IFLA_BATADV_ALGO_NAME: routing algorithm (name) which should be
+	 *  used by the newly registered batadv net_device.
+	 */
+	IFLA_BATADV_ALGO_NAME,
+
 	/* add attributes above here, update the policy in soft-interface.c */
 
 	/**
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 382fbe51fd34..500db94a6b50 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -34,7 +34,13 @@ void batadv_algo_init(void)
 	INIT_HLIST_HEAD(&batadv_algo_list);
 }
 
-static struct batadv_algo_ops *batadv_algo_get(char *name)
+/**
+ * batadv_algo_get() - Search for algorithm with specific name
+ * @name: algorithm name to find
+ *
+ * Return: Pointer to batadv_algo_ops on success, NULL otherwise
+ */
+struct batadv_algo_ops *batadv_algo_get(const char *name)
 {
 	struct batadv_algo_ops *bat_algo_ops = NULL, *bat_algo_ops_tmp;
 
@@ -97,7 +103,7 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
  *
  * Return: 0 on success or negative error number in case of failure
  */
-int batadv_algo_select(struct batadv_priv *bat_priv, char *name)
+int batadv_algo_select(struct batadv_priv *bat_priv, const char *name)
 {
 	struct batadv_algo_ops *bat_algo_ops;
 
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 686a60bc9492..2ae140eac45d 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -18,8 +18,9 @@ extern char batadv_routing_algo[];
 extern struct list_head batadv_hardif_list;
 
 void batadv_algo_init(void);
+struct batadv_algo_ops *batadv_algo_get(const char *name);
 int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops);
-int batadv_algo_select(struct batadv_priv *bat_priv, char *name);
+int batadv_algo_select(struct batadv_priv *bat_priv, const char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_algo_dump(struct sk_buff *msg, struct netlink_callback *cb);
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 9c7b89689c97..8116631c11c5 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -846,9 +846,11 @@ static int batadv_softif_init_late(struct net_device *dev)
 
 	batadv_nc_init_bat_priv(bat_priv);
 
-	ret = batadv_algo_select(bat_priv, batadv_routing_algo);
-	if (ret < 0)
-		goto free_bat_counters;
+	if (!bat_priv->algo_ops) {
+		ret = batadv_algo_select(bat_priv, batadv_routing_algo);
+		if (ret < 0)
+			goto free_bat_counters;
+	}
 
 	ret = batadv_debugfs_add_meshif(dev);
 	if (ret < 0)
@@ -1085,6 +1087,17 @@ static void batadv_softif_init_early(struct net_device *dev)
 static int batadv_softif_validate(struct nlattr *tb[], struct nlattr *data[],
 				  struct netlink_ext_ack *extack)
 {
+	struct batadv_algo_ops *algo_ops;
+
+	if (!data)
+		return 0;
+
+	if (data[IFLA_BATADV_ALGO_NAME]) {
+		algo_ops = batadv_algo_get(nla_data(data[IFLA_BATADV_ALGO_NAME]));
+		if (!algo_ops)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1102,6 +1115,17 @@ static int batadv_softif_newlink(struct net *src_net, struct net_device *dev,
 				 struct nlattr *tb[], struct nlattr *data[],
 				 struct netlink_ext_ack *extack)
 {
+	struct batadv_priv *bat_priv = netdev_priv(dev);
+	const char *algo_name;
+	int err;
+
+	if (data && data[IFLA_BATADV_ALGO_NAME]) {
+		algo_name = nla_data(data[IFLA_BATADV_ALGO_NAME]);
+		err = batadv_algo_select(bat_priv, algo_name);
+		if (err)
+			return -EINVAL;
+	}
+
 	return register_netdevice(dev);
 }
 
@@ -1204,6 +1228,7 @@ bool batadv_softif_is_valid(const struct net_device *net_dev)
 }
 
 static const struct nla_policy batadv_ifla_policy[IFLA_BATADV_MAX + 1] = {
+	[IFLA_BATADV_ALGO_NAME]	= { .type = NLA_NUL_STRING },
 };
 
 struct rtnl_link_ops batadv_link_ops __read_mostly = {
-- 
2.20.1

