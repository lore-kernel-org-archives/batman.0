Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Nov 2011 00:28:35 +0800
Message-Id: <1322497717-21268-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201111290028.01655.lindner_marek@yahoo.de>
References: <201111290028.01655.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: add infrastructure to change
	routing algorithm at runtime
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_debugfs.c    |    8 ++++++
 bat_iv_ogm.c     |    9 ++++++
 main.c           |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 main.h           |    5 +++
 soft-interface.c |    4 +++
 types.h          |    7 +++++
 6 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index d0af9bf..05e2f1f 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -221,6 +221,12 @@ static void debug_log_cleanup(struct bat_priv *bat_priv)
 }
 #endif
 
+static int bat_algorithms_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, bat_algo_seq_print_text, net_dev);
+}
+
 static int originators_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -274,6 +280,7 @@ struct bat_debuginfo bat_debuginfo_##_name = {	\
 		}				\
 };
 
+static BAT_DEBUGINFO(routing_algos, S_IRUGO, bat_algorithms_open);
 static BAT_DEBUGINFO(originators, S_IRUGO, originators_open);
 static BAT_DEBUGINFO(gateways, S_IRUGO, gateways_open);
 static BAT_DEBUGINFO(softif_neigh, S_IRUGO, softif_neigh_open);
@@ -282,6 +289,7 @@ static BAT_DEBUGINFO(transtable_local, S_IRUGO, transtable_local_open);
 static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
 
 static struct bat_debuginfo *mesh_debuginfos[] = {
+	&bat_debuginfo_routing_algos,
 	&bat_debuginfo_originators,
 	&bat_debuginfo_gateways,
 	&bat_debuginfo_softif_neigh,
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index d60e1ba..a2b25ad 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1169,3 +1169,12 @@ void bat_ogm_receive(const struct ethhdr *ethhdr, unsigned char *packet_buff,
 	} while (bat_ogm_aggr_packet(buff_pos, packet_len,
 				     batman_ogm_packet->tt_num_changes));
 }
+
+static struct bat_algo bat_algo_iv = {
+	.name = "BATMAN IV",
+};
+
+int __init bat_iv_init(void)
+{
+	return bat_algo_register(&bat_algo_iv);
+}
diff --git a/main.c b/main.c
index fb87bdc..05b85f0 100644
--- a/main.c
+++ b/main.c
@@ -37,6 +37,7 @@
 /* List manipulations on hardif_list have to be rtnl_lock()'ed,
  * list traversals just rcu-locked */
 struct list_head hardif_list;
+static struct hlist_head bat_algo_list;
 
 unsigned char broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
@@ -45,6 +46,9 @@ struct workqueue_struct *bat_event_workqueue;
 static int __init batman_init(void)
 {
 	INIT_LIST_HEAD(&hardif_list);
+	INIT_HLIST_HEAD(&bat_algo_list);
+
+	bat_iv_init();
 
 	/* the name should not be longer than 10 chars - see
 	 * http://lwn.net/Articles/23634/ */
@@ -173,6 +177,77 @@ int is_my_mac(const uint8_t *addr)
 
 }
 
+static struct bat_algo *bat_algo_get(char *name)
+{
+	struct bat_algo *bat_algo = NULL, *bat_algo_tmp;
+	struct hlist_node *node;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(bat_algo_tmp, node, &bat_algo_list, list) {
+		if (strcmp(bat_algo_tmp->name, name) != 0)
+			continue;
+
+		bat_algo = bat_algo_tmp;
+		break;
+	}
+	rcu_read_unlock();
+
+	return bat_algo;
+}
+
+int bat_algo_register(struct bat_algo *bat_algo)
+{
+	struct bat_algo *bat_algo_tmp;
+	int ret = -1;
+
+	bat_algo_tmp = bat_algo_get(bat_algo->name);
+	if (bat_algo_tmp) {
+		pr_info("Trying to register already registered routing "
+			"algorithm: %s\n", bat_algo->name);
+		goto out;
+	}
+
+	INIT_HLIST_NODE(&bat_algo->list);
+	hlist_add_head_rcu(&bat_algo->list, &bat_algo_list);
+	ret = 0;
+
+out:
+	return ret;
+}
+
+int bat_algo_select(struct bat_priv *bat_priv, char *name)
+{
+	struct bat_algo *bat_algo;
+	int ret = -1;
+
+	bat_algo = bat_algo_get(name);
+	if (!bat_algo)
+		goto out;
+
+	/* TODO: must lock here - can we highjack an existing spinlock ? */
+	rcu_assign_pointer(bat_priv->bat_algo, bat_algo);
+	ret = 0;
+
+out:
+	return ret;
+}
+
+int bat_algo_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct bat_algo *bat_algo;
+	struct hlist_node *node;
+
+	seq_printf(seq, "Available routing algorithms:\n");
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(bat_algo, node, &bat_algo_list, list) {
+		seq_printf(seq, "%s\n", bat_algo->name);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
 module_init(batman_init);
 module_exit(batman_exit);
 
diff --git a/main.h b/main.h
index 464439f..1fa71d8 100644
--- a/main.h
+++ b/main.h
@@ -159,6 +159,11 @@ void mesh_free(struct net_device *soft_iface);
 void inc_module_count(void);
 void dec_module_count(void);
 int is_my_mac(const uint8_t *addr);
+int bat_algo_register(struct bat_algo *bat_algo);
+int bat_algo_select(struct bat_priv *bat_priv, char *name);
+int bat_algo_seq_print_text(struct seq_file *seq, void *offset);
+
+int bat_iv_init(void);
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 int debug_log(struct bat_priv *bat_priv, const char *fmt, ...) __printf(2, 3);
diff --git a/soft-interface.c b/soft-interface.c
index bd8c7cf..a0046ac 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -855,6 +855,10 @@ struct net_device *softif_create(const char *name)
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
 
+	ret = bat_algo_select(bat_priv, "BATMAN IV");
+	if (ret < 0)
+		goto unreg_soft_iface;
+
 	ret = sysfs_add_meshif(soft_iface);
 	if (ret < 0)
 		goto unreg_soft_iface;
diff --git a/types.h b/types.h
index 35085f4..cfb0cc2 100644
--- a/types.h
+++ b/types.h
@@ -206,6 +206,7 @@ struct bat_priv {
 	atomic_t gw_reselect;
 	struct hard_iface __rcu *primary_if;  /* rcu protected pointer */
 	struct vis_info *my_vis_info;
+	struct bat_algo __rcu *bat_algo;
 };
 
 struct socket_client {
@@ -344,4 +345,10 @@ struct softif_neigh {
 	struct rcu_head rcu;
 };
 
+
+struct bat_algo {
+	struct hlist_node list;
+	char name[20];
+};
+
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
-- 
1.7.5.4

