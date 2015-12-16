Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 16 Dec 2015 15:49:30 +0800
Message-Id: <1450252173-20949-10-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1450252173-20949-1-git-send-email-antonio@meshcoding.com>
References: <1450252173-20949-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 09/12] batman-adv: unify flags access style
	in tt global add
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Simon Wunderlich <sw@simonwunderlich.de>

This should slightly improve readability

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 17822de..5cf4311 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1435,7 +1435,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		 * TT_CLIENT_WIFI, therefore they have to be copied in the
 		 * client entry
 		 */
-		tt_global_entry->common.flags |= flags;
+		common->flags |= flags;
 
 		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
 		 * one originator left in the list and we previously received a
-- 
2.6.4

