Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sat,  9 Jan 2016 21:20:21 +0800
Message-Id: <1452345621-15908-17-git-send-email-a@unstable.cc>
In-Reply-To: <1452345621-15908-1-git-send-email-a@unstable.cc>
References: <1452345621-15908-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 16/16] batman-adv: Add kerneldoc for
	batadv_neigh_node::refcount
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 1a67a1a402f6..3437b667a2cd 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -371,6 +371,7 @@ struct batadv_hardif_neigh_node {
  * @ifinfo_lock: lock protecting private ifinfo members and list
  * @if_incoming: pointer to incoming hard interface
  * @last_seen: when last packet via this neighbor was received
+ * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_neigh_node {
-- 
2.7.0

