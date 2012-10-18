Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 18 Oct 2012 10:48:31 +0200
Message-Id: <1350550112-5857-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix regression in bla
	multiline comment style
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

4c1721b39c8a77c99e8f4de97b5d5d112006406c ("batman-adv: Fix potential broadcast
BLA-duplicate-check race condition") introduced a comment with the wrong line
ending.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Please merge in next

 bridge_loop_avoidance.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index c6c1c59..776a73d 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1302,7 +1302,8 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 		goto out;
 	}
 	/* not found, add a new entry (overwrite the oldest entry)
-	 * and allow it, its the first occurence. */
+	 * and allow it, its the first occurence.
+	 */
 	curr = (bat_priv->bla.bcast_duplist_curr + BATADV_DUPLIST_SIZE - 1);
 	curr %= BATADV_DUPLIST_SIZE;
 	entry = &bat_priv->bla.bcast_duplist[curr];
-- 
1.7.10.4

