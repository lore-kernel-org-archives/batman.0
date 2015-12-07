Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon,  7 Dec 2015 23:12:13 +0800
Message-Id: <1449501135-30438-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1449501135-30438-1-git-send-email-antonio@meshcoding.com>
References: <1449501135-30438-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: avoid keeping false
	temporary entry
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

In the case when a temporary entry is added first and a proper tt entry
is added after that, the temporary tt entry is kept in the orig list.
However the temporary flag is removed at this point, and therefore the
purge function can not find this temporary entry anymore.

Therefore, remove the previous temp entry before adding the new proper
one.

This case can happen if a client behind a given originator moves before
the TT announcement is sent out. Other than that, this case can also be
created by bogus or malicious payload frames for VLANs which are not
existent on the sending originator.

Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Acked-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/translation-table.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4228b10..a3fc9033 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1427,9 +1427,15 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		}
 
 		/* if the client was temporary added before receiving the first
-		 * OGM announcing it, we have to clear the TEMP flag
+		 * OGM announcing it, we have to clear the TEMP flag. Also,
+		 * remove the previous temporary orig node and re-add it
+		 * if required. If the orig entry changed, the new one which
+		 * is a non-temporary entry is preferred.
 		 */
-		common->flags &= ~BATADV_TT_CLIENT_TEMP;
+		if (common->flags & BATADV_TT_CLIENT_TEMP) {
+			batadv_tt_global_del_orig_list(tt_global_entry);
+			common->flags &= ~BATADV_TT_CLIENT_TEMP;
+		}
 
 		/* the change can carry possible "attribute" flags like the
 		 * TT_CLIENT_WIFI, therefore they have to be copied in the
-- 
2.6.3

