Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Mar 2015 12:42:46 +0100
Message-Id: <1426333379-17777-2-git-send-email-sven@narfation.org>
In-Reply-To: <1426333379-17777-1-git-send-email-sven@narfation.org>
References: <1426333379-17777-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/14] alfred: Add spaces around operators
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batadv_query.c | 6 +++---
 hash.c         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/batadv_query.c b/batadv_query.c
index 473ab40..2a607b9 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -91,7 +91,7 @@ int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac)
 int batadv_interface_check(const char *mesh_iface)
 {
 	char *debugfs_mnt;
-	char full_path[MAX_PATH+1];
+	char full_path[MAX_PATH + 1];
 	FILE *f;
 
 	debugfs_mnt = debugfs_mount(NULL);
@@ -133,7 +133,7 @@ struct ether_addr *translate_mac(const char *mesh_iface, struct ether_addr *mac)
 		tg_via,
 		tg_originator,
 	} pos;
-	char full_path[MAX_PATH+1];
+	char full_path[MAX_PATH + 1];
 	char *debugfs_mnt;
 	static struct ether_addr in_mac;
 	struct ether_addr *mac_result, *mac_tmp;
@@ -215,7 +215,7 @@ uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac)
 		orig_tqstart,
 		orig_tqvalue,
 	} pos;
-	char full_path[MAX_PATH+1];
+	char full_path[MAX_PATH + 1];
 	char *debugfs_mnt;
 	static struct ether_addr in_mac;
 	struct ether_addr *mac_tmp;
diff --git a/hash.c b/hash.c
index 87e8484..685842f 100644
--- a/hash.c
+++ b/hash.c
@@ -204,7 +204,7 @@ struct hashtable_t *hash_new(int size, hashdata_compare_cb compare,
 		return NULL;
 
 	hash->size = size;
-	hash->table = debugMalloc(sizeof(struct element_t *)*size, 303);
+	hash->table = debugMalloc(sizeof(struct element_t *) * size, 303);
 
 	if (!hash->table) {
 		debugFree(hash, 1305);
-- 
2.1.4

