Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 20 Feb 2018 12:08:10 +0100
Message-Id: <20180220110810.10676-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid relation operator
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, David Binderman <dcb314@hotmail.com>, Antonio Quartulli <a@unstable.cc>, Markus Pargmann <mpa@pengutronix.de>

commit 34b3c3850e7d ("batman-adv: Distributed ARP Table - create DHT helper
functions") introduced a return check of batadv_compare_eth which uses a
boolean return value since commit 16af73458aca ("batman-adv: main,
batadv_compare_eth return bool"). A relational (<, >, <= or >=) operator
is not the right one for such a check.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: David Binderman <dcb314@hotmail.com>
Cc: Antonio Quartulli <a@unstable.cc>
Cc: Markus Pargmann <mpa@pengutronix.de>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 760c0de7..a39a07d6 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -493,7 +493,7 @@ static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
 	 * the one with the lowest address
 	 */
 	if (tmp_max == max && max_orig_node &&
-	    batadv_compare_eth(candidate->orig, max_orig_node->orig) > 0)
+	    batadv_compare_eth(candidate->orig, max_orig_node->orig))
 		goto out;
 
 	ret = true;
-- 
2.11.0

