Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/6] batman-adv: bla: fix type misuse for backbone_gw hash indexing
Date: Fri, 18 Sep 2020 15:19:51 +0200
Message-Id: <20200918131956.21598-2-sw@simonwunderlich.de>
In-Reply-To: <20200918131956.21598-1-sw@simonwunderlich.de>
References: <20200918131956.21598-1-sw@simonwunderlich.de>
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <ll@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>

From: Linus Lüssing <ll@simonwunderlich.de>

It seems that due to a copy & paste error the void pointer
in batadv_choose_backbone_gw() is cast to the wrong type.

Fixing this by using "struct batadv_bla_backbone_gw" instead of "struct
batadv_bla_claim" which better matches the caller's side.

For now it seems that we were lucky because the two structs both have
their orig/vid and addr/vid in the beginning. However I stumbled over
this issue when I was trying to add some debug variables in front of
"orig" in batadv_backbone_gw, which caused hash lookups to fail.

Fixes: 07568d0369f9 ("batman-adv: don't rely on positions in struct for hashing")
Signed-off-by: Linus Lüssing <ll@simonwunderlich.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 8500f56cbd10..d8c5d3170676 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -83,11 +83,12 @@ static inline u32 batadv_choose_claim(const void *data, u32 size)
  */
 static inline u32 batadv_choose_backbone_gw(const void *data, u32 size)
 {
-	const struct batadv_bla_claim *claim = (struct batadv_bla_claim *)data;
+	const struct batadv_bla_backbone_gw *gw;
 	u32 hash = 0;
 
-	hash = jhash(&claim->addr, sizeof(claim->addr), hash);
-	hash = jhash(&claim->vid, sizeof(claim->vid), hash);
+	gw = (struct batadv_bla_backbone_gw *)data;
+	hash = jhash(&gw->orig, sizeof(gw->orig), hash);
+	hash = jhash(&gw->vid, sizeof(gw->vid), hash);
 
 	return hash % size;
 }
-- 
2.20.1

