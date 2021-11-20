Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 4.4 02/11] batman-adv: Fix multicast TT issues with bogus ROAM
 flags
Date: Sat, 20 Nov 2021 13:39:30 +0100
Message-Id: <20211120123939.260723-3-sven@narfation.org>
In-Reply-To: <20211120123939.260723-1-sven@narfation.org>
References: <20211120123939.260723-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: stable@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, =?UTF-8?q?Leonardo=20M=C3=B6rlein?= <me@irrelefant.net>, Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>

From: Linus Lüssing <linus.luessing@c0d3.blue>

commit a44ebeff6bbd6ef50db41b4195fca87b21aefd20 upstream.

When a (broken) node wrongly sends multicast TT entries with a ROAM
flag then this causes any receiving node to drop all entries for the
same multicast MAC address announced by other nodes, leading to
packet loss.

Fix this DoS vector by only storing TT sync flags. For multicast TT
non-sync'ing flag bits like ROAM are unused so far anyway.

Fixes: 1d8ab8d3c176 ("batman-adv: Modified forwarding behaviour for multicast packets")
Reported-by: Leonardo Mörlein <me@irrelefant.net>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
[ bp: 4.4 backported: adjust context, use old style to access flags ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5f976485e8c6..208cf66868e9 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1426,7 +1426,8 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		ether_addr_copy(common->addr, tt_addr);
 		common->vid = vid;
 
-		common->flags = flags & (~BATADV_TT_SYNC_MASK);
+		if (!is_multicast_ether_addr(common->addr))
+			common->flags = flags & (~BATADV_TT_SYNC_MASK);
 
 		tt_global_entry->roam_at = 0;
 		/* node must store current time in case of roaming. This is
@@ -1489,7 +1490,8 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 * TT_CLIENT_WIFI, therefore they have to be copied in the
 		 * client entry
 		 */
-		tt_global_entry->common.flags |= flags & (~BATADV_TT_SYNC_MASK);
+		if (!is_multicast_ether_addr(common->addr))
+			tt_global_entry->common.flags |= flags & (~BATADV_TT_SYNC_MASK);
 
 		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
 		 * one originator left in the list and we previously received a
-- 
2.30.2

