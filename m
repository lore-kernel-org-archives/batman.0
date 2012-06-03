Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jun 2012 22:19:18 +0200
Message-Id: <1338754762-28424-12-git-send-email-sven@narfation.org>
In-Reply-To: <1338754762-28424-1-git-send-email-sven@narfation.org>
References: <1338754762-28424-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 12/16] batman-adv: Prefix gateway enum with
	BATADV_
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
 bat_iv_ogm.c     |    4 ++--
 bat_sysfs.c      |   14 +++++++-------
 gateway_client.c |    8 ++++----
 gateway_common.h |    8 ++++----
 soft-interface.c |   10 +++++-----
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 454b3d8..110e76f 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -611,7 +611,7 @@ static void batadv_iv_ogm_schedule(struct hard_iface *hard_iface)
 		batman_ogm_packet->flags &= ~VIS_SERVER;
 
 	if ((hard_iface == primary_if) &&
-	    (atomic_read(&bat_priv->gw_mode) == GW_MODE_SERVER))
+	    (atomic_read(&bat_priv->gw_mode) == BATADV_GW_MODE_SERVER))
 		batman_ogm_packet->gw_flags =
 				(uint8_t)atomic_read(&bat_priv->gw_bandwidth);
 	else
@@ -760,7 +760,7 @@ update_tt:
 
 	/* restart gateway selection if fast or late switching was enabled */
 	if ((orig_node->gw_flags) &&
-	    (atomic_read(&bat_priv->gw_mode) == GW_MODE_CLIENT) &&
+	    (atomic_read(&bat_priv->gw_mode) == BATADV_GW_MODE_CLIENT) &&
 	    (atomic_read(&bat_priv->gw_sel_class) > 2))
 		batadv_gw_check_election(bat_priv, orig_node);
 
diff --git a/bat_sysfs.c b/bat_sysfs.c
index 74aed8d..2abf7c9 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -359,11 +359,11 @@ static ssize_t batadv_show_gw_mode(struct kobject *kobj, struct attribute *attr,
 	int bytes_written;
 
 	switch (atomic_read(&bat_priv->gw_mode)) {
-	case GW_MODE_CLIENT:
+	case BATADV_GW_MODE_CLIENT:
 		bytes_written = sprintf(buff, "%s\n",
 					BATADV_GW_MODE_CLIENT_NAME);
 		break;
-	case GW_MODE_SERVER:
+	case BATADV_GW_MODE_SERVER:
 		bytes_written = sprintf(buff, "%s\n",
 					BATADV_GW_MODE_SERVER_NAME);
 		break;
@@ -390,15 +390,15 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 
 	if (strncmp(buff, BATADV_GW_MODE_OFF_NAME,
 		    strlen(BATADV_GW_MODE_OFF_NAME)) == 0)
-		gw_mode_tmp = GW_MODE_OFF;
+		gw_mode_tmp = BATADV_GW_MODE_OFF;
 
 	if (strncmp(buff, BATADV_GW_MODE_CLIENT_NAME,
 		    strlen(BATADV_GW_MODE_CLIENT_NAME)) == 0)
-		gw_mode_tmp = GW_MODE_CLIENT;
+		gw_mode_tmp = BATADV_GW_MODE_CLIENT;
 
 	if (strncmp(buff, BATADV_GW_MODE_SERVER_NAME,
 		    strlen(BATADV_GW_MODE_SERVER_NAME)) == 0)
-		gw_mode_tmp = GW_MODE_SERVER;
+		gw_mode_tmp = BATADV_GW_MODE_SERVER;
 
 	if (gw_mode_tmp < 0) {
 		batadv_info(net_dev,
@@ -411,10 +411,10 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 		return count;
 
 	switch (atomic_read(&bat_priv->gw_mode)) {
-	case GW_MODE_CLIENT:
+	case BATADV_GW_MODE_CLIENT:
 		curr_gw_mode_str = BATADV_GW_MODE_CLIENT_NAME;
 		break;
-	case GW_MODE_SERVER:
+	case BATADV_GW_MODE_SERVER:
 		curr_gw_mode_str = BATADV_GW_MODE_SERVER_NAME;
 		break;
 	default:
diff --git a/gateway_client.c b/gateway_client.c
index ae8b4e6..026b181 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -194,7 +194,7 @@ void batadv_gw_election(struct bat_priv *bat_priv)
 	 * hear about. This check is based on the daemon's uptime which we
 	 * don't have.
 	 */
-	if (atomic_read(&bat_priv->gw_mode) != GW_MODE_CLIENT)
+	if (atomic_read(&bat_priv->gw_mode) != BATADV_GW_MODE_CLIENT)
 		goto out;
 
 	if (!batadv_atomic_dec_not_zero(&bat_priv->gw_reselect))
@@ -663,13 +663,13 @@ bool batadv_gw_out_of_range(struct bat_priv *bat_priv,
 		goto out;
 
 	switch (atomic_read(&bat_priv->gw_mode)) {
-	case GW_MODE_SERVER:
+	case BATADV_GW_MODE_SERVER:
 		/* If we are a GW then we are our best GW. We can artificially
 		 * set the tq towards ourself as the maximum value
 		 */
 		curr_tq_avg = BATADV_TQ_MAX_VALUE;
 		break;
-	case GW_MODE_CLIENT:
+	case BATADV_GW_MODE_CLIENT:
 		curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 		if (!curr_gw)
 			goto out;
@@ -689,7 +689,7 @@ bool batadv_gw_out_of_range(struct bat_priv *bat_priv,
 
 		curr_tq_avg = neigh_curr->tq_avg;
 		break;
-	case GW_MODE_OFF:
+	case BATADV_GW_MODE_OFF:
 	default:
 		goto out;
 	}
diff --git a/gateway_common.h b/gateway_common.h
index 31bbc3c..13697f6 100644
--- a/gateway_common.h
+++ b/gateway_common.h
@@ -20,10 +20,10 @@
 #ifndef _NET_BATMAN_ADV_GATEWAY_COMMON_H_
 #define _NET_BATMAN_ADV_GATEWAY_COMMON_H_
 
-enum gw_modes {
-	GW_MODE_OFF,
-	GW_MODE_CLIENT,
-	GW_MODE_SERVER,
+enum batadv_gw_modes {
+	BATADV_GW_MODE_OFF,
+	BATADV_GW_MODE_CLIENT,
+	BATADV_GW_MODE_SERVER,
 };
 
 #define BATADV_GW_MODE_OFF_NAME	"off"
diff --git a/soft-interface.c b/soft-interface.c
index c1b2ab2..b77e598 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -177,7 +177,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		do_bcast = true;
 
 		switch (atomic_read(&bat_priv->gw_mode)) {
-		case GW_MODE_SERVER:
+		case BATADV_GW_MODE_SERVER:
 			/* gateway servers should not send dhcp
 			 * requests into the mesh
 			 */
@@ -185,7 +185,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 			if (ret)
 				goto dropped;
 			break;
-		case GW_MODE_CLIENT:
+		case BATADV_GW_MODE_CLIENT:
 			/* gateway clients should send dhcp requests
 			 * via unicast to their gateway
 			 */
@@ -193,7 +193,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 			if (ret)
 				do_bcast = false;
 			break;
-		case GW_MODE_OFF:
+		case BATADV_GW_MODE_OFF:
 		default:
 			break;
 		}
@@ -234,7 +234,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 	/* unicast packet */
 	} else {
-		if (atomic_read(&bat_priv->gw_mode) != GW_MODE_OFF) {
+		if (atomic_read(&bat_priv->gw_mode) != BATADV_GW_MODE_OFF) {
 			ret = batadv_gw_out_of_range(bat_priv, skb, ethhdr);
 			if (ret)
 				goto dropped;
@@ -387,7 +387,7 @@ struct net_device *batadv_softif_create(const char *name)
 	atomic_set(&bat_priv->bridge_loop_avoidance, 0);
 	atomic_set(&bat_priv->ap_isolation, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
-	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
+	atomic_set(&bat_priv->gw_mode, BATADV_GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_sel_class, 20);
 	atomic_set(&bat_priv->gw_bandwidth, 41);
 	atomic_set(&bat_priv->orig_interval, 1000);
-- 
1.7.10

