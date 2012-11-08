Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  8 Nov 2012 21:55:29 +0100
Message-Id: <1352408130-22971-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: don't add TEMP clients
	belonging to other backbone nodes
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

The "early client detection" mechanism must not add clients belonging
to other backbone nodes. Such clients must be reached by directly
using the LAN instead of the mesh.

This was introduced by 724d05c8215e4e8186097121595ef20b6ba601b7
("batman-adv: detect not yet announced clients")

Reported-by: Glen Page <glen.page@thet.net>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/translation-table.c b/translation-table.c
index fec1a00..baae715 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2456,6 +2456,13 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 {
 	bool ret = false;
 
+	/* if the originator is a backbone node (meaning it belongs to the same
+	 * LAN of this node) the temporary client must not be added because to
+	 * reach such destination the node must use the LAN instead of the mesh
+	 */
+	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig))
+		goto out;
+
 	if (!batadv_tt_global_add(bat_priv, orig_node, addr,
 				  BATADV_TT_CLIENT_TEMP,
 				  atomic_read(&orig_node->last_ttvn)))
-- 
1.8.0

