Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 24 May 2016 00:31:17 +0200
Message-Id: <1464042677-7787-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] RFC: batman-adv: Remove unused primary_if
	variable
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

Fixes: 29b9256e6631 ("batman-adv: consider outgoing interface in OGM sending")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---

Note sure whether the "forw_packet->if_incoming != primary_if" check vanished
on purpose or by accident in the mentioned commit. Or whether it got
substituted by some other check. Therefore sending the patch as RFC.


 net/batman-adv/bat_iv_ogm.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 5a7923c..2076048 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -529,35 +529,26 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
-	struct batadv_hard_iface *primary_if = NULL;
 
 	if (!forw_packet->if_incoming) {
 		pr_err("Error - can't forward packet: incoming iface not specified\n");
-		goto out;
+		return;
 	}
 
 	soft_iface = forw_packet->if_incoming->soft_iface;
 	bat_priv = netdev_priv(soft_iface);
 
 	if (WARN_ON(!forw_packet->if_outgoing))
-		goto out;
+		return;
 
 	if (WARN_ON(forw_packet->if_outgoing->soft_iface != soft_iface))
-		goto out;
+		return;
 
 	if (forw_packet->if_incoming->if_status != BATADV_IF_ACTIVE)
-		goto out;
-
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if)
-		goto out;
+		return;
 
 	/* only for one specific outgoing interface */
 	batadv_iv_ogm_send_to_if(forw_packet, forw_packet->if_outgoing);
-
-out:
-	if (primary_if)
-		batadv_hardif_put(primary_if);
 }
 
 /**
-- 
1.7.10.4

