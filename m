Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 29 Apr 2012 11:06:42 +0200
Message-Id: <1335690403-25228-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Free local translation table
	on error in tt_init
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 translation-table.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index 88c62f1..c3b7773 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1776,8 +1776,10 @@ int tt_init(struct bat_priv *bat_priv)
 	if (!tt_local_init(bat_priv))
 		return 0;
 
-	if (!tt_global_init(bat_priv))
+	if (!tt_global_init(bat_priv)) {
+		tt_local_table_free(bat_priv);
 		return 0;
+	}
 
 	tt_start_timer(bat_priv);
 
-- 
1.7.10

