Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Sep 2015 21:38:48 +0200
Message-Id: <1441568333-15947-5-git-send-email-sven@narfation.org>
In-Reply-To: <1441568333-15947-1-git-send-email-sven@narfation.org>
References: <1441568333-15947-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/9] batman-adv: Add kerneldoc for
	batadv_gw_node::refcount
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a758f68..c8ad8a9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -349,6 +349,7 @@ struct batadv_gw_node {
  * @ifinfo_lock: lock protecting private ifinfo members and list
  * @if_incoming: pointer to incoming hard interface
  * @last_seen: when last packet via this neighbor was received
+ * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_neigh_node {
-- 
2.5.1

