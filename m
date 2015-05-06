Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Wed,  6 May 2015 21:29:21 +0200
Message-Id: <1430940562-12148-3-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1430940562-12148-1-git-send-email-linus.luessing@c0d3.blue>
References: <1430940562-12148-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv5 2/3] batman-adv: Increase BATADV_TVLV_MCAST
 version number to 2
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

The multicast optimizations bridge integration will require the just
implemented IGMP/MLD report handling later. Therefore bumping the
version number.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/multicast.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 72d561c..87a5942 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -225,7 +225,7 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 	if (batadv_mcast_has_bridge(bat_priv)) {
 		if (bat_priv->mcast.enabled) {
 			batadv_tvlv_container_unregister(bat_priv,
-							 BATADV_TVLV_MCAST, 1);
+							 BATADV_TVLV_MCAST, 2);
 			bat_priv->mcast.enabled = false;
 		}
 
@@ -234,7 +234,7 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 
 	if (!bat_priv->mcast.enabled ||
 	    mcast_data.flags != bat_priv->mcast.flags) {
-		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 1,
+		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 2,
 					       &mcast_data, sizeof(mcast_data));
 		bat_priv->mcast.flags = mcast_data.flags;
 		bat_priv->mcast.enabled = true;
@@ -984,7 +984,7 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 void batadv_mcast_init(struct batadv_priv *bat_priv)
 {
 	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler_v1,
-				     NULL, BATADV_TVLV_MCAST, 1,
+				     NULL, BATADV_TVLV_MCAST, 2,
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 }
 
@@ -994,8 +994,8 @@ void batadv_mcast_init(struct batadv_priv *bat_priv)
  */
 void batadv_mcast_free(struct batadv_priv *bat_priv)
 {
-	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
-	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
+	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
+	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
 
 	batadv_mcast_mla_tt_retract(bat_priv, NULL);
 }
-- 
1.7.10.4

