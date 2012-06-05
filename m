Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jun 2012 22:31:31 +0200
Message-Id: <1338928292-23085-5-git-send-email-sven@narfation.org>
In-Reply-To: <1338928292-23085-1-git-send-email-sven@narfation.org>
References: <1338928292-23085-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: Prefix types structs with
	batadv_
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

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_debugfs.c           |   27 +--
 bat_iv_ogm.c            |  125 ++++++-------
 bat_sysfs.c             |   45 ++---
 bat_sysfs.h             |    2 +-
 bitarray.c              |    2 +-
 bridge_loop_avoidance.c |  188 ++++++++++----------
 bridge_loop_avoidance.h |   44 ++---
 compat.c                |   22 +--
 gateway_client.c        |   90 +++++-----
 gateway_client.h        |   24 +--
 gateway_common.c        |    2 +-
 hard-interface.c        |   71 ++++----
 hard-interface.h        |   14 +-
 icmp_socket.c           |   41 ++---
 icmp_socket.h           |    2 +-
 main.c                  |   40 +++--
 main.h                  |   24 +--
 originator.c            |  102 ++++++-----
 originator.h            |   35 ++--
 routing.c               |  144 +++++++--------
 routing.h               |   50 +++---
 send.c                  |   50 +++---
 send.h                  |   12 +-
 soft-interface.c        |   18 +-
 soft-interface.h        |    2 +-
 translation-table.c     |  446 ++++++++++++++++++++++++-----------------------
 translation-table.h     |   39 +++--
 types.h                 |  104 +++++------
 unicast.c               |   32 ++--
 unicast.h               |    9 +-
 vis.c                   |  173 +++++++++---------
 vis.h                   |    8 +-
 32 files changed, 1038 insertions(+), 949 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index fbdd5d6..b9e29ff 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -40,7 +40,7 @@ static struct dentry *batadv_debugfs;
 
 static int batadv_log_buff_len = BATADV_LOG_BUF_LEN;
 
-static void batadv_emit_log_char(struct debug_log *debug_log, char c)
+static void batadv_emit_log_char(struct batadv_debug_log *debug_log, char c)
 {
 	BATADV_LOG_BUFF(debug_log->log_end) = c;
 	debug_log->log_end++;
@@ -50,7 +50,8 @@ static void batadv_emit_log_char(struct debug_log *debug_log, char c)
 }
 
 __printf(2, 3)
-static int batadv_fdebug_log(struct debug_log *debug_log, const char *fmt, ...)
+static int batadv_fdebug_log(struct batadv_debug_log *debug_log,
+			     const char *fmt, ...)
 {
 	va_list args;
 	static char debug_log_buf[256];
@@ -74,7 +75,7 @@ static int batadv_fdebug_log(struct debug_log *debug_log, const char *fmt, ...)
 	return 0;
 }
 
-int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, ...)
+int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
 {
 	va_list args;
 	char tmp_log_buf[256];
@@ -105,8 +106,8 @@ static int batadv_log_release(struct inode *inode, struct file *file)
 static ssize_t batadv_log_read(struct file *file, char __user *buf,
 			       size_t count, loff_t *ppos)
 {
-	struct bat_priv *bat_priv = file->private_data;
-	struct debug_log *debug_log = bat_priv->debug_log;
+	struct batadv_priv *bat_priv = file->private_data;
+	struct batadv_debug_log *debug_log = bat_priv->debug_log;
 	int error, i = 0;
 	char c;
 
@@ -158,8 +159,8 @@ static ssize_t batadv_log_read(struct file *file, char __user *buf,
 
 static unsigned int batadv_log_poll(struct file *file, poll_table *wait)
 {
-	struct bat_priv *bat_priv = file->private_data;
-	struct debug_log *debug_log = bat_priv->debug_log;
+	struct batadv_priv *bat_priv = file->private_data;
+	struct batadv_debug_log *debug_log = bat_priv->debug_log;
 
 	poll_wait(file, &debug_log->queue_wait, wait);
 
@@ -177,7 +178,7 @@ static const struct file_operations batadv_log_fops = {
 	.llseek         = no_llseek,
 };
 
-static int batadv_debug_log_setup(struct bat_priv *bat_priv)
+static int batadv_debug_log_setup(struct batadv_priv *bat_priv)
 {
 	struct dentry *d;
 
@@ -203,19 +204,19 @@ err:
 	return 1;
 }
 
-static void batadv_debug_log_cleanup(struct bat_priv *bat_priv)
+static void batadv_debug_log_cleanup(struct batadv_priv *bat_priv)
 {
 	kfree(bat_priv->debug_log);
 	bat_priv->debug_log = NULL;
 }
 #else /* CONFIG_BATMAN_ADV_DEBUG */
-static int batadv_debug_log_setup(struct bat_priv *bat_priv)
+static int batadv_debug_log_setup(struct batadv_priv *bat_priv)
 {
 	bat_priv->debug_log = NULL;
 	return 0;
 }
 
-static void batadv_debug_log_cleanup(struct bat_priv *bat_priv)
+static void batadv_debug_log_cleanup(struct batadv_priv *bat_priv)
 {
 	return;
 }
@@ -339,7 +340,7 @@ void batadv_debugfs_destroy(void)
 
 int batadv_debugfs_add_meshif(struct net_device *dev)
 {
-	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct batadv_priv *bat_priv = netdev_priv(dev);
 	struct batadv_debuginfo **bat_debug;
 	struct dentry *file;
 
@@ -379,7 +380,7 @@ out:
 
 void batadv_debugfs_del_meshif(struct net_device *dev)
 {
-	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct batadv_priv *bat_priv = netdev_priv(dev);
 
 	batadv_debug_log_cleanup(bat_priv);
 
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index e431976..1dfe0e4 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -28,13 +28,13 @@
 #include "send.h"
 #include "bat_algo.h"
 
-static struct neigh_node *batadv_iv_ogm_neigh_new(struct hard_iface *hard_iface,
-						  const uint8_t *neigh_addr,
-						  struct orig_node *orig_node,
-						  struct orig_node *orig_neigh,
-						  __be32 seqno)
+static struct batadv_neigh_node *
+batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
+			const uint8_t *neigh_addr,
+			struct batadv_orig_node *orig_node,
+			struct batadv_orig_node *orig_neigh, __be32 seqno)
 {
-	struct neigh_node *neigh_node;
+	struct batadv_neigh_node *neigh_node;
 
 	neigh_node = batadv_neigh_node_new(hard_iface, neigh_addr,
 					   ntohl(seqno));
@@ -54,7 +54,7 @@ out:
 	return neigh_node;
 }
 
-static int batadv_iv_ogm_iface_enable(struct hard_iface *hard_iface)
+static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	uint32_t random_seqno;
@@ -85,13 +85,13 @@ out:
 	return res;
 }
 
-static void batadv_iv_ogm_iface_disable(struct hard_iface *hard_iface)
+static void batadv_iv_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 {
 	kfree(hard_iface->packet_buff);
 	hard_iface->packet_buff = NULL;
 }
 
-static void batadv_iv_ogm_iface_update_mac(struct hard_iface *hard_iface)
+static void batadv_iv_ogm_iface_update_mac(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_ogm_packet *batadv_ogm_packet;
 
@@ -102,7 +102,8 @@ static void batadv_iv_ogm_iface_update_mac(struct hard_iface *hard_iface)
 	       hard_iface->net_dev->dev_addr, ETH_ALEN);
 }
 
-static void batadv_iv_ogm_primary_iface_set(struct hard_iface *hard_iface)
+static void
+batadv_iv_ogm_primary_iface_set(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_ogm_packet *batadv_ogm_packet;
 
@@ -113,7 +114,7 @@ static void batadv_iv_ogm_primary_iface_set(struct hard_iface *hard_iface)
 
 /* when do we schedule our own ogm to be sent */
 static unsigned long
-batadv_iv_ogm_emit_send_time(const struct bat_priv *bat_priv)
+batadv_iv_ogm_emit_send_time(const struct batadv_priv *bat_priv)
 {
 	unsigned int msecs;
 
@@ -130,7 +131,8 @@ static unsigned long batadv_iv_ogm_fwd_send_time(void)
 }
 
 /* apply hop penalty for a normal link */
-static uint8_t batadv_hop_penalty(uint8_t tq, const struct bat_priv *bat_priv)
+static uint8_t batadv_hop_penalty(uint8_t tq,
+				  const struct batadv_priv *bat_priv)
 {
 	int hop_penalty = atomic_read(&bat_priv->hop_penalty);
 	int new_tq;
@@ -155,10 +157,10 @@ static int batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 }
 
 /* send a batman ogm to a given interface */
-static void batadv_iv_ogm_send_to_if(struct forw_packet *forw_packet,
-				  struct hard_iface *hard_iface)
+static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
+				     struct batadv_hard_iface *hard_iface)
 {
-	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	char *fwd_str;
 	uint8_t packet_num;
 	int16_t buff_pos;
@@ -217,12 +219,12 @@ static void batadv_iv_ogm_send_to_if(struct forw_packet *forw_packet,
 }
 
 /* send a batman ogm packet */
-static void batadv_iv_ogm_emit(struct forw_packet *forw_packet)
+static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
-	struct hard_iface *hard_iface;
+	struct batadv_hard_iface *hard_iface;
 	struct net_device *soft_iface;
-	struct bat_priv *bat_priv;
-	struct hard_iface *primary_if = NULL;
+	struct batadv_priv *bat_priv;
+	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	unsigned char directlink;
 
@@ -288,15 +290,15 @@ out:
 /* return true if new_packet can be aggregated with forw_packet */
 static bool
 batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
-			    struct bat_priv *bat_priv,
+			    struct batadv_priv *bat_priv,
 			    int packet_len, unsigned long send_time,
 			    bool directlink,
-			    const struct hard_iface *if_incoming,
-			    const struct forw_packet *forw_packet)
+			    const struct batadv_hard_iface *if_incoming,
+			    const struct batadv_forw_packet *forw_packet)
 {
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	int aggregated_bytes = forw_packet->packet_len + packet_len;
-	struct hard_iface *primary_if = NULL;
+	struct batadv_hard_iface *primary_if = NULL;
 	bool res = false;
 	unsigned long aggregation_end_time;
 
@@ -371,11 +373,11 @@ out:
 static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 					int packet_len, unsigned long send_time,
 					bool direct_link,
-					struct hard_iface *if_incoming,
+					struct batadv_hard_iface *if_incoming,
 					int own_packet)
 {
-	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
-	struct forw_packet *forw_packet_aggr;
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_forw_packet *forw_packet_aggr;
 	unsigned char *skb_buff;
 	unsigned int skb_size;
 
@@ -447,7 +449,7 @@ out:
 }
 
 /* aggregate a new packet into the existing ogm packet */
-static void batadv_iv_ogm_aggregate(struct forw_packet *forw_packet_aggr,
+static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
 				    const unsigned char *packet_buff,
 				    int packet_len, bool direct_link)
 {
@@ -464,16 +466,17 @@ static void batadv_iv_ogm_aggregate(struct forw_packet *forw_packet_aggr,
 			(1 << forw_packet_aggr->num_packets);
 }
 
-static void batadv_iv_ogm_queue_add(struct bat_priv *bat_priv,
+static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 				    unsigned char *packet_buff,
 				    int packet_len,
-				    struct hard_iface *if_incoming,
+				    struct batadv_hard_iface *if_incoming,
 				    int own_packet, unsigned long send_time)
 {
 	/* _aggr -> pointer to the packet we want to aggregate with
 	 * _pos -> pointer to the position in the queue
 	 */
-	struct forw_packet *forw_packet_aggr = NULL, *forw_packet_pos = NULL;
+	struct batadv_forw_packet *forw_packet_aggr = NULL;
+	struct batadv_forw_packet *forw_packet_pos = NULL;
 	struct hlist_node *tmp_node;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	bool direct_link;
@@ -524,14 +527,14 @@ static void batadv_iv_ogm_queue_add(struct bat_priv *bat_priv,
 	}
 }
 
-static void batadv_iv_ogm_forward(struct orig_node *orig_node,
+static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 				  const struct ethhdr *ethhdr,
 				  struct batadv_ogm_packet *batadv_ogm_packet,
 				  bool is_single_hop_neigh,
 				  bool is_from_best_next_hop,
-				  struct hard_iface *if_incoming)
+				  struct batadv_hard_iface *if_incoming)
 {
-	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	uint8_t tt_num_changes;
 
 	if (batadv_ogm_packet->header.ttl <= 1) {
@@ -577,11 +580,11 @@ static void batadv_iv_ogm_forward(struct orig_node *orig_node,
 				if_incoming, 0, batadv_iv_ogm_fwd_send_time());
 }
 
-static void batadv_iv_ogm_schedule(struct hard_iface *hard_iface)
+static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 {
-	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_ogm_packet *batadv_ogm_packet;
-	struct hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if;
 	int vis_server, tt_num_changes = 0;
 
 	vis_server = atomic_read(&bat_priv->vis_mode);
@@ -627,17 +630,17 @@ static void batadv_iv_ogm_schedule(struct hard_iface *hard_iface)
 }
 
 static void
-batadv_iv_ogm_orig_update(struct bat_priv *bat_priv,
-			  struct orig_node *orig_node,
+batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
+			  struct batadv_orig_node *orig_node,
 			  const struct ethhdr *ethhdr,
 			  const struct batadv_ogm_packet *batadv_ogm_packet,
-			  struct hard_iface *if_incoming,
+			  struct batadv_hard_iface *if_incoming,
 			  const unsigned char *tt_buff,
 			  int is_duplicate)
 {
-	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
-	struct neigh_node *router = NULL;
-	struct orig_node *orig_node_tmp;
+	struct batadv_neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
+	struct batadv_neigh_node *router = NULL;
+	struct batadv_orig_node *orig_node_tmp;
 	struct hlist_node *node;
 	uint8_t bcast_own_sum_orig, bcast_own_sum_neigh;
 	uint8_t *neigh_addr;
@@ -670,7 +673,7 @@ batadv_iv_ogm_orig_update(struct bat_priv *bat_priv,
 	}
 
 	if (!neigh_node) {
-		struct orig_node *orig_tmp;
+		struct batadv_orig_node *orig_tmp;
 
 		orig_tmp = batadv_get_orig_node(bat_priv, ethhdr->h_source);
 		if (!orig_tmp)
@@ -775,13 +778,13 @@ out:
 		batadv_neigh_node_free_ref(router);
 }
 
-static int batadv_iv_ogm_calc_tq(struct orig_node *orig_node,
-				 struct orig_node *orig_neigh_node,
+static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
+				 struct batadv_orig_node *orig_neigh_node,
 				 struct batadv_ogm_packet *batadv_ogm_packet,
-				 struct hard_iface *if_incoming)
+				 struct batadv_hard_iface *if_incoming)
 {
-	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
-	struct neigh_node *neigh_node = NULL, *tmp_neigh_node;
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_neigh_node *neigh_node = NULL, *tmp_neigh_node;
 	struct hlist_node *node;
 	uint8_t total_count;
 	uint8_t orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
@@ -895,11 +898,11 @@ out:
 static int
 batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 			    const struct batadv_ogm_packet *batadv_ogm_packet,
-			    const struct hard_iface *if_incoming)
+			    const struct batadv_hard_iface *if_incoming)
 {
-	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
-	struct orig_node *orig_node;
-	struct neigh_node *tmp_neigh_node;
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_orig_node *orig_node;
+	struct batadv_neigh_node *tmp_neigh_node;
 	struct hlist_node *node;
 	int is_duplicate = 0;
 	int32_t seq_diff;
@@ -965,13 +968,13 @@ out:
 static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 				  struct batadv_ogm_packet *batadv_ogm_packet,
 				  const unsigned char *tt_buff,
-				  struct hard_iface *if_incoming)
+				  struct batadv_hard_iface *if_incoming)
 {
-	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
-	struct hard_iface *hard_iface;
-	struct orig_node *orig_neigh_node, *orig_node;
-	struct neigh_node *router = NULL, *router_router = NULL;
-	struct neigh_node *orig_neigh_router = NULL;
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_hard_iface *hard_iface;
+	struct batadv_orig_node *orig_neigh_node, *orig_node;
+	struct batadv_neigh_node *router = NULL, *router_router = NULL;
+	struct batadv_neigh_node *orig_neigh_router = NULL;
 	int has_directlink_flag;
 	int is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
 	int is_broadcast = 0, is_bidirect;
@@ -1240,9 +1243,9 @@ out:
 }
 
 static int batadv_iv_ogm_receive(struct sk_buff *skb,
-				 struct hard_iface *if_incoming)
+				 struct batadv_hard_iface *if_incoming)
 {
-	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct ethhdr *ethhdr;
 	int buff_pos = 0, packet_len;
@@ -1287,7 +1290,7 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 	return NET_RX_SUCCESS;
 }
 
-static struct bat_algo_ops batadv_batman_iv __read_mostly = {
+static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.name = "BATMAN_IV",
 	.bat_iface_enable = batadv_iv_ogm_iface_enable,
 	.bat_iface_disable = batadv_iv_ogm_iface_disable,
diff --git a/bat_sysfs.c b/bat_sysfs.c
index 56ed126..e0272fe 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -32,7 +32,7 @@ static struct net_device *batadv_kobj_to_netdev(struct kobject *obj)
 	return to_net_dev(dev);
 }
 
-static struct bat_priv *batadv_kobj_to_batpriv(struct kobject *obj)
+static struct batadv_priv *batadv_kobj_to_batpriv(struct kobject *obj)
 {
 	struct net_device *net_dev = batadv_kobj_to_netdev(obj);
 	return netdev_priv(net_dev);
@@ -67,7 +67,7 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 			     size_t count)				\
 {									\
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
-	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);		\
 	return __batadv_store_bool_attr(buff, count, _post_func, attr,	\
 					&bat_priv->_name, net_dev);	\
 }
@@ -76,7 +76,7 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 ssize_t batadv_show_##_name(struct kobject *kobj,			\
 			    struct attribute *attr, char *buff)		\
 {									\
-	struct bat_priv *bat_priv = batadv_kobj_to_batpriv(kobj);	\
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);	\
 	return sprintf(buff, "%s\n",					\
 		       atomic_read(&bat_priv->_name) == 0 ?		\
 		       "disabled" : "enabled");				\
@@ -98,7 +98,7 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 			     size_t count)				\
 {									\
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
-	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);		\
 	return __batadv_store_uint_attr(buff, count, _min, _max,	\
 					_post_func, attr,		\
 					&bat_priv->_name, net_dev);	\
@@ -108,7 +108,7 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 ssize_t batadv_show_##_name(struct kobject *kobj,			\
 			    struct attribute *attr, char *buff)		\
 {									\
-	struct bat_priv *bat_priv = batadv_kobj_to_batpriv(kobj);	\
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);	\
 	return sprintf(buff, "%i\n", atomic_read(&bat_priv->_name));	\
 }									\
 
@@ -128,7 +128,7 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 			     size_t count)				\
 {									\
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
-	struct hard_iface *hard_iface;					\
+	struct batadv_hard_iface *hard_iface;				\
 	ssize_t length;							\
 									\
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);		\
@@ -147,7 +147,7 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 			    struct attribute *attr, char *buff)		\
 {									\
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
-	struct hard_iface *hard_iface;					\
+	struct batadv_hard_iface *hard_iface;				\
 	ssize_t length;							\
 									\
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);		\
@@ -280,7 +280,7 @@ __batadv_store_uint_attr(const char *buff, size_t count,
 static ssize_t batadv_show_vis_mode(struct kobject *kobj,
 				    struct attribute *attr, char *buff)
 {
-	struct bat_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 	int vis_mode = atomic_read(&bat_priv->vis_mode);
 	const char *mode;
 
@@ -297,7 +297,7 @@ static ssize_t batadv_store_vis_mode(struct kobject *kobj,
 				     size_t count)
 {
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	unsigned long val;
 	int ret, vis_mode_tmp = -1;
 	const char *old_mode, *new_mode;
@@ -348,20 +348,20 @@ static ssize_t batadv_store_vis_mode(struct kobject *kobj,
 static ssize_t batadv_show_bat_algo(struct kobject *kobj,
 				    struct attribute *attr, char *buff)
 {
-	struct bat_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 	return sprintf(buff, "%s\n", bat_priv->bat_algo_ops->name);
 }
 
 static void batadv_post_gw_deselect(struct net_device *net_dev)
 {
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	batadv_gw_deselect(bat_priv);
 }
 
 static ssize_t batadv_show_gw_mode(struct kobject *kobj, struct attribute *attr,
 				   char *buff)
 {
-	struct bat_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 	int bytes_written;
 
 	switch (atomic_read(&bat_priv->gw_mode)) {
@@ -387,7 +387,7 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 				    size_t count)
 {
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	char *curr_gw_mode_str;
 	int gw_mode_tmp = -1;
 
@@ -439,7 +439,7 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 static ssize_t batadv_show_gw_bwidth(struct kobject *kobj,
 				     struct attribute *attr, char *buff)
 {
-	struct bat_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 	int down, up;
 	int gw_bandwidth = atomic_read(&bat_priv->gw_bandwidth);
 
@@ -511,7 +511,7 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 int batadv_sysfs_add_meshif(struct net_device *dev)
 {
 	struct kobject *batif_kobject = &dev->dev.kobj;
-	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct batadv_priv *bat_priv = netdev_priv(dev);
 	struct batadv_attribute **bat_attr;
 	int err;
 
@@ -548,7 +548,7 @@ out:
 
 void batadv_sysfs_del_meshif(struct net_device *dev)
 {
-	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct batadv_priv *bat_priv = netdev_priv(dev);
 	struct batadv_attribute **bat_attr;
 
 	for (bat_attr = batadv_mesh_attrs; *bat_attr; ++bat_attr)
@@ -562,10 +562,11 @@ static ssize_t batadv_show_mesh_iface(struct kobject *kobj,
 				      struct attribute *attr, char *buff)
 {
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
-	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev);
+	struct batadv_hard_iface *hard_iface;
 	ssize_t length;
 	const char *ifname;
 
+	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	if (!hard_iface)
 		return 0;
 
@@ -586,10 +587,11 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 				       size_t count)
 {
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
-	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev);
+	struct batadv_hard_iface *hard_iface;
 	int status_tmp = -1;
 	int ret = count;
 
+	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	if (!hard_iface)
 		return count;
 
@@ -642,9 +644,10 @@ static ssize_t batadv_show_iface_status(struct kobject *kobj,
 					struct attribute *attr, char *buff)
 {
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
-	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev);
+	struct batadv_hard_iface *hard_iface;
 	ssize_t length;
 
+	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	if (!hard_iface)
 		return 0;
 
@@ -722,11 +725,11 @@ void batadv_sysfs_del_hardif(struct kobject **hardif_obj)
 	*hardif_obj = NULL;
 }
 
-int batadv_throw_uevent(struct bat_priv *bat_priv, enum batadv_uev_type type,
+int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 			enum batadv_uev_action action, const char *data)
 {
 	int ret = -ENOMEM;
-	struct hard_iface *primary_if = NULL;
+	struct batadv_hard_iface *primary_if = NULL;
 	struct kobject *bat_kobj;
 	char *uevent_env[4] = { NULL, NULL, NULL, NULL };
 
diff --git a/bat_sysfs.h b/bat_sysfs.h
index 88f95f8..3fd1412 100644
--- a/bat_sysfs.h
+++ b/bat_sysfs.h
@@ -36,7 +36,7 @@ void batadv_sysfs_del_meshif(struct net_device *dev);
 int batadv_sysfs_add_hardif(struct kobject **hardif_obj,
 			    struct net_device *dev);
 void batadv_sysfs_del_hardif(struct kobject **hardif_obj);
-int batadv_throw_uevent(struct bat_priv *bat_priv, enum batadv_uev_type type,
+int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 			enum batadv_uev_action action, const char *data);
 
 #endif /* _NET_BATMAN_ADV_SYSFS_H_ */
diff --git a/bitarray.c b/bitarray.c
index 835d3b6..aea174c 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -41,7 +41,7 @@ static void batadv_bitmap_shift_left(unsigned long *seq_bits, int32_t n)
 int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
 			  int32_t seq_num_diff, int set_mark)
 {
-	struct bat_priv *bat_priv = priv;
+	struct batadv_priv *bat_priv = priv;
 
 	/* sequence number is slightly older. We already got a sequence number
 	 * higher than this one, so we just mark it.
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 48375fd..38aab1e 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -34,8 +34,8 @@
 static const uint8_t batadv_announce_mac[4] = {0x43, 0x05, 0x43, 0x05};
 
 static void batadv_bla_periodic_work(struct work_struct *work);
-static void batadv_bla_send_announce(struct bat_priv *bat_priv,
-				     struct backbone_gw *backbone_gw);
+static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
+				     struct batadv_backbone_gw *backbone_gw);
 
 /* return the index of the claim */
 static inline uint32_t batadv_choose_claim(const void *data, uint32_t size)
@@ -83,7 +83,7 @@ static inline uint32_t batadv_choose_backbone_gw(const void *data,
 static int batadv_compare_backbone_gw(const struct hlist_node *node,
 				      const void *data2)
 {
-	const void *data1 = container_of(node, struct backbone_gw,
+	const void *data1 = container_of(node, struct batadv_backbone_gw,
 					 hash_entry);
 
 	return (memcmp(data1, data2, ETH_ALEN + sizeof(short)) == 0 ? 1 : 0);
@@ -93,14 +93,14 @@ static int batadv_compare_backbone_gw(const struct hlist_node *node,
 static int batadv_compare_claim(const struct hlist_node *node,
 				const void *data2)
 {
-	const void *data1 = container_of(node, struct claim,
+	const void *data1 = container_of(node, struct batadv_claim,
 					 hash_entry);
 
 	return (memcmp(data1, data2, ETH_ALEN + sizeof(short)) == 0 ? 1 : 0);
 }
 
 /* free a backbone gw */
-static void batadv_backbone_gw_free_ref(struct backbone_gw *backbone_gw)
+static void batadv_backbone_gw_free_ref(struct batadv_backbone_gw *backbone_gw)
 {
 	if (atomic_dec_and_test(&backbone_gw->refcount))
 		kfree_rcu(backbone_gw, rcu);
@@ -109,16 +109,16 @@ static void batadv_backbone_gw_free_ref(struct backbone_gw *backbone_gw)
 /* finally deinitialize the claim */
 static void batadv_claim_free_rcu(struct rcu_head *rcu)
 {
-	struct claim *claim;
+	struct batadv_claim *claim;
 
-	claim = container_of(rcu, struct claim, rcu);
+	claim = container_of(rcu, struct batadv_claim, rcu);
 
 	batadv_backbone_gw_free_ref(claim->backbone_gw);
 	kfree(claim);
 }
 
 /* free a claim, call claim_free_rcu if its the last reference */
-static void batadv_claim_free_ref(struct claim *claim)
+static void batadv_claim_free_ref(struct batadv_claim *claim)
 {
 	if (atomic_dec_and_test(&claim->refcount))
 		call_rcu(&claim->rcu, batadv_claim_free_rcu);
@@ -130,14 +130,14 @@ static void batadv_claim_free_ref(struct claim *claim)
  * looks for a claim in the hash, and returns it if found
  * or NULL otherwise.
  */
-static struct claim *batadv_claim_hash_find(struct bat_priv *bat_priv,
-					    struct claim *data)
+static struct batadv_claim *batadv_claim_hash_find(struct batadv_priv *bat_priv,
+						   struct batadv_claim *data)
 {
 	struct batadv_hashtable *hash = bat_priv->claim_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct claim *claim;
-	struct claim *claim_tmp = NULL;
+	struct batadv_claim *claim;
+	struct batadv_claim *claim_tmp = NULL;
 	int index;
 
 	if (!hash)
@@ -169,14 +169,15 @@ static struct claim *batadv_claim_hash_find(struct bat_priv *bat_priv,
  * looks for a claim in the hash, and returns it if found
  * or NULL otherwise.
  */
-static struct backbone_gw *batadv_backbone_hash_find(struct bat_priv *bat_priv,
-						     uint8_t *addr, short vid)
+static struct batadv_backbone_gw *
+batadv_backbone_hash_find(struct batadv_priv *bat_priv,
+			  uint8_t *addr, short vid)
 {
 	struct batadv_hashtable *hash = bat_priv->backbone_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct backbone_gw search_entry, *backbone_gw;
-	struct backbone_gw *backbone_gw_tmp = NULL;
+	struct batadv_backbone_gw search_entry, *backbone_gw;
+	struct batadv_backbone_gw *backbone_gw_tmp = NULL;
 	int index;
 
 	if (!hash)
@@ -206,12 +207,13 @@ static struct backbone_gw *batadv_backbone_hash_find(struct bat_priv *bat_priv,
 }
 
 /* delete all claims for a backbone */
-static void batadv_bla_del_backbone_claims(struct backbone_gw *backbone_gw)
+static void
+batadv_bla_del_backbone_claims(struct batadv_backbone_gw *backbone_gw)
 {
 	struct batadv_hashtable *hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
-	struct claim *claim;
+	struct batadv_claim *claim;
 	int i;
 	spinlock_t *list_lock;	/* protects write access to the hash lists */
 
@@ -247,12 +249,12 @@ static void batadv_bla_del_backbone_claims(struct backbone_gw *backbone_gw)
  *
  * sends a claim frame according to the provided info.
  */
-static void batadv_bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
+static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 				  short vid, int claimtype)
 {
 	struct sk_buff *skb;
 	struct ethhdr *ethhdr;
-	struct hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if;
 	struct net_device *soft_iface;
 	uint8_t *hw_src;
 	struct batadv_bla_claim_dst local_claim_dest;
@@ -353,11 +355,12 @@ out:
  * searches for the backbone gw or creates a new one if it could not
  * be found.
  */
-static struct backbone_gw *batadv_bla_get_backbone_gw(struct bat_priv *bat_priv,
-						      uint8_t *orig, short vid)
+static struct batadv_backbone_gw *
+batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, uint8_t *orig,
+			   short vid)
 {
-	struct backbone_gw *entry;
-	struct orig_node *orig_node;
+	struct batadv_backbone_gw *entry;
+	struct batadv_orig_node *orig_node;
 	int hash_added;
 
 	entry = batadv_backbone_hash_find(bat_priv, orig, vid);
@@ -407,11 +410,12 @@ static struct backbone_gw *batadv_bla_get_backbone_gw(struct bat_priv *bat_priv,
 /* update or add the own backbone gw to make sure we announce
  * where we receive other backbone gws
  */
-static void batadv_bla_update_own_backbone_gw(struct bat_priv *bat_priv,
-					      struct hard_iface *primary_if,
-					      short vid)
+static void
+batadv_bla_update_own_backbone_gw(struct batadv_priv *bat_priv,
+				  struct batadv_hard_iface *primary_if,
+				  short vid)
 {
-	struct backbone_gw *backbone_gw;
+	struct batadv_backbone_gw *backbone_gw;
 
 	backbone_gw = batadv_bla_get_backbone_gw(bat_priv,
 						 primary_if->net_dev->dev_addr,
@@ -429,14 +433,15 @@ static void batadv_bla_update_own_backbone_gw(struct bat_priv *bat_priv,
  * Repeat all of our own claims, and finally send an ANNOUNCE frame
  * to allow the requester another check if the CRC is correct now.
  */
-static void batadv_bla_answer_request(struct bat_priv *bat_priv,
-				      struct hard_iface *primary_if, short vid)
+static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
+				      struct batadv_hard_iface *primary_if,
+				      short vid)
 {
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct batadv_hashtable *hash;
-	struct claim *claim;
-	struct backbone_gw *backbone_gw;
+	struct batadv_claim *claim;
+	struct batadv_backbone_gw *backbone_gw;
 	int i;
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
@@ -475,7 +480,7 @@ static void batadv_bla_answer_request(struct bat_priv *bat_priv,
  * After the request, it will repeat all of his own claims and finally
  * send an announcement claim with which we can check again.
  */
-static void batadv_bla_send_request(struct backbone_gw *backbone_gw)
+static void batadv_bla_send_request(struct batadv_backbone_gw *backbone_gw)
 {
 	/* first, remove all old entries */
 	batadv_bla_del_backbone_claims(backbone_gw);
@@ -500,8 +505,8 @@ static void batadv_bla_send_request(struct backbone_gw *backbone_gw)
  * This function sends an announcement. It is called from multiple
  * places.
  */
-static void batadv_bla_send_announce(struct bat_priv *bat_priv,
-				     struct backbone_gw *backbone_gw)
+static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
+				     struct batadv_backbone_gw *backbone_gw)
 {
 	uint8_t mac[ETH_ALEN];
 	__be16 crc;
@@ -522,12 +527,12 @@ static void batadv_bla_send_announce(struct bat_priv *bat_priv,
  *
  * Adds a claim in the claim hash.
  */
-static void batadv_bla_add_claim(struct bat_priv *bat_priv, const uint8_t *mac,
-				 const short vid,
-				 struct backbone_gw *backbone_gw)
+static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
+				 const uint8_t *mac, const short vid,
+				 struct batadv_backbone_gw *backbone_gw)
 {
-	struct claim *claim;
-	struct claim search_claim;
+	struct batadv_claim *claim;
+	struct batadv_claim search_claim;
 	int hash_added;
 
 	memcpy(search_claim.addr, mac, ETH_ALEN);
@@ -588,10 +593,10 @@ claim_free_ref:
 /* Delete a claim from the claim hash which has the
  * given mac address and vid.
  */
-static void batadv_bla_del_claim(struct bat_priv *bat_priv, const uint8_t *mac,
-				 const short vid)
+static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
+				 const uint8_t *mac, const short vid)
 {
-	struct claim search_claim, *claim;
+	struct batadv_claim search_claim, *claim;
 
 	memcpy(search_claim.addr, mac, ETH_ALEN);
 	search_claim.vid = vid;
@@ -613,11 +618,11 @@ static void batadv_bla_del_claim(struct bat_priv *bat_priv, const uint8_t *mac,
 }
 
 /* check for ANNOUNCE frame, return 1 if handled */
-static int batadv_handle_announce(struct bat_priv *bat_priv,
+static int batadv_handle_announce(struct batadv_priv *bat_priv,
 				  uint8_t *an_addr, uint8_t *backbone_addr,
 				  short vid)
 {
-	struct backbone_gw *backbone_gw;
+	struct batadv_backbone_gw *backbone_gw;
 	uint16_t crc;
 
 	if (memcmp(an_addr, batadv_announce_mac, 4) != 0)
@@ -659,8 +664,8 @@ static int batadv_handle_announce(struct bat_priv *bat_priv,
 }
 
 /* check for REQUEST frame, return 1 if handled */
-static int batadv_handle_request(struct bat_priv *bat_priv,
-				 struct hard_iface *primary_if,
+static int batadv_handle_request(struct batadv_priv *bat_priv,
+				 struct batadv_hard_iface *primary_if,
 				 uint8_t *backbone_addr,
 				 struct ethhdr *ethhdr, short vid)
 {
@@ -683,12 +688,12 @@ static int batadv_handle_request(struct bat_priv *bat_priv,
 }
 
 /* check for UNCLAIM frame, return 1 if handled */
-static int batadv_handle_unclaim(struct bat_priv *bat_priv,
-				 struct hard_iface *primary_if,
+static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
+				 struct batadv_hard_iface *primary_if,
 				 uint8_t *backbone_addr,
 				 uint8_t *claim_addr, short vid)
 {
-	struct backbone_gw *backbone_gw;
+	struct batadv_backbone_gw *backbone_gw;
 
 	/* unclaim in any case if it is our own */
 	if (primary_if && batadv_compare_eth(backbone_addr,
@@ -712,12 +717,12 @@ static int batadv_handle_unclaim(struct bat_priv *bat_priv,
 }
 
 /* check for CLAIM frame, return 1 if handled */
-static int batadv_handle_claim(struct bat_priv *bat_priv,
-			       struct hard_iface *primary_if,
+static int batadv_handle_claim(struct batadv_priv *bat_priv,
+			       struct batadv_hard_iface *primary_if,
 			       uint8_t *backbone_addr, uint8_t *claim_addr,
 			       short vid)
 {
-	struct backbone_gw *backbone_gw;
+	struct batadv_backbone_gw *backbone_gw;
 
 	/* register the gateway if not yet available, and add the claim. */
 
@@ -752,13 +757,13 @@ static int batadv_handle_claim(struct bat_priv *bat_priv,
  *	1  - if is a claim packet from another group
  *	0  - if it is not a claim packet
  */
-static int batadv_check_claim_group(struct bat_priv *bat_priv,
-				    struct hard_iface *primary_if,
+static int batadv_check_claim_group(struct batadv_priv *bat_priv,
+				    struct batadv_hard_iface *primary_if,
 				    uint8_t *hw_src, uint8_t *hw_dst,
 				    struct ethhdr *ethhdr)
 {
 	uint8_t *backbone_addr;
-	struct orig_node *orig_node;
+	struct batadv_orig_node *orig_node;
 	struct batadv_bla_claim_dst *bla_dst, *bla_dst_own;
 
 	bla_dst = (struct batadv_bla_claim_dst *)hw_dst;
@@ -824,8 +829,8 @@ static int batadv_check_claim_group(struct bat_priv *bat_priv,
  * returns 1 if it was a claim frame, otherwise return 0 to
  * tell the callee that it can use the frame on its own.
  */
-static int batadv_bla_process_claim(struct bat_priv *bat_priv,
-				    struct hard_iface *primary_if,
+static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
+				    struct batadv_hard_iface *primary_if,
 				    struct sk_buff *skb)
 {
 	struct ethhdr *ethhdr;
@@ -926,9 +931,9 @@ static int batadv_bla_process_claim(struct bat_priv *bat_priv,
 /* Check when we last heard from other nodes, and remove them in case of
  * a time out, or clean all backbone gws if now is set.
  */
-static void batadv_bla_purge_backbone_gw(struct bat_priv *bat_priv, int now)
+static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 {
-	struct backbone_gw *backbone_gw;
+	struct batadv_backbone_gw *backbone_gw;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	struct batadv_hashtable *hash;
@@ -977,10 +982,11 @@ purge_now:
  * Check when we heard last time from our own claims, and remove them in case of
  * a time out, or clean all claims if now is set
  */
-static void batadv_bla_purge_claims(struct bat_priv *bat_priv,
-				    struct hard_iface *primary_if, int now)
+static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
+				    struct batadv_hard_iface *primary_if,
+				    int now)
 {
-	struct claim *claim;
+	struct batadv_claim *claim;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct batadv_hashtable *hash;
@@ -1023,11 +1029,11 @@ purge_now:
  *
  * Update the backbone gateways when the own orig address changes.
  */
-void batadv_bla_update_orig_address(struct bat_priv *bat_priv,
-				    struct hard_iface *primary_if,
-				    struct hard_iface *oldif)
+void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
+				    struct batadv_hard_iface *primary_if,
+				    struct batadv_hard_iface *oldif)
 {
-	struct backbone_gw *backbone_gw;
+	struct batadv_backbone_gw *backbone_gw;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct batadv_hashtable *hash;
@@ -1071,7 +1077,7 @@ void batadv_bla_update_orig_address(struct bat_priv *bat_priv,
 
 
 /* (re)start the timer */
-static void batadv_bla_start_timer(struct bat_priv *bat_priv)
+static void batadv_bla_start_timer(struct batadv_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->bla_work, batadv_bla_periodic_work);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->bla_work,
@@ -1086,15 +1092,15 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 {
 	struct delayed_work *delayed_work =
 		container_of(work, struct delayed_work, work);
-	struct bat_priv *bat_priv =
-		container_of(delayed_work, struct bat_priv, bla_work);
+	struct batadv_priv *bat_priv;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct backbone_gw *backbone_gw;
+	struct batadv_backbone_gw *backbone_gw;
 	struct batadv_hashtable *hash;
-	struct hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if;
 	int i;
 
+	bat_priv = container_of(delayed_work, struct batadv_priv, bla_work);
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
 		goto out;
@@ -1140,11 +1146,11 @@ static struct lock_class_key batadv_claim_hash_lock_class_key;
 static struct lock_class_key batadv_backbone_hash_lock_class_key;
 
 /* initialize all bla structures */
-int batadv_bla_init(struct bat_priv *bat_priv)
+int batadv_bla_init(struct batadv_priv *bat_priv)
 {
 	int i;
 	uint8_t claim_dest[ETH_ALEN] = {0xff, 0x43, 0x05, 0x00, 0x00, 0x00};
-	struct hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if;
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla hash registering\n");
 
@@ -1200,14 +1206,14 @@ int batadv_bla_init(struct bat_priv *bat_priv)
  * sent by another host, drop it. We allow equal packets from
  * the same host however as this might be intended.
  */
-int batadv_bla_check_bcast_duplist(struct bat_priv *bat_priv,
+int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				   struct batadv_bcast_packet *bcast_packet,
 				   int hdr_size)
 {
 	int i, length, curr;
 	uint8_t *content;
 	uint16_t crc;
-	struct bcast_duplist_entry *entry;
+	struct batadv_bcast_duplist_entry *entry;
 
 	length = hdr_size - sizeof(*bcast_packet);
 	content = (uint8_t *)bcast_packet;
@@ -1260,12 +1266,12 @@ int batadv_bla_check_bcast_duplist(struct bat_priv *bat_priv,
  *
  * returns 1 if it is found, 0 otherwise
  */
-int batadv_bla_is_backbone_gw_orig(struct bat_priv *bat_priv, uint8_t *orig)
+int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig)
 {
 	struct batadv_hashtable *hash = bat_priv->backbone_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct backbone_gw *backbone_gw;
+	struct batadv_backbone_gw *backbone_gw;
 	int i;
 
 	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
@@ -1300,11 +1306,11 @@ int batadv_bla_is_backbone_gw_orig(struct bat_priv *bat_priv, uint8_t *orig)
  * returns 0.
  */
 int batadv_bla_is_backbone_gw(struct sk_buff *skb,
-			      struct orig_node *orig_node, int hdr_size)
+			      struct batadv_orig_node *orig_node, int hdr_size)
 {
 	struct ethhdr *ethhdr;
 	struct vlan_ethhdr *vhdr;
-	struct backbone_gw *backbone_gw;
+	struct batadv_backbone_gw *backbone_gw;
 	short vid = -1;
 
 	if (!atomic_read(&orig_node->bat_priv->bridge_loop_avoidance))
@@ -1336,9 +1342,9 @@ int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 }
 
 /* free all bla structures (for softinterface free or module unload) */
-void batadv_bla_free(struct bat_priv *bat_priv)
+void batadv_bla_free(struct batadv_priv *bat_priv)
 {
-	struct hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if;
 
 	cancel_delayed_work_sync(&bat_priv->bla_work);
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -1369,11 +1375,11 @@ void batadv_bla_free(struct bat_priv *bat_priv)
  * returns 1, otherwise it returns 0 and the caller shall further
  * process the skb.
  */
-int batadv_bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
+int batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid)
 {
 	struct ethhdr *ethhdr;
-	struct claim search_claim, *claim = NULL;
-	struct hard_iface *primary_if;
+	struct batadv_claim search_claim, *claim = NULL;
+	struct batadv_hard_iface *primary_if;
 	int ret;
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
@@ -1456,11 +1462,11 @@ out:
  * returns 1, otherwise it returns 0 and the caller shall further
  * process the skb.
  */
-int batadv_bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
+int batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid)
 {
 	struct ethhdr *ethhdr;
-	struct claim search_claim, *claim = NULL;
-	struct hard_iface *primary_if;
+	struct batadv_claim search_claim, *claim = NULL;
+	struct batadv_hard_iface *primary_if;
 	int ret = 0;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -1533,10 +1539,10 @@ out:
 int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hashtable *hash = bat_priv->claim_hash;
-	struct claim *claim;
-	struct hard_iface *primary_if;
+	struct batadv_claim *claim;
+	struct batadv_hard_iface *primary_if;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	uint32_t i;
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index d69f453..08d13cb 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -21,38 +21,38 @@
 #define _NET_BATMAN_ADV_BLA_H_
 
 #ifdef CONFIG_BATMAN_ADV_BLA
-int batadv_bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid);
-int batadv_bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid);
+int batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid);
+int batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid);
 int batadv_bla_is_backbone_gw(struct sk_buff *skb,
-			      struct orig_node *orig_node, int hdr_size);
+			      struct batadv_orig_node *orig_node, int hdr_size);
 int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset);
-int batadv_bla_is_backbone_gw_orig(struct bat_priv *bat_priv, uint8_t *orig);
-int batadv_bla_check_bcast_duplist(struct bat_priv *bat_priv,
+int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig);
+int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				   struct batadv_bcast_packet *bcast_packet,
 				   int hdr_size);
-void batadv_bla_update_orig_address(struct bat_priv *bat_priv,
-				    struct hard_iface *primary_if,
-				    struct hard_iface *oldif);
-int batadv_bla_init(struct bat_priv *bat_priv);
-void batadv_bla_free(struct bat_priv *bat_priv);
+void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
+				    struct batadv_hard_iface *primary_if,
+				    struct batadv_hard_iface *oldif);
+int batadv_bla_init(struct batadv_priv *bat_priv);
+void batadv_bla_free(struct batadv_priv *bat_priv);
 
 #define BATADV_BLA_CRC_INIT	0
 #else /* ifdef CONFIG_BATMAN_ADV_BLA */
 
-static inline int batadv_bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb,
-				short vid)
+static inline int batadv_bla_rx(struct batadv_priv *bat_priv,
+				struct sk_buff *skb, short vid)
 {
 	return 0;
 }
 
-static inline int batadv_bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb,
-				short vid)
+static inline int batadv_bla_tx(struct batadv_priv *bat_priv,
+				struct sk_buff *skb, short vid)
 {
 	return 0;
 }
 
 static inline int batadv_bla_is_backbone_gw(struct sk_buff *skb,
-					    struct orig_node *orig_node,
+					    struct batadv_orig_node *orig_node,
 					    int hdr_size)
 {
 	return 0;
@@ -64,14 +64,14 @@ static inline int batadv_bla_claim_table_seq_print_text(struct seq_file *seq,
 	return 0;
 }
 
-static inline int batadv_bla_is_backbone_gw_orig(struct bat_priv *bat_priv,
+static inline int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv,
 						 uint8_t *orig)
 {
 	return 0;
 }
 
 static inline int
-batadv_bla_check_bcast_duplist(struct bat_priv *bat_priv,
+batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 			       struct batadv_bcast_packet *bcast_packet,
 			       int hdr_size)
 {
@@ -79,18 +79,18 @@ batadv_bla_check_bcast_duplist(struct bat_priv *bat_priv,
 }
 
 static inline void
-batadv_bla_update_orig_address(struct bat_priv *bat_priv,
-			       struct hard_iface *primary_if,
-			       struct hard_iface *oldif)
+batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
+			       struct batadv_hard_iface *primary_if,
+			       struct batadv_hard_iface *oldif)
 {
 }
 
-static inline int batadv_bla_init(struct bat_priv *bat_priv)
+static inline int batadv_bla_init(struct batadv_priv *bat_priv)
 {
 	return 1;
 }
 
-static inline void batadv_bla_free(struct bat_priv *bat_priv)
+static inline void batadv_bla_free(struct batadv_priv *bat_priv)
 {
 }
 
diff --git a/compat.c b/compat.c
index 4b8b202..6114f72 100644
--- a/compat.c
+++ b/compat.c
@@ -29,37 +29,37 @@
 
 void batadv_free_rcu_gw_node(struct rcu_head *rcu)
 {
-	struct gw_node *gw_node;
+	struct batadv_gw_node *gw_node;
 
-	gw_node = container_of(rcu, struct gw_node, rcu);
+	gw_node = container_of(rcu, struct batadv_gw_node, rcu);
 	kfree(gw_node);
 }
 
 void batadv_free_rcu_neigh_node(struct rcu_head *rcu)
 {
-	struct neigh_node *neigh_node;
+	struct batadv_neigh_node *neigh_node;
 
-	neigh_node = container_of(rcu, struct neigh_node, rcu);
+	neigh_node = container_of(rcu, struct batadv_neigh_node, rcu);
 	kfree(neigh_node);
 }
 
 void batadv_free_rcu_tt_local_entry(struct rcu_head *rcu)
 {
-	struct tt_common_entry *tt_common_entry;
-	struct tt_local_entry *tt_local_entry;
+	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_local_entry *tt_local_entry;
 
-	tt_common_entry = container_of(rcu, struct tt_common_entry, rcu);
-	tt_local_entry = container_of(tt_common_entry, struct tt_local_entry,
-				      common);
+	tt_common_entry = container_of(rcu, struct batadv_tt_common_entry, rcu);
+	tt_local_entry = container_of(tt_common_entry,
+				      struct batadv_tt_local_entry, common);
 	kfree(tt_local_entry);
 }
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 void batadv_free_rcu_backbone_gw(struct rcu_head *rcu)
 {
-	struct backbone_gw *backbone_gw;
+	struct batadv_backbone_gw *backbone_gw;
 
-	backbone_gw = container_of(rcu, struct backbone_gw, rcu);
+	backbone_gw = container_of(rcu, struct batadv_backbone_gw, rcu);
 	kfree(backbone_gw);
 }
 #endif
diff --git a/gateway_client.c b/gateway_client.c
index f674029..13bca58 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -36,15 +36,16 @@
 #define BATADV_DHCP_OPTIONS_OFFSET 240
 #define BATADV_DHCP_REQUEST 3
 
-static void batadv_gw_node_free_ref(struct gw_node *gw_node)
+static void batadv_gw_node_free_ref(struct batadv_gw_node *gw_node)
 {
 	if (atomic_dec_and_test(&gw_node->refcount))
 		kfree_rcu(gw_node, rcu);
 }
 
-static struct gw_node *batadv_gw_get_selected_gw_node(struct bat_priv *bat_priv)
+static struct batadv_gw_node *
+batadv_gw_get_selected_gw_node(struct batadv_priv *bat_priv)
 {
-	struct gw_node *gw_node;
+	struct batadv_gw_node *gw_node;
 
 	rcu_read_lock();
 	gw_node = rcu_dereference(bat_priv->curr_gw);
@@ -59,10 +60,11 @@ out:
 	return gw_node;
 }
 
-struct orig_node *batadv_gw_get_selected_orig(struct bat_priv *bat_priv)
+struct batadv_orig_node *
+batadv_gw_get_selected_orig(struct batadv_priv *bat_priv)
 {
-	struct gw_node *gw_node;
-	struct orig_node *orig_node = NULL;
+	struct batadv_gw_node *gw_node;
+	struct batadv_orig_node *orig_node = NULL;
 
 	gw_node = batadv_gw_get_selected_gw_node(bat_priv);
 	if (!gw_node)
@@ -84,10 +86,10 @@ out:
 	return orig_node;
 }
 
-static void batadv_gw_select(struct bat_priv *bat_priv,
-			     struct gw_node *new_gw_node)
+static void batadv_gw_select(struct batadv_priv *bat_priv,
+			     struct batadv_gw_node *new_gw_node)
 {
-	struct gw_node *curr_gw_node;
+	struct batadv_gw_node *curr_gw_node;
 
 	spin_lock_bh(&bat_priv->gw_list_lock);
 
@@ -103,20 +105,21 @@ static void batadv_gw_select(struct bat_priv *bat_priv,
 	spin_unlock_bh(&bat_priv->gw_list_lock);
 }
 
-void batadv_gw_deselect(struct bat_priv *bat_priv)
+void batadv_gw_deselect(struct batadv_priv *bat_priv)
 {
 	atomic_set(&bat_priv->gw_reselect, 1);
 }
 
-static struct gw_node *batadv_gw_get_best_gw_node(struct bat_priv *bat_priv)
+static struct batadv_gw_node *
+batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 {
-	struct neigh_node *router;
+	struct batadv_neigh_node *router;
 	struct hlist_node *node;
-	struct gw_node *gw_node, *curr_gw = NULL;
+	struct batadv_gw_node *gw_node, *curr_gw = NULL;
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
 	uint8_t max_tq = 0;
 	int down, up;
-	struct orig_node *orig_node;
+	struct batadv_orig_node *orig_node;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
@@ -183,10 +186,10 @@ next:
 	return curr_gw;
 }
 
-void batadv_gw_election(struct bat_priv *bat_priv)
+void batadv_gw_election(struct batadv_priv *bat_priv)
 {
-	struct gw_node *curr_gw = NULL, *next_gw = NULL;
-	struct neigh_node *router = NULL;
+	struct batadv_gw_node *curr_gw = NULL, *next_gw = NULL;
+	struct batadv_neigh_node *router = NULL;
 	char gw_addr[18] = { '\0' };
 
 	/* The batman daemon checks here if we already passed a full originator
@@ -249,11 +252,11 @@ out:
 		batadv_neigh_node_free_ref(router);
 }
 
-void batadv_gw_check_election(struct bat_priv *bat_priv,
-			      struct orig_node *orig_node)
+void batadv_gw_check_election(struct batadv_priv *bat_priv,
+			      struct batadv_orig_node *orig_node)
 {
-	struct orig_node *curr_gw_orig;
-	struct neigh_node *router_gw = NULL, *router_orig = NULL;
+	struct batadv_orig_node *curr_gw_orig;
+	struct batadv_neigh_node *router_gw = NULL, *router_orig = NULL;
 	uint8_t gw_tq_avg, orig_tq_avg;
 
 	curr_gw_orig = batadv_gw_get_selected_orig(bat_priv);
@@ -303,11 +306,11 @@ out:
 	return;
 }
 
-static void batadv_gw_node_add(struct bat_priv *bat_priv,
-			       struct orig_node *orig_node,
+static void batadv_gw_node_add(struct batadv_priv *bat_priv,
+			       struct batadv_orig_node *orig_node,
 			       uint8_t new_gwflags)
 {
-	struct gw_node *gw_node;
+	struct batadv_gw_node *gw_node;
 	int down, up;
 
 	gw_node = kzalloc(sizeof(*gw_node), GFP_ATOMIC);
@@ -332,11 +335,12 @@ static void batadv_gw_node_add(struct bat_priv *bat_priv,
 		   (up > 2048 ? "MBit" : "KBit"));
 }
 
-void batadv_gw_node_update(struct bat_priv *bat_priv,
-			   struct orig_node *orig_node, uint8_t new_gwflags)
+void batadv_gw_node_update(struct batadv_priv *bat_priv,
+			   struct batadv_orig_node *orig_node,
+			   uint8_t new_gwflags)
 {
 	struct hlist_node *node;
-	struct gw_node *gw_node, *curr_gw;
+	struct batadv_gw_node *gw_node, *curr_gw;
 
 	/* Note: We don't need a NULL check here, since curr_gw never gets
 	 * dereferenced. If curr_gw is NULL we also should not exit as we may
@@ -385,15 +389,15 @@ unlock:
 		batadv_gw_node_free_ref(curr_gw);
 }
 
-void batadv_gw_node_delete(struct bat_priv *bat_priv,
-			   struct orig_node *orig_node)
+void batadv_gw_node_delete(struct batadv_priv *bat_priv,
+			   struct batadv_orig_node *orig_node)
 {
 	batadv_gw_node_update(bat_priv, orig_node, 0);
 }
 
-void batadv_gw_node_purge(struct bat_priv *bat_priv)
+void batadv_gw_node_purge(struct batadv_priv *bat_priv)
 {
-	struct gw_node *gw_node, *curr_gw;
+	struct batadv_gw_node *gw_node, *curr_gw;
 	struct hlist_node *node, *node_tmp;
 	unsigned long timeout = msecs_to_jiffies(2 * BATADV_PURGE_TIMEOUT);
 	int do_deselect = 0;
@@ -427,12 +431,12 @@ void batadv_gw_node_purge(struct bat_priv *bat_priv)
 }
 
 /* fails if orig_node has no router */
-static int batadv_write_buffer_text(struct bat_priv *bat_priv,
-				     struct seq_file *seq,
-				     const struct gw_node *gw_node)
+static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
+				    struct seq_file *seq,
+				    const struct batadv_gw_node *gw_node)
 {
-	struct gw_node *curr_gw;
-	struct neigh_node *router;
+	struct batadv_gw_node *curr_gw;
+	struct batadv_neigh_node *router;
 	int down, up, ret = -1;
 
 	batadv_gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
@@ -464,9 +468,9 @@ out:
 int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	struct hard_iface *primary_if;
-	struct gw_node *gw_node;
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_hard_iface *primary_if;
+	struct batadv_gw_node *gw_node;
 	struct hlist_node *node;
 	int gw_count = 0, ret = 0;
 
@@ -639,12 +643,12 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 	return true;
 }
 
-bool batadv_gw_out_of_range(struct bat_priv *bat_priv,
+bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 			    struct sk_buff *skb, struct ethhdr *ethhdr)
 {
-	struct neigh_node *neigh_curr = NULL, *neigh_old = NULL;
-	struct orig_node *orig_dst_node = NULL;
-	struct gw_node *curr_gw = NULL;
+	struct batadv_neigh_node *neigh_curr = NULL, *neigh_old = NULL;
+	struct batadv_orig_node *orig_dst_node = NULL;
+	struct batadv_gw_node *curr_gw = NULL;
 	bool ret, out_of_range = false;
 	unsigned int header_len = 0;
 	uint8_t curr_tq_avg;
diff --git a/gateway_client.h b/gateway_client.h
index 4529d42..f0d129e 100644
--- a/gateway_client.h
+++ b/gateway_client.h
@@ -20,19 +20,21 @@
 #ifndef _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
 #define _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
 
-void batadv_gw_deselect(struct bat_priv *bat_priv);
-void batadv_gw_election(struct bat_priv *bat_priv);
-struct orig_node *batadv_gw_get_selected_orig(struct bat_priv *bat_priv);
-void batadv_gw_check_election(struct bat_priv *bat_priv,
-			      struct orig_node *orig_node);
-void batadv_gw_node_update(struct bat_priv *bat_priv,
-			   struct orig_node *orig_node, uint8_t new_gwflags);
-void batadv_gw_node_delete(struct bat_priv *bat_priv,
-			   struct orig_node *orig_node);
-void batadv_gw_node_purge(struct bat_priv *bat_priv);
+void batadv_gw_deselect(struct batadv_priv *bat_priv);
+void batadv_gw_election(struct batadv_priv *bat_priv);
+struct batadv_orig_node *
+batadv_gw_get_selected_orig(struct batadv_priv *bat_priv);
+void batadv_gw_check_election(struct batadv_priv *bat_priv,
+			      struct batadv_orig_node *orig_node);
+void batadv_gw_node_update(struct batadv_priv *bat_priv,
+			   struct batadv_orig_node *orig_node,
+			   uint8_t new_gwflags);
+void batadv_gw_node_delete(struct batadv_priv *bat_priv,
+			   struct batadv_orig_node *orig_node);
+void batadv_gw_node_purge(struct batadv_priv *bat_priv);
 int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset);
 bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len);
-bool batadv_gw_out_of_range(struct bat_priv *bat_priv,
+bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 			    struct sk_buff *skb, struct ethhdr *ethhdr);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_CLIENT_H_ */
diff --git a/gateway_common.c b/gateway_common.c
index f5c3980..9001208 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -137,7 +137,7 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 				size_t count)
 {
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	long gw_bandwidth_tmp = 0;
 	int up = 0, down = 0;
 	bool ret;
diff --git a/hard-interface.c b/hard-interface.c
index 9dbca0b..f18ccc3 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -32,16 +32,17 @@
 
 void batadv_hardif_free_rcu(struct rcu_head *rcu)
 {
-	struct hard_iface *hard_iface;
+	struct batadv_hard_iface *hard_iface;
 
-	hard_iface = container_of(rcu, struct hard_iface, rcu);
+	hard_iface = container_of(rcu, struct batadv_hard_iface, rcu);
 	dev_put(hard_iface->net_dev);
 	kfree(hard_iface);
 }
 
-struct hard_iface *batadv_hardif_get_by_netdev(const struct net_device *net_dev)
+struct batadv_hard_iface *
+batadv_hardif_get_by_netdev(const struct net_device *net_dev)
 {
-	struct hard_iface *hard_iface;
+	struct batadv_hard_iface *hard_iface;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
@@ -75,10 +76,10 @@ static int batadv_is_valid_iface(const struct net_device *net_dev)
 	return 1;
 }
 
-static struct hard_iface *
+static struct batadv_hard_iface *
 batadv_hardif_get_active(const struct net_device *soft_iface)
 {
-	struct hard_iface *hard_iface;
+	struct batadv_hard_iface *hard_iface;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
@@ -97,11 +98,11 @@ out:
 	return hard_iface;
 }
 
-static void batadv_primary_if_update_addr(struct bat_priv *bat_priv,
-					  struct hard_iface *oldif)
+static void batadv_primary_if_update_addr(struct batadv_priv *bat_priv,
+					  struct batadv_hard_iface *oldif)
 {
 	struct batadv_vis_packet *vis_packet;
-	struct hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -119,10 +120,10 @@ out:
 		batadv_hardif_free_ref(primary_if);
 }
 
-static void batadv_primary_if_select(struct bat_priv *bat_priv,
-				     struct hard_iface *new_hard_iface)
+static void batadv_primary_if_select(struct batadv_priv *bat_priv,
+				     struct batadv_hard_iface *new_hard_iface)
 {
-	struct hard_iface *curr_hard_iface;
+	struct batadv_hard_iface *curr_hard_iface;
 
 	ASSERT_RTNL();
 
@@ -143,7 +144,8 @@ out:
 		batadv_hardif_free_ref(curr_hard_iface);
 }
 
-static bool batadv_hardif_is_iface_up(const struct hard_iface *hard_iface)
+static bool
+batadv_hardif_is_iface_up(const struct batadv_hard_iface *hard_iface)
 {
 	if (hard_iface->net_dev->flags & IFF_UP)
 		return true;
@@ -153,7 +155,7 @@ static bool batadv_hardif_is_iface_up(const struct hard_iface *hard_iface)
 
 static void batadv_check_known_mac_addr(const struct net_device *net_dev)
 {
-	const struct hard_iface *hard_iface;
+	const struct batadv_hard_iface *hard_iface;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
@@ -177,8 +179,8 @@ static void batadv_check_known_mac_addr(const struct net_device *net_dev)
 
 int batadv_hardif_min_mtu(struct net_device *soft_iface)
 {
-	const struct bat_priv *bat_priv = netdev_priv(soft_iface);
-	const struct hard_iface *hard_iface;
+	const struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	const struct batadv_hard_iface *hard_iface;
 	/* allow big frames if all devices are capable to do so
 	 * (have MTU > 1500 + BAT_HEADER_LEN)
 	 */
@@ -215,10 +217,11 @@ void batadv_update_min_mtu(struct net_device *soft_iface)
 		soft_iface->mtu = min_mtu;
 }
 
-static void batadv_hardif_activate_interface(struct hard_iface *hard_iface)
+static void
+batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 {
-	struct bat_priv *bat_priv;
-	struct hard_iface *primary_if = NULL;
+	struct batadv_priv *bat_priv;
+	struct batadv_hard_iface *primary_if = NULL;
 
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;
@@ -245,7 +248,8 @@ out:
 		batadv_hardif_free_ref(primary_if);
 }
 
-static void batadv_hardif_deactivate_interface(struct hard_iface *hard_iface)
+static void
+batadv_hardif_deactivate_interface(struct batadv_hard_iface *hard_iface)
 {
 	if ((hard_iface->if_status != BATADV_IF_ACTIVE) &&
 	    (hard_iface->if_status != BATADV_IF_TO_BE_ACTIVATED))
@@ -259,10 +263,10 @@ static void batadv_hardif_deactivate_interface(struct hard_iface *hard_iface)
 	batadv_update_min_mtu(hard_iface->soft_iface);
 }
 
-int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
+int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 				   const char *iface_name)
 {
-	struct bat_priv *bat_priv;
+	struct batadv_priv *bat_priv;
 	struct net_device *soft_iface;
 	__be16 ethertype = __constant_htons(BATADV_ETH_P_BATMAN);
 	int ret;
@@ -354,10 +358,10 @@ err:
 	return ret;
 }
 
-void batadv_hardif_disable_interface(struct hard_iface *hard_iface)
+void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 {
-	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct hard_iface *primary_if = NULL;
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_hard_iface *primary_if = NULL;
 
 	if (hard_iface->if_status == BATADV_IF_ACTIVE)
 		batadv_hardif_deactivate_interface(hard_iface);
@@ -374,7 +378,7 @@ void batadv_hardif_disable_interface(struct hard_iface *hard_iface)
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (hard_iface == primary_if) {
-		struct hard_iface *new_if;
+		struct batadv_hard_iface *new_if;
 
 		new_if = batadv_hardif_get_active(hard_iface->soft_iface);
 		batadv_primary_if_select(bat_priv, new_if);
@@ -403,10 +407,10 @@ out:
 		batadv_hardif_free_ref(primary_if);
 }
 
-static struct hard_iface *
+static struct batadv_hard_iface *
 batadv_hardif_add_interface(struct net_device *net_dev)
 {
-	struct hard_iface *hard_iface;
+	struct batadv_hard_iface *hard_iface;
 	int ret;
 
 	ASSERT_RTNL();
@@ -452,7 +456,7 @@ out:
 	return NULL;
 }
 
-static void batadv_hardif_remove_interface(struct hard_iface *hard_iface)
+static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 {
 	ASSERT_RTNL();
 
@@ -470,7 +474,7 @@ static void batadv_hardif_remove_interface(struct hard_iface *hard_iface)
 
 void batadv_hardif_remove_interfaces(void)
 {
-	struct hard_iface *hard_iface, *hard_iface_tmp;
+	struct batadv_hard_iface *hard_iface, *hard_iface_tmp;
 
 	rtnl_lock();
 	list_for_each_entry_safe(hard_iface, hard_iface_tmp,
@@ -485,10 +489,11 @@ static int batadv_hard_if_event(struct notifier_block *this,
 			 unsigned long event, void *ptr)
 {
 	struct net_device *net_dev = ptr;
-	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev);
-	struct hard_iface *primary_if = NULL;
-	struct bat_priv *bat_priv;
+	struct batadv_hard_iface *hard_iface;
+	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_priv *bat_priv;
 
+	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	if (!hard_iface && event == NETDEV_REGISTER)
 		hard_iface = batadv_hardif_add_interface(net_dev);
 
diff --git a/hard-interface.h b/hard-interface.h
index 4b60d58..3732366 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -31,11 +31,11 @@ enum batadv_hard_if_state {
 
 extern struct notifier_block batadv_hard_if_notifier;
 
-struct hard_iface*
+struct batadv_hard_iface*
 batadv_hardif_get_by_netdev(const struct net_device *net_dev);
-int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
+int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 				   const char *iface_name);
-void batadv_hardif_disable_interface(struct hard_iface *hard_iface);
+void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface);
 void batadv_hardif_remove_interfaces(void);
 int batadv_hardif_min_mtu(struct net_device *soft_iface);
 void batadv_update_min_mtu(struct net_device *soft_iface);
@@ -43,16 +43,16 @@ void batadv_hardif_free_rcu(struct rcu_head *rcu);
 bool batadv_is_wifi_iface(int ifindex);
 
 static inline void
-batadv_hardif_free_ref(struct hard_iface *hard_iface)
+batadv_hardif_free_ref(struct batadv_hard_iface *hard_iface)
 {
 	if (atomic_dec_and_test(&hard_iface->refcount))
 		call_rcu(&hard_iface->rcu, batadv_hardif_free_rcu);
 }
 
-static inline struct hard_iface *
-batadv_primary_if_get_selected(struct bat_priv *bat_priv)
+static inline struct batadv_hard_iface *
+batadv_primary_if_get_selected(struct batadv_priv *bat_priv)
 {
-	struct hard_iface *hard_iface;
+	struct batadv_hard_iface *hard_iface;
 
 	rcu_read_lock();
 	hard_iface = rcu_dereference(bat_priv->primary_if);
diff --git a/icmp_socket.c b/icmp_socket.c
index 2db73f8..d370061 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -26,9 +26,9 @@
 #include "originator.h"
 #include "hard-interface.h"
 
-static struct socket_client *batadv_socket_client_hash[256];
+static struct batadv_socket_client *batadv_socket_client_hash[256];
 
-static void batadv_socket_add_packet(struct socket_client *socket_client,
+static void batadv_socket_add_packet(struct batadv_socket_client *socket_client,
 				     struct batadv_icmp_packet_rr *icmp_packet,
 				     size_t icmp_len);
 
@@ -40,7 +40,7 @@ void batadv_socket_init(void)
 static int batadv_socket_open(struct inode *inode, struct file *file)
 {
 	unsigned int i;
-	struct socket_client *socket_client;
+	struct batadv_socket_client *socket_client;
 
 	nonseekable_open(inode, file);
 
@@ -77,8 +77,8 @@ static int batadv_socket_open(struct inode *inode, struct file *file)
 
 static int batadv_socket_release(struct inode *inode, struct file *file)
 {
-	struct socket_client *socket_client = file->private_data;
-	struct socket_packet *socket_packet;
+	struct batadv_socket_client *socket_client = file->private_data;
+	struct batadv_socket_packet *socket_packet;
 	struct list_head *list_pos, *list_pos_tmp;
 
 	spin_lock_bh(&socket_client->lock);
@@ -86,7 +86,7 @@ static int batadv_socket_release(struct inode *inode, struct file *file)
 	/* for all packets in the queue ... */
 	list_for_each_safe(list_pos, list_pos_tmp, &socket_client->queue_list) {
 		socket_packet = list_entry(list_pos,
-					   struct socket_packet, list);
+					   struct batadv_socket_packet, list);
 
 		list_del(list_pos);
 		kfree(socket_packet);
@@ -104,8 +104,8 @@ static int batadv_socket_release(struct inode *inode, struct file *file)
 static ssize_t batadv_socket_read(struct file *file, char __user *buf,
 				  size_t count, loff_t *ppos)
 {
-	struct socket_client *socket_client = file->private_data;
-	struct socket_packet *socket_packet;
+	struct batadv_socket_client *socket_client = file->private_data;
+	struct batadv_socket_packet *socket_packet;
 	size_t packet_len;
 	int error;
 
@@ -127,7 +127,7 @@ static ssize_t batadv_socket_read(struct file *file, char __user *buf,
 	spin_lock_bh(&socket_client->lock);
 
 	socket_packet = list_first_entry(&socket_client->queue_list,
-					 struct socket_packet, list);
+					 struct batadv_socket_packet, list);
 	list_del(&socket_packet->list);
 	socket_client->queue_len--;
 
@@ -147,14 +147,14 @@ static ssize_t batadv_socket_read(struct file *file, char __user *buf,
 static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 				   size_t len, loff_t *off)
 {
-	struct socket_client *socket_client = file->private_data;
-	struct bat_priv *bat_priv = socket_client->bat_priv;
-	struct hard_iface *primary_if = NULL;
+	struct batadv_socket_client *socket_client = file->private_data;
+	struct batadv_priv *bat_priv = socket_client->bat_priv;
+	struct batadv_hard_iface *primary_if = NULL;
 	struct sk_buff *skb;
 	struct batadv_icmp_packet_rr *icmp_packet;
 
-	struct orig_node *orig_node = NULL;
-	struct neigh_node *neigh_node = NULL;
+	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_neigh_node *neigh_node = NULL;
 	size_t packet_len = sizeof(struct batadv_icmp_packet);
 
 	if (len < sizeof(struct batadv_icmp_packet)) {
@@ -255,7 +255,7 @@ out:
 
 static unsigned int batadv_socket_poll(struct file *file, poll_table *wait)
 {
-	struct socket_client *socket_client = file->private_data;
+	struct batadv_socket_client *socket_client = file->private_data;
 
 	poll_wait(file, &socket_client->queue_wait, wait);
 
@@ -275,7 +275,7 @@ static const struct file_operations batadv_fops = {
 	.llseek = no_llseek,
 };
 
-int batadv_socket_setup(struct bat_priv *bat_priv)
+int batadv_socket_setup(struct batadv_priv *bat_priv)
 {
 	struct dentry *d;
 
@@ -293,11 +293,11 @@ err:
 	return 1;
 }
 
-static void batadv_socket_add_packet(struct socket_client *socket_client,
+static void batadv_socket_add_packet(struct batadv_socket_client *socket_client,
 				     struct batadv_icmp_packet_rr *icmp_packet,
 				     size_t icmp_len)
 {
-	struct socket_packet *socket_packet;
+	struct batadv_socket_packet *socket_packet;
 
 	socket_packet = kmalloc(sizeof(*socket_packet), GFP_ATOMIC);
 
@@ -324,7 +324,8 @@ static void batadv_socket_add_packet(struct socket_client *socket_client,
 
 	if (socket_client->queue_len > 100) {
 		socket_packet = list_first_entry(&socket_client->queue_list,
-						 struct socket_packet, list);
+						 struct batadv_socket_packet,
+						 list);
 
 		list_del(&socket_packet->list);
 		kfree(socket_packet);
@@ -339,7 +340,7 @@ static void batadv_socket_add_packet(struct socket_client *socket_client,
 void batadv_socket_receive_packet(struct batadv_icmp_packet_rr *icmp_packet,
 				  size_t icmp_len)
 {
-	struct socket_client *hash;
+	struct batadv_socket_client *hash;
 
 	hash = batadv_socket_client_hash[icmp_packet->uid];
 	if (hash)
diff --git a/icmp_socket.h b/icmp_socket.h
index 7b8ad52..29443a1 100644
--- a/icmp_socket.h
+++ b/icmp_socket.h
@@ -23,7 +23,7 @@
 #define BATADV_ICMP_SOCKET "socket"
 
 void batadv_socket_init(void);
-int batadv_socket_setup(struct bat_priv *bat_priv);
+int batadv_socket_setup(struct batadv_priv *bat_priv);
 void batadv_socket_receive_packet(struct batadv_icmp_packet_rr *icmp_packet,
 				  size_t icmp_len);
 
diff --git a/main.c b/main.c
index 97144a9..17dcdd9 100644
--- a/main.c
+++ b/main.c
@@ -39,7 +39,7 @@
  */
 struct list_head batadv_hardif_list;
 static int (*batadv_rx_handler[256])(struct sk_buff *,
-				     struct hard_iface *);
+				     struct batadv_hard_iface *);
 char batadv_routing_algo[20] = "BATMAN_IV";
 static struct hlist_head batadv_algo_list;
 
@@ -92,7 +92,7 @@ static void __exit batadv_exit(void)
 
 int batadv_mesh_init(struct net_device *soft_iface)
 {
-	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	int ret;
 
 	spin_lock_init(&bat_priv->forw_bat_list_lock);
@@ -143,7 +143,7 @@ err:
 
 void batadv_mesh_free(struct net_device *soft_iface)
 {
-	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
@@ -175,7 +175,7 @@ void batadv_dec_module_count(void)
 
 int batadv_is_my_mac(const uint8_t *addr)
 {
-	const struct hard_iface *hard_iface;
+	const struct batadv_hard_iface *hard_iface;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
@@ -192,7 +192,7 @@ int batadv_is_my_mac(const uint8_t *addr)
 }
 
 static int batadv_recv_unhandled_packet(struct sk_buff *skb,
-					struct hard_iface *recv_if)
+					struct batadv_hard_iface *recv_if)
 {
 	return NET_RX_DROP;
 }
@@ -204,13 +204,14 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 			   struct packet_type *ptype,
 			   struct net_device *orig_dev)
 {
-	struct bat_priv *bat_priv;
+	struct batadv_priv *bat_priv;
 	struct batadv_ogm_packet *batadv_ogm_packet;
-	struct hard_iface *hard_iface;
+	struct batadv_hard_iface *hard_iface;
 	uint8_t idx;
 	int ret;
 
-	hard_iface = container_of(ptype, struct hard_iface, batman_adv_ptype);
+	hard_iface = container_of(ptype, struct batadv_hard_iface,
+				  batman_adv_ptype);
 	skb = skb_share_check(skb, GFP_ATOMIC);
 
 	/* skb was released by skb_share_check() */
@@ -290,9 +291,10 @@ static void batadv_recv_handler_init(void)
 	batadv_rx_handler[BATADV_ROAM_ADV] = batadv_recv_roam_adv;
 }
 
-int batadv_recv_handler_register(uint8_t packet_type,
-				 int (*recv_handler)(struct sk_buff *,
-						     struct hard_iface *))
+int
+batadv_recv_handler_register(uint8_t packet_type,
+			     int (*recv_handler)(struct sk_buff *,
+						 struct batadv_hard_iface *))
 {
 	if (batadv_rx_handler[packet_type] != &batadv_recv_unhandled_packet)
 		return -EBUSY;
@@ -306,9 +308,9 @@ void batadv_recv_handler_unregister(uint8_t packet_type)
 	batadv_rx_handler[packet_type] = batadv_recv_unhandled_packet;
 }
 
-static struct bat_algo_ops *batadv_algo_get(char *name)
+static struct batadv_algo_ops *batadv_algo_get(char *name)
 {
-	struct bat_algo_ops *bat_algo_ops = NULL, *bat_algo_ops_tmp;
+	struct batadv_algo_ops *bat_algo_ops = NULL, *bat_algo_ops_tmp;
 	struct hlist_node *node;
 
 	hlist_for_each_entry(bat_algo_ops_tmp, node, &batadv_algo_list, list) {
@@ -322,9 +324,9 @@ static struct bat_algo_ops *batadv_algo_get(char *name)
 	return bat_algo_ops;
 }
 
-int batadv_algo_register(struct bat_algo_ops *bat_algo_ops)
+int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 {
-	struct bat_algo_ops *bat_algo_ops_tmp;
+	struct batadv_algo_ops *bat_algo_ops_tmp;
 	int ret;
 
 	bat_algo_ops_tmp = batadv_algo_get(bat_algo_ops->name);
@@ -356,9 +358,9 @@ out:
 	return ret;
 }
 
-int batadv_algo_select(struct bat_priv *bat_priv, char *name)
+int batadv_algo_select(struct batadv_priv *bat_priv, char *name)
 {
-	struct bat_algo_ops *bat_algo_ops;
+	struct batadv_algo_ops *bat_algo_ops;
 	int ret = -EINVAL;
 
 	bat_algo_ops = batadv_algo_get(name);
@@ -374,7 +376,7 @@ out:
 
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
 {
-	struct bat_algo_ops *bat_algo_ops;
+	struct batadv_algo_ops *bat_algo_ops;
 	struct hlist_node *node;
 
 	seq_printf(seq, "Available routing algorithms:\n");
@@ -388,7 +390,7 @@ int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
 
 static int batadv_param_set_ra(const char *val, const struct kernel_param *kp)
 {
-	struct bat_algo_ops *bat_algo_ops;
+	struct batadv_algo_ops *bat_algo_ops;
 	char *algo_name = (char *)val;
 	size_t name_len = strlen(algo_name);
 
diff --git a/main.h b/main.h
index 72dca13..a229190 100644
--- a/main.h
+++ b/main.h
@@ -166,16 +166,17 @@ int batadv_is_my_mac(const uint8_t *addr);
 int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 			   struct packet_type *ptype,
 			   struct net_device *orig_dev);
-int batadv_recv_handler_register(uint8_t packet_type,
-				 int (*recv_handler)(struct sk_buff *,
-						     struct hard_iface *));
+int
+batadv_recv_handler_register(uint8_t packet_type,
+			     int (*recv_handler)(struct sk_buff *,
+						 struct batadv_hard_iface *));
 void batadv_recv_handler_unregister(uint8_t packet_type);
-int batadv_algo_register(struct bat_algo_ops *bat_algo_ops);
-int batadv_algo_select(struct bat_priv *bat_priv, char *name);
+int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops);
+int batadv_algo_select(struct batadv_priv *bat_priv, char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, ...)
+int batadv_debug_log(struct batadv_priv *bat_priv, const char *fmt, ...)
 __printf(2, 3);
 
 #define batadv_dbg(type, bat_priv, fmt, arg...)			\
@@ -187,7 +188,7 @@ __printf(2, 3);
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
 __printf(3, 4)
 static inline void batadv_dbg(int type __always_unused,
-			      struct bat_priv *bat_priv __always_unused,
+			      struct batadv_priv *bat_priv __always_unused,
 			      const char *fmt __always_unused, ...)
 {
 }
@@ -196,14 +197,14 @@ static inline void batadv_dbg(int type __always_unused,
 #define batadv_info(net_dev, fmt, arg...)				\
 	do {								\
 		struct net_device *_netdev = (net_dev);                 \
-		struct bat_priv *_batpriv = netdev_priv(_netdev);       \
+		struct batadv_priv *_batpriv = netdev_priv(_netdev);    \
 		batadv_dbg(BATADV_DBG_ALL, _batpriv, fmt, ## arg);	\
 		pr_info("%s: " fmt, _netdev->name, ## arg);		\
 	} while (0)
 #define batadv_err(net_dev, fmt, arg...)				\
 	do {								\
 		struct net_device *_netdev = (net_dev);                 \
-		struct bat_priv *_batpriv = netdev_priv(_netdev);       \
+		struct batadv_priv *_batpriv = netdev_priv(_netdev);    \
 		batadv_dbg(BATADV_DBG_ALL, _batpriv, fmt, ## arg);	\
 		pr_err("%s: " fmt, _netdev->name, ## arg);		\
 	} while (0)
@@ -252,7 +253,7 @@ static inline bool batadv_has_timed_out(unsigned long timestamp,
 #define batadv_seq_after(x, y) batadv_seq_before(y, x)
 
 /* Stop preemption on local cpu while incrementing the counter */
-static inline void batadv_add_counter(struct bat_priv *bat_priv, size_t idx,
+static inline void batadv_add_counter(struct batadv_priv *bat_priv, size_t idx,
 				      size_t count)
 {
 	int cpu = get_cpu();
@@ -263,7 +264,8 @@ static inline void batadv_add_counter(struct bat_priv *bat_priv, size_t idx,
 #define batadv_inc_counter(b, i) batadv_add_counter(b, i, 1)
 
 /* Sum and return the cpu-local counters for index 'idx' */
-static inline uint64_t batadv_sum_counter(struct bat_priv *bat_priv, size_t idx)
+static inline uint64_t batadv_sum_counter(struct batadv_priv *bat_priv,
+					  size_t idx)
 {
 	uint64_t *counters;
 	int cpu;
diff --git a/originator.c b/originator.c
index dc9c4bf..fc1ce26 100644
--- a/originator.c
+++ b/originator.c
@@ -30,7 +30,7 @@
 
 static void batadv_purge_orig(struct work_struct *work);
 
-static void batadv_start_purge_timer(struct bat_priv *bat_priv)
+static void batadv_start_purge_timer(struct batadv_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->orig_work, batadv_purge_orig);
 	queue_delayed_work(batadv_event_workqueue,
@@ -40,12 +40,13 @@ static void batadv_start_purge_timer(struct bat_priv *bat_priv)
 /* returns 1 if they are the same originator */
 static int batadv_compare_orig(const struct hlist_node *node, const void *data2)
 {
-	const void *data1 = container_of(node, struct orig_node, hash_entry);
+	const void *data1 = container_of(node, struct batadv_orig_node,
+					 hash_entry);
 
 	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
 }
 
-int batadv_originator_init(struct bat_priv *bat_priv)
+int batadv_originator_init(struct batadv_priv *bat_priv)
 {
 	if (bat_priv->orig_hash)
 		return 0;
@@ -62,16 +63,17 @@ err:
 	return -ENOMEM;
 }
 
-void batadv_neigh_node_free_ref(struct neigh_node *neigh_node)
+void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node)
 {
 	if (atomic_dec_and_test(&neigh_node->refcount))
 		kfree_rcu(neigh_node, rcu);
 }
 
 /* increases the refcounter of a found router */
-struct neigh_node *batadv_orig_node_get_router(struct orig_node *orig_node)
+struct batadv_neigh_node *
+batadv_orig_node_get_router(struct batadv_orig_node *orig_node)
 {
-	struct neigh_node *router;
+	struct batadv_neigh_node *router;
 
 	rcu_read_lock();
 	router = rcu_dereference(orig_node->router);
@@ -83,12 +85,12 @@ struct neigh_node *batadv_orig_node_get_router(struct orig_node *orig_node)
 	return router;
 }
 
-struct neigh_node *batadv_neigh_node_new(struct hard_iface *hard_iface,
-					 const uint8_t *neigh_addr,
-					 uint32_t seqno)
+struct batadv_neigh_node *
+batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
+		      const uint8_t *neigh_addr, uint32_t seqno)
 {
-	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct neigh_node *neigh_node;
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_neigh_node *neigh_node;
 
 	neigh_node = kzalloc(sizeof(*neigh_node), GFP_ATOMIC);
 	if (!neigh_node)
@@ -113,10 +115,10 @@ out:
 static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 {
 	struct hlist_node *node, *node_tmp;
-	struct neigh_node *neigh_node, *tmp_neigh_node;
-	struct orig_node *orig_node;
+	struct batadv_neigh_node *neigh_node, *tmp_neigh_node;
+	struct batadv_orig_node *orig_node;
 
-	orig_node = container_of(rcu, struct orig_node, rcu);
+	orig_node = container_of(rcu, struct batadv_orig_node, rcu);
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -146,19 +148,19 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 	kfree(orig_node);
 }
 
-void batadv_orig_node_free_ref(struct orig_node *orig_node)
+void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node)
 {
 	if (atomic_dec_and_test(&orig_node->refcount))
 		call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
 }
 
-void batadv_originator_free(struct bat_priv *bat_priv)
+void batadv_originator_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* spinlock to protect write access */
-	struct orig_node *orig_node;
+	struct batadv_orig_node *orig_node;
 	uint32_t i;
 
 	if (!hash)
@@ -188,10 +190,10 @@ void batadv_originator_free(struct bat_priv *bat_priv)
 /* this function finds or creates an originator entry for the given
  * address if it does not exits
  */
-struct orig_node *batadv_get_orig_node(struct bat_priv *bat_priv,
-				       const uint8_t *addr)
+struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
+					      const uint8_t *addr)
 {
-	struct orig_node *orig_node;
+	struct batadv_orig_node *orig_node;
 	int size;
 	int hash_added;
 	unsigned long reset_time;
@@ -264,15 +266,16 @@ free_orig_node:
 	return NULL;
 }
 
-static bool batadv_purge_orig_neighbors(struct bat_priv *bat_priv,
-					struct orig_node *orig_node,
-					struct neigh_node **best_neigh_node)
+static bool
+batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
+			    struct batadv_orig_node *orig_node,
+			    struct batadv_neigh_node **best_neigh_node)
 {
 	struct hlist_node *node, *node_tmp;
-	struct neigh_node *neigh_node;
+	struct batadv_neigh_node *neigh_node;
 	bool neigh_purged = false;
 	unsigned long last_seen;
-	struct hard_iface *if_incoming;
+	struct batadv_hard_iface *if_incoming;
 
 	*best_neigh_node = NULL;
 
@@ -319,10 +322,10 @@ static bool batadv_purge_orig_neighbors(struct bat_priv *bat_priv,
 	return neigh_purged;
 }
 
-static bool batadv_purge_orig_node(struct bat_priv *bat_priv,
-				   struct orig_node *orig_node)
+static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
+				   struct batadv_orig_node *orig_node)
 {
-	struct neigh_node *best_neigh_node;
+	struct batadv_neigh_node *best_neigh_node;
 
 	if (batadv_has_timed_out(orig_node->last_seen,
 				 2 * BATADV_PURGE_TIMEOUT)) {
@@ -341,13 +344,13 @@ static bool batadv_purge_orig_node(struct bat_priv *bat_priv,
 	return false;
 }
 
-static void _batadv_purge_orig(struct bat_priv *bat_priv)
+static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* spinlock to protect write access */
-	struct orig_node *orig_node;
+	struct batadv_orig_node *orig_node;
 	uint32_t i;
 
 	if (!hash)
@@ -383,16 +386,16 @@ static void _batadv_purge_orig(struct bat_priv *bat_priv)
 
 static void batadv_purge_orig(struct work_struct *work)
 {
-	struct delayed_work *delayed_work =
-		container_of(work, struct delayed_work, work);
-	struct bat_priv *bat_priv =
-		container_of(delayed_work, struct bat_priv, orig_work);
+	struct delayed_work *delayed_work;
+	struct batadv_priv *bat_priv;
 
+	delayed_work = container_of(work, struct delayed_work, work);
+	bat_priv = container_of(delayed_work, struct batadv_priv, orig_work);
 	_batadv_purge_orig(bat_priv);
 	batadv_start_purge_timer(bat_priv);
 }
 
-void batadv_purge_orig_ref(struct bat_priv *bat_priv)
+void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 {
 	_batadv_purge_orig(bat_priv);
 }
@@ -400,13 +403,13 @@ void batadv_purge_orig_ref(struct bat_priv *bat_priv)
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
-	struct hard_iface *primary_if;
-	struct orig_node *orig_node;
-	struct neigh_node *neigh_node, *neigh_node_tmp;
+	struct batadv_hard_iface *primary_if;
+	struct batadv_orig_node *orig_node;
+	struct batadv_neigh_node *neigh_node, *neigh_node_tmp;
 	int batman_count = 0;
 	int last_seen_secs;
 	int last_seen_msecs;
@@ -484,7 +487,8 @@ out:
 	return ret;
 }
 
-static int batadv_orig_node_add_if(struct orig_node *orig_node, int max_if_num)
+static int batadv_orig_node_add_if(struct batadv_orig_node *orig_node,
+				   int max_if_num)
 {
 	void *data_ptr;
 	size_t data_size, old_size;
@@ -511,13 +515,14 @@ static int batadv_orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 	return 0;
 }
 
-int batadv_orig_hash_add_if(struct hard_iface *hard_iface, int max_if_num)
+int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
+			    int max_if_num)
 {
-	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct orig_node *orig_node;
+	struct batadv_orig_node *orig_node;
 	uint32_t i;
 	int ret;
 
@@ -546,7 +551,7 @@ err:
 	return -ENOMEM;
 }
 
-static int batadv_orig_node_del_if(struct orig_node *orig_node,
+static int batadv_orig_node_del_if(struct batadv_orig_node *orig_node,
 				   int max_if_num, int del_if_num)
 {
 	void *data_ptr = NULL;
@@ -594,14 +599,15 @@ free_own_sum:
 	return 0;
 }
 
-int batadv_orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num)
+int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
+			    int max_if_num)
 {
-	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct hard_iface *hard_iface_tmp;
-	struct orig_node *orig_node;
+	struct batadv_hard_iface *hard_iface_tmp;
+	struct batadv_orig_node *orig_node;
 	uint32_t i;
 	int ret;
 
diff --git a/originator.h b/originator.h
index 32e7e28..9778e65 100644
--- a/originator.h
+++ b/originator.h
@@ -22,20 +22,23 @@
 
 #include "hash.h"
 
-int batadv_originator_init(struct bat_priv *bat_priv);
-void batadv_originator_free(struct bat_priv *bat_priv);
-void batadv_purge_orig_ref(struct bat_priv *bat_priv);
-void batadv_orig_node_free_ref(struct orig_node *orig_node);
-struct orig_node *batadv_get_orig_node(struct bat_priv *bat_priv,
-				       const uint8_t *addr);
-struct neigh_node *batadv_neigh_node_new(struct hard_iface *hard_iface,
-					 const uint8_t *neigh_addr,
-					 uint32_t seqno);
-void batadv_neigh_node_free_ref(struct neigh_node *neigh_node);
-struct neigh_node *batadv_orig_node_get_router(struct orig_node *orig_node);
+int batadv_originator_init(struct batadv_priv *bat_priv);
+void batadv_originator_free(struct batadv_priv *bat_priv);
+void batadv_purge_orig_ref(struct batadv_priv *bat_priv);
+void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node);
+struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
+					      const uint8_t *addr);
+struct batadv_neigh_node *
+batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
+		      const uint8_t *neigh_addr, uint32_t seqno);
+void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node);
+struct batadv_neigh_node *
+batadv_orig_node_get_router(struct batadv_orig_node *orig_node);
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
-int batadv_orig_hash_add_if(struct hard_iface *hard_iface, int max_if_num);
-int batadv_orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num);
+int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
+			    int max_if_num);
+int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
+			    int max_if_num);
 
 
 /* hashfunction to choose an entry in a hash table of given size
@@ -60,13 +63,13 @@ static inline uint32_t batadv_choose_orig(const void *data, uint32_t size)
 	return hash % size;
 }
 
-static inline struct orig_node *batadv_orig_hash_find(struct bat_priv *bat_priv,
-						      const void *data)
+static inline struct batadv_orig_node *
+batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct orig_node *orig_node, *orig_node_tmp = NULL;
+	struct batadv_orig_node *orig_node, *orig_node_tmp = NULL;
 	int index;
 
 	if (!hash)
diff --git a/routing.c b/routing.c
index b7388f4..be068f3 100644
--- a/routing.c
+++ b/routing.c
@@ -30,15 +30,15 @@
 #include "bridge_loop_avoidance.h"
 
 static int batadv_route_unicast_packet(struct sk_buff *skb,
-				       struct hard_iface *recv_if);
+				       struct batadv_hard_iface *recv_if);
 
-void batadv_slide_own_bcast_window(struct hard_iface *hard_iface)
+void batadv_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 {
-	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct orig_node *orig_node;
+	struct batadv_orig_node *orig_node;
 	unsigned long *word;
 	uint32_t i;
 	size_t word_index;
@@ -62,11 +62,11 @@ void batadv_slide_own_bcast_window(struct hard_iface *hard_iface)
 	}
 }
 
-static void _batadv_update_route(struct bat_priv *bat_priv,
-				 struct orig_node *orig_node,
-				 struct neigh_node *neigh_node)
+static void _batadv_update_route(struct batadv_priv *bat_priv,
+				 struct batadv_orig_node *orig_node,
+				 struct batadv_neigh_node *neigh_node)
 {
-	struct neigh_node *curr_router;
+	struct batadv_neigh_node *curr_router;
 
 	curr_router = batadv_orig_node_get_router(orig_node);
 
@@ -107,10 +107,11 @@ static void _batadv_update_route(struct bat_priv *bat_priv,
 		batadv_neigh_node_free_ref(curr_router);
 }
 
-void batadv_update_route(struct bat_priv *bat_priv, struct orig_node *orig_node,
-			 struct neigh_node *neigh_node)
+void batadv_update_route(struct batadv_priv *bat_priv,
+			 struct batadv_orig_node *orig_node,
+			 struct batadv_neigh_node *neigh_node)
 {
-	struct neigh_node *router = NULL;
+	struct batadv_neigh_node *router = NULL;
 
 	if (!orig_node)
 		goto out;
@@ -126,8 +127,8 @@ out:
 }
 
 /* caller must hold the neigh_list_lock */
-void batadv_bonding_candidate_del(struct orig_node *orig_node,
-				  struct neigh_node *neigh_node)
+void batadv_bonding_candidate_del(struct batadv_orig_node *orig_node,
+				  struct batadv_neigh_node *neigh_node)
 {
 	/* this neighbor is not part of our candidate list */
 	if (list_empty(&neigh_node->bonding_list))
@@ -142,11 +143,11 @@ out:
 	return;
 }
 
-void batadv_bonding_candidate_add(struct orig_node *orig_node,
-				  struct neigh_node *neigh_node)
+void batadv_bonding_candidate_add(struct batadv_orig_node *orig_node,
+				  struct batadv_neigh_node *neigh_node)
 {
 	struct hlist_node *node;
-	struct neigh_node *tmp_neigh_node, *router = NULL;
+	struct batadv_neigh_node *tmp_neigh_node, *router = NULL;
 	uint8_t interference_candidate = 0;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
@@ -215,8 +216,8 @@ out:
 
 /* copy primary address for bonding */
 void
-batadv_bonding_save_primary(const struct orig_node *orig_node,
-			    struct orig_node *orig_neigh_node,
+batadv_bonding_save_primary(const struct batadv_orig_node *orig_node,
+			    struct batadv_orig_node *orig_neigh_node,
 			    const struct batadv_ogm_packet *batman_ogm_packet)
 {
 	if (!(batman_ogm_packet->flags & BATADV_PRIMARIES_FIRST_HOP))
@@ -230,7 +231,7 @@ batadv_bonding_save_primary(const struct orig_node *orig_node,
  *  0 if the packet is to be accepted
  *  1 if the packet is to be ignored.
  */
-int batadv_window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
+int batadv_window_protected(struct batadv_priv *bat_priv, int32_t seq_num_diff,
 			    unsigned long *last_reset)
 {
 	if (seq_num_diff <= -BATADV_TQ_LOCAL_WINDOW_SIZE ||
@@ -248,7 +249,7 @@ int batadv_window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
 }
 
 bool batadv_check_management_packet(struct sk_buff *skb,
-				    struct hard_iface *hard_iface,
+				    struct batadv_hard_iface *hard_iface,
 				    int header_len)
 {
 	struct ethhdr *ethhdr;
@@ -278,12 +279,12 @@ bool batadv_check_management_packet(struct sk_buff *skb,
 	return true;
 }
 
-static int batadv_recv_my_icmp_packet(struct bat_priv *bat_priv,
+static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 				      struct sk_buff *skb, size_t icmp_len)
 {
-	struct hard_iface *primary_if = NULL;
-	struct orig_node *orig_node = NULL;
-	struct neigh_node *router = NULL;
+	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_neigh_node *router = NULL;
 	struct batadv_icmp_packet_rr *icmp_packet;
 	int ret = NET_RX_DROP;
 
@@ -333,12 +334,12 @@ out:
 	return ret;
 }
 
-static int batadv_recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
+static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
 {
-	struct hard_iface *primary_if = NULL;
-	struct orig_node *orig_node = NULL;
-	struct neigh_node *router = NULL;
+	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_neigh_node *router = NULL;
 	struct batadv_icmp_packet *icmp_packet;
 	int ret = NET_RX_DROP;
 
@@ -389,13 +390,14 @@ out:
 }
 
 
-int batadv_recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
+int batadv_recv_icmp_packet(struct sk_buff *skb,
+			    struct batadv_hard_iface *recv_if)
 {
-	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
-	struct orig_node *orig_node = NULL;
-	struct neigh_node *router = NULL;
+	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_neigh_node *router = NULL;
 	int hdr_size = sizeof(struct batadv_icmp_packet);
 	int ret = NET_RX_DROP;
 
@@ -475,12 +477,12 @@ out:
  * This method rotates the bonding list and increases the
  * returned router's refcount.
  */
-static struct neigh_node *
-batadv_find_bond_router(struct orig_node *primary_orig,
-			const struct hard_iface *recv_if)
+static struct batadv_neigh_node *
+batadv_find_bond_router(struct batadv_orig_node *primary_orig,
+			const struct batadv_hard_iface *recv_if)
 {
-	struct neigh_node *tmp_neigh_node;
-	struct neigh_node *router = NULL, *first_candidate = NULL;
+	struct batadv_neigh_node *tmp_neigh_node;
+	struct batadv_neigh_node *router = NULL, *first_candidate = NULL;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tmp_neigh_node, &primary_orig->bond_list,
@@ -530,12 +532,12 @@ out:
  *
  * Increases the returned router's refcount
  */
-static struct neigh_node *
-batadv_find_ifalter_router(struct orig_node *primary_orig,
-			   const struct hard_iface *recv_if)
+static struct batadv_neigh_node *
+batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
+			   const struct batadv_hard_iface *recv_if)
 {
-	struct neigh_node *tmp_neigh_node;
-	struct neigh_node *router = NULL, *first_candidate = NULL;
+	struct batadv_neigh_node *tmp_neigh_node;
+	struct batadv_neigh_node *router = NULL, *first_candidate = NULL;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tmp_neigh_node, &primary_orig->bond_list,
@@ -577,9 +579,9 @@ batadv_find_ifalter_router(struct orig_node *primary_orig,
 	return router;
 }
 
-int batadv_recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
+int batadv_recv_tt_query(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
 {
-	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_tt_query_packet *tt_query;
 	uint16_t tt_size;
 	struct ethhdr *ethhdr;
@@ -665,11 +667,11 @@ out:
 	return NET_RX_DROP;
 }
 
-int batadv_recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
+int batadv_recv_roam_adv(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
 {
-	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_roam_adv_packet *roam_adv_packet;
-	struct orig_node *orig_node;
+	struct batadv_orig_node *orig_node;
 	struct ethhdr *ethhdr;
 
 	/* drop packet if it has not necessary minimum size */
@@ -729,13 +731,14 @@ out:
  * bonding if possible. increases the found neighbors
  * refcount.
  */
-struct neigh_node *batadv_find_router(struct bat_priv *bat_priv,
-				      struct orig_node *orig_node,
-				      const struct hard_iface *recv_if)
+struct batadv_neigh_node *
+batadv_find_router(struct batadv_priv *bat_priv,
+		   struct batadv_orig_node *orig_node,
+		   const struct batadv_hard_iface *recv_if)
 {
-	struct orig_node *primary_orig_node;
-	struct orig_node *router_orig;
-	struct neigh_node *router;
+	struct batadv_orig_node *primary_orig_node;
+	struct batadv_orig_node *router_orig;
+	struct batadv_neigh_node *router;
 	static uint8_t zero_mac[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 	int bonding_enabled;
 	uint8_t *primary_addr;
@@ -840,11 +843,11 @@ static int batadv_check_unicast_packet(struct sk_buff *skb, int hdr_size)
 }
 
 static int batadv_route_unicast_packet(struct sk_buff *skb,
-				       struct hard_iface *recv_if)
+				       struct batadv_hard_iface *recv_if)
 {
-	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
-	struct orig_node *orig_node = NULL;
-	struct neigh_node *neigh_node = NULL;
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
 	int ret = NET_RX_DROP;
@@ -925,12 +928,12 @@ out:
 	return ret;
 }
 
-static int batadv_check_unicast_ttvn(struct bat_priv *bat_priv,
+static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 				     struct sk_buff *skb) {
 	uint8_t curr_ttvn;
-	struct orig_node *orig_node;
+	struct batadv_orig_node *orig_node;
 	struct ethhdr *ethhdr;
-	struct hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if;
 	struct batadv_unicast_packet *unicast_packet;
 	bool tt_poss_change;
 	int is_old_ttvn;
@@ -1004,9 +1007,10 @@ static int batadv_check_unicast_ttvn(struct bat_priv *bat_priv,
 	return 1;
 }
 
-int batadv_recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
+int batadv_recv_unicast_packet(struct sk_buff *skb,
+			       struct batadv_hard_iface *recv_if)
 {
-	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_unicast_packet *unicast_packet;
 	int hdr_size = sizeof(*unicast_packet);
 
@@ -1029,9 +1033,9 @@ int batadv_recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 }
 
 int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
-				  struct hard_iface *recv_if)
+				  struct batadv_hard_iface *recv_if)
 {
-	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct batadv_unicast_frag_packet *unicast_packet;
 	int hdr_size = sizeof(*unicast_packet);
 	struct sk_buff *new_skb = NULL;
@@ -1066,10 +1070,11 @@ int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
 }
 
 
-int batadv_recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
+int batadv_recv_bcast_packet(struct sk_buff *skb,
+			     struct batadv_hard_iface *recv_if)
 {
-	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
-	struct orig_node *orig_node = NULL;
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_bcast_packet *bcast_packet;
 	struct ethhdr *ethhdr;
 	int hdr_size = sizeof(*bcast_packet);
@@ -1156,11 +1161,12 @@ out:
 	return ret;
 }
 
-int batadv_recv_vis_packet(struct sk_buff *skb, struct hard_iface *recv_if)
+int batadv_recv_vis_packet(struct sk_buff *skb,
+			   struct batadv_hard_iface *recv_if)
 {
 	struct batadv_vis_packet *vis_packet;
 	struct ethhdr *ethhdr;
-	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	int hdr_size = sizeof(*vis_packet);
 
 	/* keep skb linear */
diff --git a/routing.h b/routing.h
index ead4ae0..9262279 100644
--- a/routing.h
+++ b/routing.h
@@ -20,32 +20,40 @@
 #ifndef _NET_BATMAN_ADV_ROUTING_H_
 #define _NET_BATMAN_ADV_ROUTING_H_
 
-void batadv_slide_own_bcast_window(struct hard_iface *hard_iface);
+void batadv_slide_own_bcast_window(struct batadv_hard_iface *hard_iface);
 bool batadv_check_management_packet(struct sk_buff *skb,
-				    struct hard_iface *hard_iface,
+				    struct batadv_hard_iface *hard_iface,
 				    int header_len);
-void batadv_update_route(struct bat_priv *bat_priv, struct orig_node *orig_node,
-			 struct neigh_node *neigh_node);
-int batadv_recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if);
-int batadv_recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
+void batadv_update_route(struct batadv_priv *bat_priv,
+			 struct batadv_orig_node *orig_node,
+			 struct batadv_neigh_node *neigh_node);
+int batadv_recv_icmp_packet(struct sk_buff *skb,
+			    struct batadv_hard_iface *recv_if);
+int batadv_recv_unicast_packet(struct sk_buff *skb,
+			       struct batadv_hard_iface *recv_if);
 int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
-				  struct hard_iface *recv_if);
-int batadv_recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
-int batadv_recv_vis_packet(struct sk_buff *skb, struct hard_iface *recv_if);
-int batadv_recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if);
-int batadv_recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if);
-struct neigh_node *batadv_find_router(struct bat_priv *bat_priv,
-				      struct orig_node *orig_node,
-				      const struct hard_iface *recv_if);
-void batadv_bonding_candidate_del(struct orig_node *orig_node,
-				  struct neigh_node *neigh_node);
-void batadv_bonding_candidate_add(struct orig_node *orig_node,
-				  struct neigh_node *neigh_node);
-void batadv_bonding_save_primary(const struct orig_node *orig_node,
-				 struct orig_node *orig_neigh_node,
+				  struct batadv_hard_iface *recv_if);
+int batadv_recv_bcast_packet(struct sk_buff *skb,
+			     struct batadv_hard_iface *recv_if);
+int batadv_recv_vis_packet(struct sk_buff *skb,
+			   struct batadv_hard_iface *recv_if);
+int batadv_recv_tt_query(struct sk_buff *skb,
+			 struct batadv_hard_iface *recv_if);
+int batadv_recv_roam_adv(struct sk_buff *skb,
+			 struct batadv_hard_iface *recv_if);
+struct batadv_neigh_node *
+batadv_find_router(struct batadv_priv *bat_priv,
+		   struct batadv_orig_node *orig_node,
+		   const struct batadv_hard_iface *recv_if);
+void batadv_bonding_candidate_del(struct batadv_orig_node *orig_node,
+				  struct batadv_neigh_node *neigh_node);
+void batadv_bonding_candidate_add(struct batadv_orig_node *orig_node,
+				  struct batadv_neigh_node *neigh_node);
+void batadv_bonding_save_primary(const struct batadv_orig_node *orig_node,
+				 struct batadv_orig_node *orig_neigh_node,
 				 const struct batadv_ogm_packet
 				 *batman_ogm_packet);
-int batadv_window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
+int batadv_window_protected(struct batadv_priv *bat_priv, int32_t seq_num_diff,
 			    unsigned long *last_reset);
 
 #endif /* _NET_BATMAN_ADV_ROUTING_H_ */
diff --git a/send.c b/send.c
index 67c1c6c..3b4b2da 100644
--- a/send.c
+++ b/send.c
@@ -32,7 +32,8 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work);
 /* send out an already prepared packet to the given address via the
  * specified batman interface
  */
-int batadv_send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
+int batadv_send_skb_packet(struct sk_buff *skb,
+			   struct batadv_hard_iface *hard_iface,
 			   const uint8_t *dst_addr)
 {
 	struct ethhdr *ethhdr;
@@ -76,9 +77,9 @@ send_skb_err:
 	return NET_XMIT_DROP;
 }
 
-void batadv_schedule_bat_ogm(struct hard_iface *hard_iface)
+void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface)
 {
-	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 
 	if ((hard_iface->if_status == BATADV_IF_NOT_IN_USE) ||
 	    (hard_iface->if_status == BATADV_IF_TO_BE_REMOVED))
@@ -96,7 +97,7 @@ void batadv_schedule_bat_ogm(struct hard_iface *hard_iface)
 	bat_priv->bat_algo_ops->bat_ogm_schedule(hard_iface);
 }
 
-static void batadv_forw_packet_free(struct forw_packet *forw_packet)
+static void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
 {
 	if (forw_packet->skb)
 		kfree_skb(forw_packet->skb);
@@ -105,9 +106,10 @@ static void batadv_forw_packet_free(struct forw_packet *forw_packet)
 	kfree(forw_packet);
 }
 
-static void _batadv_add_bcast_packet_to_list(struct bat_priv *bat_priv,
-					     struct forw_packet *forw_packet,
-					     unsigned long send_time)
+static void
+_batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
+				 struct batadv_forw_packet *forw_packet,
+				 unsigned long send_time)
 {
 	INIT_HLIST_NODE(&forw_packet->list);
 
@@ -132,12 +134,12 @@ static void _batadv_add_bcast_packet_to_list(struct bat_priv *bat_priv,
  * The skb is not consumed, so the caller should make sure that the
  * skb is freed.
  */
-int batadv_add_bcast_packet_to_list(struct bat_priv *bat_priv,
+int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				    const struct sk_buff *skb,
 				    unsigned long delay)
 {
-	struct hard_iface *primary_if = NULL;
-	struct forw_packet *forw_packet;
+	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_forw_packet *forw_packet;
 	struct batadv_bcast_packet *bcast_packet;
 	struct sk_buff *newskb;
 
@@ -187,14 +189,18 @@ out:
 
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 {
-	struct hard_iface *hard_iface;
+	struct batadv_hard_iface *hard_iface;
 	struct delayed_work *delayed_work =
 		container_of(work, struct delayed_work, work);
-	struct forw_packet *forw_packet =
-		container_of(delayed_work, struct forw_packet, delayed_work);
+	struct batadv_forw_packet *forw_packet;
 	struct sk_buff *skb1;
-	struct net_device *soft_iface = forw_packet->if_incoming->soft_iface;
-	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+	struct net_device *soft_iface;
+	struct batadv_priv *bat_priv;
+
+	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
+				   delayed_work);
+	soft_iface = forw_packet->if_incoming->soft_iface;
+	bat_priv = netdev_priv(soft_iface);
 
 	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
 	hlist_del(&forw_packet->list);
@@ -235,10 +241,11 @@ void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 {
 	struct delayed_work *delayed_work =
 		container_of(work, struct delayed_work, work);
-	struct forw_packet *forw_packet =
-		container_of(delayed_work, struct forw_packet, delayed_work);
-	struct bat_priv *bat_priv;
+	struct batadv_forw_packet *forw_packet;
+	struct batadv_priv *bat_priv;
 
+	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
+				   delayed_work);
 	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
 	spin_lock_bh(&bat_priv->forw_bat_list_lock);
 	hlist_del(&forw_packet->list);
@@ -264,10 +271,11 @@ out:
 	batadv_forw_packet_free(forw_packet);
 }
 
-void batadv_purge_outstanding_packets(struct bat_priv *bat_priv,
-				      const struct hard_iface *hard_iface)
+void
+batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
+				 const struct batadv_hard_iface *hard_iface)
 {
-	struct forw_packet *forw_packet;
+	struct batadv_forw_packet *forw_packet;
 	struct hlist_node *tmp_node, *safe_tmp_node;
 	bool pending;
 
diff --git a/send.h b/send.h
index e3ac75b..643329b 100644
--- a/send.h
+++ b/send.h
@@ -20,14 +20,16 @@
 #ifndef _NET_BATMAN_ADV_SEND_H_
 #define _NET_BATMAN_ADV_SEND_H_
 
-int batadv_send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
+int batadv_send_skb_packet(struct sk_buff *skb,
+			   struct batadv_hard_iface *hard_iface,
 			   const uint8_t *dst_addr);
-void batadv_schedule_bat_ogm(struct hard_iface *hard_iface);
-int batadv_add_bcast_packet_to_list(struct bat_priv *bat_priv,
+void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface);
+int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				    const struct sk_buff *skb,
 				    unsigned long delay);
 void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work);
-void batadv_purge_outstanding_packets(struct bat_priv *bat_priv,
-				      const struct hard_iface *hard_iface);
+void
+batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
+				 const struct batadv_hard_iface *hard_iface);
 
 #endif /* _NET_BATMAN_ADV_SEND_H_ */
diff --git a/soft-interface.c b/soft-interface.c
index 0a5d73a..7a7d821 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -92,13 +92,13 @@ static int batadv_interface_release(struct net_device *dev)
 
 static struct net_device_stats *batadv_interface_stats(struct net_device *dev)
 {
-	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct batadv_priv *bat_priv = netdev_priv(dev);
 	return &bat_priv->stats;
 }
 
 static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 {
-	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct batadv_priv *bat_priv = netdev_priv(dev);
 	struct sockaddr *addr = p;
 
 	if (!is_valid_ether_addr(addr->sa_data))
@@ -131,8 +131,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 			       struct net_device *soft_iface)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
-	struct bat_priv *bat_priv = netdev_priv(soft_iface);
-	struct hard_iface *primary_if = NULL;
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_bcast_packet *bcast_packet;
 	struct vlan_ethhdr *vhdr;
 	__be16 ethertype = __constant_htons(BATADV_ETH_P_BATMAN);
@@ -260,10 +260,10 @@ end:
 }
 
 void batadv_interface_rx(struct net_device *soft_iface,
-			 struct sk_buff *skb, struct hard_iface *recv_if,
+			 struct sk_buff *skb, struct batadv_hard_iface *recv_if,
 			 int hdr_size)
 {
-	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct ethhdr *ethhdr;
 	struct vlan_ethhdr *vhdr;
 	short vid __maybe_unused = -1;
@@ -338,7 +338,7 @@ static const struct net_device_ops batadv_netdev_ops = {
 
 static void batadv_interface_setup(struct net_device *dev)
 {
-	struct bat_priv *priv = netdev_priv(dev);
+	struct batadv_priv *priv = netdev_priv(dev);
 
 	ether_setup(dev);
 
@@ -364,7 +364,7 @@ static void batadv_interface_setup(struct net_device *dev)
 struct net_device *batadv_softif_create(const char *name)
 {
 	struct net_device *soft_iface;
-	struct bat_priv *bat_priv;
+	struct batadv_priv *bat_priv;
 	int ret;
 	size_t cnt_len = sizeof(uint64_t) * BATADV_CNT_NUM;
 
@@ -539,7 +539,7 @@ static void batadv_get_ethtool_stats(struct net_device *dev,
 				     struct ethtool_stats *stats,
 				     uint64_t *data)
 {
-	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct batadv_priv *bat_priv = netdev_priv(dev);
 	int i;
 
 	for (i = 0; i < BATADV_CNT_NUM; i++)
diff --git a/soft-interface.h b/soft-interface.h
index 2711ba5..852c683 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -22,7 +22,7 @@
 
 int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
 void batadv_interface_rx(struct net_device *soft_iface, struct sk_buff *skb,
-			 struct hard_iface *recv_if, int hdr_size);
+			 struct batadv_hard_iface *recv_if, int hdr_size);
 struct net_device *batadv_softif_create(const char *name);
 void batadv_softif_destroy(struct net_device *soft_iface);
 int batadv_softif_is_valid(const struct net_device *net_dev);
diff --git a/translation-table.c b/translation-table.c
index 4873d54..2a6d7d6 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -29,34 +29,35 @@
 
 #include <linux/crc16.h>
 
-static void batadv_send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
-				 struct orig_node *orig_node);
+static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
+				 struct batadv_orig_node *orig_node);
 static void batadv_tt_purge(struct work_struct *work);
 static void
-batadv_tt_global_del_orig_list(struct tt_global_entry *tt_global_entry);
+batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry);
 
 /* returns 1 if they are the same mac addr */
 static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
 {
-	const void *data1 = container_of(node, struct tt_common_entry,
+	const void *data1 = container_of(node, struct batadv_tt_common_entry,
 					 hash_entry);
 
 	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
 }
 
-static void batadv_tt_start_timer(struct bat_priv *bat_priv)
+static void batadv_tt_start_timer(struct batadv_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->tt_work, batadv_tt_purge);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->tt_work,
 			   msecs_to_jiffies(5000));
 }
 
-static struct tt_common_entry *
+static struct batadv_tt_common_entry *
 batadv_tt_hash_find(struct batadv_hashtable *hash, const void *data)
 {
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct tt_common_entry *tt_common_entry, *tt_common_entry_tmp = NULL;
+	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_common_entry *tt_common_entry_tmp = NULL;
 	uint32_t index;
 
 	if (!hash)
@@ -81,35 +82,37 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const void *data)
 	return tt_common_entry_tmp;
 }
 
-static struct tt_local_entry *
-batadv_tt_local_hash_find(struct bat_priv *bat_priv, const void *data)
+static struct batadv_tt_local_entry *
+batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const void *data)
 {
-	struct tt_common_entry *tt_common_entry;
-	struct tt_local_entry *tt_local_entry = NULL;
+	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_local_entry *tt_local_entry = NULL;
 
 	tt_common_entry = batadv_tt_hash_find(bat_priv->tt_local_hash, data);
 	if (tt_common_entry)
 		tt_local_entry = container_of(tt_common_entry,
-					      struct tt_local_entry, common);
+					      struct batadv_tt_local_entry,
+					      common);
 	return tt_local_entry;
 }
 
-static struct tt_global_entry *
-batadv_tt_global_hash_find(struct bat_priv *bat_priv, const void *data)
+static struct batadv_tt_global_entry *
+batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const void *data)
 {
-	struct tt_common_entry *tt_common_entry;
-	struct tt_global_entry *tt_global_entry = NULL;
+	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_global_entry *tt_global_entry = NULL;
 
 	tt_common_entry = batadv_tt_hash_find(bat_priv->tt_global_hash, data);
 	if (tt_common_entry)
 		tt_global_entry = container_of(tt_common_entry,
-					       struct tt_global_entry, common);
+					       struct batadv_tt_global_entry,
+					       common);
 	return tt_global_entry;
 
 }
 
 static void
-batadv_tt_local_entry_free_ref(struct tt_local_entry *tt_local_entry)
+batadv_tt_local_entry_free_ref(struct batadv_tt_local_entry *tt_local_entry)
 {
 	if (atomic_dec_and_test(&tt_local_entry->common.refcount))
 		kfree_rcu(tt_local_entry, common.rcu);
@@ -117,18 +120,18 @@ batadv_tt_local_entry_free_ref(struct tt_local_entry *tt_local_entry)
 
 static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
 {
-	struct tt_common_entry *tt_common_entry;
-	struct tt_global_entry *tt_global_entry;
+	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_global_entry *tt_global_entry;
 
-	tt_common_entry = container_of(rcu, struct tt_common_entry, rcu);
-	tt_global_entry = container_of(tt_common_entry, struct tt_global_entry,
-				       common);
+	tt_common_entry = container_of(rcu, struct batadv_tt_common_entry, rcu);
+	tt_global_entry = container_of(tt_common_entry,
+				       struct batadv_tt_global_entry, common);
 
 	kfree(tt_global_entry);
 }
 
 static void
-batadv_tt_global_entry_free_ref(struct tt_global_entry *tt_global_entry)
+batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
 {
 	if (atomic_dec_and_test(&tt_global_entry->common.refcount)) {
 		batadv_tt_global_del_orig_list(tt_global_entry);
@@ -139,24 +142,24 @@ batadv_tt_global_entry_free_ref(struct tt_global_entry *tt_global_entry)
 
 static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 {
-	struct tt_orig_list_entry *orig_entry;
+	struct batadv_tt_orig_list_entry *orig_entry;
 
-	orig_entry = container_of(rcu, struct tt_orig_list_entry, rcu);
+	orig_entry = container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
 	atomic_dec(&orig_entry->orig_node->tt_size);
 	batadv_orig_node_free_ref(orig_entry->orig_node);
 	kfree(orig_entry);
 }
 
 static void
-batadv_tt_orig_list_entry_free_ref(struct tt_orig_list_entry *orig_entry)
+batadv_tt_orig_list_entry_free_ref(struct batadv_tt_orig_list_entry *orig_entry)
 {
 	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
 }
 
-static void batadv_tt_local_event(struct bat_priv *bat_priv,
+static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 				  const uint8_t *addr, uint8_t flags)
 {
-	struct tt_change_node *tt_change_node, *entry, *safe;
+	struct batadv_tt_change_node *tt_change_node, *entry, *safe;
 	bool event_removed = false;
 	bool del_op_requested, del_op_entry;
 
@@ -214,7 +217,7 @@ int batadv_tt_len(int changes_num)
 	return changes_num * sizeof(struct batadv_tt_change);
 }
 
-static int batadv_tt_local_init(struct bat_priv *bat_priv)
+static int batadv_tt_local_init(struct batadv_priv *bat_priv)
 {
 	if (bat_priv->tt_local_hash)
 		return 0;
@@ -230,12 +233,12 @@ static int batadv_tt_local_init(struct bat_priv *bat_priv)
 void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 			 int ifindex)
 {
-	struct bat_priv *bat_priv = netdev_priv(soft_iface);
-	struct tt_local_entry *tt_local_entry = NULL;
-	struct tt_global_entry *tt_global_entry = NULL;
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_tt_local_entry *tt_local_entry = NULL;
+	struct batadv_tt_global_entry *tt_global_entry = NULL;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct tt_orig_list_entry *orig_entry;
+	struct batadv_tt_orig_list_entry *orig_entry;
 	int hash_added;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
@@ -332,12 +335,12 @@ static void batadv_tt_realloc_packet_buff(unsigned char **packet_buff,
 	}
 }
 
-static void batadv_tt_prepare_packet_buff(struct bat_priv *bat_priv,
+static void batadv_tt_prepare_packet_buff(struct batadv_priv *bat_priv,
 					  unsigned char **packet_buff,
 					  int *packet_buff_len,
 					  int min_packet_len)
 {
-	struct hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if;
 	int req_len;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -358,12 +361,12 @@ static void batadv_tt_prepare_packet_buff(struct bat_priv *bat_priv,
 		batadv_hardif_free_ref(primary_if);
 }
 
-static int batadv_tt_changes_fill_buff(struct bat_priv *bat_priv,
+static int batadv_tt_changes_fill_buff(struct batadv_priv *bat_priv,
 				       unsigned char **packet_buff,
 				       int *packet_buff_len,
 				       int min_packet_len)
 {
-	struct tt_change_node *entry, *safe;
+	struct batadv_tt_change_node *entry, *safe;
 	int count = 0, tot_changes = 0, new_len;
 	unsigned char *tt_buff;
 
@@ -415,10 +418,10 @@ static int batadv_tt_changes_fill_buff(struct bat_priv *bat_priv,
 int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hashtable *hash = bat_priv->tt_local_hash;
-	struct tt_common_entry *tt_common_entry;
-	struct hard_iface *primary_if;
+	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_hard_iface *primary_if;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	uint32_t i;
@@ -470,9 +473,10 @@ out:
 	return ret;
 }
 
-static void batadv_tt_local_set_pending(struct bat_priv *bat_priv,
-					struct tt_local_entry *tt_local_entry,
-					uint16_t flags, const char *message)
+static void
+batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
+			    struct batadv_tt_local_entry *tt_local_entry,
+			    uint16_t flags, const char *message)
 {
 	batadv_tt_local_event(bat_priv, tt_local_entry->common.addr,
 			      tt_local_entry->common.flags | flags);
@@ -488,10 +492,10 @@ static void batadv_tt_local_set_pending(struct bat_priv *bat_priv,
 		   tt_local_entry->common.addr, message);
 }
 
-void batadv_tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
+void batadv_tt_local_remove(struct batadv_priv *bat_priv, const uint8_t *addr,
 			    const char *message, bool roaming)
 {
-	struct tt_local_entry *tt_local_entry = NULL;
+	struct batadv_tt_local_entry *tt_local_entry = NULL;
 	uint16_t flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
@@ -508,17 +512,18 @@ out:
 		batadv_tt_local_entry_free_ref(tt_local_entry);
 }
 
-static void batadv_tt_local_purge_list(struct bat_priv *bat_priv,
+static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 				       struct hlist_head *head)
 {
-	struct tt_local_entry *tt_local_entry;
-	struct tt_common_entry *tt_common_entry;
+	struct batadv_tt_local_entry *tt_local_entry;
+	struct batadv_tt_common_entry *tt_common_entry;
 	struct hlist_node *node, *node_tmp;
 
 	hlist_for_each_entry_safe(tt_common_entry, node, node_tmp, head,
 				  hash_entry) {
 		tt_local_entry = container_of(tt_common_entry,
-					      struct tt_local_entry, common);
+					      struct batadv_tt_local_entry,
+					      common);
 		if (tt_local_entry->common.flags & BATADV_TT_CLIENT_NOPURGE)
 			continue;
 
@@ -535,7 +540,7 @@ static void batadv_tt_local_purge_list(struct bat_priv *bat_priv,
 	}
 }
 
-static void batadv_tt_local_purge(struct bat_priv *bat_priv)
+static void batadv_tt_local_purge(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->tt_local_hash;
 	struct hlist_head *head;
@@ -553,12 +558,12 @@ static void batadv_tt_local_purge(struct bat_priv *bat_priv)
 
 }
 
-static void batadv_tt_local_table_free(struct bat_priv *bat_priv)
+static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
-	struct tt_common_entry *tt_common_entry;
-	struct tt_local_entry *tt_local_entry;
+	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_local_entry *tt_local;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	uint32_t i;
@@ -576,10 +581,10 @@ static void batadv_tt_local_table_free(struct bat_priv *bat_priv)
 		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
 					  head, hash_entry) {
 			hlist_del_rcu(node);
-			tt_local_entry = container_of(tt_common_entry,
-						      struct tt_local_entry,
-						      common);
-			batadv_tt_local_entry_free_ref(tt_local_entry);
+			tt_local = container_of(tt_common_entry,
+						struct batadv_tt_local_entry,
+						common);
+			batadv_tt_local_entry_free_ref(tt_local);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -589,7 +594,7 @@ static void batadv_tt_local_table_free(struct bat_priv *bat_priv)
 	bat_priv->tt_local_hash = NULL;
 }
 
-static int batadv_tt_global_init(struct bat_priv *bat_priv)
+static int batadv_tt_global_init(struct batadv_priv *bat_priv)
 {
 	if (bat_priv->tt_global_hash)
 		return 0;
@@ -602,9 +607,9 @@ static int batadv_tt_global_init(struct bat_priv *bat_priv)
 	return 0;
 }
 
-static void batadv_tt_changes_list_free(struct bat_priv *bat_priv)
+static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 {
-	struct tt_change_node *entry, *safe;
+	struct batadv_tt_change_node *entry, *safe;
 
 	spin_lock_bh(&bat_priv->tt_changes_list_lock);
 
@@ -621,10 +626,11 @@ static void batadv_tt_changes_list_free(struct bat_priv *bat_priv)
 /* find out if an orig_node is already in the list of a tt_global_entry.
  * returns 1 if found, 0 otherwise
  */
-static bool batadv_tt_global_entry_has_orig(const struct tt_global_entry *entry,
-					    const struct orig_node *orig_node)
+static bool
+batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
+				const struct batadv_orig_node *orig_node)
 {
-	struct tt_orig_list_entry *tmp_orig_entry;
+	struct batadv_tt_orig_list_entry *tmp_orig_entry;
 	const struct hlist_head *head;
 	struct hlist_node *node;
 	bool found = false;
@@ -642,10 +648,10 @@ static bool batadv_tt_global_entry_has_orig(const struct tt_global_entry *entry,
 }
 
 static void
-batadv_tt_global_add_orig_entry(struct tt_global_entry *tt_global_entry,
-				struct orig_node *orig_node, int ttvn)
+batadv_tt_global_add_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
+				struct batadv_orig_node *orig_node, int ttvn)
 {
-	struct tt_orig_list_entry *orig_entry;
+	struct batadv_tt_orig_list_entry *orig_entry;
 
 	orig_entry = kzalloc(sizeof(*orig_entry), GFP_ATOMIC);
 	if (!orig_entry)
@@ -664,14 +670,15 @@ batadv_tt_global_add_orig_entry(struct tt_global_entry *tt_global_entry,
 }
 
 /* caller must hold orig_node refcount */
-int batadv_tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
+int batadv_tt_global_add(struct batadv_priv *bat_priv,
+			 struct batadv_orig_node *orig_node,
 			 const unsigned char *tt_addr, uint8_t flags,
 			 uint8_t ttvn)
 {
-	struct tt_global_entry *tt_global_entry = NULL;
+	struct batadv_tt_global_entry *tt_global_entry = NULL;
 	int ret = 0;
 	int hash_added;
-	struct tt_common_entry *common;
+	struct batadv_tt_common_entry *common;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, tt_addr);
 
@@ -745,13 +752,13 @@ out:
  * it is assumed that the caller holds rcu_read_lock();
  */
 static void
-batadv_tt_global_print_entry(struct tt_global_entry *tt_global_entry,
+batadv_tt_global_print_entry(struct batadv_tt_global_entry *tt_global_entry,
 			     struct seq_file *seq)
 {
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct tt_orig_list_entry *orig_entry;
-	struct tt_common_entry *tt_common_entry;
+	struct batadv_tt_orig_list_entry *orig_entry;
+	struct batadv_tt_common_entry *tt_common_entry;
 	uint16_t flags;
 	uint8_t last_ttvn;
 
@@ -773,11 +780,11 @@ batadv_tt_global_print_entry(struct tt_global_entry *tt_global_entry,
 int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hashtable *hash = bat_priv->tt_global_hash;
-	struct tt_common_entry *tt_common_entry;
-	struct tt_global_entry *tt_global_entry;
-	struct hard_iface *primary_if;
+	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_global_entry *tt_global;
+	struct batadv_hard_iface *primary_if;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	uint32_t i;
@@ -810,10 +817,10 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry, node,
 					 head, hash_entry) {
-			tt_global_entry = container_of(tt_common_entry,
-						       struct tt_global_entry,
-						       common);
-			batadv_tt_global_print_entry(tt_global_entry, seq);
+			tt_global = container_of(tt_common_entry,
+						 struct batadv_tt_global_entry,
+						 common);
+			batadv_tt_global_print_entry(tt_global, seq);
 		}
 		rcu_read_unlock();
 	}
@@ -825,11 +832,11 @@ out:
 
 /* deletes the orig list of a tt_global_entry */
 static void
-batadv_tt_global_del_orig_list(struct tt_global_entry *tt_global_entry)
+batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry)
 {
 	struct hlist_head *head;
 	struct hlist_node *node, *safe;
-	struct tt_orig_list_entry *orig_entry;
+	struct batadv_tt_orig_list_entry *orig_entry;
 
 	spin_lock_bh(&tt_global_entry->list_lock);
 	head = &tt_global_entry->orig_list;
@@ -842,14 +849,14 @@ batadv_tt_global_del_orig_list(struct tt_global_entry *tt_global_entry)
 }
 
 static void
-batadv_tt_global_del_orig_entry(struct bat_priv *bat_priv,
-				struct tt_global_entry *tt_global_entry,
-				struct orig_node *orig_node,
+batadv_tt_global_del_orig_entry(struct batadv_priv *bat_priv,
+				struct batadv_tt_global_entry *tt_global_entry,
+				struct batadv_orig_node *orig_node,
 				const char *message)
 {
 	struct hlist_head *head;
 	struct hlist_node *node, *safe;
-	struct tt_orig_list_entry *orig_entry;
+	struct batadv_tt_orig_list_entry *orig_entry;
 
 	spin_lock_bh(&tt_global_entry->list_lock);
 	head = &tt_global_entry->orig_list;
@@ -866,9 +873,10 @@ batadv_tt_global_del_orig_entry(struct bat_priv *bat_priv,
 	spin_unlock_bh(&tt_global_entry->list_lock);
 }
 
-static void batadv_tt_global_del_struct(struct bat_priv *bat_priv,
-					struct tt_global_entry *tt_global_entry,
-					const char *message)
+static void
+batadv_tt_global_del_struct(struct batadv_priv *bat_priv,
+			    struct batadv_tt_global_entry *tt_global_entry,
+			    const char *message)
 {
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Deleting global tt entry %pM: %s\n",
@@ -885,14 +893,15 @@ static void batadv_tt_global_del_struct(struct bat_priv *bat_priv,
  * otherwise we simply remove the originator scheduled for deletion.
  */
 static void
-batadv_tt_global_del_roaming(struct bat_priv *bat_priv,
-			     struct tt_global_entry *tt_global_entry,
-			     struct orig_node *orig_node, const char *message)
+batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
+			     struct batadv_tt_global_entry *tt_global_entry,
+			     struct batadv_orig_node *orig_node,
+			     const char *message)
 {
 	bool last_entry = true;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct tt_orig_list_entry *orig_entry;
+	struct batadv_tt_orig_list_entry *orig_entry;
 
 	/* no local entry exists, case 1:
 	 * Check if this is the last one or if other entries exist.
@@ -922,13 +931,13 @@ batadv_tt_global_del_roaming(struct bat_priv *bat_priv,
 
 
 
-static void batadv_tt_global_del(struct bat_priv *bat_priv,
-				 struct orig_node *orig_node,
+static void batadv_tt_global_del(struct batadv_priv *bat_priv,
+				 struct batadv_orig_node *orig_node,
 				 const unsigned char *addr,
 				 const char *message, bool roaming)
 {
-	struct tt_global_entry *tt_global_entry = NULL;
-	struct tt_local_entry *local_entry = NULL;
+	struct batadv_tt_global_entry *tt_global_entry = NULL;
+	struct batadv_tt_local_entry *local_entry = NULL;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr);
 	if (!tt_global_entry)
@@ -977,11 +986,12 @@ out:
 		batadv_tt_local_entry_free_ref(local_entry);
 }
 
-void batadv_tt_global_del_orig(struct bat_priv *bat_priv,
-			       struct orig_node *orig_node, const char *message)
+void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
+			       struct batadv_orig_node *orig_node,
+			       const char *message)
 {
-	struct tt_global_entry *global_entry;
-	struct tt_common_entry *tt_common_entry;
+	struct batadv_tt_global_entry *tt_global;
+	struct batadv_tt_common_entry *tt_common_entry;
 	uint32_t i;
 	struct batadv_hashtable *hash = bat_priv->tt_global_hash;
 	struct hlist_node *node, *safe;
@@ -998,19 +1008,19 @@ void batadv_tt_global_del_orig(struct bat_priv *bat_priv,
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node, safe,
 					  head, hash_entry) {
-			global_entry = container_of(tt_common_entry,
-						    struct tt_global_entry,
-						    common);
+			tt_global = container_of(tt_common_entry,
+						 struct batadv_tt_global_entry,
+						 common);
 
-			batadv_tt_global_del_orig_entry(bat_priv, global_entry,
+			batadv_tt_global_del_orig_entry(bat_priv, tt_global,
 							orig_node, message);
 
-			if (hlist_empty(&global_entry->orig_list)) {
+			if (hlist_empty(&tt_global->orig_list)) {
 				batadv_dbg(BATADV_DBG_TT, bat_priv,
 					   "Deleting global tt entry %pM: %s\n",
-					   global_entry->common.addr, message);
+					   tt_global->common.addr, message);
 				hlist_del_rcu(node);
-				batadv_tt_global_entry_free_ref(global_entry);
+				batadv_tt_global_entry_free_ref(tt_global);
 			}
 		}
 		spin_unlock_bh(list_lock);
@@ -1019,17 +1029,18 @@ void batadv_tt_global_del_orig(struct bat_priv *bat_priv,
 	orig_node->tt_initialised = false;
 }
 
-static void batadv_tt_global_roam_purge_list(struct bat_priv *bat_priv,
+static void batadv_tt_global_roam_purge_list(struct batadv_priv *bat_priv,
 					     struct hlist_head *head)
 {
-	struct tt_common_entry *tt_common_entry;
-	struct tt_global_entry *tt_global_entry;
+	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_global_entry *tt_global_entry;
 	struct hlist_node *node, *node_tmp;
 
 	hlist_for_each_entry_safe(tt_common_entry, node, node_tmp, head,
 				  hash_entry) {
 		tt_global_entry = container_of(tt_common_entry,
-					       struct tt_global_entry, common);
+					       struct batadv_tt_global_entry,
+					       common);
 		if (!(tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM))
 			continue;
 		if (!batadv_has_timed_out(tt_global_entry->roam_at,
@@ -1045,7 +1056,7 @@ static void batadv_tt_global_roam_purge_list(struct bat_priv *bat_priv,
 	}
 }
 
-static void batadv_tt_global_roam_purge(struct bat_priv *bat_priv)
+static void batadv_tt_global_roam_purge(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->tt_global_hash;
 	struct hlist_head *head;
@@ -1063,12 +1074,12 @@ static void batadv_tt_global_roam_purge(struct bat_priv *bat_priv)
 
 }
 
-static void batadv_tt_global_table_free(struct bat_priv *bat_priv)
+static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
-	struct tt_common_entry *tt_common_entry;
-	struct tt_global_entry *tt_global_entry;
+	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_global_entry *tt_global;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	uint32_t i;
@@ -1086,10 +1097,10 @@ static void batadv_tt_global_table_free(struct bat_priv *bat_priv)
 		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
 					  head, hash_entry) {
 			hlist_del_rcu(node);
-			tt_global_entry = container_of(tt_common_entry,
-						       struct tt_global_entry,
-						       common);
-			batadv_tt_global_entry_free_ref(tt_global_entry);
+			tt_global = container_of(tt_common_entry,
+						 struct batadv_tt_global_entry,
+						 common);
+			batadv_tt_global_entry_free_ref(tt_global);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -1099,8 +1110,9 @@ static void batadv_tt_global_table_free(struct bat_priv *bat_priv)
 	bat_priv->tt_global_hash = NULL;
 }
 
-static bool _batadv_is_ap_isolated(struct tt_local_entry *tt_local_entry,
-				   struct tt_global_entry *tt_global_entry)
+static bool
+_batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
+		       struct batadv_tt_global_entry *tt_global_entry)
 {
 	bool ret = false;
 
@@ -1111,17 +1123,17 @@ static bool _batadv_is_ap_isolated(struct tt_local_entry *tt_local_entry,
 	return ret;
 }
 
-struct orig_node *batadv_transtable_search(struct bat_priv *bat_priv,
-					   const uint8_t *src,
-					   const uint8_t *addr)
+struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
+						  const uint8_t *src,
+						  const uint8_t *addr)
 {
-	struct tt_local_entry *tt_local_entry = NULL;
-	struct tt_global_entry *tt_global_entry = NULL;
-	struct orig_node *orig_node = NULL;
-	struct neigh_node *router = NULL;
+	struct batadv_tt_local_entry *tt_local_entry = NULL;
+	struct batadv_tt_global_entry *tt_global_entry = NULL;
+	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_neigh_node *router = NULL;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct tt_orig_list_entry *orig_entry;
+	struct batadv_tt_orig_list_entry *orig_entry;
 	int best_tq;
 
 	if (src && atomic_read(&bat_priv->ap_isolation)) {
@@ -1170,13 +1182,13 @@ out:
 }
 
 /* Calculates the checksum of the local table of a given orig_node */
-static uint16_t batadv_tt_global_crc(struct bat_priv *bat_priv,
-				     struct orig_node *orig_node)
+static uint16_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
+				     struct batadv_orig_node *orig_node)
 {
 	uint16_t total = 0, total_one;
 	struct batadv_hashtable *hash = bat_priv->tt_global_hash;
-	struct tt_common_entry *tt_common;
-	struct tt_global_entry *tt_global_entry;
+	struct batadv_tt_common_entry *tt_common;
+	struct batadv_tt_global_entry *tt_global;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	uint32_t i;
@@ -1187,9 +1199,9 @@ static uint16_t batadv_tt_global_crc(struct bat_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, node, head, hash_entry) {
-			tt_global_entry = container_of(tt_common,
-						       struct tt_global_entry,
-						       common);
+			tt_global = container_of(tt_common,
+						 struct batadv_tt_global_entry,
+						 common);
 			/* Roaming clients are in the global table for
 			 * consistency only. They don't have to be
 			 * taken into account while computing the
@@ -1201,7 +1213,7 @@ static uint16_t batadv_tt_global_crc(struct bat_priv *bat_priv,
 			/* find out if this global entry is announced by this
 			 * originator
 			 */
-			if (!batadv_tt_global_entry_has_orig(tt_global_entry,
+			if (!batadv_tt_global_entry_has_orig(tt_global,
 							     orig_node))
 				continue;
 
@@ -1218,11 +1230,11 @@ static uint16_t batadv_tt_global_crc(struct bat_priv *bat_priv,
 }
 
 /* Calculates the checksum of the local table */
-static uint16_t batadv_tt_local_crc(struct bat_priv *bat_priv)
+static uint16_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
 {
 	uint16_t total = 0, total_one;
 	struct batadv_hashtable *hash = bat_priv->tt_local_hash;
-	struct tt_common_entry *tt_common;
+	struct batadv_tt_common_entry *tt_common;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	uint32_t i;
@@ -1250,9 +1262,9 @@ static uint16_t batadv_tt_local_crc(struct bat_priv *bat_priv)
 	return total;
 }
 
-static void batadv_tt_req_list_free(struct bat_priv *bat_priv)
+static void batadv_tt_req_list_free(struct batadv_priv *bat_priv)
 {
-	struct tt_req_node *node, *safe;
+	struct batadv_tt_req_node *node, *safe;
 
 	spin_lock_bh(&bat_priv->tt_req_list_lock);
 
@@ -1264,8 +1276,8 @@ static void batadv_tt_req_list_free(struct bat_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt_req_list_lock);
 }
 
-static void batadv_tt_save_orig_buffer(struct bat_priv *bat_priv,
-				       struct orig_node *orig_node,
+static void batadv_tt_save_orig_buffer(struct batadv_priv *bat_priv,
+				       struct batadv_orig_node *orig_node,
 				       const unsigned char *tt_buff,
 				       uint8_t tt_num_changes)
 {
@@ -1287,9 +1299,9 @@ static void batadv_tt_save_orig_buffer(struct bat_priv *bat_priv,
 	spin_unlock_bh(&orig_node->tt_buff_lock);
 }
 
-static void batadv_tt_req_purge(struct bat_priv *bat_priv)
+static void batadv_tt_req_purge(struct batadv_priv *bat_priv)
 {
-	struct tt_req_node *node, *safe;
+	struct batadv_tt_req_node *node, *safe;
 
 	spin_lock_bh(&bat_priv->tt_req_list_lock);
 	list_for_each_entry_safe(node, safe, &bat_priv->tt_req_list, list) {
@@ -1305,10 +1317,11 @@ static void batadv_tt_req_purge(struct bat_priv *bat_priv)
 /* returns the pointer to the new tt_req_node struct if no request
  * has already been issued for this orig_node, NULL otherwise
  */
-static struct tt_req_node *batadv_new_tt_req_node(struct bat_priv *bat_priv,
-						  struct orig_node *orig_node)
+static struct batadv_tt_req_node *
+batadv_new_tt_req_node(struct batadv_priv *bat_priv,
+		       struct batadv_orig_node *orig_node)
 {
-	struct tt_req_node *tt_req_node_tmp, *tt_req_node = NULL;
+	struct batadv_tt_req_node *tt_req_node_tmp, *tt_req_node = NULL;
 
 	spin_lock_bh(&bat_priv->tt_req_list_lock);
 	list_for_each_entry(tt_req_node_tmp, &bat_priv->tt_req_list, list) {
@@ -1335,7 +1348,7 @@ unlock:
 static int batadv_tt_local_valid_entry(const void *entry_ptr,
 				       const void *data_ptr)
 {
-	const struct tt_common_entry *tt_common_entry = entry_ptr;
+	const struct batadv_tt_common_entry *tt_common_entry = entry_ptr;
 
 	if (tt_common_entry->flags & BATADV_TT_CLIENT_NEW)
 		return 0;
@@ -1345,14 +1358,15 @@ static int batadv_tt_local_valid_entry(const void *entry_ptr,
 static int batadv_tt_global_valid(const void *entry_ptr,
 				  const void *data_ptr)
 {
-	const struct tt_common_entry *tt_common_entry = entry_ptr;
-	const struct tt_global_entry *tt_global_entry;
-	const struct orig_node *orig_node = data_ptr;
+	const struct batadv_tt_common_entry *tt_common_entry = entry_ptr;
+	const struct batadv_tt_global_entry *tt_global_entry;
+	const struct batadv_orig_node *orig_node = data_ptr;
 
 	if (tt_common_entry->flags & BATADV_TT_CLIENT_ROAM)
 		return 0;
 
-	tt_global_entry = container_of(tt_common_entry, struct tt_global_entry,
+	tt_global_entry = container_of(tt_common_entry,
+				       struct batadv_tt_global_entry,
 				       common);
 
 	return batadv_tt_global_entry_has_orig(tt_global_entry, orig_node);
@@ -1361,11 +1375,11 @@ static int batadv_tt_global_valid(const void *entry_ptr,
 static struct sk_buff *
 batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 			      struct batadv_hashtable *hash,
-			      struct hard_iface *primary_if,
+			      struct batadv_hard_iface *primary_if,
 			      int (*valid_cb)(const void *, const void *),
 			      void *cb_data)
 {
-	struct tt_common_entry *tt_common_entry;
+	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_query_packet *tt_response;
 	struct batadv_tt_change *tt_change;
 	struct hlist_node *node;
@@ -1425,16 +1439,16 @@ out:
 	return skb;
 }
 
-static int batadv_send_tt_request(struct bat_priv *bat_priv,
-				  struct orig_node *dst_orig_node,
+static int batadv_send_tt_request(struct batadv_priv *bat_priv,
+				  struct batadv_orig_node *dst_orig_node,
 				  uint8_t ttvn, uint16_t tt_crc,
 				  bool full_table)
 {
 	struct sk_buff *skb = NULL;
 	struct batadv_tt_query_packet *tt_request;
-	struct neigh_node *neigh_node = NULL;
-	struct hard_iface *primary_if;
-	struct tt_req_node *tt_req_node = NULL;
+	struct batadv_neigh_node *neigh_node = NULL;
+	struct batadv_hard_iface *primary_if;
+	struct batadv_tt_req_node *tt_req_node = NULL;
 	int ret = 1;
 	size_t tt_req_len;
 
@@ -1501,12 +1515,13 @@ out:
 }
 
 static bool
-batadv_send_other_tt_response(struct bat_priv *bat_priv,
+batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 			      struct batadv_tt_query_packet *tt_request)
 {
-	struct orig_node *req_dst_orig_node = NULL, *res_dst_orig_node = NULL;
-	struct neigh_node *neigh_node = NULL;
-	struct hard_iface *primary_if = NULL;
+	struct batadv_orig_node *req_dst_orig_node = NULL;
+	struct batadv_orig_node *res_dst_orig_node = NULL;
+	struct batadv_neigh_node *neigh_node = NULL;
+	struct batadv_hard_iface *primary_if = NULL;
 	uint8_t orig_ttvn, req_ttvn, ttvn;
 	int ret = false;
 	unsigned char *tt_buff;
@@ -1634,12 +1649,12 @@ out:
 }
 
 static bool
-batadv_send_my_tt_response(struct bat_priv *bat_priv,
+batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 			   struct batadv_tt_query_packet *tt_request)
 {
-	struct orig_node *orig_node = NULL;
-	struct neigh_node *neigh_node = NULL;
-	struct hard_iface *primary_if = NULL;
+	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_neigh_node *neigh_node = NULL;
+	struct batadv_hard_iface *primary_if = NULL;
 	uint8_t my_ttvn, req_ttvn, ttvn;
 	int ret = false;
 	unsigned char *tt_buff;
@@ -1754,7 +1769,7 @@ out:
 	return true;
 }
 
-bool batadv_send_tt_response(struct bat_priv *bat_priv,
+bool batadv_send_tt_response(struct batadv_priv *bat_priv,
 			     struct batadv_tt_query_packet *tt_request)
 {
 	if (batadv_is_my_mac(tt_request->dst)) {
@@ -1768,8 +1783,8 @@ bool batadv_send_tt_response(struct bat_priv *bat_priv,
 	}
 }
 
-static void _batadv_tt_update_changes(struct bat_priv *bat_priv,
-				      struct orig_node *orig_node,
+static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
+				      struct batadv_orig_node *orig_node,
 				      struct batadv_tt_change *tt_change,
 				      uint16_t tt_num_changes, uint8_t ttvn)
 {
@@ -1799,10 +1814,10 @@ static void _batadv_tt_update_changes(struct bat_priv *bat_priv,
 	orig_node->tt_initialised = true;
 }
 
-static void batadv_tt_fill_gtable(struct bat_priv *bat_priv,
+static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 				  struct batadv_tt_query_packet *tt_response)
 {
-	struct orig_node *orig_node = NULL;
+	struct batadv_orig_node *orig_node = NULL;
 
 	orig_node = batadv_orig_hash_find(bat_priv, tt_response->src);
 	if (!orig_node)
@@ -1829,8 +1844,8 @@ out:
 		batadv_orig_node_free_ref(orig_node);
 }
 
-static void batadv_tt_update_changes(struct bat_priv *bat_priv,
-				     struct orig_node *orig_node,
+static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
+				     struct batadv_orig_node *orig_node,
 				     uint16_t tt_num_changes, uint8_t ttvn,
 				     struct batadv_tt_change *tt_change)
 {
@@ -1842,9 +1857,9 @@ static void batadv_tt_update_changes(struct bat_priv *bat_priv,
 	atomic_set(&orig_node->last_ttvn, ttvn);
 }
 
-bool batadv_is_my_client(struct bat_priv *bat_priv, const uint8_t *addr)
+bool batadv_is_my_client(struct batadv_priv *bat_priv, const uint8_t *addr)
 {
-	struct tt_local_entry *tt_local_entry = NULL;
+	struct batadv_tt_local_entry *tt_local_entry = NULL;
 	bool ret = false;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
@@ -1862,11 +1877,11 @@ out:
 	return ret;
 }
 
-void batadv_handle_tt_response(struct bat_priv *bat_priv,
+void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 			       struct batadv_tt_query_packet *tt_response)
 {
-	struct tt_req_node *node, *safe;
-	struct orig_node *orig_node = NULL;
+	struct batadv_tt_req_node *node, *safe;
+	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tt_change *tt_change;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -1913,7 +1928,7 @@ out:
 		batadv_orig_node_free_ref(orig_node);
 }
 
-int batadv_tt_init(struct bat_priv *bat_priv)
+int batadv_tt_init(struct batadv_priv *bat_priv)
 {
 	int ret;
 
@@ -1930,9 +1945,9 @@ int batadv_tt_init(struct bat_priv *bat_priv)
 	return 1;
 }
 
-static void batadv_tt_roam_list_free(struct bat_priv *bat_priv)
+static void batadv_tt_roam_list_free(struct batadv_priv *bat_priv)
 {
-	struct tt_roam_node *node, *safe;
+	struct batadv_tt_roam_node *node, *safe;
 
 	spin_lock_bh(&bat_priv->tt_roam_list_lock);
 
@@ -1944,9 +1959,9 @@ static void batadv_tt_roam_list_free(struct bat_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt_roam_list_lock);
 }
 
-static void batadv_tt_roam_purge(struct bat_priv *bat_priv)
+static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
 {
-	struct tt_roam_node *node, *safe;
+	struct batadv_tt_roam_node *node, *safe;
 
 	spin_lock_bh(&bat_priv->tt_roam_list_lock);
 	list_for_each_entry_safe(node, safe, &bat_priv->tt_roam_list, list) {
@@ -1966,10 +1981,10 @@ static void batadv_tt_roam_purge(struct bat_priv *bat_priv)
  *
  * returns true if the ROAMING_ADV can be sent, false otherwise
  */
-static bool batadv_tt_check_roam_count(struct bat_priv *bat_priv,
+static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv,
 				       uint8_t *client)
 {
-	struct tt_roam_node *tt_roam_node;
+	struct batadv_tt_roam_node *tt_roam_node;
 	bool ret = false;
 
 	spin_lock_bh(&bat_priv->tt_roam_list_lock);
@@ -2010,14 +2025,14 @@ unlock:
 	return ret;
 }
 
-static void batadv_send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
-				 struct orig_node *orig_node)
+static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
+				 struct batadv_orig_node *orig_node)
 {
-	struct neigh_node *neigh_node = NULL;
+	struct batadv_neigh_node *neigh_node = NULL;
 	struct sk_buff *skb = NULL;
 	struct batadv_roam_adv_packet *roam_adv_packet;
 	int ret = 1;
-	struct hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if;
 	size_t len = sizeof(*roam_adv_packet);
 
 	/* before going on we have to check whether the client has
@@ -2068,10 +2083,11 @@ out:
 
 static void batadv_tt_purge(struct work_struct *work)
 {
-	struct delayed_work *delayed_work =
-		container_of(work, struct delayed_work, work);
-	struct bat_priv *bat_priv =
-		container_of(delayed_work, struct bat_priv, tt_work);
+	struct delayed_work *delayed_work;
+	struct batadv_priv *bat_priv;
+
+	delayed_work = container_of(work, struct delayed_work, work);
+	bat_priv = container_of(delayed_work, struct batadv_priv, tt_work);
 
 	batadv_tt_local_purge(bat_priv);
 	batadv_tt_global_roam_purge(bat_priv);
@@ -2081,7 +2097,7 @@ static void batadv_tt_purge(struct work_struct *work)
 	batadv_tt_start_timer(bat_priv);
 }
 
-void batadv_tt_free(struct bat_priv *bat_priv)
+void batadv_tt_free(struct batadv_priv *bat_priv)
 {
 	cancel_delayed_work_sync(&bat_priv->tt_work);
 
@@ -2104,7 +2120,7 @@ static uint16_t batadv_tt_set_flags(struct batadv_hashtable *hash,
 	uint16_t changed_num = 0;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct tt_common_entry *tt_common_entry;
+	struct batadv_tt_common_entry *tt_common_entry;
 
 	if (!hash)
 		goto out;
@@ -2133,11 +2149,11 @@ out:
 }
 
 /* Purge out all the tt local entries marked with TT_CLIENT_PENDING */
-static void batadv_tt_local_purge_pending_clients(struct bat_priv *bat_priv)
+static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->tt_local_hash;
-	struct tt_common_entry *tt_common;
-	struct tt_local_entry *tt_local_entry;
+	struct batadv_tt_common_entry *tt_common;
+	struct batadv_tt_local_entry *tt_local;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
@@ -2162,17 +2178,17 @@ static void batadv_tt_local_purge_pending_clients(struct bat_priv *bat_priv)
 
 			atomic_dec(&bat_priv->num_local_tt);
 			hlist_del_rcu(node);
-			tt_local_entry = container_of(tt_common,
-						      struct tt_local_entry,
-						      common);
-			batadv_tt_local_entry_free_ref(tt_local_entry);
+			tt_local = container_of(tt_common,
+						struct batadv_tt_local_entry,
+						common);
+			batadv_tt_local_entry_free_ref(tt_local);
 		}
 		spin_unlock_bh(list_lock);
 	}
 
 }
 
-static int batadv_tt_commit_changes(struct bat_priv *bat_priv,
+static int batadv_tt_commit_changes(struct batadv_priv *bat_priv,
 				    unsigned char **packet_buff,
 				    int *packet_buff_len, int packet_min_len)
 {
@@ -2204,7 +2220,7 @@ static int batadv_tt_commit_changes(struct bat_priv *bat_priv,
 }
 
 /* when calling this function (hard_iface == primary_if) has to be true */
-int batadv_tt_append_diff(struct bat_priv *bat_priv,
+int batadv_tt_append_diff(struct batadv_priv *bat_priv,
 			  unsigned char **packet_buff, int *packet_buff_len,
 			  int packet_min_len)
 {
@@ -2226,11 +2242,11 @@ int batadv_tt_append_diff(struct bat_priv *bat_priv,
 	return tt_num_changes;
 }
 
-bool batadv_is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src,
+bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, uint8_t *src,
 			   uint8_t *dst)
 {
-	struct tt_local_entry *tt_local_entry = NULL;
-	struct tt_global_entry *tt_global_entry = NULL;
+	struct batadv_tt_local_entry *tt_local_entry = NULL;
+	struct batadv_tt_global_entry *tt_global_entry = NULL;
 	bool ret = true;
 
 	if (!atomic_read(&bat_priv->ap_isolation))
@@ -2257,8 +2273,8 @@ out:
 	return ret;
 }
 
-void batadv_tt_update_orig(struct bat_priv *bat_priv,
-			   struct orig_node *orig_node,
+void batadv_tt_update_orig(struct batadv_priv *bat_priv,
+			   struct batadv_orig_node *orig_node,
 			   const unsigned char *tt_buff, uint8_t tt_num_changes,
 			   uint8_t ttvn, uint16_t tt_crc)
 {
@@ -2332,10 +2348,10 @@ request_table:
  * originator to another one. This entry is kept is still kept for consistency
  * purposes
  */
-bool batadv_tt_global_client_is_roaming(struct bat_priv *bat_priv,
+bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 					uint8_t *addr)
 {
-	struct tt_global_entry *tt_global_entry;
+	struct batadv_tt_global_entry *tt_global_entry;
 	bool ret = false;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr);
diff --git a/translation-table.h b/translation-table.h
index 4e83b29..ffa8735 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -21,42 +21,43 @@
 #define _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
 
 int batadv_tt_len(int changes_num);
-int batadv_tt_init(struct bat_priv *bat_priv);
+int batadv_tt_init(struct batadv_priv *bat_priv);
 void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 			 int ifindex);
-void batadv_tt_local_remove(struct bat_priv *bat_priv,
+void batadv_tt_local_remove(struct batadv_priv *bat_priv,
 			    const uint8_t *addr, const char *message,
 			    bool roaming);
 int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset);
-void batadv_tt_global_add_orig(struct bat_priv *bat_priv,
-			       struct orig_node *orig_node,
+void batadv_tt_global_add_orig(struct batadv_priv *bat_priv,
+			       struct batadv_orig_node *orig_node,
 			       const unsigned char *tt_buff, int tt_buff_len);
-int batadv_tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
+int batadv_tt_global_add(struct batadv_priv *bat_priv,
+			 struct batadv_orig_node *orig_node,
 			 const unsigned char *addr, uint8_t flags,
 			 uint8_t ttvn);
 int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset);
-void batadv_tt_global_del_orig(struct bat_priv *bat_priv,
-			       struct orig_node *orig_node,
+void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
+			       struct batadv_orig_node *orig_node,
 			       const char *message);
-struct orig_node *batadv_transtable_search(struct bat_priv *bat_priv,
-					   const uint8_t *src,
-					   const uint8_t *addr);
-void batadv_tt_free(struct bat_priv *bat_priv);
-bool batadv_send_tt_response(struct bat_priv *bat_priv,
+struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
+						  const uint8_t *src,
+						  const uint8_t *addr);
+void batadv_tt_free(struct batadv_priv *bat_priv);
+bool batadv_send_tt_response(struct batadv_priv *bat_priv,
 			     struct batadv_tt_query_packet *tt_request);
-bool batadv_is_my_client(struct bat_priv *bat_priv, const uint8_t *addr);
-void batadv_handle_tt_response(struct bat_priv *bat_priv,
+bool batadv_is_my_client(struct batadv_priv *bat_priv, const uint8_t *addr);
+void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 			       struct batadv_tt_query_packet *tt_response);
-bool batadv_is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src,
+bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, uint8_t *src,
 			   uint8_t *dst);
-void batadv_tt_update_orig(struct bat_priv *bat_priv,
-			   struct orig_node *orig_node,
+void batadv_tt_update_orig(struct batadv_priv *bat_priv,
+			   struct batadv_orig_node *orig_node,
 			   const unsigned char *tt_buff, uint8_t tt_num_changes,
 			   uint8_t ttvn, uint16_t tt_crc);
-int batadv_tt_append_diff(struct bat_priv *bat_priv,
+int batadv_tt_append_diff(struct batadv_priv *bat_priv,
 			  unsigned char **packet_buff, int *packet_buff_len,
 			  int packet_min_len);
-bool batadv_tt_global_client_is_roaming(struct bat_priv *bat_priv,
+bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 					uint8_t *addr);
 
 
diff --git a/types.h b/types.h
index 7dc1d50..fd86a44 100644
--- a/types.h
+++ b/types.h
@@ -28,7 +28,7 @@
 	(ETH_HLEN + max(sizeof(struct batadv_unicast_packet), \
 			sizeof(struct batadv_bcast_packet)))
 
-struct hard_iface {
+struct batadv_hard_iface {
 	struct list_head list;
 	int16_t if_num;
 	char if_status;
@@ -44,7 +44,7 @@ struct hard_iface {
 	struct rcu_head rcu;
 };
 
-/*	orig_node - structure for orig_list maintaining nodes of mesh
+/*	batadv_orig_node - structure for orig_list maintaining nodes of mesh
  *	@primary_addr: hosts primary interface address
  *	@last_seen: when last packet from this node was received
  *	@bcast_seqno_reset: time when the broadcast seqno window was reset
@@ -58,10 +58,10 @@ struct hard_iface {
  *	@candidates: how many candidates are available
  *	@selected: next bonding candidate
  */
-struct orig_node {
+struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
-	struct neigh_node __rcu *router; /* rcu protected pointer */
+	struct batadv_neigh_node __rcu *router; /* rcu protected pointer */
 	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
 	unsigned long last_seen;
@@ -93,7 +93,7 @@ struct orig_node {
 	atomic_t refcount;
 	struct rcu_head rcu;
 	struct hlist_node hash_entry;
-	struct bat_priv *bat_priv;
+	struct batadv_priv *bat_priv;
 	unsigned long last_frag_packet;
 	/* ogm_cnt_lock protects: bcast_own, bcast_own_sum,
 	 * neigh_node->real_bits, neigh_node->real_packet_count
@@ -106,18 +106,18 @@ struct orig_node {
 	struct list_head bond_list;
 };
 
-struct gw_node {
+struct batadv_gw_node {
 	struct hlist_node list;
-	struct orig_node *orig_node;
+	struct batadv_orig_node *orig_node;
 	unsigned long deleted;
 	atomic_t refcount;
 	struct rcu_head rcu;
 };
 
-/*	neigh_node
+/*	batadv_neigh_node
  *	@last_seen: when last packet via this neighbor was received
  */
-struct neigh_node {
+struct batadv_neigh_node {
 	struct hlist_node list;
 	uint8_t addr[ETH_ALEN];
 	uint8_t real_packet_count;
@@ -130,13 +130,13 @@ struct neigh_node {
 	DECLARE_BITMAP(real_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 	atomic_t refcount;
 	struct rcu_head rcu;
-	struct orig_node *orig_node;
-	struct hard_iface *if_incoming;
+	struct batadv_orig_node *orig_node;
+	struct batadv_hard_iface *if_incoming;
 	spinlock_t lq_update_lock;	/* protects: tq_recv, tq_index */
 };
 
 #ifdef CONFIG_BATMAN_ADV_BLA
-struct bcast_duplist_entry {
+struct batadv_bcast_duplist_entry {
 	uint8_t orig[ETH_ALEN];
 	uint16_t crc;
 	unsigned long entrytime;
@@ -159,7 +159,7 @@ enum batadv_counters {
 	BATADV_CNT_NUM,
 };
 
-struct bat_priv {
+struct batadv_priv {
 	atomic_t mesh_state;
 	struct net_device_stats stats;
 	uint64_t __percpu *bat_counters; /* Per cpu counters */
@@ -190,7 +190,7 @@ struct bat_priv {
 	 */
 	bool tt_poss_change;
 	char num_ifaces;
-	struct debug_log *debug_log;
+	struct batadv_debug_log *debug_log;
 	struct kobject *mesh_obj;
 	struct dentry *debug_dir;
 	struct hlist_head forw_bat_list;
@@ -209,7 +209,7 @@ struct bat_priv {
 	struct list_head tt_roam_list;
 	struct batadv_hashtable *vis_hash;
 #ifdef CONFIG_BATMAN_ADV_BLA
-	struct bcast_duplist_entry bcast_duplist[BATADV_DUPLIST_SIZE];
+	struct batadv_bcast_duplist_entry bcast_duplist[BATADV_DUPLIST_SIZE];
 	int bcast_duplist_curr;
 	struct batadv_bla_claim_dst claim_dest;
 #endif
@@ -231,29 +231,29 @@ struct bat_priv {
 	struct delayed_work orig_work;
 	struct delayed_work vis_work;
 	struct delayed_work bla_work;
-	struct gw_node __rcu *curr_gw;  /* rcu protected pointer */
+	struct batadv_gw_node __rcu *curr_gw;  /* rcu protected pointer */
 	atomic_t gw_reselect;
-	struct hard_iface __rcu *primary_if;  /* rcu protected pointer */
-	struct vis_info *my_vis_info;
-	struct bat_algo_ops *bat_algo_ops;
+	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
+	struct batadv_vis_info *my_vis_info;
+	struct batadv_algo_ops *bat_algo_ops;
 };
 
-struct socket_client {
+struct batadv_socket_client {
 	struct list_head queue_list;
 	unsigned int queue_len;
 	unsigned char index;
 	spinlock_t lock; /* protects queue_list, queue_len, index */
 	wait_queue_head_t queue_wait;
-	struct bat_priv *bat_priv;
+	struct batadv_priv *bat_priv;
 };
 
-struct socket_packet {
+struct batadv_socket_packet {
 	struct list_head list;
 	size_t icmp_len;
 	struct batadv_icmp_packet_rr icmp_packet;
 };
 
-struct tt_common_entry {
+struct batadv_tt_common_entry {
 	uint8_t addr[ETH_ALEN];
 	struct hlist_node hash_entry;
 	uint16_t flags;
@@ -261,31 +261,31 @@ struct tt_common_entry {
 	struct rcu_head rcu;
 };
 
-struct tt_local_entry {
-	struct tt_common_entry common;
+struct batadv_tt_local_entry {
+	struct batadv_tt_common_entry common;
 	unsigned long last_seen;
 };
 
-struct tt_global_entry {
-	struct tt_common_entry common;
+struct batadv_tt_global_entry {
+	struct batadv_tt_common_entry common;
 	struct hlist_head orig_list;
 	spinlock_t list_lock;	/* protects the list */
 	unsigned long roam_at; /* time at which TT_GLOBAL_ROAM was set */
 };
 
-struct tt_orig_list_entry {
-	struct orig_node *orig_node;
+struct batadv_tt_orig_list_entry {
+	struct batadv_orig_node *orig_node;
 	uint8_t ttvn;
 	struct rcu_head rcu;
 	struct hlist_node list;
 };
 
 #ifdef CONFIG_BATMAN_ADV_BLA
-struct backbone_gw {
+struct batadv_backbone_gw {
 	uint8_t orig[ETH_ALEN];
 	short vid;		/* used VLAN ID */
 	struct hlist_node hash_entry;
-	struct bat_priv *bat_priv;
+	struct batadv_priv *bat_priv;
 	unsigned long lasttime;	/* last time we heard of this backbone gw */
 	atomic_t request_sent;
 	atomic_t refcount;
@@ -293,10 +293,10 @@ struct backbone_gw {
 	uint16_t crc;		/* crc checksum over all claims */
 };
 
-struct claim {
+struct batadv_claim {
 	uint8_t addr[ETH_ALEN];
 	short vid;
-	struct backbone_gw *backbone_gw;
+	struct batadv_backbone_gw *backbone_gw;
 	unsigned long lasttime;	/* last time we heard of claim (locals only) */
 	struct rcu_head rcu;
 	atomic_t refcount;
@@ -304,18 +304,18 @@ struct claim {
 };
 #endif
 
-struct tt_change_node {
+struct batadv_tt_change_node {
 	struct list_head list;
 	struct batadv_tt_change change;
 };
 
-struct tt_req_node {
+struct batadv_tt_req_node {
 	uint8_t addr[ETH_ALEN];
 	unsigned long issued_at;
 	struct list_head list;
 };
 
-struct tt_roam_node {
+struct batadv_tt_roam_node {
 	uint8_t addr[ETH_ALEN];
 	atomic_t counter;
 	unsigned long first_time;
@@ -325,7 +325,7 @@ struct tt_roam_node {
 /*	forw_packet - structure for forw_list maintaining packets to be
  *	              send/forwarded
  */
-struct forw_packet {
+struct batadv_forw_packet {
 	struct hlist_node list;
 	unsigned long send_time;
 	uint8_t own;
@@ -334,20 +334,20 @@ struct forw_packet {
 	uint32_t direct_link_flags;
 	uint8_t num_packets;
 	struct delayed_work delayed_work;
-	struct hard_iface *if_incoming;
+	struct batadv_hard_iface *if_incoming;
 };
 
 /* While scanning for vis-entries of a particular vis-originator
  * this list collects its interfaces to create a subgraph/cluster
  * out of them later
  */
-struct if_list_entry {
+struct batadv_if_list_entry {
 	uint8_t addr[ETH_ALEN];
 	bool primary;
 	struct hlist_node list;
 };
 
-struct debug_log {
+struct batadv_debug_log {
 	char log_buff[BATADV_LOG_BUF_LEN];
 	unsigned long log_start;
 	unsigned long log_end;
@@ -355,13 +355,13 @@ struct debug_log {
 	wait_queue_head_t queue_wait;
 };
 
-struct frag_packet_list_entry {
+struct batadv_frag_packet_list_entry {
 	struct list_head list;
 	uint16_t seqno;
 	struct sk_buff *skb;
 };
 
-struct vis_info {
+struct batadv_vis_info {
 	unsigned long first_seen;
 	/* list of server-neighbors we received a vis-packet
 	 * from.  we should not reply to them.
@@ -370,40 +370,40 @@ struct vis_info {
 	struct list_head send_list;
 	struct kref refcount;
 	struct hlist_node hash_entry;
-	struct bat_priv *bat_priv;
+	struct batadv_priv *bat_priv;
 	/* this packet might be part of the vis send queue. */
 	struct sk_buff *skb_packet;
 	/* vis_info may follow here */
 } __packed;
 
-struct vis_info_entry {
+struct batadv_vis_info_entry {
 	uint8_t  src[ETH_ALEN];
 	uint8_t  dest[ETH_ALEN];
 	uint8_t  quality;	/* quality = 0 client */
 } __packed;
 
-struct recvlist_node {
+struct batadv_recvlist_node {
 	struct list_head list;
 	uint8_t mac[ETH_ALEN];
 };
 
-struct bat_algo_ops {
+struct batadv_algo_ops {
 	struct hlist_node list;
 	char *name;
 	/* init routing info when hard-interface is enabled */
-	int (*bat_iface_enable)(struct hard_iface *hard_iface);
+	int (*bat_iface_enable)(struct batadv_hard_iface *hard_iface);
 	/* de-init routing info when hard-interface is disabled */
-	void (*bat_iface_disable)(struct hard_iface *hard_iface);
+	void (*bat_iface_disable)(struct batadv_hard_iface *hard_iface);
 	/* (re-)init mac addresses of the protocol information
 	 * belonging to this hard-interface
 	 */
-	void (*bat_iface_update_mac)(struct hard_iface *hard_iface);
+	void (*bat_iface_update_mac)(struct batadv_hard_iface *hard_iface);
 	/* called when primary interface is selected / changed */
-	void (*bat_primary_iface_set)(struct hard_iface *hard_iface);
+	void (*bat_primary_iface_set)(struct batadv_hard_iface *hard_iface);
 	/* prepare a new outgoing OGM for the send queue */
-	void (*bat_ogm_schedule)(struct hard_iface *hard_iface);
+	void (*bat_ogm_schedule)(struct batadv_hard_iface *hard_iface);
 	/* send scheduled OGM */
-	void (*bat_ogm_emit)(struct forw_packet *forw_packet);
+	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
 };
 
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
diff --git a/unicast.c b/unicast.c
index 7409061..c42b81d 100644
--- a/unicast.c
+++ b/unicast.c
@@ -31,7 +31,7 @@
 
 static struct sk_buff *
 batadv_frag_merge_packet(struct list_head *head,
-			 struct frag_packet_list_entry *tfp,
+			 struct batadv_frag_packet_list_entry *tfp,
 			 struct sk_buff *skb)
 {
 	struct batadv_unicast_frag_packet *up;
@@ -80,7 +80,7 @@ err:
 static void batadv_frag_create_entry(struct list_head *head,
 				     struct sk_buff *skb)
 {
-	struct frag_packet_list_entry *tfp;
+	struct batadv_frag_packet_list_entry *tfp;
 	struct batadv_unicast_frag_packet *up;
 
 	up = (struct batadv_unicast_frag_packet *)skb->data;
@@ -98,7 +98,7 @@ static void batadv_frag_create_entry(struct list_head *head,
 static int batadv_frag_create_buffer(struct list_head *head)
 {
 	int i;
-	struct frag_packet_list_entry *tfp;
+	struct batadv_frag_packet_list_entry *tfp;
 
 	for (i = 0; i < BATADV_FRAG_BUFFER_SIZE; i++) {
 		tfp = kmalloc(sizeof(*tfp), GFP_ATOMIC);
@@ -115,11 +115,11 @@ static int batadv_frag_create_buffer(struct list_head *head)
 	return 0;
 }
 
-static struct frag_packet_list_entry *
+static struct batadv_frag_packet_list_entry *
 batadv_frag_search_packet(struct list_head *head,
 			  const struct batadv_unicast_frag_packet *up)
 {
-	struct frag_packet_list_entry *tfp;
+	struct batadv_frag_packet_list_entry *tfp;
 	struct batadv_unicast_frag_packet *tmp_up = NULL;
 	uint16_t search_seqno;
 
@@ -156,7 +156,7 @@ mov_tail:
 
 void batadv_frag_list_free(struct list_head *head)
 {
-	struct frag_packet_list_entry *pf, *tmp_pf;
+	struct batadv_frag_packet_list_entry *pf, *tmp_pf;
 
 	if (!list_empty(head)) {
 
@@ -175,11 +175,12 @@ void batadv_frag_list_free(struct list_head *head)
  * or the skb could be reassembled (skb_new will point to the new packet and
  * skb was freed)
  */
-int batadv_frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+int batadv_frag_reassemble_skb(struct sk_buff *skb,
+			       struct batadv_priv *bat_priv,
 			       struct sk_buff **new_skb)
 {
-	struct orig_node *orig_node;
-	struct frag_packet_list_entry *tmp_frag_entry;
+	struct batadv_orig_node *orig_node;
+	struct batadv_frag_packet_list_entry *tmp_frag_entry;
 	int ret = NET_RX_DROP;
 	struct batadv_unicast_frag_packet *unicast_packet;
 
@@ -219,11 +220,12 @@ out:
 	return ret;
 }
 
-int batadv_frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			 struct hard_iface *hard_iface, const uint8_t dstaddr[])
+int batadv_frag_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv,
+			 struct batadv_hard_iface *hard_iface,
+			 const uint8_t dstaddr[])
 {
 	struct batadv_unicast_packet tmp_uc, *unicast_packet;
-	struct hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if;
 	struct sk_buff *frag_skb;
 	struct batadv_unicast_frag_packet *frag1, *frag2;
 	int uc_hdr_len = sizeof(*unicast_packet);
@@ -286,12 +288,12 @@ out:
 	return ret;
 }
 
-int batadv_unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
+int batadv_unicast_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct batadv_unicast_packet *unicast_packet;
-	struct orig_node *orig_node;
-	struct neigh_node *neigh_node;
+	struct batadv_orig_node *orig_node;
+	struct batadv_neigh_node *neigh_node;
 	int data_len = skb->len;
 	int ret = 1;
 
diff --git a/unicast.h b/unicast.h
index e0b6e33..1c46e2e 100644
--- a/unicast.h
+++ b/unicast.h
@@ -25,12 +25,13 @@
 #define BATADV_FRAG_TIMEOUT 10000 /* purge frag list entries after time in ms */
 #define BATADV_FRAG_BUFFER_SIZE 6 /* number of list elements in buffer */
 
-int batadv_frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+int batadv_frag_reassemble_skb(struct sk_buff *skb,
+			       struct batadv_priv *bat_priv,
 			       struct sk_buff **new_skb);
 void batadv_frag_list_free(struct list_head *head);
-int batadv_unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
-int batadv_frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			 struct hard_iface *hard_iface,
+int batadv_unicast_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv);
+int batadv_frag_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv,
+			 struct batadv_hard_iface *hard_iface,
 			 const uint8_t dstaddr[]);
 
 static inline int batadv_frag_can_reassemble(const struct sk_buff *skb, int mtu)
diff --git a/vis.c b/vis.c
index 309493d..f09cc9a 100644
--- a/vis.c
+++ b/vis.c
@@ -28,14 +28,17 @@
 
 #define BATADV_MAX_VIS_PACKET_SIZE 1000
 
-static void batadv_start_vis_timer(struct bat_priv *bat_priv);
+static void batadv_start_vis_timer(struct batadv_priv *bat_priv);
 
 /* free the info */
 static void batadv_free_info(struct kref *ref)
 {
-	struct vis_info *info = container_of(ref, struct vis_info, refcount);
-	struct bat_priv *bat_priv = info->bat_priv;
-	struct recvlist_node *entry, *tmp;
+	struct batadv_vis_info *info;
+	struct batadv_priv *bat_priv;
+	struct batadv_recvlist_node *entry, *tmp;
+
+	info = container_of(ref, struct batadv_vis_info, refcount);
+	bat_priv = info->bat_priv;
 
 	list_del_init(&info->send_list);
 	spin_lock_bh(&bat_priv->vis_list_lock);
@@ -52,10 +55,10 @@ static void batadv_free_info(struct kref *ref)
 /* Compare two vis packets, used by the hashing algorithm */
 static int batadv_vis_info_cmp(const struct hlist_node *node, const void *data2)
 {
-	const struct vis_info *d1, *d2;
+	const struct batadv_vis_info *d1, *d2;
 	const struct batadv_vis_packet *p1, *p2;
 
-	d1 = container_of(node, struct vis_info, hash_entry);
+	d1 = container_of(node, struct batadv_vis_info, hash_entry);
 	d2 = data2;
 	p1 = (struct batadv_vis_packet *)d1->skb_packet->data;
 	p2 = (struct batadv_vis_packet *)d2->skb_packet->data;
@@ -67,7 +70,7 @@ static int batadv_vis_info_cmp(const struct hlist_node *node, const void *data2)
  */
 static uint32_t batadv_vis_info_choose(const void *data, uint32_t size)
 {
-	const struct vis_info *vis_info = data;
+	const struct batadv_vis_info *vis_info = data;
 	const struct batadv_vis_packet *packet;
 	const unsigned char *key;
 	uint32_t hash = 0;
@@ -88,13 +91,13 @@ static uint32_t batadv_vis_info_choose(const void *data, uint32_t size)
 	return hash % size;
 }
 
-static struct vis_info *batadv_vis_hash_find(struct bat_priv *bat_priv,
-					     const void *data)
+static struct batadv_vis_info *
+batadv_vis_hash_find(struct batadv_priv *bat_priv, const void *data)
 {
 	struct batadv_hashtable *hash = bat_priv->vis_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct vis_info *vis_info, *vis_info_tmp = NULL;
+	struct batadv_vis_info *vis_info, *vis_info_tmp = NULL;
 	uint32_t index;
 
 	if (!hash)
@@ -123,7 +126,7 @@ static void batadv_vis_data_insert_interface(const uint8_t *interface,
 					     struct hlist_head *if_list,
 					     bool primary)
 {
-	struct if_list_entry *entry;
+	struct batadv_if_list_entry *entry;
 	struct hlist_node *pos;
 
 	hlist_for_each_entry(entry, pos, if_list, list) {
@@ -143,7 +146,7 @@ static void batadv_vis_data_insert_interface(const uint8_t *interface,
 static void batadv_vis_data_read_prim_sec(struct seq_file *seq,
 					  const struct hlist_head *if_list)
 {
-	struct if_list_entry *entry;
+	struct batadv_if_list_entry *entry;
 	struct hlist_node *pos;
 
 	hlist_for_each_entry(entry, pos, if_list, list) {
@@ -155,9 +158,10 @@ static void batadv_vis_data_read_prim_sec(struct seq_file *seq,
 }
 
 /* read an entry  */
-static ssize_t batadv_vis_data_read_entry(struct seq_file *seq,
-					  const struct vis_info_entry *entry,
-					  const uint8_t *src, bool primary)
+static ssize_t
+batadv_vis_data_read_entry(struct seq_file *seq,
+			   const struct batadv_vis_info_entry *entry,
+			   const uint8_t *src, bool primary)
 {
 	if (primary && entry->quality == 0)
 		return seq_printf(seq, "TT %pM, ", entry->dest);
@@ -168,9 +172,10 @@ static ssize_t batadv_vis_data_read_entry(struct seq_file *seq,
 	return 0;
 }
 
-static void batadv_vis_data_insert_interfaces(struct hlist_head *list,
-					      struct batadv_vis_packet *packet,
-					      struct vis_info_entry *entries)
+static void
+batadv_vis_data_insert_interfaces(struct hlist_head *list,
+				  struct batadv_vis_packet *packet,
+				  struct batadv_vis_info_entry *entries)
 {
 	int i;
 
@@ -188,10 +193,10 @@ static void batadv_vis_data_insert_interfaces(struct hlist_head *list,
 static void batadv_vis_data_read_entries(struct seq_file *seq,
 					 struct hlist_head *list,
 					 struct batadv_vis_packet *packet,
-					 struct vis_info_entry *entries)
+					 struct batadv_vis_info_entry *entries)
 {
 	int i;
-	struct if_list_entry *entry;
+	struct batadv_if_list_entry *entry;
 	struct hlist_node *pos;
 
 	hlist_for_each_entry(entry, pos, list, list) {
@@ -213,11 +218,11 @@ static void batadv_vis_seq_print_text_bucket(struct seq_file *seq,
 					     const struct hlist_head *head)
 {
 	struct hlist_node *node;
-	struct vis_info *info;
+	struct batadv_vis_info *info;
 	struct batadv_vis_packet *packet;
 	uint8_t *entries_pos;
-	struct vis_info_entry *entries;
-	struct if_list_entry *entry;
+	struct batadv_vis_info_entry *entries;
+	struct batadv_if_list_entry *entry;
 	struct hlist_node *pos, *n;
 
 	HLIST_HEAD(vis_if_list);
@@ -225,7 +230,7 @@ static void batadv_vis_seq_print_text_bucket(struct seq_file *seq,
 	hlist_for_each_entry_rcu(info, node, head, hash_entry) {
 		packet = (struct batadv_vis_packet *)info->skb_packet->data;
 		entries_pos = (uint8_t *)packet + sizeof(*packet);
-		entries = (struct vis_info_entry *)entries_pos;
+		entries = (struct batadv_vis_info_entry *)entries_pos;
 
 		batadv_vis_data_insert_interface(packet->vis_orig, &vis_if_list,
 						 true);
@@ -243,10 +248,10 @@ static void batadv_vis_seq_print_text_bucket(struct seq_file *seq,
 
 int batadv_vis_seq_print_text(struct seq_file *seq, void *offset)
 {
-	struct hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
 	struct net_device *net_dev = (struct net_device *)seq->private;
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hashtable *hash = bat_priv->vis_hash;
 	uint32_t i;
 	int ret = 0;
@@ -275,8 +280,8 @@ out:
 /* add the info packet to the send list, if it was not
  * already linked in.
  */
-static void batadv_send_list_add(struct bat_priv *bat_priv,
-				 struct vis_info *info)
+static void batadv_send_list_add(struct batadv_priv *bat_priv,
+				 struct batadv_vis_info *info)
 {
 	if (list_empty(&info->send_list)) {
 		kref_get(&info->refcount);
@@ -287,7 +292,7 @@ static void batadv_send_list_add(struct bat_priv *bat_priv,
 /* delete the info packet from the send list, if it was
  * linked in.
  */
-static void batadv_send_list_del(struct vis_info *info)
+static void batadv_send_list_del(struct batadv_vis_info *info)
 {
 	if (!list_empty(&info->send_list)) {
 		list_del_init(&info->send_list);
@@ -296,10 +301,10 @@ static void batadv_send_list_del(struct vis_info *info)
 }
 
 /* tries to add one entry to the receive list. */
-static void batadv_recv_list_add(struct bat_priv *bat_priv,
+static void batadv_recv_list_add(struct batadv_priv *bat_priv,
 				 struct list_head *recv_list, const char *mac)
 {
-	struct recvlist_node *entry;
+	struct batadv_recvlist_node *entry;
 
 	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
@@ -312,11 +317,11 @@ static void batadv_recv_list_add(struct bat_priv *bat_priv,
 }
 
 /* returns 1 if this mac is in the recv_list */
-static int batadv_recv_list_is_in(struct bat_priv *bat_priv,
+static int batadv_recv_list_is_in(struct batadv_priv *bat_priv,
 				  const struct list_head *recv_list,
 				  const char *mac)
 {
-	const struct recvlist_node *entry;
+	const struct batadv_recvlist_node *entry;
 
 	spin_lock_bh(&bat_priv->vis_list_lock);
 	list_for_each_entry(entry, recv_list, list) {
@@ -333,18 +338,19 @@ static int batadv_recv_list_is_in(struct bat_priv *bat_priv,
  * broken.. ).	vis hash must be locked outside.  is_new is set when the packet
  * is newer than old entries in the hash.
  */
-static struct vis_info *batadv_add_packet(struct bat_priv *bat_priv,
-					  struct batadv_vis_packet *vis_packet,
-					  int vis_info_len, int *is_new,
-					  int make_broadcast)
+static struct batadv_vis_info *
+batadv_add_packet(struct batadv_priv *bat_priv,
+		  struct batadv_vis_packet *vis_packet, int vis_info_len,
+		  int *is_new, int make_broadcast)
 {
-	struct vis_info *info, *old_info;
+	struct batadv_vis_info *info, *old_info;
 	struct batadv_vis_packet *search_packet, *old_packet;
-	struct vis_info search_elem;
+	struct batadv_vis_info search_elem;
 	struct batadv_vis_packet *packet;
 	struct sk_buff *tmp_skb;
 	int hash_added;
 	size_t len;
+	size_t max_entries;
 
 	*is_new = 0;
 	/* sanity check */
@@ -413,8 +419,9 @@ static struct vis_info *batadv_add_packet(struct bat_priv *bat_priv,
 		memcpy(packet->target_orig, batadv_broadcast_addr, ETH_ALEN);
 
 	/* repair if entries is longer than packet. */
-	if (packet->entries * sizeof(struct vis_info_entry) > vis_info_len)
-		packet->entries = vis_info_len / sizeof(struct vis_info_entry);
+	max_entries = vis_info_len / sizeof(struct batadv_vis_info_entry);
+	if (packet->entries > max_entries)
+		packet->entries = max_entries;
 
 	batadv_recv_list_add(bat_priv, &info->recv_list, packet->sender_orig);
 
@@ -432,11 +439,11 @@ static struct vis_info *batadv_add_packet(struct bat_priv *bat_priv,
 }
 
 /* handle the server sync packet, forward if needed. */
-void batadv_receive_server_sync_packet(struct bat_priv *bat_priv,
+void batadv_receive_server_sync_packet(struct batadv_priv *bat_priv,
 				       struct batadv_vis_packet *vis_packet,
 				       int vis_info_len)
 {
-	struct vis_info *info;
+	struct batadv_vis_info *info;
 	int is_new, make_broadcast;
 	int vis_server = atomic_read(&bat_priv->vis_mode);
 
@@ -458,11 +465,11 @@ end:
 }
 
 /* handle an incoming client update packet and schedule forward if needed. */
-void batadv_receive_client_update_packet(struct bat_priv *bat_priv,
+void batadv_receive_client_update_packet(struct batadv_priv *bat_priv,
 					 struct batadv_vis_packet *vis_packet,
 					 int vis_info_len)
 {
-	struct vis_info *info;
+	struct batadv_vis_info *info;
 	struct batadv_vis_packet *packet;
 	int is_new;
 	int vis_server = atomic_read(&bat_priv->vis_mode);
@@ -506,14 +513,14 @@ end:
  *
  * Must be called with the originator hash locked
  */
-static int batadv_find_best_vis_server(struct bat_priv *bat_priv,
-				       struct vis_info *info)
+static int batadv_find_best_vis_server(struct batadv_priv *bat_priv,
+				       struct batadv_vis_info *info)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
-	struct neigh_node *router;
+	struct batadv_neigh_node *router;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct orig_node *orig_node;
+	struct batadv_orig_node *orig_node;
 	struct batadv_vis_packet *packet;
 	int best_tq = -1;
 	uint32_t i;
@@ -544,15 +551,15 @@ static int batadv_find_best_vis_server(struct bat_priv *bat_priv,
 }
 
 /* Return true if the vis packet is full. */
-static bool batadv_vis_packet_full(const struct vis_info *info)
+static bool batadv_vis_packet_full(const struct batadv_vis_info *info)
 {
 	const struct batadv_vis_packet *packet;
-	size_t num_items;
+	size_t num;
 
 	packet = (struct batadv_vis_packet *)info->skb_packet->data;
-	num_items = BATADV_MAX_VIS_PACKET_SIZE / sizeof(struct vis_info_entry);
+	num = BATADV_MAX_VIS_PACKET_SIZE / sizeof(struct batadv_vis_info_entry);
 
-	if (num_items < packet->entries + 1)
+	if (num < packet->entries + 1)
 		return true;
 	return false;
 }
@@ -560,17 +567,17 @@ static bool batadv_vis_packet_full(const struct vis_info *info)
 /* generates a packet of own vis data,
  * returns 0 on success, -1 if no packet could be generated
  */
-static int batadv_generate_vis_packet(struct bat_priv *bat_priv)
+static int batadv_generate_vis_packet(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct orig_node *orig_node;
-	struct neigh_node *router;
-	struct vis_info *info = bat_priv->my_vis_info;
+	struct batadv_orig_node *orig_node;
+	struct batadv_neigh_node *router;
+	struct batadv_vis_info *info = bat_priv->my_vis_info;
 	struct batadv_vis_packet *packet;
-	struct vis_info_entry *entry;
-	struct tt_common_entry *tt_common_entry;
+	struct batadv_vis_info_entry *entry;
+	struct batadv_tt_common_entry *tt_common_entry;
 	int best_tq = -1;
 	uint32_t i;
 
@@ -610,7 +617,7 @@ static int batadv_generate_vis_packet(struct bat_priv *bat_priv)
 				goto next;
 
 			/* fill one entry into buffer. */
-			entry = (struct vis_info_entry *)
+			entry = (struct batadv_vis_info_entry *)
 				      skb_put(info->skb_packet, sizeof(*entry));
 			memcpy(entry->src,
 			       router->if_incoming->net_dev->dev_addr,
@@ -636,7 +643,7 @@ next:
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry, node, head,
 					 hash_entry) {
-			entry = (struct vis_info_entry *)
+			entry = (struct batadv_vis_info_entry *)
 					skb_put(info->skb_packet,
 						sizeof(*entry));
 			memset(entry->src, 0, ETH_ALEN);
@@ -660,13 +667,13 @@ unlock:
 /* free old vis packets. Must be called with this vis_hash_lock
  * held
  */
-static void batadv_purge_vis_packets(struct bat_priv *bat_priv)
+static void batadv_purge_vis_packets(struct batadv_priv *bat_priv)
 {
 	uint32_t i;
 	struct batadv_hashtable *hash = bat_priv->vis_hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
-	struct vis_info *info;
+	struct batadv_vis_info *info;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -687,17 +694,17 @@ static void batadv_purge_vis_packets(struct bat_priv *bat_priv)
 	}
 }
 
-static void batadv_broadcast_vis_packet(struct bat_priv *bat_priv,
-					struct vis_info *info)
+static void batadv_broadcast_vis_packet(struct batadv_priv *bat_priv,
+					struct batadv_vis_info *info)
 {
-	struct neigh_node *router;
+	struct batadv_neigh_node *router;
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct orig_node *orig_node;
+	struct batadv_orig_node *orig_node;
 	struct batadv_vis_packet *packet;
 	struct sk_buff *skb;
-	struct hard_iface *hard_iface;
+	struct batadv_hard_iface *hard_iface;
 	uint8_t dstaddr[ETH_ALEN];
 	uint32_t i;
 
@@ -743,11 +750,11 @@ static void batadv_broadcast_vis_packet(struct bat_priv *bat_priv,
 	}
 }
 
-static void batadv_unicast_vis_packet(struct bat_priv *bat_priv,
-				      struct vis_info *info)
+static void batadv_unicast_vis_packet(struct batadv_priv *bat_priv,
+				      struct batadv_vis_info *info)
 {
-	struct orig_node *orig_node;
-	struct neigh_node *router = NULL;
+	struct batadv_orig_node *orig_node;
+	struct batadv_neigh_node *router = NULL;
 	struct sk_buff *skb;
 	struct batadv_vis_packet *packet;
 
@@ -773,10 +780,10 @@ out:
 }
 
 /* only send one vis packet. called from batadv_send_vis_packets() */
-static void batadv_send_vis_packet(struct bat_priv *bat_priv,
-				   struct vis_info *info)
+static void batadv_send_vis_packet(struct batadv_priv *bat_priv,
+				   struct batadv_vis_info *info)
 {
-	struct hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if;
 	struct batadv_vis_packet *packet;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -808,10 +815,10 @@ static void batadv_send_vis_packets(struct work_struct *work)
 {
 	struct delayed_work *delayed_work =
 		container_of(work, struct delayed_work, work);
-	struct bat_priv *bat_priv =
-		container_of(delayed_work, struct bat_priv, vis_work);
-	struct vis_info *info;
+	struct batadv_priv *bat_priv;
+	struct batadv_vis_info *info;
 
+	bat_priv = container_of(delayed_work, struct batadv_priv, vis_work);
 	spin_lock_bh(&bat_priv->vis_hash_lock);
 	batadv_purge_vis_packets(bat_priv);
 
@@ -840,7 +847,7 @@ static void batadv_send_vis_packets(struct work_struct *work)
 /* init the vis server. this may only be called when if_list is already
  * initialized (e.g. bat0 is initialized, interfaces have been added)
  */
-int batadv_vis_init(struct bat_priv *bat_priv)
+int batadv_vis_init(struct batadv_priv *bat_priv)
 {
 	struct batadv_vis_packet *packet;
 	int hash_added;
@@ -914,15 +921,15 @@ err:
 /* Decrease the reference count on a hash item info */
 static void batadv_free_info_ref(struct hlist_node *node, void *arg)
 {
-	struct vis_info *info;
+	struct batadv_vis_info *info;
 
-	info = container_of(node, struct vis_info, hash_entry);
+	info = container_of(node, struct batadv_vis_info, hash_entry);
 	batadv_send_list_del(info);
 	kref_put(&info->refcount, batadv_free_info);
 }
 
 /* shutdown vis-server */
-void batadv_vis_quit(struct bat_priv *bat_priv)
+void batadv_vis_quit(struct batadv_priv *bat_priv)
 {
 	if (!bat_priv->vis_hash)
 		return;
@@ -938,7 +945,7 @@ void batadv_vis_quit(struct bat_priv *bat_priv)
 }
 
 /* schedule packets for (re)transmission */
-static void batadv_start_vis_timer(struct bat_priv *bat_priv)
+static void batadv_start_vis_timer(struct batadv_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->vis_work, batadv_send_vis_packets);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->vis_work,
diff --git a/vis.h b/vis.h
index d6bfcc7..84e716e 100644
--- a/vis.h
+++ b/vis.h
@@ -24,13 +24,13 @@
 #define BATADV_VIS_TIMEOUT		200000
 
 int batadv_vis_seq_print_text(struct seq_file *seq, void *offset);
-void batadv_receive_server_sync_packet(struct bat_priv *bat_priv,
+void batadv_receive_server_sync_packet(struct batadv_priv *bat_priv,
 				       struct batadv_vis_packet *vis_packet,
 				       int vis_info_len);
-void batadv_receive_client_update_packet(struct bat_priv *bat_priv,
+void batadv_receive_client_update_packet(struct batadv_priv *bat_priv,
 					 struct batadv_vis_packet *vis_packet,
 					 int vis_info_len);
-int batadv_vis_init(struct bat_priv *bat_priv);
-void batadv_vis_quit(struct bat_priv *bat_priv);
+int batadv_vis_init(struct batadv_priv *bat_priv);
+void batadv_vis_quit(struct batadv_priv *bat_priv);
 
 #endif /* _NET_BATMAN_ADV_VIS_H_ */
-- 
1.7.10

