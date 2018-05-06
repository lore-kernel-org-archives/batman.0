Return-Path: <me@irrelefant.net>
From: =?UTF-8?q?Leonardo=20M=C3=B6rlein?= <me@irrelefant.net>
Date: Sun,  6 May 2018 21:55:59 +0200
Message-Id: <20180506195559.32602-1-me@irrelefant.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: mitigate issue when empty
 vlan is received
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
Cc: =?UTF-8?q?Leonardo=20M=C3=B6rlein?= <me@irrelefant.net>

This patch is not a fix for the issue itself, but a fix for the
other nodes, which are also influenced by the issue.

- Some (affected) nodes send TT announcements for an empty vlan (for
  now only seen with vlan_id = 0).
- This behaviour is a bug! Batman-adv nodes must not send TT
  announcements for empty vlans.
- The receiving batman-adv can not handle incoming TT announcements
  with empty vlans. (The crc check routine batadv_tt_global_check_crc()
  fails.)
- As the receiving node thinks, the crc is broken, it does a full
  table request then.
- The announcing node sends a TT full table to the receiving node
  then, which also contains the empty vlan, so
  *batadv_tt_global_check_crc()* fails again on the receiver side.
- This causes a lot of unneeded TT traffic. In Freifunk Hannover we
  decreased the amount of from ~20kpp/s to ~4kpp/s on our supernodes.
  We have ~800 nodes, which are connected via vpn to one of six
  supernodes. Those supernodes are connected with each other in a fully
  connected mesh.

Signed-off-by: Leonardo Mörlein <me@irrelefant.net>
---
 net/batman-adv/translation-table.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 0225616d..d2a843fd 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2996,8 +2996,21 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 
 		vlan = batadv_orig_node_vlan_get(orig_node,
 						 ntohs(tt_vlan_tmp->vid));
-		if (!vlan)
-			return false;
+		if (!vlan) {
+			/* Due to a bug, some originators send TT
+			 * announcements for empty vlans. As the receiving
+			 * nodes will ignore those empty vlans (they do not
+			 * add a batadv_orig_node_vlan into the transglobal
+			 * for the originating node), crc check will fail
+			 * here. To circumvent this issue, we skip the
+			 * verification for the vlan if the crc is
+			 * equal to 0x00000000.
+			 */
+			if (tt_vlan_tmp->crc == 0x00000000)
+				continue;
+			else
+				return false;
+		}
 
 		crc = vlan->tt.crc;
 		batadv_orig_node_vlan_put(vlan);
-- 
2.17.0

