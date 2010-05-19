Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 19 May 2010 21:43:50 +0200
Message-Id: <1274298233-21487-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201005192141.32752.sven.eckelmann@gmx.de>
References: <201005192141.32752.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: Move device for icmp
	injection to debugfs
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

batctl uses /dev/batman-adv to send special batman-adv icmp packets to
other nodes in the mesh. To get it working with multiple batX devices we
must ensure that every mesh device can have their own socket which is
used to inject those packets in exactly one mesh.

The current implementation still doesn't allow to use complete separated
meshes as we rely on structures which are not part of the private data
of a batman device.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
Please apply using git-am on top of batman-adv maint branch

 Makefile.kbuild           |    2 +-
 bat_debugfs.c             |   74 ++++++++++
 bat_debugfs.h             |   33 ++++
 compat.h                  |   65 +++++++--
 device.c                  |  355 ---------------------------------------------
 icmp_socket.c             |  329 +++++++++++++++++++++++++++++++++++++++++
 device.h => icmp_socket.h |   18 +--
 main.c                    |   21 ++-
 routing.c                 |    4 +-
 types.h                   |    5 +-
 10 files changed, 516 insertions(+), 390 deletions(-)
 create mode 100644 bat_debugfs.c
 create mode 100644 bat_debugfs.h
 delete mode 100644 device.c
 create mode 100644 icmp_socket.c
 rename device.h => icmp_socket.h (54%)

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 914d556..33eb961 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -32,4 +32,4 @@ EXTRA_CFLAGS += -DREVISION_VERSION=\"r$(REVISION)\"
 endif
 
 obj-m += batman-adv.o
-batman-adv-objs := main.o bat_sysfs.o send.o routing.o soft-interface.o device.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o $(shell [ "2" -eq "$(VERSION)" ] 2>&- && [ "6" -eq "$(PATCHLEVEL)" ] 2>&- && [ "$(SUBLEVEL)" -le "28" ] 2>&- && echo bat_printk.o)
+batman-adv-objs := main.o bat_debugfs.o bat_sysfs.o send.o routing.o soft-interface.o icmp_socket.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o $(shell [ "2" -eq "$(VERSION)" ] 2>&- && [ "6" -eq "$(PATCHLEVEL)" ] 2>&- && [ "$(SUBLEVEL)" -le "28" ] 2>&- && echo bat_printk.o)
diff --git a/bat_debugfs.c b/bat_debugfs.c
new file mode 100644
index 0000000..32d8144
--- /dev/null
+++ b/bat_debugfs.c
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) 2010 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner
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
+
+#include "main.h"
+#include "bat_debugfs.h"
+#include "translation-table.h"
+#include "originator.h"
+#include "hard-interface.h"
+#include "vis.h"
+#include "icmp_socket.h"
+#include "compat.h"
+
+static struct dentry *bat_debugfs;
+
+void debugfs_init(void)
+{
+	bat_debugfs = debugfs_create_dir(DEBUGFS_BAT_SUBDIR, NULL);
+}
+
+void debugfs_destroy(void)
+{
+	if (bat_debugfs) {
+		debugfs_remove_recursive(bat_debugfs);
+		bat_debugfs = NULL;
+	}
+}
+
+int debugfs_add_meshif(struct net_device *dev)
+{
+	struct bat_priv *bat_priv = netdev_priv(dev);
+
+	if (!bat_debugfs)
+		goto out;
+
+	bat_priv->debug_dir = debugfs_create_dir(dev->name, bat_debugfs);
+	if (!bat_priv->debug_dir)
+		goto out;
+
+	bat_socket_setup(bat_priv);
+
+	return 0;
+out:
+	return -ENOMEM;
+}
+
+void debugfs_del_meshif(struct net_device *dev)
+{
+	struct bat_priv *bat_priv = netdev_priv(dev);
+
+	if (bat_debugfs) {
+		debugfs_remove_recursive(bat_priv->debug_dir);
+		bat_priv->debug_dir = NULL;
+	}
+}
diff --git a/bat_debugfs.h b/bat_debugfs.h
new file mode 100644
index 0000000..5cdd332
--- /dev/null
+++ b/bat_debugfs.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2010 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner
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
+
+#ifndef BAT_DEBUGFS_H
+#define BAT_DEBUGFS_H
+
+#define DEBUGFS_BAT_SUBDIR "batman_adv"
+
+void debugfs_init(void);
+void debugfs_destroy(void);
+int debugfs_add_meshif(struct net_device *dev);
+void debugfs_del_meshif(struct net_device *dev);
+
+#endif
diff --git a/compat.h b/compat.h
index 5d30976..a8b24e4 100644
--- a/compat.h
+++ b/compat.h
@@ -160,12 +160,6 @@ static inline char *pack_hex_byte(char *buf, u8 byte)
     return buf;
 }
 
-#define device_create(_cls, _parent, _devt, _device, _fmt) \
-	class_device_create(_cls, _parent, _devt, _device, _fmt)
-
-#define device_destroy(_cls, _device) \
-	class_device_destroy(_cls, _device)
-
 #endif /* < KERNEL_VERSION(2, 6, 26) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 27)
@@ -174,10 +168,61 @@ static inline char *pack_hex_byte(char *buf, u8 byte)
 #define dereference_function_descriptor(p) (p)
 #endif
 
-#ifndef device_create
-#define device_create(_cls, _parent, _devt, _device, _fmt) \
-	device_create_drvdata(_cls, _parent, _devt, _device, _fmt)
-#endif
+#include <linux/debugfs.h>
+
+static inline void debugfs_remove_recursive(struct dentry *dentry)
+{
+	struct dentry *child;
+	struct dentry *parent;
+
+	if (!dentry)
+		return;
+
+	parent = dentry->d_parent;
+	if (!parent || !parent->d_inode)
+		return;
+
+	parent = dentry;
+
+	while (1) {
+		/*
+		 * When all dentries under "parent" has been removed,
+		 * walk up the tree until we reach our starting point.
+		 */
+		if (list_empty(&parent->d_subdirs)) {
+			if (parent == dentry)
+				break;
+			parent = parent->d_parent;
+		}
+		child = list_entry(parent->d_subdirs.next, struct dentry,
+				d_u.d_child);
+next_sibling:
+
+		/*
+		 * If "child" isn't empty, walk down the tree and
+		 * remove all its descendants first.
+		 */
+		if (!list_empty(&child->d_subdirs)) {
+			parent = child;
+			continue;
+		}
+		debugfs_remove(child);
+		if (parent->d_subdirs.next == &child->d_u.d_child) {
+			/*
+			 * Try the next sibling.
+			 */
+			if (child->d_u.d_child.next != &parent->d_subdirs) {
+				child = list_entry(child->d_u.d_child.next,
+						   struct dentry,
+						   d_u.d_child);
+				goto next_sibling;
+			}
+			break;
+		}
+	}
+
+	debugfs_remove(dentry);
+}
 
 #endif /* < KERNEL_VERSION(2, 6, 27) */
 
diff --git a/device.c b/device.c
deleted file mode 100644
index bbd30f2..0000000
--- a/device.c
+++ /dev/null
@@ -1,355 +0,0 @@
-/*
- * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
- *
- * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- */
-
-#include <linux/device.h>
-#include "main.h"
-#include "device.h"
-#include "send.h"
-#include "types.h"
-#include "hash.h"
-#include "hard-interface.h"
-
-#include "compat.h"
-
-static struct class *batman_class;
-
-static int Major;	/* Major number assigned to our device driver */
-
-static const struct file_operations fops = {
-	.open = bat_device_open,
-	.release = bat_device_release,
-	.read = bat_device_read,
-	.write = bat_device_write,
-	.poll = bat_device_poll,
-};
-
-static struct device_client *device_client_hash[256];
-
-void bat_device_init(void)
-{
-	memset(device_client_hash, 0, sizeof(device_client_hash));
-}
-
-int bat_device_setup(void)
-{
-	int tmp_major;
-
-	if (Major)
-		return 1;
-
-	/* register our device - kernel assigns a free major number */
-	tmp_major = register_chrdev(0, DRIVER_DEVICE, &fops);
-	if (tmp_major < 0) {
-		printk(KERN_ERR "batman-adv:"
-		       "Registering the character device failed with %d\n",
-			  tmp_major);
-		return 0;
-	}
-
-	batman_class = class_create(THIS_MODULE, "batman-adv");
-
-	if (IS_ERR(batman_class)) {
-		printk(KERN_ERR "batman-adv:"
-		       "Could not register class 'batman-adv'\n");
-		return 0;
-	}
-
-	device_create(batman_class, NULL, MKDEV(tmp_major, 0), NULL,
-		      "batman-adv");
-
-	Major = tmp_major;
-	return 1;
-}
-
-void bat_device_destroy(void)
-{
-	if (!Major)
-		return;
-
-	device_destroy(batman_class, MKDEV(Major, 0));
-	class_destroy(batman_class);
-
-	/* Unregister the device */
-	unregister_chrdev(Major, DRIVER_DEVICE);
-
-	Major = 0;
-}
-
-int bat_device_open(struct inode *inode, struct file *file)
-{
-	unsigned int i;
-	struct device_client *device_client;
-
-	device_client = kmalloc(sizeof(struct device_client), GFP_KERNEL);
-
-	if (!device_client)
-		return -ENOMEM;
-
-	for (i = 0; i < ARRAY_SIZE(device_client_hash); i++) {
-		if (!device_client_hash[i]) {
-			device_client_hash[i] = device_client;
-			break;
-		}
-	}
-
-	if (i == ARRAY_SIZE(device_client_hash)) {
-		printk(KERN_ERR "batman-adv:"
-		       "Error - can't add another packet client: "
-		       "maximum number of clients reached\n");
-		kfree(device_client);
-		return -EXFULL;
-	}
-
-	INIT_LIST_HEAD(&device_client->queue_list);
-	device_client->queue_len = 0;
-	device_client->index = i;
-	spin_lock_init(&device_client->lock);
-	init_waitqueue_head(&device_client->queue_wait);
-
-	file->private_data = device_client;
-
-	inc_module_count();
-	return 0;
-}
-
-int bat_device_release(struct inode *inode, struct file *file)
-{
-	struct device_client *device_client =
-		(struct device_client *)file->private_data;
-	struct device_packet *device_packet;
-	struct list_head *list_pos, *list_pos_tmp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&device_client->lock, flags);
-
-	/* for all packets in the queue ... */
-	list_for_each_safe(list_pos, list_pos_tmp, &device_client->queue_list) {
-		device_packet = list_entry(list_pos,
-					   struct device_packet, list);
-
-		list_del(list_pos);
-		kfree(device_packet);
-	}
-
-	device_client_hash[device_client->index] = NULL;
-	spin_unlock_irqrestore(&device_client->lock, flags);
-
-	kfree(device_client);
-	dec_module_count();
-
-	return 0;
-}
-
-ssize_t bat_device_read(struct file *file, char __user *buf, size_t count,
-			loff_t *ppos)
-{
-	struct device_client *device_client =
-		(struct device_client *)file->private_data;
-	struct device_packet *device_packet;
-	int error;
-	unsigned long flags;
-
-	if ((file->f_flags & O_NONBLOCK) && (device_client->queue_len == 0))
-		return -EAGAIN;
-
-	if ((!buf) || (count < sizeof(struct icmp_packet)))
-		return -EINVAL;
-
-	if (!access_ok(VERIFY_WRITE, buf, count))
-		return -EFAULT;
-
-	error = wait_event_interruptible(device_client->queue_wait,
-					 device_client->queue_len);
-
-	if (error)
-		return error;
-
-	spin_lock_irqsave(&device_client->lock, flags);
-
-	device_packet = list_first_entry(&device_client->queue_list,
-					 struct device_packet, list);
-	list_del(&device_packet->list);
-	device_client->queue_len--;
-
-	spin_unlock_irqrestore(&device_client->lock, flags);
-
-	error = __copy_to_user(buf, &device_packet->icmp_packet,
-			       sizeof(struct icmp_packet));
-
-	kfree(device_packet);
-
-	if (error)
-		return error;
-
-	return sizeof(struct icmp_packet);
-}
-
-ssize_t bat_device_write(struct file *file, const char __user *buff,
-			 size_t len, loff_t *off)
-{
-	struct device_client *device_client =
-		(struct device_client *)file->private_data;
-	struct icmp_packet icmp_packet;
-	struct orig_node *orig_node;
-	struct batman_if *batman_if;
-	uint8_t dstaddr[ETH_ALEN];
-	unsigned long flags;
-
-	if (len < sizeof(struct icmp_packet)) {
-		bat_dbg(DBG_BATMAN, "batman-adv:"
-			"Error - can't send packet from char device: "
-			"invalid packet size\n");
-		return -EINVAL;
-	}
-
-	if (!access_ok(VERIFY_READ, buff, sizeof(struct icmp_packet)))
-		return -EFAULT;
-
-	if (__copy_from_user(&icmp_packet, buff, sizeof(icmp_packet)))
-		return -EFAULT;
-
-	if (icmp_packet.packet_type != BAT_ICMP) {
-		bat_dbg(DBG_BATMAN, "batman-adv:"
-			"Error - can't send packet from char device: "
-			"got bogus packet type (expected: BAT_ICMP)\n");
-		return -EINVAL;
-	}
-
-	if (icmp_packet.msg_type != ECHO_REQUEST) {
-		bat_dbg(DBG_BATMAN, "batman-adv:"
-			"Error - can't send packet from char device: "
-			"got bogus message type (expected: ECHO_REQUEST)\n");
-		return -EINVAL;
-	}
-
-	icmp_packet.uid = device_client->index;
-
-	if (icmp_packet.version != COMPAT_VERSION) {
-		icmp_packet.msg_type = PARAMETER_PROBLEM;
-		icmp_packet.ttl = COMPAT_VERSION;
-		bat_device_add_packet(device_client, &icmp_packet);
-		goto out;
-	}
-
-	if (atomic_read(&module_state) != MODULE_ACTIVE)
-		goto dst_unreach;
-
-	spin_lock_irqsave(&orig_hash_lock, flags);
-	orig_node = ((struct orig_node *)hash_find(orig_hash, icmp_packet.dst));
-
-	if (!orig_node)
-		goto unlock;
-
-	if (!orig_node->router)
-		goto unlock;
-
-	batman_if = orig_node->router->if_incoming;
-	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
-
-	if (!batman_if)
-		goto dst_unreach;
-
-	if (batman_if->if_status != IF_ACTIVE)
-		goto dst_unreach;
-
-	memcpy(icmp_packet.orig,
-	       batman_if->net_dev->dev_addr,
-	       ETH_ALEN);
-
-	send_raw_packet((unsigned char *)&icmp_packet,
-			sizeof(struct icmp_packet),
-			batman_if, dstaddr);
-
-	goto out;
-
-unlock:
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
-dst_unreach:
-	icmp_packet.msg_type = DESTINATION_UNREACHABLE;
-	bat_device_add_packet(device_client, &icmp_packet);
-out:
-	return len;
-}
-
-unsigned int bat_device_poll(struct file *file, poll_table *wait)
-{
-	struct device_client *device_client =
-		(struct device_client *)file->private_data;
-
-	poll_wait(file, &device_client->queue_wait, wait);
-
-	if (device_client->queue_len > 0)
-		return POLLIN | POLLRDNORM;
-
-	return 0;
-}
-
-void bat_device_add_packet(struct device_client *device_client,
-			   struct icmp_packet *icmp_packet)
-{
-	struct device_packet *device_packet;
-	unsigned long flags;
-
-	device_packet = kmalloc(sizeof(struct device_packet), GFP_KERNEL);
-
-	if (!device_packet)
-		return;
-
-	INIT_LIST_HEAD(&device_packet->list);
-	memcpy(&device_packet->icmp_packet, icmp_packet,
-	       sizeof(struct icmp_packet));
-
-	spin_lock_irqsave(&device_client->lock, flags);
-
-	/* while waiting for the lock the device_client could have been
-	 * deleted */
-	if (!device_client_hash[icmp_packet->uid]) {
-		spin_unlock_irqrestore(&device_client->lock, flags);
-		kfree(device_packet);
-		return;
-	}
-
-	list_add_tail(&device_packet->list, &device_client->queue_list);
-	device_client->queue_len++;
-
-	if (device_client->queue_len > 100) {
-		device_packet = list_first_entry(&device_client->queue_list,
-						 struct device_packet, list);
-
-		list_del(&device_packet->list);
-		kfree(device_packet);
-		device_client->queue_len--;
-	}
-
-	spin_unlock_irqrestore(&device_client->lock, flags);
-
-	wake_up(&device_client->queue_wait);
-}
-
-void bat_device_receive_packet(struct icmp_packet *icmp_packet)
-{
-	struct device_client *hash = device_client_hash[icmp_packet->uid];
-
-	if (hash)
-		bat_device_add_packet(hash, icmp_packet);
-}
diff --git a/icmp_socket.c b/icmp_socket.c
new file mode 100644
index 0000000..eba8aa2
--- /dev/null
+++ b/icmp_socket.c
@@ -0,0 +1,329 @@
+/*
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner
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
+#include "icmp_socket.h"
+#include "send.h"
+#include "types.h"
+#include "hash.h"
+#include "hard-interface.h"
+
+#include "compat.h"
+
+
+static struct socket_client *socket_client_hash[256];
+
+static void bat_socket_add_packet(struct socket_client *socket_client,
+				  struct icmp_packet *icmp_packet);
+
+void bat_socket_init(void)
+{
+	memset(socket_client_hash, 0, sizeof(socket_client_hash));
+}
+
+static int bat_socket_open(struct inode *inode, struct file *file)
+{
+	unsigned int i;
+	struct socket_client *socket_client;
+
+	socket_client = kmalloc(sizeof(struct socket_client), GFP_KERNEL);
+
+	if (!socket_client)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(socket_client_hash); i++) {
+		if (!socket_client_hash[i]) {
+			socket_client_hash[i] = socket_client;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(socket_client_hash)) {
+		printk(KERN_ERR "batman-adv:"
+		       "Error - can't add another packet client: "
+		       "maximum number of clients reached\n");
+		kfree(socket_client);
+		return -EXFULL;
+	}
+
+	INIT_LIST_HEAD(&socket_client->queue_list);
+	socket_client->queue_len = 0;
+	socket_client->index = i;
+	spin_lock_init(&socket_client->lock);
+	init_waitqueue_head(&socket_client->queue_wait);
+
+	file->private_data = socket_client;
+
+	inc_module_count();
+	return 0;
+}
+
+static int bat_socket_release(struct inode *inode, struct file *file)
+{
+	struct socket_client *socket_client =
+		(struct socket_client *)file->private_data;
+	struct socket_packet *socket_packet;
+	struct list_head *list_pos, *list_pos_tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&socket_client->lock, flags);
+
+	/* for all packets in the queue ... */
+	list_for_each_safe(list_pos, list_pos_tmp, &socket_client->queue_list) {
+		socket_packet = list_entry(list_pos,
+					   struct socket_packet, list);
+
+		list_del(list_pos);
+		kfree(socket_packet);
+	}
+
+	socket_client_hash[socket_client->index] = NULL;
+	spin_unlock_irqrestore(&socket_client->lock, flags);
+
+	kfree(socket_client);
+	dec_module_count();
+
+	return 0;
+}
+
+static ssize_t bat_socket_read(struct file *file, char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	struct socket_client *socket_client =
+		(struct socket_client *)file->private_data;
+	struct socket_packet *socket_packet;
+	int error;
+	unsigned long flags;
+
+	if ((file->f_flags & O_NONBLOCK) && (socket_client->queue_len == 0))
+		return -EAGAIN;
+
+	if ((!buf) || (count < sizeof(struct icmp_packet)))
+		return -EINVAL;
+
+	if (!access_ok(VERIFY_WRITE, buf, count))
+		return -EFAULT;
+
+	error = wait_event_interruptible(socket_client->queue_wait,
+					 socket_client->queue_len);
+
+	if (error)
+		return error;
+
+	spin_lock_irqsave(&socket_client->lock, flags);
+
+	socket_packet = list_first_entry(&socket_client->queue_list,
+					 struct socket_packet, list);
+	list_del(&socket_packet->list);
+	socket_client->queue_len--;
+
+	spin_unlock_irqrestore(&socket_client->lock, flags);
+
+	error = __copy_to_user(buf, &socket_packet->icmp_packet,
+			       sizeof(struct icmp_packet));
+
+	kfree(socket_packet);
+
+	if (error)
+		return error;
+
+	return sizeof(struct icmp_packet);
+}
+
+static ssize_t bat_socket_write(struct file *file, const char __user *buff,
+				size_t len, loff_t *off)
+{
+	struct socket_client *socket_client =
+		(struct socket_client *)file->private_data;
+	struct icmp_packet icmp_packet;
+	struct orig_node *orig_node;
+	struct batman_if *batman_if;
+	uint8_t dstaddr[ETH_ALEN];
+	unsigned long flags;
+
+	if (len < sizeof(struct icmp_packet)) {
+		bat_dbg(DBG_BATMAN, "batman-adv:"
+			"Error - can't send packet from char device: "
+			"invalid packet size\n");
+		return -EINVAL;
+	}
+
+	if (!access_ok(VERIFY_READ, buff, sizeof(struct icmp_packet)))
+		return -EFAULT;
+
+	if (__copy_from_user(&icmp_packet, buff, sizeof(icmp_packet)))
+		return -EFAULT;
+
+	if (icmp_packet.packet_type != BAT_ICMP) {
+		bat_dbg(DBG_BATMAN, "batman-adv:"
+			"Error - can't send packet from char device: "
+			"got bogus packet type (expected: BAT_ICMP)\n");
+		return -EINVAL;
+	}
+
+	if (icmp_packet.msg_type != ECHO_REQUEST) {
+		bat_dbg(DBG_BATMAN, "batman-adv:"
+			"Error - can't send packet from char device: "
+			"got bogus message type (expected: ECHO_REQUEST)\n");
+		return -EINVAL;
+	}
+
+	icmp_packet.uid = socket_client->index;
+
+	if (icmp_packet.version != COMPAT_VERSION) {
+		icmp_packet.msg_type = PARAMETER_PROBLEM;
+		icmp_packet.ttl = COMPAT_VERSION;
+		bat_socket_add_packet(socket_client, &icmp_packet);
+		goto out;
+	}
+
+	if (atomic_read(&module_state) != MODULE_ACTIVE)
+		goto dst_unreach;
+
+	spin_lock_irqsave(&orig_hash_lock, flags);
+	orig_node = ((struct orig_node *)hash_find(orig_hash, icmp_packet.dst));
+
+	if (!orig_node)
+		goto unlock;
+
+	if (!orig_node->router)
+		goto unlock;
+
+	batman_if = orig_node->router->if_incoming;
+	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
+
+	if (!batman_if)
+		goto dst_unreach;
+
+	if (batman_if->if_status != IF_ACTIVE)
+		goto dst_unreach;
+
+	memcpy(icmp_packet.orig,
+	       batman_if->net_dev->dev_addr,
+	       ETH_ALEN);
+
+	send_raw_packet((unsigned char *)&icmp_packet,
+			sizeof(struct icmp_packet),
+			batman_if, dstaddr);
+
+	goto out;
+
+unlock:
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
+dst_unreach:
+	icmp_packet.msg_type = DESTINATION_UNREACHABLE;
+	bat_socket_add_packet(socket_client, &icmp_packet);
+out:
+	return len;
+}
+
+static unsigned int bat_socket_poll(struct file *file, poll_table *wait)
+{
+	struct socket_client *socket_client =
+		(struct socket_client *)file->private_data;
+
+	poll_wait(file, &socket_client->queue_wait, wait);
+
+	if (socket_client->queue_len > 0)
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+static const struct file_operations fops = {
+	.owner = THIS_MODULE,
+	.open = bat_socket_open,
+	.release = bat_socket_release,
+	.read = bat_socket_read,
+	.write = bat_socket_write,
+	.poll = bat_socket_poll,
+};
+
+int bat_socket_setup(struct bat_priv *bat_priv)
+{
+	struct dentry *d;
+
+	if (!bat_priv->debug_dir)
+		goto err;
+
+	d = debugfs_create_file(ICMP_SOCKET, S_IFREG | S_IWUSR | S_IRUSR,
+				bat_priv->debug_dir, NULL, &fops);
+	if (d)
+		goto err;
+
+	return 0;
+
+err:
+	return 1;
+}
+
+static void bat_socket_add_packet(struct socket_client *socket_client,
+				  struct icmp_packet *icmp_packet)
+{
+	struct socket_packet *socket_packet;
+	unsigned long flags;
+
+	socket_packet = kmalloc(sizeof(struct socket_packet), GFP_KERNEL);
+
+	if (!socket_packet)
+		return;
+
+	INIT_LIST_HEAD(&socket_packet->list);
+	memcpy(&socket_packet->icmp_packet, icmp_packet,
+	       sizeof(struct icmp_packet));
+
+	spin_lock_irqsave(&socket_client->lock, flags);
+
+	/* while waiting for the lock the socket_client could have been
+	 * deleted */
+	if (!socket_client_hash[icmp_packet->uid]) {
+		spin_unlock_irqrestore(&socket_client->lock, flags);
+		kfree(socket_packet);
+		return;
+	}
+
+	list_add_tail(&socket_packet->list, &socket_client->queue_list);
+	socket_client->queue_len++;
+
+	if (socket_client->queue_len > 100) {
+		socket_packet = list_first_entry(&socket_client->queue_list,
+						 struct socket_packet, list);
+
+		list_del(&socket_packet->list);
+		kfree(socket_packet);
+		socket_client->queue_len--;
+	}
+
+	spin_unlock_irqrestore(&socket_client->lock, flags);
+
+	wake_up(&socket_client->queue_wait);
+}
+
+void bat_socket_receive_packet(struct icmp_packet *icmp_packet)
+{
+	struct socket_client *hash = socket_client_hash[icmp_packet->uid];
+
+	if (hash)
+		bat_socket_add_packet(hash, icmp_packet);
+}
diff --git a/device.h b/icmp_socket.h
similarity index 54%
rename from device.h
rename to icmp_socket.h
index eb14b37..5ad73da 100644
--- a/device.h
+++ b/icmp_socket.h
@@ -21,16 +21,8 @@
 
 #include "types.h"
 
-void bat_device_init(void);
-int bat_device_setup(void);
-void bat_device_destroy(void);
-int bat_device_open(struct inode *inode, struct file *file);
-int bat_device_release(struct inode *inode, struct file *file);
-ssize_t bat_device_read(struct file *file, char __user *buf, size_t count,
-			loff_t *ppos);
-ssize_t bat_device_write(struct file *file, const char __user *buff,
-			 size_t len, loff_t *off);
-unsigned int bat_device_poll(struct file *file, poll_table *wait);
-void bat_device_add_packet(struct device_client *device_client,
-			   struct icmp_packet *icmp_packet);
-void bat_device_receive_packet(struct icmp_packet *icmp_packet);
+#define ICMP_SOCKET "socket"
+
+void bat_socket_init(void);
+int bat_socket_setup(struct bat_priv *bat_priv);
+void bat_socket_receive_packet(struct icmp_packet *icmp_packet);
diff --git a/main.c b/main.c
index 6c39990..770625f 100644
--- a/main.c
+++ b/main.c
@@ -21,11 +21,12 @@
 
 #include "main.h"
 #include "bat_sysfs.h"
+#include "bat_debugfs.h"
 #include "routing.h"
 #include "send.h"
 #include "originator.h"
 #include "soft-interface.h"
-#include "device.h"
+#include "icmp_socket.h"
 #include "translation-table.h"
 #include "hard-interface.h"
 #include "types.h"
@@ -93,7 +94,8 @@ int init_module(void)
 	if (!bat_event_workqueue)
 		return -ENOMEM;
 
-	bat_device_init();
+	bat_socket_init();
+	debugfs_init();
 
 	/* initialize layer 2 interface */
 	soft_device = alloc_netdev(sizeof(struct bat_priv) , "bat%d",
@@ -118,6 +120,11 @@ int init_module(void)
 	if (retval < 0)
 		goto unreg_soft_device;
 
+	retval = debugfs_add_meshif(soft_device);
+
+	if (retval < 0)
+		goto unreg_sysfs;
+
 	register_netdevice_notifier(&hard_if_notifier);
 	dev_add_pack(&batman_adv_packet_type);
 
@@ -127,6 +134,8 @@ int init_module(void)
 
 	return 0;
 
+unreg_sysfs:
+	sysfs_del_meshif(soft_device);
 unreg_soft_device:
 	unregister_netdevice(soft_device);
 free_soft_device:
@@ -144,6 +153,7 @@ void cleanup_module(void)
 	hardif_remove_interfaces();
 
 	if (soft_device) {
+		debugfs_del_meshif(soft_device);
 		sysfs_del_meshif(soft_device);
 		unregister_netdev(soft_device);
 		soft_device = NULL;
@@ -155,7 +165,7 @@ void cleanup_module(void)
 	bat_event_workqueue = NULL;
 }
 
-/* activates the module, creates bat device, starts timer ... */
+/* activates the module, starts timer ... */
 void activate_module(void)
 {
 	if (originator_init() < 1)
@@ -169,9 +179,6 @@ void activate_module(void)
 
 	hna_local_add(soft_device->dev_addr);
 
-	if (bat_device_setup() < 1)
-		goto end;
-
 	if (vis_init() < 1)
 		goto err;
 
@@ -206,7 +213,7 @@ void deactivate_module(void)
 	hna_global_free();
 
 	synchronize_net();
-	bat_device_destroy();
+	debugfs_destroy();
 
 	synchronize_rcu();
 	atomic_set(&module_state, MODULE_INACTIVE);
diff --git a/routing.c b/routing.c
index 13d2dc5..e9b0377 100644
--- a/routing.c
+++ b/routing.c
@@ -25,7 +25,7 @@
 #include "hash.h"
 #include "soft-interface.h"
 #include "hard-interface.h"
-#include "device.h"
+#include "icmp_socket.h"
 #include "translation-table.h"
 #include "originator.h"
 #include "types.h"
@@ -669,7 +669,7 @@ static int recv_my_icmp_packet(struct sk_buff *skb)
 
 	/* add data to device queue */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
-		bat_device_receive_packet(icmp_packet);
+		bat_socket_receive_packet(icmp_packet);
 		return NET_RX_DROP;
 	}
 
diff --git a/types.h b/types.h
index 86007c7..751cd63 100644
--- a/types.h
+++ b/types.h
@@ -106,9 +106,10 @@ struct bat_priv {
 	char num_ifaces;
 	struct batman_if *primary_if;
 	struct kobject *mesh_obj;
+	struct dentry *debug_dir;
 };
 
-struct device_client {
+struct socket_client {
 	struct list_head queue_list;
 	unsigned int queue_len;
 	unsigned char index;
@@ -116,7 +117,7 @@ struct device_client {
 	wait_queue_head_t queue_wait;
 };
 
-struct device_packet {
+struct socket_packet {
 	struct list_head list;
 	struct icmp_packet icmp_packet;
 };
-- 
1.7.1

