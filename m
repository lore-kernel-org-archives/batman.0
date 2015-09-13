Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 Sep 2015 09:42:48 +0200
Message-Id: <1442130168-3628-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Place constant on right side of
	comparison
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

checkpatch warns when the constant is on the right side of a comparison.

Fixes: 56fd0bab9c18 ("batman-adv: Fix gw_bandwidth calculation on 32 bit systems")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 0cb5e6b..66d9514 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -89,7 +89,7 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 		break;
 	}
 
-	if (U32_MAX < ldown) {
+	if (ldown > U32_MAX) {
 		batadv_err(net_dev,
 			   "Download speed of gateway mode too large: %s\n",
 			   buff);
@@ -139,7 +139,7 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 			break;
 		}
 
-		if (U32_MAX < lup) {
+		if (lup > U32_MAX) {
 			batadv_err(net_dev,
 				   "Upload speed of gateway mode too large: %s\n",
 				   slash_ptr + 1);
-- 
2.5.1

