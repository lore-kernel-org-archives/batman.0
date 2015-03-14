Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Mar 2015 12:42:48 +0100
Message-Id: <1426333379-17777-4-git-send-email-sven@narfation.org>
In-Reply-To: <1426333379-17777-1-git-send-email-sven@narfation.org>
References: <1426333379-17777-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 03/14] alfred: Reduce number of lines with
	more than 80 chars
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
 batadv_query.h |  3 ++-
 client.c       |  4 +++-
 hash.c         | 13 +++++++------
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/batadv_query.h b/batadv_query.h
index 6b938ea..8991ee9 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -24,7 +24,8 @@
 #include <stdint.h>
 #include <netinet/in.h>
 
-struct ether_addr *translate_mac(const char *mesh_iface, struct ether_addr *mac);
+struct ether_addr *translate_mac(const char *mesh_iface,
+				 struct ether_addr *mac);
 uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac);
 int batadv_interface_check(const char *mesh_iface);
 int mac_to_ipv6(const struct ether_addr *mac, struct in6_addr *addr);
diff --git a/client.c b/client.c
index 42dd4ad..f68a5b0 100644
--- a/client.c
+++ b/client.c
@@ -265,11 +265,13 @@ int alfred_client_change_interface(struct globals *globals)
 	struct alfred_change_interface_v0 *change_interface;
 	int ret, len;
 	char *input, *token, *saveptr;
+	size_t interface_len;
 
 	if (unix_sock_open_client(globals))
 		return -1;
 
-	if (strlen(globals->change_interface) > sizeof(change_interface->ifaces)) {
+	interface_len = strlen(globals->change_interface);
+	if (interface_len > sizeof(change_interface->ifaces)) {
 		fprintf(stderr, "%s: interface name list too long, not changing\n",
 			__func__);
 		return 0;
diff --git a/hash.c b/hash.c
index 685842f..a53bb9c 100644
--- a/hash.c
+++ b/hash.c
@@ -292,12 +292,13 @@ void *hash_remove(struct hashtable_t *hash, void *data)
 
 	while (hash_it_t.bucket != NULL) {
 		if (hash->compare(hash_it_t.bucket->data, data)) {
-			int bucket_same;
-			bucket_same = (hash_it_t.bucket ==
-				       hash->table[hash_it_t.index]);
-			hash_it_t.first_bucket = (bucket_same ?
-						  &hash->table[hash_it_t.index] :
-						  NULL);
+			struct element_t **first_bucket = NULL;
+
+			if (hash_it_t.bucket == hash->table[hash_it_t.index])
+				first_bucket = &hash->table[hash_it_t.index];
+
+			hash_it_t.first_bucket = first_bucket;
+
 			return hash_remove_bucket(hash, &hash_it_t);
 		}
 
-- 
2.1.4

