Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sat,  9 Jan 2016 21:20:20 +0800
Message-Id: <1452345621-15908-16-git-send-email-a@unstable.cc>
In-Reply-To: <1452345621-15908-1-git-send-email-a@unstable.cc>
References: <1452345621-15908-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 15/16] batman-adv: Remove kerneldoc for
	missing struct members
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
 net/batman-adv/types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d93501edb987..1a67a1a402f6 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -371,9 +371,7 @@ struct batadv_hardif_neigh_node {
  * @ifinfo_lock: lock protecting private ifinfo members and list
  * @if_incoming: pointer to incoming hard interface
  * @last_seen: when last packet via this neighbor was received
- * @last_ttl: last received ttl from this neigh node
  * @rcu: struct used for freeing in an RCU-safe manner
- * @bat_iv: B.A.T.M.A.N. IV private structure
  */
 struct batadv_neigh_node {
 	struct hlist_node list;
@@ -1257,8 +1255,6 @@ struct batadv_dat_candidate {
  * struct batadv_tvlv_container - container for tvlv appended to OGMs
  * @list: hlist node for batadv_priv_tvlv::container_list
  * @tvlv_hdr: tvlv header information needed to construct the tvlv
- * @value_len: length of the buffer following this struct which contains
- *  the actual tvlv payload
  * @refcount: number of contexts the object is used
  */
 struct batadv_tvlv_container {
-- 
2.7.0

