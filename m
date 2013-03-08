Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri,  8 Mar 2013 18:38:56 +0100
Message-Id: <1362764336-1591-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1362764336-1591-1-git-send-email-linus.luessing@web.de>
References: <1362764336-1591-1-git-send-email-linus.luessing@web.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: make number of broadcasts
	configurable per hardif
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

From: Matthias Schiffer <mschiffer@universe-factory.net>

In heterogenous networks, setting the number of broadcasts to differing values
on different interfaces can be beneficial.

E.g., on wireless interfaces with high packet loss a higher number of broadcasts
may be necessary, whereas on low-bandwidth interfaces with relatively high
reliablily (such as VPN links over slow internet lines) sending only a single
packet makes more sense to preserve bandwidth.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 hard-interface.c           |    1 +
 send.c                     |   14 +++++++++--
 sysfs-class-net-batman-adv |   10 ++++++++
 sysfs.c                    |   56 ++++++++++++++++++++++++++++++++++++++++++++
 types.h                    |    1 +
 5 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index fd99e42..6cd53d0 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -511,6 +511,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	hard_iface->net_dev = net_dev;
 	hard_iface->soft_iface = NULL;
 	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
+	atomic_set(&hard_iface->num_bcasts, 0);
 	INIT_LIST_HEAD(&hard_iface->list);
 	INIT_WORK(&hard_iface->cleanup_work,
 		  batadv_hardif_remove_interface_finish);
diff --git a/send.c b/send.c
index 4a73c37..9a66076 100644
--- a/send.c
+++ b/send.c
@@ -237,7 +237,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	struct sk_buff *skb1;
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
-	int num_bcasts;
+	int num_bcasts, if_num_bcasts, max_num_bcasts = 0;
 
 	delayed_work = container_of(work, struct delayed_work, work);
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
@@ -262,6 +262,16 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 		if (hard_iface->soft_iface != soft_iface)
 			continue;
 
+		if_num_bcasts = atomic_read(&hard_iface->num_bcasts);
+		if (if_num_bcasts == 0)
+			if_num_bcasts = num_bcasts;
+
+		if (forw_packet->num_packets >= if_num_bcasts)
+			continue;
+
+		if (if_num_bcasts > max_num_bcasts)
+			max_num_bcasts = if_num_bcasts;
+
 		/* send a copy of the saved skb */
 		skb1 = skb_clone(forw_packet->skb, GFP_ATOMIC);
 		if (skb1)
@@ -273,7 +283,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	forw_packet->num_packets++;
 
 	/* if we still have some more bcasts to send */
-	if (forw_packet->num_packets < num_bcasts) {
+	if (forw_packet->num_packets < max_num_bcasts) {
 		_batadv_add_bcast_packet_to_list(bat_priv, forw_packet,
 						 msecs_to_jiffies(5));
 		return;
diff --git a/sysfs-class-net-batman-adv b/sysfs-class-net-batman-adv
index bdc0070..eb07a4d 100644
--- a/sysfs-class-net-batman-adv
+++ b/sysfs-class-net-batman-adv
@@ -1,4 +1,14 @@
 
+What:           /sys/class/net/<iface>/batman-adv/iface_num_bcasts
+Date:           Mar 2013
+Contact:        Matthias Schiffer <mschiffer@universe-factory.net>
+Description:
+		Defines the number of broadcasts used to forward
+		a multicast (including broadcast) payload frame on a
+		single interface. When the value is 'default', the
+		num_bcasts value from the associated batman mesh
+		interface is used.
+
 What:           /sys/class/net/<iface>/batman-adv/iface_status
 Date:           May 2010
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
diff --git a/sysfs.c b/sysfs.c
index d166b87..152f96b 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -644,13 +644,69 @@ static ssize_t batadv_show_iface_status(struct kobject *kobj,
 	return length;
 }
 
+static ssize_t batadv_show_iface_num_bcasts(struct kobject *kobj,
+				      struct attribute *attr, char *buff)
+{
+	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
+	struct batadv_hard_iface *hard_iface;
+	ssize_t length;
+	int num_bcasts;
+
+	hard_iface = batadv_hardif_get_by_netdev(net_dev);
+	if (!hard_iface)
+		return 0;
+
+	num_bcasts = atomic_read(&hard_iface->num_bcasts);
+	if (num_bcasts)
+		length = sprintf(buff, "%i\n", num_bcasts);
+	else
+		length = sprintf(buff, "default\n");
+
+	batadv_hardif_free_ref(hard_iface);
+
+	return length;
+}
+
+static ssize_t batadv_store_iface_num_bcasts(struct kobject *kobj,
+				       struct attribute *attr, char *buff,
+				       size_t count)
+{
+	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
+	struct batadv_hard_iface *hard_iface;
+	int ret;
+
+	hard_iface = batadv_hardif_get_by_netdev(net_dev);
+	if (!hard_iface)
+		return count;
+
+	if (buff[count - 1] == '\n')
+		buff[count - 1] = '\0';
+
+	if (strncmp(buff, "default", 8) == 0) {
+		atomic_set(&hard_iface->num_bcasts, 0);
+		ret = count;
+	} else {
+		ret = batadv_store_uint_attr(buff, count, net_dev, "num_bcasts",
+					     0, INT_MAX,
+					     &hard_iface->num_bcasts);
+	}
+
+	batadv_hardif_free_ref(hard_iface);
+
+	return ret;
+}
+
+
 static BATADV_ATTR(mesh_iface, S_IRUGO | S_IWUSR, batadv_show_mesh_iface,
 		   batadv_store_mesh_iface);
 static BATADV_ATTR(iface_status, S_IRUGO, batadv_show_iface_status, NULL);
+static BATADV_ATTR(iface_num_bcasts, S_IRUGO | S_IWUSR,
+		   batadv_show_iface_num_bcasts, batadv_store_iface_num_bcasts);
 
 static struct batadv_attribute *batadv_batman_attrs[] = {
 	&batadv_attr_mesh_iface,
 	&batadv_attr_iface_status,
+	&batadv_attr_iface_num_bcasts,
 	NULL,
 };
 
diff --git a/types.h b/types.h
index 41bfa0b..acfcb90 100644
--- a/types.h
+++ b/types.h
@@ -76,6 +76,7 @@ struct batadv_hard_iface {
 	char if_status;
 	struct net_device *net_dev;
 	atomic_t frag_seqno;
+	atomic_t num_bcasts;
 	struct kobject *hardif_obj;
 	atomic_t refcount;
 	struct packet_type batman_adv_ptype;
-- 
1.7.10.4

