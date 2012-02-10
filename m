Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 10 Feb 2012 15:53:11 +0100
Message-Id: <1328885591-10445-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1328727958-16119-1-git-send-email-martin@hundeboll.net>
References: <1328727958-16119-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFCv2] batman-adv: Add blocking of one hop OGM
	messages
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

For testing purposes, forcing specific paths in a network where all
nodes are within reach, can be useful. This patch allows the user to
enter addresses from which direct OGMs should be ignored or not dropped.

The blocking of OGM is controlled through a file in debugfs:
/sys/kernel/debug/batman-adv/bat0/block_ogm.

The list of currently handled addresses is exported through that file.
An addresses is added by echoing it, together with an action, into the
file, e.g.:
echo de:ad:be:ef:ca:fe drop  > block_ogm
echo de:ad:be:ef:ca:fe allow > block_ogm
echo de:ad:be:ef:ca:fe del   > block_ogm

The drop action leads to dropping all OGMs received directly from this
address. The allow action leads to dropping all OGMs *not* from this
(or other allowed) addresses. The del action deletes the address from
the blocking list.

Addresses and actions are stored in a doubly linked list. When new
addresses are added, the list of originators is searched, and an
possible existing originator is updated. When new originators are created,
the list of addresses is searched and "orig_node->block_action" is set
accordingly.

The filtering is performed by checking the value of member
"orig_node->block_action" together with a count of addresses with the
"allow" action. The orig_node struct is found using the Ethernet source of
the OGM message in question. If "orig_node->block_action" is equal 2. If
the count of addresses with the "allow" action is non-zero, and
"orig_node->block_action" is not 3, the OGM is dropped.

v2: This is almost a complete rewrite of the previous patch to allow
adding addresses of unknown originators and the allow-only feature.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 Makefile               |    2 +
 Makefile.kbuild        |    1 +
 bat_debugfs.c          |    3 +
 block_ogm.c            |  394 ++++++++++++++++++++++++++++++++++++++++++++++++
 block_ogm.h            |   59 +++++++
 compat.c               |    8 +
 compat.h               |    1 +
 gen-compat-autoconf.sh |    1 +
 main.c                 |    2 +
 originator.c           |    2 +
 routing.c              |    5 +
 soft-interface.c       |    1 +
 types.h                |   12 ++
 13 files changed, 491 insertions(+), 0 deletions(-)
 create mode 100644 block_ogm.c
 create mode 100644 block_ogm.h

diff --git a/Makefile b/Makefile
index 08f8c39..b60a47f 100644
--- a/Makefile
+++ b/Makefile
@@ -23,6 +23,8 @@
 export CONFIG_BATMAN_ADV_DEBUG=n
 # B.A.T.M.A.N. bridge loop avoidance:
 export CONFIG_BATMAN_ADV_BLA=y
+# B.A.T.M.A.N. OGM packet filtering:
+export CONFIG_BATMAN_ADV_BLOCK_OGM=y
 
 PWD:=$(shell pwd)
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
diff --git a/Makefile.kbuild b/Makefile.kbuild
index 6d5c194..8262811 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -24,6 +24,7 @@ batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bat_sysfs.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
+batman-adv-$(CONFIG_BATMAN_ADV_BLOCK_OGM) += block_ogm.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/bat_debugfs.c b/bat_debugfs.c
index 916380c..863f59b 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -33,6 +33,7 @@
 #include "vis.h"
 #include "icmp_socket.h"
 #include "bridge_loop_avoidance.h"
+#include "block_ogm.h"
 
 static struct dentry *bat_debugfs;
 
@@ -350,6 +351,7 @@ int debugfs_add_meshif(struct net_device *dev)
 
 	bat_socket_setup(bat_priv);
 	debug_log_setup(bat_priv);
+	block_file_setup(bat_priv);
 
 	for (bat_debug = mesh_debuginfos; *bat_debug; ++bat_debug) {
 		file = debugfs_create_file(((*bat_debug)->attr).name,
@@ -380,6 +382,7 @@ void debugfs_del_meshif(struct net_device *dev)
 	struct bat_priv *bat_priv = netdev_priv(dev);
 
 	debug_log_cleanup(bat_priv);
+	block_file_cleanup(bat_priv);
 
 	if (bat_debugfs) {
 		debugfs_remove_recursive(bat_priv->debug_dir);
diff --git a/block_ogm.c b/block_ogm.c
new file mode 100644
index 0000000..3df385e
--- /dev/null
+++ b/block_ogm.c
@@ -0,0 +1,394 @@
+/*
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+ *
+ * Martin Hundebøll <martin@hundeboll.net>
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
+#include <linux/debugfs.h>
+#include "main.h"
+#include "block_ogm.h"
+#include "originator.h"
+
+/* Called when receiving OGM packets to check if it should be dropped.
+ * Returns true if the packets should be dropped. False if not. */
+bool block_ogm(struct bat_priv *bat_priv, const uint8_t *addr)
+{
+	struct orig_node *orig_node = orig_hash_find(bat_priv, addr);
+	uint8_t action;
+
+	if (!orig_node)
+		return false;
+
+	action = atomic_read(&orig_node->block_action);
+
+	/* Check if address is blocked */
+	if (action == BLOCK_ACTION_DROP)
+		return true;
+
+	/* Check if address is not allowed */
+	if (atomic_read(&bat_priv->block_ogm_allow_cnt) &&
+	    action != BLOCK_ACTION_ALLOW)
+		return true;
+
+	return false;
+}
+
+/* Decrement reference count of the block entry and free it, if it becomes
+ * zero. */
+static void block_entry_free_ref(struct block_entry *block_entry)
+{
+	if (atomic_dec_and_test(&block_entry->refcount))
+		kfree_rcu(block_entry, rcu);
+}
+
+/* Search the list of block-entries for an address. Returns the found entry
+ * and NULL if none is found. */
+static struct block_entry *block_find_entry(struct bat_priv *bat_priv,
+					    const uint8_t *addr)
+{
+	struct block_entry *block_entry_tmp, *block_entry = NULL;
+
+	/* Search for existing entry */
+	rcu_read_lock();
+	list_for_each_entry_rcu(block_entry_tmp, &bat_priv->block_list, list) {
+		if (compare_eth(block_entry_tmp->addr, addr)) {
+			/* Found a match */
+			block_entry = block_entry_tmp;
+			atomic_inc_not_zero(&block_entry->refcount);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return block_entry;
+}
+
+/* Searches the list of block-entries and creates one, if none is found. */
+static struct block_entry *block_get_entry(struct bat_priv *bat_priv,
+					   const uint8_t *addr)
+{
+	struct block_entry *block_entry = block_find_entry(bat_priv, addr);
+
+	if (block_entry)
+		return block_entry;
+
+	/* Create and insert entry if needed */
+	block_entry = kmalloc(sizeof(*block_entry), GFP_ATOMIC);
+	if (!block_entry)
+		return NULL;
+
+	memcpy(block_entry->addr, addr, ETH_ALEN);
+	atomic_set(&block_entry->refcount, 2);
+	block_entry->action = BLOCK_ACTION_NONE;
+
+	spin_lock_bh(&bat_priv->block_lock);
+	list_add(&block_entry->list, &bat_priv->block_list);
+	spin_unlock_bh(&bat_priv->block_lock);
+
+	return block_entry;
+}
+
+/* Deletes an entry from the list */
+static void block_del_addr(struct bat_priv *bat_priv,
+			   struct block_entry *block_entry)
+{
+	if (!block_entry)
+		return;
+
+	spin_lock_bh(&bat_priv->block_lock);
+	list_del(&block_entry->list);
+	spin_unlock_bh(&bat_priv->block_lock);
+
+	block_entry_free_ref(block_entry);
+}
+
+/* When new entries are added to the list, existing originators are
+ * searched and if one exists, its block_action member is set accordingly. */
+static void block_set_orig_action(struct bat_priv *bat_priv,
+				  struct block_entry *block_entry,
+				  uint8_t action)
+{
+	struct orig_node *orig_node = orig_hash_find(bat_priv, block_entry->addr);
+
+	if (!orig_node)
+		return;
+
+	atomic_set(&orig_node->block_action, action);
+	orig_node_free_ref(orig_node);
+}
+
+/* Set the action of an entry and update the allow counter in bat_priv
+ * if necessary. Also, update existing originators. */
+static void block_add_action(struct bat_priv *bat_priv,
+			     struct block_entry *block_entry,
+			     uint8_t action)
+{
+	uint8_t old_action;
+
+	if (!block_entry)
+		return;
+
+	old_action = block_entry->action;
+
+	/* Check if the allow counter should be adjusted. */
+	if (action == old_action)
+		return;
+	else if (old_action == BLOCK_ACTION_ALLOW)
+		atomic_dec_not_zero(&bat_priv->block_ogm_allow_cnt);
+	else if (action == BLOCK_ACTION_ALLOW)
+		atomic_inc(&bat_priv->block_ogm_allow_cnt);
+
+	block_entry->action = action;
+	block_set_orig_action(bat_priv, block_entry, action);
+}
+
+/* Adjust allow counter if needed and set action of originator, if one
+ * exists. */
+static void block_del_action(struct bat_priv *bat_priv,
+			     struct block_entry *block_entry)
+{
+	if (!block_entry)
+		return;
+
+	if (block_entry->action == BLOCK_ACTION_ALLOW)
+		atomic_dec_not_zero(&bat_priv->block_ogm_allow_cnt);
+
+	block_set_orig_action(bat_priv, block_entry, BLOCK_ACTION_NONE);
+}
+
+/* Called upon creation of an originator. Checks if the address of the new
+ * originator is listed in the list of block entries and sets the action of
+ * the originator accordingly. */
+void block_check_orig_entry(struct bat_priv *bat_priv,
+			    struct orig_node *orig_node)
+{
+	struct block_entry *block_entry;
+
+	block_entry = block_find_entry(bat_priv, orig_node->orig);
+
+	if (block_entry) {
+		atomic_set(&orig_node->block_action, block_entry->action);
+		block_entry_free_ref(block_entry);
+	} else {
+		atomic_set(&orig_node->block_action, BLOCK_ACTION_NONE);
+	}
+}
+
+/* Convert a human-readable MAC address into byte values. */
+static int block_parse_pretty_mac(const char *str, char *addr)
+{
+	int i;
+
+	if (str[MAC_ADDR_LEN] != ' ')
+		return -EINVAL;
+
+	/* Validate if string has valid format */
+	for (i = 1; i <= ETH_ALEN - 1; i++) {
+		if (str[i*3-1] != ':')
+			return -EINVAL;
+	}
+
+	/* Convert string to bytes */
+	for (i = 0; i < ETH_ALEN; i++) {
+		unsigned long l;
+
+		l = simple_strtoul(&str[i*3], (char **)NULL, 16);
+		addr[i] = (char)l;
+	}
+
+	return 0;
+}
+
+/* Convert the human readable action to a decimal value. */
+static int block_parse_action(const char *str, int *action)
+{
+	if (strncmp(str, BLOCK_ACTION_DEL_NAME,
+		    strlen(BLOCK_ACTION_DEL_NAME)) == 0)
+		*action = BLOCK_ACTION_DEL;
+	else if (strncmp(str, BLOCK_ACTION_DROP_NAME,
+			 strlen(BLOCK_ACTION_DROP_NAME)) == 0)
+		*action = BLOCK_ACTION_DROP;
+	else if (strncmp(str, BLOCK_ACTION_ALLOW_NAME,
+			 strlen(BLOCK_ACTION_ALLOW_NAME)) == 0)
+		*action = BLOCK_ACTION_ALLOW;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Called by debugfs when our file is opened. */
+static int block_file_open(struct inode *inode, struct file *file)
+{
+	nonseekable_open(inode, file);
+	file->private_data = inode->i_private;
+	inc_module_count();
+	return 0;
+}
+
+/* Called by debugfs when our file is closed. */
+static int block_file_release(struct inode *inode, struct file *file)
+{
+	dec_module_count();
+	return 0;
+}
+
+/* Called by debugfs when data is requested from our file. The function
+ * copies the address and action from each entry in the block list into 
+ * the user buffer. */
+static ssize_t block_file_read(struct file *file, char __user *buff,
+			       size_t count, loff_t *ppos)
+{
+	struct bat_priv *bat_priv = file->private_data;
+	struct block_entry *block_entry;
+	char mac[MAC_ADDR_LEN + BLOCK_ACTION_MAX_LEN + 2];
+	ssize_t c, i = 0;
+
+	/* If private_data is cleared, our work is done. */
+	if (!bat_priv)
+		return 0;
+
+	if (!access_ok(VERIFY_WRITE, buff, count))
+		return -EFAULT;
+
+	/* For each block entry. */
+	rcu_read_lock();
+	list_for_each_entry_rcu(block_entry, &bat_priv->block_list,
+				list) {
+		/* Copy address and action into temp buffer. */
+		c = scnprintf(mac, MAC_ADDR_LEN + BLOCK_ACTION_MAX_LEN + 2,
+			      "%pM %hhu\n",
+			      block_entry->addr,
+			      block_entry->action);
+		/* Copy formatted string to user space. */
+		c = c > count ? count : c;
+		copy_to_user(buff, mac, c);
+
+		/* Update counters before next copy. */
+		buff += c;
+		i += c;
+	}
+	rcu_read_unlock();
+
+	/* Clear private_data to skip further reads */
+	file->private_data = NULL;
+
+	return i;
+}
+
+/* Called by debugfs when data is written to our file. Copies the written data
+ * into a local buffer and reads out the MAC address and action from this and
+ * calls the according functions. */
+static ssize_t block_file_write(struct file *file, const char __user *buff,
+			        size_t count, loff_t *ppos)
+{
+	struct bat_priv *bat_priv = file->private_data;
+	struct block_entry *block_entry = NULL;
+	char *str;
+	char addr[MAC_ADDR_LEN];
+	int error = 0;
+	int action = 0;
+
+	/* Make sure buffer is long enough to hold at least a MAC address. */
+	if (!buff || count < MAC_ADDR_LEN + 1)
+		return -EINVAL;
+
+	if (!access_ok(VERIFY_READ, buff, count))
+		return -EFAULT;
+
+	/* Copy data from user space buffer. */
+	str = kmalloc(count, GFP_ATOMIC);
+	if (!str)
+		return -ENOMEM;
+	copy_from_user(str, buff, count);
+	str[count - 1] = '\0';
+
+	/* Read out MAC address. */
+	if ((error = block_parse_pretty_mac(str, addr)))
+		goto out;
+
+	/* Read out action. */
+	if ((error = block_parse_action(str + MAC_ADDR_LEN + 1, &action)) < 0)
+		goto out;
+
+	switch (action) {
+		/* Find and delete requested address. */
+	case BLOCK_ACTION_DEL:
+		block_entry = block_find_entry(bat_priv, addr);
+		block_del_action(bat_priv, block_entry);
+		block_del_addr(bat_priv, block_entry);
+		break;
+
+		/* Create or update requested address. */
+	case BLOCK_ACTION_DROP:
+	case BLOCK_ACTION_ALLOW:
+		block_entry = block_get_entry(bat_priv, addr);
+		block_add_action(bat_priv, block_entry, action);
+		break;
+	}
+
+	if (block_entry)
+		block_entry_free_ref(block_entry);
+
+out:
+	kfree(str);
+	return count;
+}
+
+static const struct file_operations fops = {
+	.owner = THIS_MODULE,
+	.open = block_file_open,
+	.release = block_file_release,
+	.read = block_file_read,
+	.write = block_file_write,
+	.llseek = no_llseek,
+};
+
+/* Register/create our file in debugfs and initialize bat_priv members. */
+int block_file_setup(struct bat_priv *bat_priv)
+{
+	struct dentry *d;
+
+	if (!bat_priv->debug_dir)
+		goto err;
+
+	d = debugfs_create_file("block_ogm", S_IFREG | S_IWUSR | S_IRUSR,
+				bat_priv->debug_dir, bat_priv, &fops);
+	if (d)
+		goto err;
+
+	return 0;
+
+err:
+	return 1;
+}
+
+/* Remove all entries from the block list. */
+int block_file_cleanup(struct bat_priv *bat_priv)
+{
+	struct block_entry *block_entry, *block_entry_tmp;
+
+	spin_lock_bh(&bat_priv->block_lock);
+	list_for_each_entry_safe(block_entry, block_entry_tmp,
+				 &bat_priv->block_list, list) {
+		list_del(&block_entry->list);
+		kfree(block_entry);
+	}
+	spin_unlock_bh(&bat_priv->block_lock);
+	return 0;
+}
diff --git a/block_ogm.h b/block_ogm.h
new file mode 100644
index 0000000..ff9cd75
--- /dev/null
+++ b/block_ogm.h
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+ *
+ * Martin Hundebøll <martin@hundeboll.net>
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
+#ifndef _NET_BATMAN_ADV_NETWORK_BLOCK_OGM_H
+#define _NET_BATMAN_ADV_NETWORK_BLOCK_OGM_H
+
+enum {
+	BLOCK_ACTION_NONE,
+	BLOCK_ACTION_DEL,
+	BLOCK_ACTION_DROP,
+	BLOCK_ACTION_ALLOW,
+};
+
+#define BLOCK_ACTION_DEL_NAME	"del"
+#define BLOCK_ACTION_DROP_NAME	"drop"
+#define BLOCK_ACTION_ALLOW_NAME	"allow"
+
+#define MAC_ADDR_LEN 17
+#define BLOCK_ACTION_MAX_LEN 10
+
+#ifdef CONFIG_BATMAN_ADV_BLOCK_OGM
+
+int block_file_setup(struct bat_priv *bat_priv);
+int block_file_cleanup(struct bat_priv *bat_priv);
+bool block_ogm(struct bat_priv *bat_priv, const uint8_t *addr);
+void block_check_orig_entry(struct bat_priv *bat_priv, struct orig_node *orig_node);
+
+#else /* ifdef CONFIG_BATMAN_ADV_BLOCK_OGM */
+
+#define block_file_setup(...)	(0)
+#define block_file_cleanup(...)	(0)
+
+static inline bool block_addr_drop(struct bat_priv *bat_priv,
+				   const uint8_t *addr)
+{
+	return false
+}
+
+#endif /* ifdef CONFIG_BATMAN_ADV_BLOCK_OGM */
+
+#endif /* _NET_BATMAN_ADV_NETWORK_BLOCK_OGM_H */
diff --git a/compat.c b/compat.c
index 73a2d8b..8a0b16b 100644
--- a/compat.c
+++ b/compat.c
@@ -63,4 +63,12 @@ void free_rcu_backbone_gw(struct rcu_head *rcu)
 	kfree(backbone_gw);
 }
 
+void free_rcu_block_entry(struct rcu_head *rcu)
+{
+	struct block_entry *block_entry;
+
+	block_entry = container_of(rcu, struct block_entry, rcu);
+	kfree(block_entry);
+}
+
 #endif /* < KERNEL_VERSION(3, 0, 0) */
diff --git a/compat.h b/compat.h
index e90409f..ccb787d 100644
--- a/compat.h
+++ b/compat.h
@@ -124,6 +124,7 @@ void free_rcu_gw_node(struct rcu_head *rcu);
 void free_rcu_neigh_node(struct rcu_head *rcu);
 void free_rcu_tt_local_entry(struct rcu_head *rcu);
 void free_rcu_backbone_gw(struct rcu_head *rcu);
+void free_rcu_block_entry(struct rcu_head *rcu);
 
 #endif /* < KERNEL_VERSION(3, 0, 0) */
 
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 7cf621b..b4ffe84 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -38,6 +38,7 @@ gen_config() {
 # write config variables
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_BLOCK_OGM' ${CONFIG_BATMAN_ADV_FILTER:="y"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
 diff "${TMP}" "${TARGET}" > /dev/null 2>&1 || cp "${TMP}" "${TARGET}"
diff --git a/main.c b/main.c
index 7750bca..8808ed6 100644
--- a/main.c
+++ b/main.c
@@ -97,6 +97,7 @@ int mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->gw_list_lock);
 	spin_lock_init(&bat_priv->vis_hash_lock);
 	spin_lock_init(&bat_priv->vis_list_lock);
+	spin_lock_init(&bat_priv->block_lock);
 
 	INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
 	INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
@@ -104,6 +105,7 @@ int mesh_init(struct net_device *soft_iface)
 	INIT_LIST_HEAD(&bat_priv->tt_changes_list);
 	INIT_LIST_HEAD(&bat_priv->tt_req_list);
 	INIT_LIST_HEAD(&bat_priv->tt_roam_list);
+	INIT_LIST_HEAD(&bat_priv->block_list);
 
 	if (originator_init(bat_priv) < 1)
 		goto err;
diff --git a/originator.c b/originator.c
index 2db4b53..992738b 100644
--- a/originator.c
+++ b/originator.c
@@ -29,6 +29,7 @@
 #include "unicast.h"
 #include "soft-interface.h"
 #include "bridge_loop_avoidance.h"
+#include "block_ogm.h"
 
 static void purge_orig(struct work_struct *work);
 
@@ -236,6 +237,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
 
 	atomic_set(&orig_node->bond_candidates, 0);
+	block_check_orig_entry(bat_priv, orig_node);
 
 	size = bat_priv->num_ifaces * sizeof(unsigned long) * NUM_WORDS;
 
diff --git a/routing.c b/routing.c
index 7b7fcbe..125f35c 100644
--- a/routing.c
+++ b/routing.c
@@ -30,6 +30,7 @@
 #include "vis.h"
 #include "unicast.h"
 #include "bridge_loop_avoidance.h"
+#include "block_ogm.h"
 
 static int route_unicast_packet(struct sk_buff *skb,
 				struct hard_iface *recv_if);
@@ -259,6 +260,10 @@ int recv_bat_ogm_packet(struct sk_buff *skb, struct hard_iface *hard_iface)
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
+	/* Packet is blocked by user */
+	if (block_ogm(bat_priv, ethhdr->h_source))
+		return NET_RX_DROP;
+
 	/* packet with broadcast indication but unicast recipient */
 	if (!is_broadcast_ether_addr(ethhdr->h_dest))
 		return NET_RX_DROP;
diff --git a/soft-interface.c b/soft-interface.c
index 8de8779..357f555 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -389,6 +389,7 @@ struct net_device *softif_create(const char *name)
 	atomic_set(&bat_priv->tt_local_changes, 0);
 	atomic_set(&bat_priv->tt_ogm_append_cnt, 0);
 	atomic_set(&bat_priv->bla_num_requests, 0);
+	atomic_set(&bat_priv->block_ogm_allow_cnt, 0);
 
 	bat_priv->tt_buff = NULL;
 	bat_priv->tt_buff_len = 0;
diff --git a/types.h b/types.h
index 7f7f610..54c71b7 100644
--- a/types.h
+++ b/types.h
@@ -108,6 +108,7 @@ struct orig_node {
 	spinlock_t tt_list_lock; /* protects tt_list */
 	atomic_t bond_candidates;
 	struct list_head bond_list;
+	atomic_t block_action; /* Boolean */
 };
 
 struct gw_node {
@@ -217,6 +218,9 @@ struct bat_priv {
 	struct hard_iface __rcu *primary_if;  /* rcu protected pointer */
 	struct vis_info *my_vis_info;
 	struct bat_algo_ops *bat_algo_ops;
+	struct list_head block_list;
+	spinlock_t block_lock;
+	atomic_t block_ogm_allow_cnt; /* uint */
 };
 
 struct socket_client {
@@ -385,4 +389,12 @@ struct bat_algo_ops {
 				struct sk_buff *skb);
 };
 
+struct block_entry {
+	struct list_head list;
+	uint8_t addr[ETH_ALEN];
+	uint8_t action;
+	struct rcu_head rcu;
+	atomic_t refcount; /* uint */
+};
+
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
-- 
1.7.9

