Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 19 Nov 2012 09:24:03 +0100
Message-Id: <1353313451-2930-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1353313451-2930-1-git-send-email-ordex@autistici.org>
References: <1353313451-2930-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 02/10] batman-adv: fix bla compare function
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>

From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>

The address and the VLAN VID may not be packed in the respective
structs. Fix this by comparing the elements individually.

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index bda8b17..7ffef8b 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -77,8 +77,15 @@ static int batadv_compare_backbone_gw(const struct hlist_node *node,
 {
 	const void *data1 = container_of(node, struct batadv_backbone_gw,
 					 hash_entry);
+	const struct batadv_backbone_gw *gw1 = data1, *gw2 = data2;
 
-	return (memcmp(data1, data2, ETH_ALEN + sizeof(short)) == 0 ? 1 : 0);
+	if (!batadv_compare_eth(gw1->orig, gw2->orig))
+		return 0;
+
+	if (gw1->vid != gw2->vid)
+		return 0;
+
+	return 1;
 }
 
 /* compares address and vid of two claims */
@@ -87,8 +94,15 @@ static int batadv_compare_claim(const struct hlist_node *node,
 {
 	const void *data1 = container_of(node, struct batadv_claim,
 					 hash_entry);
+	const struct batadv_claim *cl1 = data1, *cl2 = data2;
 
-	return (memcmp(data1, data2, ETH_ALEN + sizeof(short)) == 0 ? 1 : 0);
+	if (!batadv_compare_eth(cl1->addr, cl2->addr))
+		return 0;
+
+	if (cl1->vid != cl2->vid)
+		return 0;
+
+	return 1;
 }
 
 /* free a backbone gw */
-- 
1.8.0

