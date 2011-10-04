Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  5 Oct 2011 00:12:04 +0200
Message-Id: <1317766324-28264-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fixed hash functions type to
	uint32_t instead of int
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

In choose_orig and vis_choose the size agrument was int while the hash
result is uint32_t, then the argument has been fixed to uint32_t too.
The same apply for the returned type.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 hash.h       |    2 +-
 originator.h |    2 +-
 vis.c        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hash.h b/hash.h
index d20aa71..588ef79 100644
--- a/hash.h
+++ b/hash.h
@@ -33,7 +33,7 @@ typedef int (*hashdata_compare_cb)(const struct hlist_node *, const void *);
 /* the hashfunction, should return an index
  * based on the key in the data of the first
  * argument and the size the second */
-typedef int (*hashdata_choose_cb)(const void *, int);
+typedef uint32_t (*hashdata_choose_cb)(const void *, uint32_t);
 typedef void (*hashdata_free_cb)(struct hlist_node *, void *);
 
 struct hashtable_t {
diff --git a/originator.h b/originator.h
index cfc1f60..67765ff 100644
--- a/originator.h
+++ b/originator.h
@@ -42,7 +42,7 @@ int orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num);
 
 /* hashfunction to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
-static inline int choose_orig(const void *data, int32_t size)
+static inline uint32_t choose_orig(const void *data, uint32_t size)
 {
 	const unsigned char *key = data;
 	uint32_t hash = 0;
diff --git a/vis.c b/vis.c
index f81a6b6..a9cd152 100644
--- a/vis.c
+++ b/vis.c
@@ -66,7 +66,7 @@ static int vis_info_cmp(const struct hlist_node *node, const void *data2)
 
 /* hash function to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
-static int vis_info_choose(const void *data, int size)
+static uint32_t vis_info_choose(const void *data, uint32_t size)
 {
 	const struct vis_info *vis_info = data;
 	const struct vis_packet *packet;
-- 
1.7.3.4

