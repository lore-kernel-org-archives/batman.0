Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri,  7 Jun 2013 16:52:05 +0200
Message-Id: <1370616725-1598-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't handle address updates
	when bla is disabled
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

The bridge loop avoidance has a hook to handle address updates of the
originator. These should not be handled when bridge loop avoidance is
disabled - it might send some bridge loop avoidance packets which should
not appear if bla is disabled.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 bridge_loop_avoidance.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index ab537ec..6ea7ccf 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1073,6 +1073,10 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 	group = htons(crc16(0, primary_if->net_dev->dev_addr, ETH_ALEN));
 	bat_priv->bla.claim_dest.group = group;
 
+	/* purge everything when bridge loop avoidance is turned off. */
+	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+		oldif = NULL;
+
 	if (!oldif) {
 		batadv_bla_purge_claims(bat_priv, NULL, 1);
 		batadv_bla_purge_backbone_gw(bat_priv, 1);
-- 
1.7.10.4

