Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  4 Nov 2010 18:21:01 +0100
Message-Id: <1288891265-16035-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201011041820.44518.lindner_marek@yahoo.de>
References: <201011041820.44518.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/8] batman-adv: move gateway bandwidth into
	its own sysfs file
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

The Linux kernel guidelines require each sysfs file to have a single
value / purpose, therefore it is necessary to split up the sysfs
gateway files.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/bat_sysfs.c      |   37 ++++++++++++--
 batman-adv/gateway_client.c |    6 +-
 batman-adv/gateway_common.c |  115 ++++++++++++++++++++++++++++++++++++++++---
 batman-adv/gateway_common.h |    3 +-
 batman-adv/send.c           |    2 +-
 batman-adv/soft-interface.c |    2 +-
 batman-adv/types.h          |    2 +-
 7 files changed, 149 insertions(+), 18 deletions(-)

diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index 0f39213..f937f6f 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -262,8 +262,7 @@ static ssize_t show_gw_mode(struct kobject *kobj, struct attribute *attr,
 {
 	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);
 	int down, up, bytes_written;
-	int gw_mode = atomic_read(&bat_priv->gw_mode);
-	int gw_class = atomic_read(&bat_priv->gw_class);
+	int gw_class, gw_mode = atomic_read(&bat_priv->gw_mode);
 
 	switch (gw_mode) {
 	case GW_MODE_CLIENT:
@@ -272,7 +271,8 @@ static ssize_t show_gw_mode(struct kobject *kobj, struct attribute *attr,
 					GW_MODE_CLIENT_NAME, gw_class);
 		break;
 	case GW_MODE_SERVER:
-		gw_srv_class_to_kbit(gw_class, &down, &up);
+		gw_class = atomic_read(&bat_priv->gw_bandwidth);
+		gw_bandwidth_to_kbit(gw_class, &down, &up);
 		bytes_written = sprintf(buff,
 					"%s (gw_class: %i "
 					"-> propagating: %i%s/%i%s)\n",
@@ -292,12 +292,38 @@ static ssize_t show_gw_mode(struct kobject *kobj, struct attribute *attr,
 }
 
 static ssize_t store_gw_mode(struct kobject *kobj, struct attribute *attr,
-			      char *buff, size_t count)
+			     char *buff, size_t count)
 {
 	struct net_device *net_dev = kobj_to_netdev(kobj);
 	return gw_mode_set(net_dev, buff, count);
 }
 
+static ssize_t show_gw_bwidth(struct kobject *kobj, struct attribute *attr,
+			      char *buff)
+{
+	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);
+	int down, up;
+	int gw_bandwidth = atomic_read(&bat_priv->gw_bandwidth);
+
+	gw_bandwidth_to_kbit(gw_bandwidth, &down, &up);
+	return sprintf(buff, "%i%s/%i%s\n",
+		       (down > 2048 ? down / 1024 : down),
+		       (down > 2048 ? "MBit" : "KBit"),
+		       (up > 2048 ? up / 1024 : up),
+		       (up > 2048 ? "MBit" : "KBit"));
+}
+
+static ssize_t store_gw_bwidth(struct kobject *kobj, struct attribute *attr,
+			       char *buff, size_t count)
+{
+	struct net_device *net_dev = kobj_to_netdev(kobj);
+
+	if (buff[count - 1] == '\n')
+		buff[count - 1] = '\0';
+
+	return gw_bandwidth_set(net_dev, buff, count);
+}
+
 BAT_ATTR_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
@@ -307,6 +333,8 @@ BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
 BAT_ATTR_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, TQ_MAX_VALUE, NULL);
 BAT_ATTR_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, TQ_MAX_VALUE,
 	      post_gw_deselect);
+static BAT_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, show_gw_bwidth,
+		store_gw_bwidth);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 3, NULL);
 #endif
@@ -320,6 +348,7 @@ static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_orig_interval,
 	&bat_attr_hop_penalty,
 	&bat_attr_gw_sel_class,
+	&bat_attr_gw_bandwidth,
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	&bat_attr_log_level,
 #endif
diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 56c52b0..fde1d8a 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -118,7 +118,7 @@ void gw_election(struct bat_priv *bat_priv)
 
 		switch (atomic_read(&bat_priv->gw_sel_class)) {
 		case 1: /* fast connection */
-			gw_srv_class_to_kbit(gw_node->orig_node->gw_flags,
+			gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags,
 					     &down, &up);
 
 			tmp_gw_factor = (gw_node->orig_node->router->tq_avg *
@@ -247,7 +247,7 @@ static void gw_node_add(struct bat_priv *bat_priv,
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw_list);
 	spin_unlock_bh(&bat_priv->gw_list_lock);
 
-	gw_srv_class_to_kbit(new_gwflags, &down, &up);
+	gw_bandwidth_to_kbit(new_gwflags, &down, &up);
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Found new gateway %pM -> gw_class: %i - %i%s/%i%s\n",
 		orig_node->orig, new_gwflags,
@@ -336,7 +336,7 @@ static int _write_buffer_text(struct bat_priv *bat_priv,
 {
 	int down, up;
 
-	gw_srv_class_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
+	gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
 
 	return seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %3i - %i%s/%i%s\n",
 		       (bat_priv->curr_gw == gw_node ? "=>" : "  "),
diff --git a/batman-adv/gateway_common.c b/batman-adv/gateway_common.c
index 330167e..9d03e3c 100644
--- a/batman-adv/gateway_common.c
+++ b/batman-adv/gateway_common.c
@@ -24,7 +24,7 @@
 #include "gateway_client.h"
 
 /* calculates the gateway class from kbit */
-static void kbit_to_gw_srv_class(int down, int up, long *gw_srv_class)
+static void kbit_to_gw_bandwidth(int down, int up, long *gw_srv_class)
 {
 	int mdown = 0, tdown, tup, difference;
 	uint8_t sbit, part;
@@ -59,7 +59,7 @@ static void kbit_to_gw_srv_class(int down, int up, long *gw_srv_class)
 }
 
 /* returns the up and downspeeds in kbit, calculated from the class */
-void gw_srv_class_to_kbit(uint8_t gw_srv_class, int *down, int *up)
+void gw_bandwidth_to_kbit(uint8_t gw_srv_class, int *down, int *up)
 {
 	char sbit = (gw_srv_class & 0x80) >> 7;
 	char dpart = (gw_srv_class & 0x78) >> 3;
@@ -113,8 +113,7 @@ static bool parse_gw_mode_tok(struct net_device *net_dev,
 			if (strnicmp(tmp_ptr, "mbit", 4) == 0)
 				multi = 1024;
 
-			if ((strnicmp(tmp_ptr, "kbit", 4) == 0) ||
-			    (multi > 1))
+			if ((strnicmp(tmp_ptr, "kbit", 4) == 0) || (multi > 1))
 				*tmp_ptr = '\0';
 		}
 
@@ -253,14 +252,14 @@ next:
 		if (!up)
 			up = down / 5;
 
-		kbit_to_gw_srv_class(down, up, &gw_class_tmp);
+		kbit_to_gw_bandwidth(down, up, &gw_class_tmp);
 
 		/**
 		 * the gw class we guessed above might not match the given
 		 * speeds, hence we need to calculate it back to show the
 		 * number that is going to be propagated
 		 **/
-		gw_srv_class_to_kbit((uint8_t)gw_class_tmp,
+		gw_bandwidth_to_kbit((uint8_t)gw_class_tmp,
 				     (int *)&down, (int *)&up);
 
 		gw_deselect(bat_priv);
@@ -271,6 +270,8 @@ next:
 			 (down > 2048 ? "MBit" : "KBit"),
 			 (up > 2048 ? up / 1024 : up),
 			 (up > 2048 ? "MBit" : "KBit"));
+
+		atomic_set(&bat_priv->gw_bandwidth, gw_class_tmp);
 		break;
 	default:
 		bat_info(net_dev, "Changing gateway mode from: '%s' to: '%s'\n",
@@ -279,7 +280,6 @@ next:
 	}
 
 	atomic_set(&bat_priv->gw_mode, gw_mode_tmp);
-	atomic_set(&bat_priv->gw_class, gw_class_tmp);
 
 	if (gw_class_tmp == 0)
 		gw_deselect(bat_priv);
@@ -287,3 +287,104 @@ next:
 end:
 	return count;
 }
+
+static bool parse_gw_bandwidth(struct net_device *net_dev, char *buff,
+			       long *up, long *down)
+{
+	int ret, multi = 1;
+	char *slash_ptr, *tmp_ptr;
+
+	slash_ptr = strchr(buff, '/');
+	if (slash_ptr)
+		*slash_ptr = 0;
+
+	if (strlen(buff) > 4) {
+		tmp_ptr = buff + strlen(buff) - 4;
+
+		if (strnicmp(tmp_ptr, "mbit", 4) == 0)
+			multi = 1024;
+
+		if ((strnicmp(tmp_ptr, "kbit", 4) == 0) ||
+			(multi > 1))
+			*tmp_ptr = '\0';
+	}
+
+	ret = strict_strtoul(buff, 10, down);
+	if (ret) {
+		bat_err(net_dev,
+			"Download speed of gateway mode invalid: %s\n",
+			buff);
+		return false;
+	}
+
+	*down *= multi;
+
+	/* we also got some upload info */
+	if (slash_ptr) {
+		multi = 1;
+
+		if (strlen(slash_ptr + 1) > 4) {
+			tmp_ptr = slash_ptr + 1 - 4 + strlen(slash_ptr + 1);
+
+			if (strnicmp(tmp_ptr, "mbit", 4) == 0)
+				multi = 1024;
+
+			if ((strnicmp(tmp_ptr, "kbit", 4) == 0) ||
+				(multi > 1))
+				*tmp_ptr = '\0';
+		}
+
+		ret = strict_strtoul(slash_ptr + 1, 10, up);
+		if (ret) {
+			bat_err(net_dev,
+				"Upload speed of gateway mode invalid: "
+				"%s\n", slash_ptr + 1);
+			return false;
+		}
+
+		*up *= multi;
+	}
+
+	return true;
+}
+
+ssize_t gw_bandwidth_set(struct net_device *net_dev, char *buff, size_t count)
+{
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	long gw_bandwidth_tmp = 0, up = 0, down = 0;
+	bool ret;
+
+	ret = parse_gw_bandwidth(net_dev, buff, &up, &down);
+	if (!ret)
+		goto end;
+
+	if ((!down) || (down < 256))
+		down = 2000;
+
+	if (!up)
+		up = down / 5;
+
+	kbit_to_gw_bandwidth(down, up, &gw_bandwidth_tmp);
+
+	/**
+	 * the gw bandwidth we guessed above might not match the given
+	 * speeds, hence we need to calculate it back to show the number
+	 * that is going to be propagated
+	 **/
+	gw_bandwidth_to_kbit((uint8_t)gw_bandwidth_tmp,
+			     (int *)&down, (int *)&up);
+
+	gw_deselect(bat_priv);
+	bat_info(net_dev, "Changing gateway bandwidth from: '%i' to: '%ld' "
+		 "(propagating: %ld%s/%ld%s)\n",
+		 atomic_read(&bat_priv->gw_bandwidth), gw_bandwidth_tmp,
+		 (down > 2048 ? down / 1024 : down),
+		 (down > 2048 ? "MBit" : "KBit"),
+		 (up > 2048 ? up / 1024 : up),
+		 (up > 2048 ? "MBit" : "KBit"));
+
+	atomic_set(&bat_priv->gw_bandwidth, gw_bandwidth_tmp);
+
+end:
+	return count;
+}
diff --git a/batman-adv/gateway_common.h b/batman-adv/gateway_common.h
index 8074c70..181a306 100644
--- a/batman-adv/gateway_common.h
+++ b/batman-adv/gateway_common.h
@@ -32,7 +32,8 @@ enum gw_modes {
 #define GW_MODE_CLIENT_NAME	"client"
 #define GW_MODE_SERVER_NAME	"server"
 
-void gw_srv_class_to_kbit(uint8_t gw_class, int *down, int *up);
+void gw_bandwidth_to_kbit(uint8_t gw_class, int *down, int *up);
 ssize_t gw_mode_set(struct net_device *net_dev, char *buff, size_t count);
+ssize_t gw_bandwidth_set(struct net_device *net_dev, char *buff, size_t count);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_COMMON_H_ */
diff --git a/batman-adv/send.c b/batman-adv/send.c
index 454049c..b89b9f7 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -287,7 +287,7 @@ void schedule_own_packet(struct batman_if *batman_if)
 	if ((batman_if == bat_priv->primary_if) &&
 	    (atomic_read(&bat_priv->gw_mode) == GW_MODE_SERVER))
 		batman_packet->gw_flags =
-				(uint8_t)atomic_read(&bat_priv->gw_class);
+				(uint8_t)atomic_read(&bat_priv->gw_bandwidth);
 	else
 		batman_packet->gw_flags = 0;
 
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 7b2673c..9561433 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -592,7 +592,7 @@ struct net_device *softif_create(char *name)
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_sel_class, 0);
-	atomic_set(&bat_priv->gw_class, 0);
+	atomic_set(&bat_priv->gw_bandwidth, 0);
 	atomic_set(&bat_priv->orig_interval, 1000);
 	atomic_set(&bat_priv->hop_penalty, 10);
 	atomic_set(&bat_priv->log_level, 0);
diff --git a/batman-adv/types.h b/batman-adv/types.h
index b68add4..1d00849 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -129,7 +129,7 @@ struct bat_priv {
 	atomic_t vis_mode;		/* VIS_TYPE_* */
 	atomic_t gw_mode;		/* GW_MODE_* */
 	atomic_t gw_sel_class;		/* uint */
-	atomic_t gw_class;		/* uint */
+	atomic_t gw_bandwidth;		/* gw bandwidth */
 	atomic_t orig_interval;		/* uint */
 	atomic_t hop_penalty;		/* uint */
 	atomic_t log_level;		/* uint */
-- 
1.7.1

