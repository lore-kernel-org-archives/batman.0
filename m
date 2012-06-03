Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jun 2012 22:19:11 +0200
Message-Id: <1338754762-28424-5-git-send-email-sven@narfation.org>
In-Reply-To: <1338754762-28424-1-git-send-email-sven@narfation.org>
References: <1338754762-28424-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 05/16] batman-adv: Prefix gateway defines
	with BATADV_
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
 bat_sysfs.c      |   26 +++++++++++++++-----------
 gateway_common.h |    6 +++---
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 937f61f..24881d8 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -360,13 +360,16 @@ static ssize_t batadv_show_gw_mode(struct kobject *kobj, struct attribute *attr,
 
 	switch (atomic_read(&bat_priv->gw_mode)) {
 	case GW_MODE_CLIENT:
-		bytes_written = sprintf(buff, "%s\n", GW_MODE_CLIENT_NAME);
+		bytes_written = sprintf(buff, "%s\n",
+					BATADV_GW_MODE_CLIENT_NAME);
 		break;
 	case GW_MODE_SERVER:
-		bytes_written = sprintf(buff, "%s\n", GW_MODE_SERVER_NAME);
+		bytes_written = sprintf(buff, "%s\n",
+					BATADV_GW_MODE_SERVER_NAME);
 		break;
 	default:
-		bytes_written = sprintf(buff, "%s\n", GW_MODE_OFF_NAME);
+		bytes_written = sprintf(buff, "%s\n",
+					BATADV_GW_MODE_OFF_NAME);
 		break;
 	}
 
@@ -385,15 +388,16 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 	if (buff[count - 1] == '\n')
 		buff[count - 1] = '\0';
 
-	if (strncmp(buff, GW_MODE_OFF_NAME, strlen(GW_MODE_OFF_NAME)) == 0)
+	if (strncmp(buff, BATADV_GW_MODE_OFF_NAME,
+		    strlen(BATADV_GW_MODE_OFF_NAME)) == 0)
 		gw_mode_tmp = GW_MODE_OFF;
 
-	if (strncmp(buff, GW_MODE_CLIENT_NAME,
-		    strlen(GW_MODE_CLIENT_NAME)) == 0)
+	if (strncmp(buff, BATADV_GW_MODE_CLIENT_NAME,
+		    strlen(BATADV_GW_MODE_CLIENT_NAME)) == 0)
 		gw_mode_tmp = GW_MODE_CLIENT;
 
-	if (strncmp(buff, GW_MODE_SERVER_NAME,
-		    strlen(GW_MODE_SERVER_NAME)) == 0)
+	if (strncmp(buff, BATADV_GW_MODE_SERVER_NAME,
+		    strlen(BATADV_GW_MODE_SERVER_NAME)) == 0)
 		gw_mode_tmp = GW_MODE_SERVER;
 
 	if (gw_mode_tmp < 0) {
@@ -408,13 +412,13 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 
 	switch (atomic_read(&bat_priv->gw_mode)) {
 	case GW_MODE_CLIENT:
-		curr_gw_mode_str = GW_MODE_CLIENT_NAME;
+		curr_gw_mode_str = BATADV_GW_MODE_CLIENT_NAME;
 		break;
 	case GW_MODE_SERVER:
-		curr_gw_mode_str = GW_MODE_SERVER_NAME;
+		curr_gw_mode_str = BATADV_GW_MODE_SERVER_NAME;
 		break;
 	default:
-		curr_gw_mode_str = GW_MODE_OFF_NAME;
+		curr_gw_mode_str = BATADV_GW_MODE_OFF_NAME;
 		break;
 	}
 
diff --git a/gateway_common.h b/gateway_common.h
index 6f8a4d0..31bbc3c 100644
--- a/gateway_common.h
+++ b/gateway_common.h
@@ -26,9 +26,9 @@ enum gw_modes {
 	GW_MODE_SERVER,
 };
 
-#define GW_MODE_OFF_NAME	"off"
-#define GW_MODE_CLIENT_NAME	"client"
-#define GW_MODE_SERVER_NAME	"server"
+#define BATADV_GW_MODE_OFF_NAME	"off"
+#define BATADV_GW_MODE_CLIENT_NAME	"client"
+#define BATADV_GW_MODE_SERVER_NAME	"server"
 
 void batadv_gw_bandwidth_to_kbit(uint8_t gw_class, int *down, int *up);
 ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
-- 
1.7.10

