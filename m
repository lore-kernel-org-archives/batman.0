Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 Mar 2016 14:01:10 +0100
Message-Id: <1457701271-24248-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: use batadv_compare_eth when
	possible
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
Cc: Antonio Quartulli <a@unstable.cc>

From: Antonio Quartulli <a@unstable.cc>

When comparing Ethernet address it is better to use the more
generic batadv_compare_eth. The latter is also optimised for
architectures having a fast unaligned access.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
[sven@narfation.org: fix conflicts with current version]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Patch was resurrected from https://patchwork.open-mesh.org/patch/3668/

I've requested an rebased version at
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014639.html
but done it myself because it was rather trivial.
---
 net/batman-adv/network-coding.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 32f9fa1..cbc667a 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -521,12 +521,10 @@ static bool batadv_nc_hash_compare(const struct hlist_node *node,
 	nc_path2 = data2;
 
 	/* Return 1 if the two keys are identical */
-	if (memcmp(nc_path1->prev_hop, nc_path2->prev_hop,
-		   sizeof(nc_path1->prev_hop)) != 0)
+	if (!batadv_compare_eth(nc_path1->prev_hop, nc_path2->prev_hop))
 		return false;
 
-	if (memcmp(nc_path1->next_hop, nc_path2->next_hop,
-		   sizeof(nc_path1->next_hop)) != 0)
+	if (!batadv_compare_eth(nc_path1->next_hop, nc_path2->next_hop))
 		return false;
 
 	return true;
-- 
2.7.0

