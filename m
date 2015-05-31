Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 May 2015 11:37:45 +0200
Message-Id: <1433065068-25957-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: Return EINVAL on invalid
	gw_bandwidth change
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

Invalid speed settings by the user are currently acknowledged as correct
but not stored. Instead the return of the store operation of the file
"gw_bandwidth" should indicate that the given value is not acceptable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 39cf44c..f907a20 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -157,7 +157,7 @@ ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 
 	ret = batadv_parse_gw_bandwidth(net_dev, buff, &down_new, &up_new);
 	if (!ret)
-		goto end;
+		return -EINVAL;
 
 	if (!down_new)
 		down_new = 1;
@@ -181,7 +181,6 @@ ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 	atomic_set(&bat_priv->gw.bandwidth_up, up_new);
 	batadv_gw_tvlv_container_update(bat_priv);
 
-end:
 	return count;
 }
 
-- 
2.1.4

