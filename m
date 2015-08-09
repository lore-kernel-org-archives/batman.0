Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun,  9 Aug 2015 23:58:52 +0800
Message-Id: <1439135932-17520-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove leftovers of unused
	BATADV_PRIMARIES_FIRST_HOP flag
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bat_iv_ogm.c | 3 ---
 net/batman-adv/packet.h     | 3 +--
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 5677169..2467024 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -361,7 +361,6 @@ batadv_iv_ogm_primary_iface_set(struct batadv_hard_iface *hard_iface)
 	unsigned char *ogm_buff = hard_iface->bat_iv.ogm_buff;
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)ogm_buff;
-	batadv_ogm_packet->flags = BATADV_PRIMARIES_FIRST_HOP;
 	batadv_ogm_packet->ttl = BATADV_TTL;
 }
 
@@ -842,8 +841,6 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 		   "Forwarding packet: tq: %i, ttl: %i\n",
 		   batadv_ogm_packet->tq, batadv_ogm_packet->ttl);
 
-	/* switch of primaries first hop flag when forwarding */
-	batadv_ogm_packet->flags &= ~BATADV_PRIMARIES_FIRST_HOP;
 	if (is_single_hop_neigh)
 		batadv_ogm_packet->flags |= BATADV_DIRECTLINK;
 	else
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 11f996b..0558e32 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -72,8 +72,7 @@ enum batadv_subtype {
  * enum batadv_iv_flags - flags used in B.A.T.M.A.N. IV OGM packets
  * @BATADV_NOT_BEST_NEXT_HOP: flag is set when ogm packet is forwarded and was
  *     previously received from someone else than the best neighbor.
- * @BATADV_PRIMARIES_FIRST_HOP: flag is set when the primary interface address
- *     is used, and the packet travels its first hop.
+ * @BATADV_PRIMARIES_FIRST_HOP: flag unused.
  * @BATADV_DIRECTLINK: flag is for the first hop or if rebroadcasted from a
  *     one hop neighbor on the interface where it was originally received.
  */
-- 
2.5.0

