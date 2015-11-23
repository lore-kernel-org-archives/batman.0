Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 Nov 2015 19:57:20 +0100
Message-Id: <1448305042-5806-2-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
References: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix lockdep splat when doing
	mcast_free
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

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 net/batman-adv/multicast.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 8abf488..d984eee 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -801,7 +801,9 @@ void batadv_mcast_free(struct batadv_priv *bat_priv)
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
 
+	spin_lock_bh(&bat_priv->tt.commit_lock);
 	batadv_mcast_mla_tt_retract(bat_priv, NULL);
+	spin_unlock_bh(&bat_priv->tt.commit_lock);
 }
 
 /**
-- 
2.6.2

