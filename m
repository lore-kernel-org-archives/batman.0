Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 17 Jul 2018 17:19:45 +0200
Message-Id: <20180717151946.31900-6-sw@simonwunderlich.de>
In-Reply-To: <20180717151946.31900-1-sw@simonwunderlich.de>
References: <20180717151946.31900-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: Avoid storing non-TT-sync
 flags on singular entries too
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Linus Lüssing <linus.luessing@c0d3.blue>

Since commit 54e22f265e87 ("batman-adv: fix TT sync flag inconsistencies")
TT sync flags and TT non-sync'd flags are supposed to be stored
separately.

The previous patch missed to apply this separation on a TT entry with
only a single TT orig entry.

This is a minor fix because with only a single TT orig entry the DDoS
issue the former patch solves does not apply.

Fixes: 54e22f265e87 ("batman-adv: fix TT sync flag inconsistencies")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 3986551397ca..61ce300091f3 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1705,7 +1705,8 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		ether_addr_copy(common->addr, tt_addr);
 		common->vid = vid;
 
-		common->flags = flags;
+		common->flags = flags & (~BATADV_TT_SYNC_MASK);
+
 		tt_global_entry->roam_at = 0;
 		/* node must store current time in case of roaming. This is
 		 * needed to purge this entry out on timeout (if nobody claims
-- 
2.11.0

