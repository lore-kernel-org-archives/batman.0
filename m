Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Jan 2011 22:47:35 +0100
Message-Id: <1296337660-12376-9-git-send-email-sven@narfation.org>
In-Reply-To: <1296337660-12376-1-git-send-email-sven@narfation.org>
References: <1296337660-12376-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/13] batman-adv: Remove dangling
	declaration of hash_remove_element
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hash.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 09216ad..2f508e6 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -49,11 +49,6 @@ struct hashtable_t {
 /* allocates and clears the hash */
 struct hashtable_t *hash_new(int size);
 
-/* remove element if you already found the element you want to delete and don't
- * need the overhead to find it again with hash_remove().  But usually, you
- * don't want to use this function, as it fiddles with hash-internals. */
-void *hash_remove_element(struct hashtable_t *hash, struct element_t *elem);
-
 /* free only the hashtable and the hash itself. */
 void hash_destroy(struct hashtable_t *hash);
 
-- 
1.7.2.3

