Return-Path: <andrew.lunn@ascom.ch>
Date: Sat, 18 Jul 2009 16:36:56 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090718143656.GJ4656@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv] cleanup device.[ch]
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Make device.[ch] clean with respect to the 2.6.29 checkpatch
script. Exceptions are long lines with debug_log and the use of
KERNEL_VERSION.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batman-adv-kernelland/device.c
===================================================================
--- batman-adv-kernelland/device.c	(revision 1351)
+++ batman-adv-kernelland/device.c	(working copy)
@@ -17,10 +17,6 @@
  *
  */
 
-
-
-
-
 #include "main.h"
 #include "device.h"
 #include "log.h"
@@ -34,11 +30,9 @@
 static struct class *batman_class;
 #endif
 
+static int Major;	/* Major number assigned to our device driver */
 
-
-static int Major = 0;	/* Major number assigned to our device driver */
-
-static struct file_operations fops = {
+static const struct file_operations fops = {
 	.open = bat_device_open,
 	.release = bat_device_release,
 	.read = bat_device_read,
@@ -48,8 +42,6 @@
 
 static struct device_client *device_client_hash[256];
 
-
-
 void bat_device_init(void)
 {
 	int i;
@@ -66,14 +58,17 @@
 		return;
 
 	/* register our device - kernel assigns a free major number */
-	if ((tmp_major = register_chrdev(0, DRIVER_DEVICE, &fops)) < 0) {
-		debug_log(LOG_TYPE_WARN, "Registering the character device failed with %d\n", tmp_major);
+	tmp_major = register_chrdev(0, DRIVER_DEVICE, &fops);
+	if (tmp_major < 0) {
+		debug_log(LOG_TYPE_WARN, "Registering the character device failed with %d\n",
+			  tmp_major);
 		return;
 	}
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-	if (devfs_mk_cdev(MKDEV(tmp_major, 0), S_IFCHR | S_IRUGO | S_IWUGO, "batman-adv", 0)) {
-		debug_log(LOG_TYPE_WARN, "Could not create /dev/batman-adv\n" );
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
+	if (devfs_mk_cdev(MKDEV(tmp_major, 0), S_IFCHR | S_IRUGO | S_IWUGO,
+			  "batman-adv", 0)) {
+		debug_log(LOG_TYPE_WARN, "Could not create /dev/batman-adv\n");
 		return;
 	}
 #else
@@ -84,7 +79,8 @@
 		return;
 	}
 
-	device_create(batman_class, NULL, MKDEV(tmp_major, 0), NULL, "batman-adv");
+	device_create(batman_class, NULL, MKDEV(tmp_major, 0), NULL,
+		      "batman-adv");
 #endif
 
 	Major = tmp_major;
@@ -97,7 +93,7 @@
 	if (!Major)
 		return;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
 	devfs_remove("batman-adv", 0);
 #else
 	device_destroy(batman_class, MKDEV(Major, 0));
@@ -105,7 +101,7 @@
 #endif
 
 	/* Unregister the device */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,23)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 23)
 	result = unregister_chrdev(Major, DRIVER_DEVICE);
 #else
 	unregister_chrdev(Major, DRIVER_DEVICE);
@@ -154,7 +150,8 @@
 
 int bat_device_release(struct inode *inode, struct file *file)
 {
-	struct device_client *device_client = (struct device_client *)file->private_data;
+	struct device_client *device_client =
+		(struct device_client *)file->private_data;
 	struct device_packet *device_packet;
 	struct list_head *list_pos, *list_pos_tmp;
 
@@ -162,7 +159,8 @@
 
 	/* for all packets in the queue ... */
 	list_for_each_safe(list_pos, list_pos_tmp, &device_client->queue_list) {
-		device_packet = list_entry(list_pos, struct device_packet, list);
+		device_packet = list_entry(list_pos,
+					   struct device_packet, list);
 
 		list_del(list_pos);
 		kfree(device_packet);
@@ -177,9 +175,11 @@
 	return 0;
 }
 
-ssize_t bat_device_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+ssize_t bat_device_read(struct file *file, char __user *buf, size_t count,
+			loff_t *ppos)
 {
-	struct device_client *device_client = (struct device_client *)file->private_data;
+	struct device_client *device_client =
+		(struct device_client *)file->private_data;
 	struct device_packet *device_packet;
 	int error;
 
@@ -192,20 +192,23 @@
 	if (!access_ok(VERIFY_WRITE, buf, count))
 		return -EFAULT;
 
-	error = wait_event_interruptible(device_client->queue_wait, (device_client->queue_len));
+	error = wait_event_interruptible(device_client->queue_wait,
+					 device_client->queue_len);
 
 	if (error)
 		return error;
 
 	spin_lock(&device_client->lock);
 
-	device_packet = list_first_entry(&device_client->queue_list, struct device_packet, list);
+	device_packet = list_first_entry(&device_client->queue_list,
+					 struct device_packet, list);
 	list_del(&device_packet->list);
 	device_client->queue_len--;
 
 	spin_unlock(&device_client->lock);
 
-	error = __copy_to_user(buf, &device_packet->icmp_packet, sizeof(struct icmp_packet));
+	error = __copy_to_user(buf, &device_packet->icmp_packet,
+			       sizeof(struct icmp_packet));
 
 	kfree(device_packet);
 
@@ -215,9 +218,11 @@
 	return sizeof(struct icmp_packet);
 }
 
-ssize_t bat_device_write(struct file *file, const char __user *buff, size_t len, loff_t *off)
+ssize_t bat_device_write(struct file *file, const char __user *buff,
+			 size_t len, loff_t *off)
 {
-	struct device_client *device_client = (struct device_client *)file->private_data;
+	struct device_client *device_client =
+		(struct device_client *)file->private_data;
 	struct icmp_packet icmp_packet;
 	struct orig_node *orig_node;
 
@@ -229,9 +234,8 @@
 	if (!access_ok(VERIFY_READ, buff, sizeof(struct icmp_packet)))
 		return -EFAULT;
 
-	if (__copy_from_user(&icmp_packet, buff, sizeof(icmp_packet))) {
+	if (__copy_from_user(&icmp_packet, buff, sizeof(icmp_packet)))
 		return -EFAULT;
-	}
 
 	if (icmp_packet.packet_type != BAT_ICMP) {
 		debug_log(LOG_TYPE_NOTICE, "Error - can't send packet from char device: got bogus packet type (expected: BAT_ICMP)\n");
@@ -255,17 +259,19 @@
 	spin_lock(&orig_hash_lock);
 	orig_node = ((struct orig_node *)hash_find(orig_hash, icmp_packet.dst));
 
-	if ((orig_node != NULL) && (orig_node->batman_if != NULL) && (orig_node->router != NULL)) {
+	if ((orig_node != NULL) &&
+	    (orig_node->batman_if != NULL) &&
+	    (orig_node->router != NULL)) {
+		memcpy(icmp_packet.orig,
+		       orig_node->batman_if->net_dev->dev_addr, ETH_ALEN);
 
-		memcpy(icmp_packet.orig, orig_node->batman_if->net_dev->dev_addr, ETH_ALEN);
-
-		send_raw_packet((unsigned char *)&icmp_packet, sizeof(struct icmp_packet), orig_node->batman_if->net_dev->dev_addr, orig_node->router->addr, orig_node->batman_if);
-
+		send_raw_packet((unsigned char *)&icmp_packet,
+				sizeof(struct icmp_packet),
+				orig_node->batman_if->net_dev->dev_addr,
+				orig_node->router->addr, orig_node->batman_if);
 	} else {
-
 		icmp_packet.msg_type = DESTINATION_UNREACHABLE;
 		bat_device_add_packet(device_client, &icmp_packet);
-
 	}
 
 	spin_unlock(&orig_hash_lock);
@@ -276,7 +282,8 @@
 
 unsigned int bat_device_poll(struct file *file, poll_table *wait)
 {
-	struct device_client *device_client = (struct device_client *)file->private_data;
+	struct device_client *device_client =
+		(struct device_client *)file->private_data;
 
 	poll_wait(file, &device_client->queue_wait, wait);
 
@@ -286,7 +293,8 @@
 	return 0;
 }
 
-void bat_device_add_packet(struct device_client *device_client, struct icmp_packet *icmp_packet)
+void bat_device_add_packet(struct device_client *device_client,
+			   struct icmp_packet *icmp_packet)
 {
 	struct device_packet *device_packet;
 
@@ -296,11 +304,13 @@
 		return;
 
 	INIT_LIST_HEAD(&device_packet->list);
-	memcpy(&device_packet->icmp_packet, icmp_packet, sizeof(struct icmp_packet));
+	memcpy(&device_packet->icmp_packet, icmp_packet,
+	       sizeof(struct icmp_packet));
 
 	spin_lock(&device_client->lock);
 
-	/* while waiting for the lock the device_client could have been deleted */
+	/* while waiting for the lock the device_client could have been
+	 * deleted */
 	if (device_client_hash[icmp_packet->uid] == NULL) {
 		kfree(device_packet);
 		return;
@@ -310,7 +320,8 @@
 	device_client->queue_len++;
 
 	if (device_client->queue_len > 100) {
-		device_packet = list_first_entry(&device_client->queue_list, struct device_packet, list);
+		device_packet = list_first_entry(&device_client->queue_list,
+						 struct device_packet, list);
 
 		list_del(&device_packet->list);
 		kfree(device_packet);
@@ -324,7 +335,8 @@
 
 void bat_device_receive_packet(struct icmp_packet *icmp_packet)
 {
-	if (device_client_hash[icmp_packet->uid] != NULL)
-		bat_device_add_packet((struct device_client *)device_client_hash[icmp_packet->uid], icmp_packet);
+	struct device_client *hash = device_client_hash[icmp_packet->uid];
+
+	if (hash != NULL)
+		bat_device_add_packet(hash, icmp_packet);
 }
-
Index: batman-adv-kernelland/device.h
===================================================================
--- batman-adv-kernelland/device.h	(revision 1351)
+++ batman-adv-kernelland/device.h	(working copy)
@@ -17,22 +17,18 @@
  *
  */
 
-
-
-
-
 #include "types.h"
 
-
-
 void bat_device_init(void);
 void bat_device_setup(void);
 void bat_device_destroy(void);
 int bat_device_open(struct inode *inode, struct file *file);
 int bat_device_release(struct inode *inode, struct file *file);
-ssize_t bat_device_read(struct file *file, char __user *buf, size_t count, loff_t *ppos);
-ssize_t bat_device_write(struct file *file, const char __user *buff, size_t len, loff_t *off);
+ssize_t bat_device_read(struct file *file, char __user *buf, size_t count,
+			loff_t *ppos);
+ssize_t bat_device_write(struct file *file, const char __user *buff,
+			 size_t len, loff_t *off);
 unsigned int bat_device_poll(struct file *file, poll_table *wait);
-void bat_device_add_packet(struct device_client *device_client, struct icmp_packet *icmp_packet);
+void bat_device_add_packet(struct device_client *device_client,
+			   struct icmp_packet *icmp_packet);
 void bat_device_receive_packet(struct icmp_packet *icmp_packet);
-
