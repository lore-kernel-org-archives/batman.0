Return-Path: <sven@open-mesh.com>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue,  3 Nov 2015 17:43:05 +0100
Message-Id: <1446568985-4222-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix lockdep annotation of
	batadv_tlv_container_remove
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
Cc: Sven Eckelmann <sven@open-mesh.com>

The function handles tlv containers and not tlv handlers. Thus the
lockdep_assert_held has to check for the container_list lock.

Fixes: 5b95c427d187 ("batman-adv: Annotate deleting functions with external lock via lockdep")
Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 net/batman-adv/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 2fa168a..c898853 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -747,7 +747,7 @@ static u16 batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
 static void batadv_tvlv_container_remove(struct batadv_priv *bat_priv,
 					 struct batadv_tvlv_container *tvlv)
 {
-	lockdep_assert_held(&bat_priv->tvlv.handler_list_lock);
+	lockdep_assert_held(&bat_priv->tvlv.container_list_lock);
 
 	if (!tvlv)
 		return;
-- 
2.6.2

