Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  4 Nov 2010 18:21:02 +0100
Message-Id: <1288891265-16035-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201011041820.44518.lindner_marek@yahoo.de>
References: <201011041820.44518.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/8] batman-adv: cleanup gw mode sysfs file
	to only accept one value
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
 batman-adv/bat_sysfs.c      |   70 ++++++++++----
 batman-adv/gateway_common.c |  213 -------------------------------------------
 batman-adv/gateway_common.h |    1 -
 batman-adv/soft-interface.c |    4 +-
 4 files changed, 53 insertions(+), 235 deletions(-)

diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index f937f6f..cd7bb51 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -261,30 +261,17 @@ static ssize_t show_gw_mode(struct kobject *kobj, struct attribute *attr,
 			    char *buff)
 {
 	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);
-	int down, up, bytes_written;
-	int gw_class, gw_mode = atomic_read(&bat_priv->gw_mode);
+	int bytes_written;
 
-	switch (gw_mode) {
+	switch (atomic_read(&bat_priv->gw_mode)) {
 	case GW_MODE_CLIENT:
-		gw_class = atomic_read(&bat_priv->gw_sel_class);
-		bytes_written = sprintf(buff, "%s (gw_class: %i)\n",
-					GW_MODE_CLIENT_NAME, gw_class);
+		bytes_written = sprintf(buff, "%s\n", GW_MODE_CLIENT_NAME);
 		break;
 	case GW_MODE_SERVER:
-		gw_class = atomic_read(&bat_priv->gw_bandwidth);
-		gw_bandwidth_to_kbit(gw_class, &down, &up);
-		bytes_written = sprintf(buff,
-					"%s (gw_class: %i "
-					"-> propagating: %i%s/%i%s)\n",
-					GW_MODE_SERVER_NAME, gw_class,
-					(down > 2048 ? down / 1024 : down),
-					(down > 2048 ? "MBit" : "KBit"),
-					(up > 2048 ? up / 1024 : up),
-					(up > 2048 ? "MBit" : "KBit"));
+		bytes_written = sprintf(buff, "%s\n", GW_MODE_SERVER_NAME);
 		break;
 	default:
-		bytes_written = sprintf(buff, "%s\n",
-					GW_MODE_OFF_NAME);
+		bytes_written = sprintf(buff, "%s\n", GW_MODE_OFF_NAME);
 		break;
 	}
 
@@ -295,7 +282,52 @@ static ssize_t store_gw_mode(struct kobject *kobj, struct attribute *attr,
 			     char *buff, size_t count)
 {
 	struct net_device *net_dev = kobj_to_netdev(kobj);
-	return gw_mode_set(net_dev, buff, count);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	char *curr_gw_mode_str;
+	int gw_mode_tmp = -1;
+
+	if (buff[count - 1] == '\n')
+		buff[count - 1] = '\0';
+
+	if (strncmp(buff, GW_MODE_OFF_NAME, strlen(GW_MODE_OFF_NAME)) == 0)
+		gw_mode_tmp = GW_MODE_OFF;
+
+	if (strncmp(buff, GW_MODE_CLIENT_NAME,
+		   strlen(GW_MODE_CLIENT_NAME)) == 0)
+		gw_mode_tmp = GW_MODE_CLIENT;
+
+	if (strncmp(buff, GW_MODE_SERVER_NAME,
+		   strlen(GW_MODE_SERVER_NAME)) == 0)
+		gw_mode_tmp = GW_MODE_SERVER;
+
+	if (gw_mode_tmp < 0) {
+		bat_info(net_dev,
+			 "Invalid parameter for 'gw mode' setting received: "
+			 "%s\n", buff);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&bat_priv->gw_mode) == gw_mode_tmp)
+		return count;
+
+	switch (atomic_read(&bat_priv->gw_mode)) {
+	case GW_MODE_CLIENT:
+		curr_gw_mode_str = GW_MODE_CLIENT_NAME;
+		break;
+	case GW_MODE_SERVER:
+		curr_gw_mode_str = GW_MODE_SERVER_NAME;
+		break;
+	default:
+		curr_gw_mode_str = GW_MODE_OFF_NAME;
+		break;
+	}
+
+	bat_info(net_dev, "Changing gw mode from: %s to: %s\n",
+		 curr_gw_mode_str, buff);
+
+	gw_deselect(bat_priv);
+	atomic_set(&bat_priv->gw_mode, (unsigned)gw_mode_tmp);
+	return count;
 }
 
 static ssize_t show_gw_bwidth(struct kobject *kobj, struct attribute *attr,
diff --git a/batman-adv/gateway_common.c b/batman-adv/gateway_common.c
index 9d03e3c..b962982 100644
--- a/batman-adv/gateway_common.c
+++ b/batman-adv/gateway_common.c
@@ -75,219 +75,6 @@ void gw_bandwidth_to_kbit(uint8_t gw_srv_class, int *down, int *up)
 	*up = ((upart + 1) * (*down)) / 8;
 }
 
-static bool parse_gw_mode_tok(struct net_device *net_dev,
-			      char *tokptr, long *gw_mode_tmp,
-			      char **gw_mode_tmp_str, long *gw_class_tmp,
-			      long *up, long *down)
-{
-	int ret, multi;
-	char *slash_ptr, *tmp_ptr;
-
-	switch (*gw_mode_tmp) {
-	case GW_MODE_CLIENT:
-		ret = strict_strtoul(tokptr, 10, gw_class_tmp);
-		if (ret) {
-			bat_err(net_dev, "Client class of gateway mode invalid:"
-				" %s\n", tokptr);
-			return false;
-		}
-
-		if (*gw_class_tmp > TQ_MAX_VALUE) {
-			bat_err(net_dev,
-				"Client class of gateway mode greater than %i: "
-				"%ld\n", TQ_MAX_VALUE, *gw_class_tmp);
-			return false;
-		}
-
-		break;
-	case GW_MODE_SERVER:
-		slash_ptr = strchr(tokptr, '/');
-		if (slash_ptr)
-			*slash_ptr = 0;
-
-		multi = 1;
-
-		if (strlen(tokptr) > 4) {
-			tmp_ptr = tokptr + strlen(tokptr) - 4;
-
-			if (strnicmp(tmp_ptr, "mbit", 4) == 0)
-				multi = 1024;
-
-			if ((strnicmp(tmp_ptr, "kbit", 4) == 0) || (multi > 1))
-				*tmp_ptr = '\0';
-		}
-
-		ret = strict_strtoul(tokptr, 10, down);
-		if (ret) {
-			bat_err(net_dev,
-				"Download speed of gateway mode invalid: %s\n",
-				tokptr);
-			return false;
-		}
-
-		*down *= multi;
-
-		/* we also got some upload info */
-		if (slash_ptr) {
-			multi = 1;
-
-			if (strlen(slash_ptr + 1) > 4) {
-				tmp_ptr = slash_ptr + 1 - 4
-					   + strlen(slash_ptr + 1);
-
-				if (strnicmp(tmp_ptr, "mbit", 4) == 0)
-					multi = 1024;
-
-				if ((strnicmp(tmp_ptr, "kbit", 4) == 0) ||
-				    (multi > 1))
-					*tmp_ptr = '\0';
-			}
-
-			ret = strict_strtoul(slash_ptr + 1, 10, up);
-			if (ret) {
-				bat_err(net_dev,
-					"Upload speed of gateway mode invalid: "
-					"%s\n", slash_ptr + 1);
-				return false;
-			}
-
-			*up *= multi;
-		}
-
-		break;
-	default:
-		if (strcmp(tokptr, GW_MODE_OFF_NAME) == 0) {
-			*gw_mode_tmp = GW_MODE_OFF;
-			*gw_mode_tmp_str = GW_MODE_OFF_NAME;
-		}
-
-		if (strcmp(tokptr, GW_MODE_CLIENT_NAME) == 0) {
-			*gw_mode_tmp = GW_MODE_CLIENT;
-			*gw_mode_tmp_str = GW_MODE_CLIENT_NAME;
-		}
-
-		if (strcmp(tokptr, GW_MODE_SERVER_NAME) == 0) {
-			*gw_mode_tmp = GW_MODE_SERVER;
-			*gw_mode_tmp_str = GW_MODE_SERVER_NAME;
-		}
-	}
-
-	return true;
-}
-
-ssize_t gw_mode_set(struct net_device *net_dev, char *buff, size_t count)
-{
-	char *tokptr, *cp, finished;
-	char *gw_mode_curr_str, *gw_mode_tmp_str = NULL;
-	long gw_mode_curr, gw_mode_tmp = GW_MODE_OFF;
-	long gw_class_tmp = 0, up = 0, down = 0;
-	bool ret;
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
-
-	tokptr = buff;
-	gw_mode_curr = atomic_read(&bat_priv->gw_mode);
-
-	for (cp = buff, finished = 0; !finished; cp++) {
-		switch (*cp) {
-		case 0:
-			finished = 1;
-		case ' ':
-		case '\n':
-		case '\t':
-			*cp = 0;
-
-			if (strlen(tokptr) == 0)
-				goto next;
-
-			ret = parse_gw_mode_tok(net_dev, tokptr, &gw_mode_tmp,
-						&gw_mode_tmp_str, &gw_class_tmp,
-						&up, &down);
-
-			if (!ret)
-				goto end;
-
-next:
-			tokptr = cp + 1;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!gw_mode_tmp_str) {
-		bat_info(net_dev, "Gateway mode can only be set to: '%s', '%s' "
-			 "or '%s' - given value: %s\n", GW_MODE_OFF_NAME,
-			 GW_MODE_CLIENT_NAME, GW_MODE_SERVER_NAME, buff);
-		goto end;
-	}
-
-	switch (gw_mode_curr) {
-	case GW_MODE_CLIENT:
-		gw_mode_curr_str = GW_MODE_CLIENT_NAME;
-		break;
-	case GW_MODE_SERVER:
-		gw_mode_curr_str = GW_MODE_SERVER_NAME;
-		break;
-	default:
-		gw_mode_curr_str = GW_MODE_OFF_NAME;
-		break;
-	}
-
-	switch (gw_mode_tmp) {
-	case GW_MODE_CLIENT:
-		gw_class_tmp = atomic_read(&bat_priv->gw_sel_class);
-		if ((gw_mode_tmp == GW_MODE_CLIENT) && (!gw_class_tmp))
-			gw_class_tmp = 20;
-
-		bat_info(net_dev, "Changing gateway mode from: '%s' to: '%s' "
-			 "(gw_sel_class: %ld)\n",
-			 gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp);
-
-		atomic_set(&bat_priv->gw_sel_class, gw_class_tmp);
-		break;
-	case GW_MODE_SERVER:
-		if (!down)
-			down = 2000;
-
-		if (!up)
-			up = down / 5;
-
-		kbit_to_gw_bandwidth(down, up, &gw_class_tmp);
-
-		/**
-		 * the gw class we guessed above might not match the given
-		 * speeds, hence we need to calculate it back to show the
-		 * number that is going to be propagated
-		 **/
-		gw_bandwidth_to_kbit((uint8_t)gw_class_tmp,
-				     (int *)&down, (int *)&up);
-
-		gw_deselect(bat_priv);
-		bat_info(net_dev, "Changing gateway mode from: '%s' to: '%s' "
-			 "(gw_class: %ld -> propagating: %ld%s/%ld%s)\n",
-			 gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp,
-			 (down > 2048 ? down / 1024 : down),
-			 (down > 2048 ? "MBit" : "KBit"),
-			 (up > 2048 ? up / 1024 : up),
-			 (up > 2048 ? "MBit" : "KBit"));
-
-		atomic_set(&bat_priv->gw_bandwidth, gw_class_tmp);
-		break;
-	default:
-		bat_info(net_dev, "Changing gateway mode from: '%s' to: '%s'\n",
-			 gw_mode_curr_str, gw_mode_tmp_str);
-		break;
-	}
-
-	atomic_set(&bat_priv->gw_mode, gw_mode_tmp);
-
-	if (gw_class_tmp == 0)
-		gw_deselect(bat_priv);
-
-end:
-	return count;
-}
-
 static bool parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 			       long *up, long *down)
 {
diff --git a/batman-adv/gateway_common.h b/batman-adv/gateway_common.h
index 181a306..5e728d0 100644
--- a/batman-adv/gateway_common.h
+++ b/batman-adv/gateway_common.h
@@ -33,7 +33,6 @@ enum gw_modes {
 #define GW_MODE_SERVER_NAME	"server"
 
 void gw_bandwidth_to_kbit(uint8_t gw_class, int *down, int *up);
-ssize_t gw_mode_set(struct net_device *net_dev, char *buff, size_t count);
 ssize_t gw_bandwidth_set(struct net_device *net_dev, char *buff, size_t count);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_COMMON_H_ */
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 9561433..1e55bdb 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -591,8 +591,8 @@ struct net_device *softif_create(char *name)
 	atomic_set(&bat_priv->bonding, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
-	atomic_set(&bat_priv->gw_sel_class, 0);
-	atomic_set(&bat_priv->gw_bandwidth, 0);
+	atomic_set(&bat_priv->gw_sel_class, 20);
+	atomic_set(&bat_priv->gw_bandwidth, 41);
 	atomic_set(&bat_priv->orig_interval, 1000);
 	atomic_set(&bat_priv->hop_penalty, 10);
 	atomic_set(&bat_priv->log_level, 0);
-- 
1.7.1

