Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  1 May 2010 15:10:08 +0200
Message-Id: <1272719410-406-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1272719410-406-1-git-send-email-andrew@lunn.ch>
References: <1272719410-406-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Import sparse fixes from
	mainline.
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
To: lindner_marek@yahoo.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

I fixed sparce warnings as i moved patches from maint to mainline.
This patch move the fixes back to maint.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 bat_sysfs.c |    9 ++++++---
 vis.c       |    8 ++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 7acf8d8..e2c000b 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -357,7 +357,8 @@ void sysfs_del_meshif(struct net_device *dev)
 static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 			       char *buff)
 {
-	struct net_device *net_dev = to_net_dev(to_dev(kobj->parent));
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
 
 	if (!batman_if)
@@ -371,7 +372,8 @@ static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 				char *buff, size_t count)
 {
-	struct net_device *net_dev = to_net_dev(to_dev(kobj->parent));
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
 	int status_tmp = -1;
 
@@ -409,7 +411,8 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
 				 char *buff)
 {
-	struct net_device *net_dev = to_net_dev(to_dev(kobj->parent));
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
 
 	if (!batman_if)
diff --git a/vis.c b/vis.c
index 3144439..bac1401 100644
--- a/vis.c
+++ b/vis.c
@@ -103,7 +103,7 @@ static int vis_info_choose(void *data, int size)
 
 /* insert interface to the list of interfaces of one originator, if it
  * does not already exist in the list */
-void vis_data_insert_interface(const uint8_t *interface,
+static void vis_data_insert_interface(const uint8_t *interface,
 				      struct hlist_head *if_list,
 				      bool primary)
 {
@@ -124,7 +124,7 @@ void vis_data_insert_interface(const uint8_t *interface,
 	hlist_add_head(&entry->list, if_list);
 }
 
-ssize_t vis_data_read_prim_sec(char *buff, struct hlist_head *if_list)
+static ssize_t vis_data_read_prim_sec(char *buff, struct hlist_head *if_list)
 {
 	struct if_list_entry *entry;
 	struct hlist_node *pos;
@@ -144,8 +144,8 @@ ssize_t vis_data_read_prim_sec(char *buff, struct hlist_head *if_list)
 }
 
 /* read an entry  */
-ssize_t vis_data_read_entry(char *buff, struct vis_info_entry *entry,
-			    uint8_t *src, bool primary)
+static ssize_t vis_data_read_entry(char *buff, struct vis_info_entry *entry,
+				   uint8_t *src, bool primary)
 {
 	char to[40];
 
-- 
1.7.1

