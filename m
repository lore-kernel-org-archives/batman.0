Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 Jun 2014 21:56:02 +0200
Message-Id: <1403034964-6737-5-git-send-email-sven@narfation.org>
In-Reply-To: <1403034964-6737-1-git-send-email-sven@narfation.org>
References: <1403034964-6737-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/7] batmand: Don't cause NULL ptr
	dereference when searching through HNAs
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
Cc: Sven Eckelmann <sven@narfation.org>

The _hna_global_add function searches through the list of HNAs to check if
there is already a hna for this orig pointer. Otherwise it is automatically
allocated.

This was implemented by setting hna_orig_ptr to NULL after the comparison. This
will most likely crash the program because the list_for_each_entry
implementation uses hna_orig_ptr to find the next entry before doing the loop
condition check. The next entry cannot be found by dereferencing NULL+epsilon.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 hna.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hna.c b/hna.c
index f0d64e1..0f28bfe 100644
--- a/hna.c
+++ b/hna.c
@@ -322,6 +322,7 @@ static void _hna_global_add(struct orig_node *orig_node, struct hna_element *hna
 	struct hna_orig_ptr *hna_orig_ptr = NULL;
 	struct orig_node *old_orig_node = NULL;
 	struct hashtable_t *swaphash;
+	int found = 0;
 
 	hna_global_entry = ((struct hna_global_entry *)hash_find(hna_global_hash, hna_element));
 
@@ -354,14 +355,14 @@ static void _hna_global_add(struct orig_node *orig_node, struct hna_element *hna
 		return;
 
 	list_for_each_entry(hna_orig_ptr, &hna_global_entry->orig_list, list) {
-		if (hna_orig_ptr->orig_node == orig_node)
+		if (hna_orig_ptr->orig_node == orig_node) {
+			found = 1;
 			break;
-
-		hna_orig_ptr = NULL;
+		}
 	}
 
 	/* append the given orig node to the list */
-	if (!hna_orig_ptr) {
+	if (!found) {
 		hna_orig_ptr = debugMalloc(sizeof(struct hna_orig_ptr), 704);
 
 		if (!hna_orig_ptr)
-- 
2.0.0

