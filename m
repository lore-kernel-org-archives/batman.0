Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat,  8 Sep 2012 18:02:53 +0200
Message-Id: <1347120174-29589-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: send announcement when
	backbone gw is registered
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

To avoid loops in the startup phase until the first announcement is
sent, send an announcement immediately as soon as a backbone gw is
added.

This may happen due to various reasons, e.g. a packet passes the rx
or tx path.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bridge_loop_avoidance.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 0921509..c522bdf 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -362,7 +362,7 @@ out:
  */
 static struct batadv_backbone_gw *
 batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, uint8_t *orig,
-			   short vid)
+			   short vid, bool own_backbone)
 {
 	struct batadv_backbone_gw *entry;
 	struct batadv_orig_node *orig_node;
@@ -409,6 +409,10 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, uint8_t *orig,
 					  "became a backbone gateway");
 		batadv_orig_node_free_ref(orig_node);
 	}
+
+	if (own_backbone)
+		batadv_bla_send_announce(bat_priv, entry);
+
 	return entry;
 }
 
@@ -424,7 +428,7 @@ batadv_bla_update_own_backbone_gw(struct batadv_priv *bat_priv,
 
 	backbone_gw = batadv_bla_get_backbone_gw(bat_priv,
 						 primary_if->net_dev->dev_addr,
-						 vid);
+						 vid, true);
 	if (unlikely(!backbone_gw))
 		return;
 
@@ -632,7 +636,8 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv,
 	if (memcmp(an_addr, batadv_announce_mac, 4) != 0)
 		return 0;
 
-	backbone_gw = batadv_bla_get_backbone_gw(bat_priv, backbone_addr, vid);
+	backbone_gw = batadv_bla_get_backbone_gw(bat_priv, backbone_addr, vid,
+						 false);
 
 	if (unlikely(!backbone_gw))
 		return 1;
@@ -730,7 +735,8 @@ static int batadv_handle_claim(struct batadv_priv *bat_priv,
 
 	/* register the gateway if not yet available, and add the claim. */
 
-	backbone_gw = batadv_bla_get_backbone_gw(bat_priv, backbone_addr, vid);
+	backbone_gw = batadv_bla_get_backbone_gw(bat_priv, backbone_addr, vid,
+						 false);
 
 	if (unlikely(!backbone_gw))
 		return 1;
-- 
1.7.10

