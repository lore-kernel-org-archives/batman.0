Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 Nov 2015 09:41:41 +0100
Message-Id: <1447836101-17282-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix variable declaration warning
	in batadv_compare_tt
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

checkpatch is warning about the wrong way a pointer is declared in
batadv_compare_tt.

    ERROR: "foo* bar" should be "foo *bar"
    #80: FILE: ./net/batman-adv/translation-table.c:80:
    +	const struct batadv_tt_common_entry* tt1 = data1;

Fixes: af5fa950cbb6 ("batman-adv: fix erroneous client entry duplicate detection")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 92af58b..c02f68e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -77,8 +77,8 @@ static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
 {
 	const void *data1 = container_of(node, struct batadv_tt_common_entry,
 					 hash_entry);
-	const struct batadv_tt_common_entry* tt1 = data1;
-	const struct batadv_tt_common_entry* tt2 = data2;
+	const struct batadv_tt_common_entry *tt1 = data1;
+	const struct batadv_tt_common_entry *tt2 = data2;
 
 	return (tt1->vid == tt2->vid) && batadv_compare_eth(data1, data2);
 }
-- 
2.6.2

