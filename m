Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  8 Jun 2011 22:33:53 +0200
Message-Id: <1307565233-15101-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove cast after kmalloc
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

Casting (void *) value returned by kmalloc is useless as mentioned in
Documentation/CodingStyle, Chap 14.

This regression was introduced in
cea194d90b11aff7fc289149e4c7f305fad3535a

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 translation-table.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index d2a9f80..adecf1b 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -148,8 +148,7 @@ static void tt_local_event(struct bat_priv *bat_priv, uint8_t op,
 {
 	struct tt_change_node *tt_change_node;
 
-	tt_change_node = (struct tt_change_node *)
-		kmalloc(sizeof(*tt_change_node), GFP_ATOMIC);
+	tt_change_node = kmalloc(sizeof(*tt_change_node), GFP_ATOMIC);
 
 	if (!tt_change_node)
 		return;
-- 
1.7.5.3

