Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 May 2015 11:37:48 +0200
Message-Id: <1433065068-25957-4-git-send-email-sven@narfation.org>
In-Reply-To: <1433065068-25957-1-git-send-email-sven@narfation.org>
References: <1433065068-25957-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: Fix gw_bandwidth calculation
	on 32 bit systems
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

The TVLV for the gw_bandwidth stores everything as u32. But the
gw_bandwidth reads the signed long which limits the maximum value to
(2 ** 31 - 1) on systems with 4 byte long. Also the input value is always
converted from either Mibit/s or Kibit/s to 100Kibit/s. This reduces the
values even further when the user sets it via the default unit Kibit/s. It
may even cause an integer overflow and end up with a value the user never
intended.

Instead read the values as u64, check for possible overflows, do the unit
adjustments and then reduce the size to u32.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_common.c | 49 +++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index f907a20..7430b12 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -18,6 +18,7 @@
 #include "gateway_common.h"
 #include "main.h"
 
+#include <asm/div64.h>
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
 #include <linux/kernel.h>
@@ -43,7 +44,7 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 {
 	enum batadv_bandwidth_units bw_unit_type = BATADV_BW_UNIT_KBIT;
 	char *slash_ptr, *tmp_ptr;
-	long ldown, lup;
+	u64 ldown, lup;
 	int ret;
 
 	slash_ptr = strchr(buff, '/');
@@ -61,7 +62,7 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 			*tmp_ptr = '\0';
 	}
 
-	ret = kstrtol(buff, 10, &ldown);
+	ret = kstrtou64(buff, 10, &ldown);
 	if (ret) {
 		batadv_err(net_dev,
 			   "Download speed of gateway mode invalid: %s\n",
@@ -71,14 +72,31 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 
 	switch (bw_unit_type) {
 	case BATADV_BW_UNIT_MBIT:
-		*down = ldown * 10;
+		/* prevent overflow */
+		if (U64_MAX / 10 < ldown) {
+			batadv_err(net_dev,
+				   "Download speed of gateway mode too large: %s\n",
+				   buff);
+			return false;
+		}
+
+		ldown *= 10;
 		break;
 	case BATADV_BW_UNIT_KBIT:
 	default:
-		*down = ldown / 100;
+		do_div(ldown, 100);
 		break;
 	}
 
+	if (U32_MAX < ldown) {
+		batadv_err(net_dev,
+			   "Download speed of gateway mode too large: %s\n",
+			   buff);
+		return false;
+	}
+
+	*down = ldown;
+
 	/* we also got some upload info */
 	if (slash_ptr) {
 		bw_unit_type = BATADV_BW_UNIT_KBIT;
@@ -94,7 +112,7 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 				*tmp_ptr = '\0';
 		}
 
-		ret = kstrtol(slash_ptr + 1, 10, &lup);
+		ret = kstrtou64(slash_ptr + 1, 10, &lup);
 		if (ret) {
 			batadv_err(net_dev,
 				   "Upload speed of gateway mode invalid: %s\n",
@@ -104,13 +122,30 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 
 		switch (bw_unit_type) {
 		case BATADV_BW_UNIT_MBIT:
-			*up = lup * 10;
+			/* prevent overflow */
+			if (U64_MAX / 10 < lup) {
+				batadv_err(net_dev,
+					   "Upload speed of gateway mode too large: %s\n",
+					   slash_ptr + 1);
+				return false;
+			}
+
+			lup *= 10;
 			break;
 		case BATADV_BW_UNIT_KBIT:
 		default:
-			*up = lup / 100;
+			do_div(lup, 100);
 			break;
 		}
+
+		if (U32_MAX < lup) {
+			batadv_err(net_dev,
+				   "Upload speed of gateway mode too large: %s\n",
+				   slash_ptr + 1);
+			return false;
+		}
+
+		*up = lup;
 	}
 
 	return true;
-- 
2.1.4

