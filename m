Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 30 Oct 2012 14:09:49 +0100
Message-Id: <1351602589-22844-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1351602589-22844-1-git-send-email-ordex@autistici.org>
References: <1351602589-22844-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: fix local client recognition
	in is_my_client()
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

A tt_local_entry which ROAM flag is set cannot be considered a local
client anymore. Having the ROAM flag set means that the client roamed away
and that the nodes received a ROAMING_ADV for such event

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index 0e18348..78d02fb 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2042,7 +2042,8 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const uint8_t *addr)
 	/* Check if the client has been logically deleted (but is kept for
 	 * consistency purpose)
 	 */
-	if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING)
+	if ((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
+	    (tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM))
 		goto out;
 	ret = true;
 out:
-- 
1.7.12.4

