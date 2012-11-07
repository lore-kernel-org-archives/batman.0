Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  7 Nov 2012 21:07:35 +0100
Message-Id: <1352318855-20696-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix kernel-doc for
	batadv_reroute_unicast_packet()
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

This was introduced by ("batman-adv: substitute tt_poss_change with a
per-tt_entry flag")

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/routing.c b/routing.c
index 63ff456..1aa1722 100644
--- a/routing.c
+++ b/routing.c
@@ -877,11 +877,10 @@ out:
  * @bat_priv: the bat priv with all the soft interface information
  * @unicast_packet: the unicast header to be updated
  * @dst_addr: the payload destination
- * @msg: the message to print explaining the reason of the requested re-route
  *
- * Search the global translation table for dst_addr and update the unicast
- * header with the new corresponding information (originator address where the
- * destination client currently is and its known TTVN)
+ * Search the translation table for dst_addr and update the unicast header with
+ * the new corresponding information (originator address where the destination
+ * client currently is and its known TTVN)
  *
  * Returns true if the packet header has been updated, false otherwise
  */
-- 
1.8.0

