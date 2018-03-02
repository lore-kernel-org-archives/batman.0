Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  2 Mar 2018 18:57:44 +0100
Message-Id: <20180302175745.12551-5-sw@simonwunderlich.de>
In-Reply-To: <20180302175745.12551-1-sw@simonwunderlich.de>
References: <20180302175745.12551-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: Avoid relation operator
 comparison with bool
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

commit 785ea1144182 ("batman-adv: Distributed ARP Table - create DHT helper
functions") introduced a return check of batadv_compare_eth which uses a
boolean return value since commit 16af73458aca ("batman-adv: main,
batadv_compare_eth return bool"). A relational (<, >, <= or >=) operator
is not the right one for such a check.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 19b15de455ab..4469dcc1558f 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -495,7 +495,7 @@ static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
 	 * the one with the lowest address
 	 */
 	if (tmp_max == max && max_orig_node &&
-	    batadv_compare_eth(candidate->orig, max_orig_node->orig) > 0)
+	    batadv_compare_eth(candidate->orig, max_orig_node->orig))
 		goto out;
 
 	ret = true;
-- 
2.11.0

