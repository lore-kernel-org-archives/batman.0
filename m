Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 22 Aug 2016 15:56:17 +0200
Message-Id: <20160822135620.15337-18-sw@simonwunderlich.de>
In-Reply-To: <20160822135620.15337-1-sw@simonwunderlich.de>
References: <20160822135620.15337-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 17/20] batman-adv: Place kref_get for
	tvlv_container near use
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

It is hard to understand why the refcnt is increased when it isn't done
near the actual place the new reference is used. So using kref_get right
before the place which requires the reference and in the same function
helps to avoid accidental problems caused by incorrect reference counting.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tvlv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 3d1cf0f..3533867 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -257,8 +257,13 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
 	tvlv_old = batadv_tvlv_container_get(bat_priv, type, version);
 	batadv_tvlv_container_remove(bat_priv, tvlv_old);
+
+	kref_get(&tvlv_new->refcount);
 	hlist_add_head(&tvlv_new->list, &bat_priv->tvlv.container_list);
 	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
+
+	/* don't return reference to new tvlv_container */
+	batadv_tvlv_container_put(tvlv_new);
 }
 
 /**
-- 
2.9.3

