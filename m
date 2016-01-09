Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sat,  9 Jan 2016 21:20:07 +0800
Message-Id: <1452345621-15908-3-git-send-email-a@unstable.cc>
In-Reply-To: <1452345621-15908-1-git-send-email-a@unstable.cc>
References: <1452345621-15908-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 02/16] batman-adv: Fix lockdep annotation of
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>, Sven Eckelmann <sven@open-mesh.com>

From: Sven Eckelmann <sven@open-mesh.com>

The function handles tlv containers and not tlv handlers. Thus the
lockdep_assert_held has to check for the container_list lock.

Fixes: 2c72d655b044 ("batman-adv: Annotate deleting functions with external lock via lockdep")
Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 5dbcb2e2b497..95fd418e9567 100644
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
2.7.0

