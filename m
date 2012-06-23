Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 23 Jun 2012 12:34:17 +0200
Message-Id: <1340447658-27405-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: correct comments in bridge
	loop avoidance
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 38aab1e..a61bb74 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -280,7 +280,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 			 NULL,
 			 /* Ethernet SRC/HW SRC:  originator mac */
 			 primary_if->net_dev->dev_addr,
-			 /* HW DST: FF:43:05:XX:00:00
+			 /* HW DST: FF:43:05:XX:YY:YY
 			  * with XX   = claim type
 			  * and YY:YY = group id
 			  */
@@ -322,7 +322,8 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 		break;
 	case BATADV_CLAIM_TYPE_REQUEST:
 		/* request frame
-		 * set HW SRC to the special mac containg the crc
+		 * set HW SRC and header destination to the receiving backbone
+		 * gws mac
 		 */
 		memcpy(hw_src, mac, ETH_ALEN);
 		memcpy(ethhdr->h_dest, mac, ETH_ALEN);
-- 
1.7.10

