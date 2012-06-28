Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 28 Jun 2012 11:34:21 +0200
Message-Id: <1340876067-28333-13-git-send-email-ordex@autistici.org>
In-Reply-To: <1340876067-28333-1-git-send-email-ordex@autistici.org>
References: <1340876067-28333-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 12/18] batman-adv: Prefix gateway defines
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_sysfs.c      |   26 +++++++++++++++-----------
 net/batman-adv/gateway_common.h |    6 +++---
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/bat_sysfs.c b/net/batman-adv/bat_sysfs.c
index 725e7d7..a6c27f0 100644
--- a/net/batman-adv/bat_sysfs.c
+++ b/net/batman-adv/bat_sysfs.c
@@ -361,13 +361,16 @@ static ssize_t batadv_show_gw_mode(struct kobject *kobj, struct attribute *attr,
 
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
 
@@ -386,15 +389,16 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
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
@@ -409,13 +413,13 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 
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
 
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index 6f8a4d0..31bbc3c 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
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
1.7.9.4

