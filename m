Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2016 16:09:20 +0100
Message-Id: <1457190564-11419-5-git-send-email-sven@narfation.org>
In-Reply-To: <1457190564-11419-1-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/9] batman-adv: Use kref_get for
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
To: b.a.t.m.a.n@lists.open-mesh.org

batadv_tvlv_container_get requires that tvlv.container_list_lock is held by
the caller. It is therefore not possible that an item in
tvlv.container_list has an reference counter of 0 and is still in the list

The kref_get function instead WARNs (with debug information) when the
reference counter would still be 0. This makes a bug in batman-adv better
visible because kref_get_unless_zero would have ignored this problem.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index bda5f13..1245a58 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -748,9 +748,7 @@ static struct batadv_tvlv_container
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
2.7.0

