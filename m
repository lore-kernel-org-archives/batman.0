Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun,  5 Jan 2014 12:36:49 +0100
Message-Id: <1388921809-4005-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use batadv_compare_eth when
	possible
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

When comparing Ethernet address it is better to use the more
generic batadv_compare_eth. The latter is also optimised for
architectures having a fast unaligned access.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 network-coding.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/network-coding.c b/network-coding.c
index f1b604d..0049e7a 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -481,12 +481,10 @@ static int batadv_nc_hash_compare(const struct hlist_node *node,
 	nc_path2 = data2;
 
 	/* Return 1 if the two keys are identical */
-	if (memcmp(nc_path1->prev_hop, nc_path2->prev_hop,
-		   sizeof(nc_path1->prev_hop)) != 0)
+	if (!batadv_compare_eth(nc_path1->prev_hop, nc_path2->prev_hop))
 		return 0;
 
-	if (memcmp(nc_path1->next_hop, nc_path2->next_hop,
-		   sizeof(nc_path1->next_hop)) != 0)
+	if (!batadv_compare_eth(nc_path1->next_hop, nc_path2->next_hop))
 		return 0;
 
 	return 1;
-- 
1.8.5.2

