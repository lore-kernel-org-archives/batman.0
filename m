Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 23 Nov 2017 15:04:36 +0100
Message-Id: <20171123140444.17119-3-sven.eckelmann@openmesh.com>
In-Reply-To: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
References: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 02/10] batctl: Handle failure during
 hash_iterator allocation
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

The iterator functions should not try to start the iteration when the
iterator could not be allocated.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 hash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hash.c b/hash.c
index f4a7af7..0e4d1e3 100644
--- a/hash.c
+++ b/hash.c
@@ -120,6 +120,9 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 
 	if (iter_in == NULL) {
 		iter = debugMalloc(sizeof(struct hash_it_t), 301);
+		if (!iter)
+			return NULL;
+
 		iter->index =  -1;
 		iter->bucket = NULL;
 		iter->prev_bucket = NULL;
-- 
2.11.0

