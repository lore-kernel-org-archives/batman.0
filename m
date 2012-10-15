Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 15 Oct 2012 22:23:16 +0200
Message-Id: <1350332596-23684-2-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1350332596-23684-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1350332596-23684-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: fix bla compare function
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

The address and the VLAN VID may not be packed in the respective
structs. Fix this by comparing the elements individually.

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 758d921..8313322 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -77,8 +77,10 @@ static int batadv_compare_backbone_gw(const struct hlist_node *node,
 {
 	const void *data1 = container_of(node, struct batadv_backbone_gw,
 					 hash_entry);
+	const struct batadv_backbone_gw *gw1 = data1, *gw2 = data2;
 
-	return (memcmp(data1, data2, ETH_ALEN + sizeof(short)) == 0 ? 1 : 0);
+	return (((memcmp(gw1->orig, gw2->orig, ETH_ALEN) == 0) &&
+		 (gw1->vid == gw2->vid)) ? 1 : 0);
 }
 
 /* compares address and vid of two claims */
@@ -87,8 +89,10 @@ static int batadv_compare_claim(const struct hlist_node *node,
 {
 	const void *data1 = container_of(node, struct batadv_claim,
 					 hash_entry);
+	const struct batadv_claim *cl1 = data1, *cl2 = data2;
 
-	return (memcmp(data1, data2, ETH_ALEN + sizeof(short)) == 0 ? 1 : 0);
+	return (((memcmp(cl1->addr, cl2->addr, ETH_ALEN) == 0) &&
+		 (cl1->vid == cl2->vid)) ? 1 : 0);
 }
 
 /* free a backbone gw */
-- 
1.7.10

