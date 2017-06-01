Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu,  1 Jun 2017 17:11:24 +0200
Message-Id: <20170601151126.20708-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: do not add loop detection
 mac addresses to global tt
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

This change has been made for local TT already, add another one for
global TT - but only for temporary entries (aka speedy join), to prevent
inconsistencies between local and global tables in case an older
batman-adv version is still announcing those entries from its local
table.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e75b4937..4b64a9a6 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4012,6 +4012,12 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 {
 	bool ret = false;
 
+	/* ignore loop detect macs, they are not supposed to be in the tt local
+	 * data as well.
+	 */
+	if (batadv_bla_is_loopdetect_mac(addr))
+		return false;
+
 	if (!batadv_tt_global_add(bat_priv, orig_node, addr, vid,
 				  BATADV_TT_CLIENT_TEMP,
 				  atomic_read(&orig_node->last_ttvn)))
-- 
2.11.0

