Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed, 11 May 2016 03:29:57 +0800
Message-Id: <1462908605-27412-10-git-send-email-a@unstable.cc>
In-Reply-To: <1462908605-27412-1-git-send-email-a@unstable.cc>
References: <1462908605-27412-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 09/17] batman-adv: Use kref_get for
	batadv_tvlv_container_get
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

batadv_tvlv_container_get requires that tvlv.container_list_lock is held by
the caller. It is therefore not possible that an item in
tvlv.container_list has an reference counter of 0 and is still in the list

The kref_get function instead WARNs (with debug information) when the
reference counter would still be 0. This makes a bug in batman-adv better
visible because kref_get_unless_zero would have ignored this problem.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index c8d8bc78a518..5f2974bd1227 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -748,9 +748,7 @@ batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
 		if (tvlv_tmp->tvlv_hdr.version != version)
 			continue;
 
-		if (!kref_get_unless_zero(&tvlv_tmp->refcount))
-			continue;
-
+		kref_get(&tvlv_tmp->refcount);
 		tvlv = tvlv_tmp;
 		break;
 	}
-- 
2.8.2

