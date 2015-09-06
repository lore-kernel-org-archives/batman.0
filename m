Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Sep 2015 21:38:47 +0200
Message-Id: <1441568333-15947-4-git-send-email-sven@narfation.org>
In-Reply-To: <1441568333-15947-1-git-send-email-sven@narfation.org>
References: <1441568333-15947-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/9] batman-adv: Remove kerneldoc for missing
	struct members
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
 net/batman-adv/types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 409b0bb..a758f68 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -349,9 +349,7 @@ struct batadv_gw_node {
  * @ifinfo_lock: lock protecting private ifinfo members and list
  * @if_incoming: pointer to incoming hard interface
  * @last_seen: when last packet via this neighbor was received
- * @last_ttl: last received ttl from this neigh node
  * @rcu: struct used for freeing in an RCU-safe manner
- * @bat_iv: B.A.T.M.A.N. IV private structure
  */
 struct batadv_neigh_node {
 	struct hlist_node list;
@@ -1229,8 +1227,6 @@ struct batadv_dat_candidate {
  * struct batadv_tvlv_container - container for tvlv appended to OGMs
  * @list: hlist node for batadv_priv_tvlv::container_list
  * @tvlv_hdr: tvlv header information needed to construct the tvlv
- * @value_len: length of the buffer following this struct which contains
- *  the actual tvlv payload
  * @refcount: number of contexts the object is used
  */
 struct batadv_tvlv_container {
-- 
2.5.1

