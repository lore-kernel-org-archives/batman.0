Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 3/3] batman-adv: Fix misspelled "wont"
Date: Thu,  8 Apr 2021 13:54:01 +0200
Message-Id: <20210408115401.16988-4-sw@simonwunderlich.de>
In-Reply-To: <20210408115401.16988-1-sw@simonwunderlich.de>
References: <20210408115401.16988-1-sw@simonwunderlich.de>
MIME-Version: 1.0
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
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

checkpatch started to complain about the mispelling of:

  CHECK: 'wont' may be misspelled - perhaps 'won't'?
  #459: FILE: ./net/batman-adv/bat_iv_ogm.c:459:
  +    * - the resulting packet wont be bigger than

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index a5e313cd6f44..789f257be24f 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -456,7 +456,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	 * if:
 	 *
 	 * - the send time is within our MAX_AGGREGATION_MS time
-	 * - the resulting packet wont be bigger than
+	 * - the resulting packet won't be bigger than
 	 *   MAX_AGGREGATION_BYTES
 	 * otherwise aggregation is not possible
 	 */
-- 
2.20.1

