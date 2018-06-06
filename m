Return-Path: <ll@simonwunderlich.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu,  7 Jun 2018 00:46:24 +0200
Message-Id: <20180606224624.10141-2-linus.luessing@c0d3.blue>
In-Reply-To: <20180606224624.10141-1-linus.luessing@c0d3.blue>
References: <20180606224624.10141-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: Fix multicast TT
 issues with bogus ROAM flags
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

When a (broken) node wrongly sends multicast TT entries with a ROAM
flag then this causes any receiving node to drop all entries for the
same multicast MAC address announced by other nodes, leading to
packet loss.

Fix this DoS vector by only storing TT sync flags. For multicast TT
non-sync'ing flag bits like ROAM are unused so far anyway.

Fixes: 405cc1e5a81e ("batman-adv: Modified forwarding behaviour for multicast packets")
Reported-by: Leonardo Mörlein <me@irrelefant.net>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---

Fixes: https://www.open-mesh.org/issues/355

The issue reported by Leonardo was reproduceable in a small, virtual test
setup with a ROAM flag injected on multicast TT entries by one node.
---
 net/batman-adv/translation-table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 61ce3000..12a2b7d2 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1705,7 +1705,8 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		ether_addr_copy(common->addr, tt_addr);
 		common->vid = vid;
 
-		common->flags = flags & (~BATADV_TT_SYNC_MASK);
+		if (!is_multicast_ether_addr(common->addr))
+			common->flags = flags & (~BATADV_TT_SYNC_MASK);
 
 		tt_global_entry->roam_at = 0;
 		/* node must store current time in case of roaming. This is
@@ -1769,7 +1770,8 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 * TT_CLIENT_TEMP, therefore they have to be copied in the
 		 * client entry
 		 */
-		common->flags |= flags & (~BATADV_TT_SYNC_MASK);
+		if (!is_multicast_ether_addr(common->addr))
+			common->flags |= flags & (~BATADV_TT_SYNC_MASK);
 
 		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
 		 * one originator left in the list and we previously received a
-- 
2.11.0

