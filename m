Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  6 Jun 2010 21:03:05 +0200
Message-Id: <1275850985-27105-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1275850985-27105-1-git-send-email-sven.eckelmann@gmx.de>
References: <1275850985-27105-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] Staging: batman-adv: fix function
	prototype
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
To: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>

From: Javier Martinez Canillas <martinez.javier@gmail.com>

In today linux-next I got a compile warning in staging/batman-adv.

This is due a struct bin_attribute read function prototype change and the driver was not updated.

This patch solves the issue

Signed-off-by: Javier Martinez Canillas <martinez.javier@gmail.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/bat_sysfs.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index e2c000b..212bc21 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -225,9 +225,9 @@ static struct bat_attribute *mesh_attrs[] = {
 	NULL,
 };
 
-static ssize_t transtable_local_read(struct kobject *kobj,
-			       struct bin_attribute *bin_attr,
-			       char *buff, loff_t off, size_t count)
+static ssize_t transtable_local_read(struct file *filp, struct kobject *kobj,
+				  struct bin_attribute *bin_attr,
+				  char *buff, loff_t off, size_t count)
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
@@ -235,9 +235,9 @@ static ssize_t transtable_local_read(struct kobject *kobj,
 	return hna_local_fill_buffer_text(net_dev, buff, count, off);
 }
 
-static ssize_t transtable_global_read(struct kobject *kobj,
-			       struct bin_attribute *bin_attr,
-			       char *buff, loff_t off, size_t count)
+static ssize_t transtable_global_read(struct file *filp, struct kobject *kobj,
+				  struct bin_attribute *bin_attr,
+				  char *buff, loff_t off, size_t count)
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
@@ -245,9 +245,9 @@ static ssize_t transtable_global_read(struct kobject *kobj,
 	return hna_global_fill_buffer_text(net_dev, buff, count, off);
 }
 
-static ssize_t originators_read(struct kobject *kobj,
-			       struct bin_attribute *bin_attr,
-			       char *buff, loff_t off, size_t count)
+static ssize_t originators_read(struct file *filp, struct kobject *kobj,
+				  struct bin_attribute *bin_attr,
+				  char *buff, loff_t off, size_t count)
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
@@ -255,9 +255,9 @@ static ssize_t originators_read(struct kobject *kobj,
 	return orig_fill_buffer_text(net_dev, buff, count, off);
 }
 
-static ssize_t vis_data_read(struct kobject *kobj,
-			     struct bin_attribute *bin_attr,
-			     char *buff, loff_t off, size_t count)
+static ssize_t vis_data_read(struct file *filp, struct kobject *kobj,
+				  struct bin_attribute *bin_attr,
+				  char *buff, loff_t off, size_t count)
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
-- 
1.7.1

