Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  9 Nov 2015 22:04:20 +0100
Message-Id: <1447103060-8960-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Add function to convert
	string to batadv throughput
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
Cc: Sven Eckelmann <sven@open-mesh.com>

From: Sven Eckelmann <sven@open-mesh.com>

The code to convert the throughput information from a string to the
batman-adv internal (100Kibit/s) representation is duplicated in
batadv_parse_gw_bandwidth. Move this functionality to its own function
batadv_parse_throughput to reduce the code complexity.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
v2: add kerneldoc for description

 net/batman-adv/gateway_common.c | 117 +++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 68 deletions(-)

diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 0ef4546..b287448 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -31,27 +31,23 @@
 #include "packet.h"
 
 /**
- * batadv_parse_gw_bandwidth - parse supplied string buffer to extract download
- *  and upload bandwidth information
+ * batadv_parse_throughput - parse supplied string buffer to extract throughput
+ *  information
  * @net_dev: the soft interface net device
  * @buff: string buffer to parse
- * @down: pointer holding the returned download bandwidth information
- * @up: pointer holding the returned upload bandwidth information
+ * @description: text shown when throughput string cannot be parsed
+ * @throughput: pointer holding the returned throughput information
  *
  * Return: false on parse error and true otherwise.
  */
-static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
-				      u32 *down, u32 *up)
+static bool batadv_parse_throughput(struct net_device *net_dev, char *buff,
+				    const char *description, u32 *throughput)
 {
 	enum batadv_bandwidth_units bw_unit_type = BATADV_BW_UNIT_KBIT;
-	char *slash_ptr, *tmp_ptr;
-	u64 ldown, lup;
+	u64 lthroughput;
+	char *tmp_ptr;
 	int ret;
 
-	slash_ptr = strchr(buff, '/');
-	if (slash_ptr)
-		*slash_ptr = 0;
-
 	if (strlen(buff) > 4) {
 		tmp_ptr = buff + strlen(buff) - 4;
 
@@ -63,90 +59,75 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 			*tmp_ptr = '\0';
 	}
 
-	ret = kstrtou64(buff, 10, &ldown);
+	ret = kstrtou64(buff, 10, &lthroughput);
 	if (ret) {
 		batadv_err(net_dev,
-			   "Download speed of gateway mode invalid: %s\n",
-			   buff);
+			   "Invalid throughput speed for %s: %s\n",
+			   description, buff);
 		return false;
 	}
 
 	switch (bw_unit_type) {
 	case BATADV_BW_UNIT_MBIT:
 		/* prevent overflow */
-		if (U64_MAX / 10 < ldown) {
+		if (U64_MAX / 10 < lthroughput) {
 			batadv_err(net_dev,
-				   "Download speed of gateway mode too large: %s\n",
-				   buff);
+				   "Throughput speed for %s too large: %s\n",
+				   description, buff);
 			return false;
 		}
 
-		ldown *= 10;
+		lthroughput *= 10;
 		break;
 	case BATADV_BW_UNIT_KBIT:
 	default:
-		ldown = div_u64(ldown, 100);
+		lthroughput = div_u64(lthroughput, 100);
 		break;
 	}
 
-	if (ldown > U32_MAX) {
+	if (lthroughput > U32_MAX) {
 		batadv_err(net_dev,
-			   "Download speed of gateway mode too large: %s\n",
-			   buff);
+			   "Throughput speed for %s too large: %s\n",
+			   description, buff);
 		return false;
 	}
 
-	*down = ldown;
+	*throughput = lthroughput;
 
-	/* we also got some upload info */
-	if (slash_ptr) {
-		bw_unit_type = BATADV_BW_UNIT_KBIT;
-
-		if (strlen(slash_ptr + 1) > 4) {
-			tmp_ptr = slash_ptr + 1 - 4 + strlen(slash_ptr + 1);
-
-			if (strncasecmp(tmp_ptr, "mbit", 4) == 0)
-				bw_unit_type = BATADV_BW_UNIT_MBIT;
+	return true;
+}
 
-			if ((strncasecmp(tmp_ptr, "kbit", 4) == 0) ||
-			    (bw_unit_type == BATADV_BW_UNIT_MBIT))
-				*tmp_ptr = '\0';
-		}
+/**
+ * batadv_parse_gw_bandwidth - parse supplied string buffer to extract download
+ *  and upload bandwidth information
+ * @net_dev: the soft interface net device
+ * @buff: string buffer to parse
+ * @down: pointer holding the returned download bandwidth information
+ * @up: pointer holding the returned upload bandwidth information
+ *
+ * Return: false on parse error and true otherwise.
+ */
+static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
+				      u32 *down, u32 *up)
+{
+	char *slash_ptr;
+	bool ret;
 
-		ret = kstrtou64(slash_ptr + 1, 10, &lup);
-		if (ret) {
-			batadv_err(net_dev,
-				   "Upload speed of gateway mode invalid: %s\n",
-				   slash_ptr + 1);
-			return false;
-		}
+	slash_ptr = strchr(buff, '/');
+	if (slash_ptr)
+		*slash_ptr = 0;
 
-		switch (bw_unit_type) {
-		case BATADV_BW_UNIT_MBIT:
-			/* prevent overflow */
-			if (U64_MAX / 10 < lup) {
-				batadv_err(net_dev,
-					   "Upload speed of gateway mode too large: %s\n",
-					   slash_ptr + 1);
-				return false;
-			}
-
-			lup *= 10;
-			break;
-		case BATADV_BW_UNIT_KBIT:
-		default:
-			lup = div_u64(lup, 100);
-			break;
-		}
+	ret = batadv_parse_throughput(net_dev, buff, "download gateway speed",
+				      down);
+	if (!ret)
+		return false;
 
-		if (lup > U32_MAX) {
-			batadv_err(net_dev,
-				   "Upload speed of gateway mode too large: %s\n",
-				   slash_ptr + 1);
+	/* we also got some upload info */
+	if (slash_ptr) {
+		ret = batadv_parse_throughput(net_dev, slash_ptr + 1,
+					      "upload gateway speed", up);
+		if (!ret)
 			return false;
-		}
-
-		*up = lup;
 	}
 
 	return true;
-- 
2.6.2

