Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 23 Nov 2017 13:21:42 +0100
Message-Id: <20171123122142.2968-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Handle failure during hash iterator
 allocation
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

From: Sven Eckelmann <sven@narfation.org>

The hash_iterate functions should not try to start the iteration when the
iterator could not be allocated.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 hash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hash.c b/hash.c
index 5a3cdef..116e46f 100644
--- a/hash.c
+++ b/hash.c
@@ -116,6 +116,9 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 
 	if (!iter_in) {
 		iter = debugMalloc(sizeof(struct hash_it_t), 301);
+		if (!iter)
+			return NULL;
+
 		iter->index =  -1;
 		iter->bucket = NULL;
 		iter->prev_bucket = NULL;
-- 
2.11.0

