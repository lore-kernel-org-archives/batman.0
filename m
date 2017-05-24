Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Wed, 24 May 2017 12:32:10 +0200
Message-Id: <20170524103211.810-4-sven.eckelmann@openmesh.com>
In-Reply-To: <4690435.IOLn72U8Ez@bentobox>
References: <4690435.IOLn72U8Ez@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] alfred: Cache the TQ values for each
	originator
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

There is a single loop which goes over all servers to find the TQs for each
server. The TQ value doesn't change often and it is relative unlikely that
it is different after some milliseconds. It is therefore not necessary to
re-request the TQ values from the kernel for each server in the server
hash. Instead, the values can be retrieved ones from the kernel during each
sync interval, cached and then retrieved from the cache again.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 batadv_query.c   | 108 ++++++++++++++++++++++++++++++++++++++++++-------------
 batadv_query.h   |  14 +++++++-
 batadv_querynl.c |  29 +++++----------
 batadv_querynl.h |   4 +--
 server.c         |  17 +++++++--
 5 files changed, 121 insertions(+), 51 deletions(-)

diff --git a/batadv_query.c b/batadv_query.c
index e68052b..1123cf5 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -298,8 +298,7 @@ struct ether_addr *translate_mac(const char *mesh_iface,
 	return mac_result;
 }
 
-static int get_tq_debugfs(const char *mesh_iface, struct ether_addr *mac,
-			  uint8_t *tq)
+static int get_tq_debugfs(const char *mesh_iface, struct hashtable_t *orig_hash)
 {
 	enum {
 		orig_mac,
@@ -308,16 +307,13 @@ static int get_tq_debugfs(const char *mesh_iface, struct ether_addr *mac,
 		orig_tqvalue,
 	} pos;
 	char full_path[MAX_PATH + 1];
-	static struct ether_addr in_mac;
 	struct ether_addr *mac_tmp;
 	FILE *f = NULL;
 	size_t len = 0;
 	char *line = NULL;
 	char *input, *saveptr, *token;
 	int line_invalid;
-	bool found = false;
-
-	memcpy(&in_mac, mac, sizeof(in_mac));
+	uint8_t tq;
 
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_ORIGINATORS,
 			  mesh_iface, full_path, sizeof(full_path));
@@ -337,8 +333,7 @@ static int get_tq_debugfs(const char *mesh_iface, struct ether_addr *mac,
 			switch (pos) {
 			case orig_mac:
 				mac_tmp = ether_aton(token);
-				if (!mac_tmp || memcmp(mac_tmp, &in_mac,
-						       sizeof(in_mac)) != 0)
+				if (!mac_tmp)
 					line_invalid = 1;
 				else
 					pos = orig_lastseen;
@@ -365,9 +360,8 @@ static int get_tq_debugfs(const char *mesh_iface, struct ether_addr *mac,
 					line_invalid = 1;
 				} else {
 					token[strlen(token) - 1] = '\0';
-					*tq = strtol(token, NULL, 10);
-					found = true;
-					goto out;
+					tq = strtol(token, NULL, 10);
+					orig_hash_add(orig_hash, mac_tmp, tq);
 				}
 				break;
 			}
@@ -377,34 +371,98 @@ static int get_tq_debugfs(const char *mesh_iface, struct ether_addr *mac,
 		}
 	}
 
-out:
 	if (f)
 		fclose(f);
 	free(line);
 
-	if (found)
-		return 0;
+	return 0;
+}
+
+static int orig_compare(void *d1, void *d2)
+{
+	struct orig_entry *s1 = d1, *s2 = d2;
+
+	if (memcmp(&s1->mac, &s2->mac, sizeof(s1->mac)) == 0)
+		return 1;
 	else
-		return -ENOENT;
+		return 0;
 }
 
-uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac)
+static int orig_choose(void *d1, int size)
 {
-	struct ether_addr in_mac;
-	uint8_t tq = 0;
+	struct orig_entry *s1 = d1;
+	uint32_t hash = 0;
+	size_t i;
+
+	for (i = 0; i < sizeof(s1->mac); i++) {
+		hash += s1->mac.ether_addr_octet[i];
+		hash += (hash << 10);
+		hash ^= (hash >> 6);
+	}
+
+	hash += (hash << 3);
+	hash ^= (hash >> 11);
+	hash += (hash << 15);
+
+	return hash % size;
+}
+
+struct hashtable_t *orig_hash_new(const char *mesh_iface)
+{
+	struct hashtable_t *orig_hash;
 	int ret;
 
-	/* input mac has to be copied because it could be in the shared
-	 * ether_aton buffer
-	 */
-	memcpy(&in_mac, mac, sizeof(in_mac));
+	orig_hash = hash_new(64, orig_compare, orig_choose);
+	if (!orig_hash)
+		return NULL;
 
 	enable_net_admin_capability(1);
-	ret = get_tq_netlink(mesh_iface, &in_mac, &tq);
+	ret = get_tq_netlink(mesh_iface, orig_hash);
 	enable_net_admin_capability(0);
 
+	ret = -EOPNOTSUPP;
 	if (ret == -EOPNOTSUPP)
-		get_tq_debugfs(mesh_iface, &in_mac, &tq);
+		get_tq_debugfs(mesh_iface, orig_hash);
+
+	return orig_hash;
+}
+
+void orig_hash_free(struct hashtable_t *orig_hash)
+{
+	hash_delete(orig_hash, free);
+}
+
+int orig_hash_add(struct hashtable_t *orig_hash, struct ether_addr *mac,
+		  uint8_t tq)
+{
+	struct orig_entry *n;
+
+	n = malloc(sizeof(*n));
+	if (!n)
+		return -ENOMEM;
+
+	n->mac = *mac;
+	n->tq = tq;
+
+	if (hash_add(orig_hash, n)) {
+		free(n);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+uint8_t get_tq(struct hashtable_t *orig_hash, struct ether_addr *mac)
+{
+	struct orig_entry search = {
+		.mac = *mac,
+		.tq = 0,
+	};
+	struct orig_entry *found;
+
+	found = hash_find(orig_hash, &search);
+	if (!found)
+		return 0;
 
-	return tq;
+	return found->tq;
 }
diff --git a/batadv_query.h b/batadv_query.h
index 9aa4f0e..aa4d3f8 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -24,9 +24,21 @@
 #include <stdint.h>
 #include <netinet/in.h>
 
+#include "hash.h"
+
+struct orig_entry {
+	struct ether_addr mac;
+	uint8_t tq;
+};
+
 struct ether_addr *translate_mac(const char *mesh_iface,
 				 const struct ether_addr *mac);
-uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac);
+
+struct hashtable_t *orig_hash_new(const char *mesh_iface);
+void orig_hash_free(struct hashtable_t *orig_hash);
+int orig_hash_add(struct hashtable_t *orig_hash, struct ether_addr *mac,
+		  uint8_t tq);
+uint8_t get_tq(struct hashtable_t *orig_hash, struct ether_addr *mac);
 int batadv_interface_check(const char *mesh_iface);
 int mac_to_ipv6(const struct ether_addr *mac, alfred_addr *addr);
 int ipv6_to_mac(const alfred_addr *addr, struct ether_addr *mac);
diff --git a/batadv_querynl.c b/batadv_querynl.c
index 8dab96e..ba678ae 100644
--- a/batadv_querynl.c
+++ b/batadv_querynl.c
@@ -34,7 +34,9 @@
 #include <netlink/genl/ctrl.h>
 #include <net/ethernet.h>
 
+#include "alfred.h"
 #include "batman_adv.h"
+#include "batadv_query.h"
 #include "netlink.h"
 
 #ifndef __unused
@@ -131,9 +133,7 @@ static const int get_tq_netlink_mandatory[] = {
 };
 
 struct get_tq_netlink_opts {
-	struct ether_addr mac;
-	uint8_t tq;
-	bool found;
+	struct hashtable_t *orig_hash;
 	struct nlquery_opts query_opts;
 };
 
@@ -145,6 +145,7 @@ static int get_tq_netlink_cb(struct nl_msg *msg, void *arg)
 	struct get_tq_netlink_opts *opts;
 	struct genlmsghdr *ghdr;
 	uint8_t *orig;
+	struct ether_addr mac;
 	uint8_t tq;
 
 	opts = container_of(query_opts, struct get_tq_netlink_opts,
@@ -173,40 +174,28 @@ static int get_tq_netlink_cb(struct nl_msg *msg, void *arg)
 	if (!attrs[BATADV_ATTR_FLAG_BEST])
 		return NL_OK;
 
-	if (memcmp(&opts->mac, orig, ETH_ALEN) != 0)
-		return NL_OK;
-
-	opts->tq = tq;
-	opts->found = true;
+	memcpy(&mac, orig, sizeof(mac));
+	orig_hash_add(opts->orig_hash, &mac, tq);
 	opts->query_opts.err = 0;
 
-	return NL_STOP;
+	return NL_OK;
 }
 
-int get_tq_netlink(const char *mesh_iface, const struct ether_addr *mac,
-		   uint8_t *tq)
+int get_tq_netlink(const char *mesh_iface, struct hashtable_t *orig_hash)
 {
 	struct get_tq_netlink_opts opts = {
-		.tq = 0,
-		.found = false,
+		.orig_hash = orig_hash,
 		.query_opts = {
 			.err = 0,
 		},
 	};
 	int ret;
 
-	memcpy(&opts.mac, mac, ETH_ALEN);
-
 	ret = netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINATORS,
 				   get_tq_netlink_cb, &opts.query_opts);
 	if (ret < 0)
 		return ret;
 
-	if (!opts.found)
-		return -ENOENT;
-
-	*tq = opts.tq;
-
 	return 0;
 }
 
diff --git a/batadv_querynl.h b/batadv_querynl.h
index 9b93a47..f5c7e38 100644
--- a/batadv_querynl.h
+++ b/batadv_querynl.h
@@ -25,11 +25,11 @@
 #include <stdint.h>
 
 struct ether_addr;
+struct hashtable_t;
 
 int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
 			  struct ether_addr *mac_out);
-int get_tq_netlink(const char *mesh_iface, const struct ether_addr *mac,
-		   uint8_t *tq);
+int get_tq_netlink(const char *mesh_iface, struct hashtable_t *orig_hash);
 int batadv_interface_check_netlink(const char *mesh_iface);
 
 #endif /* _BATADV_QUERYNL_H */
diff --git a/server.c b/server.c
index 09acb80..91aa729 100644
--- a/server.c
+++ b/server.c
@@ -223,17 +223,26 @@ static void update_server_info(struct globals *globals)
 	struct hash_it_t *hashit = NULL;
 	struct interface *interface;
 	struct ether_addr *macaddr;
+	struct hashtable_t *orig_hash;
 
 	/* TQ is not used for master sync mode */
 	if (globals->opmode == OPMODE_MASTER)
 		return;
 
+	if (strcmp(globals->mesh_iface, "none") != 0) {
+		orig_hash = orig_hash_new(globals->mesh_iface);
+		if (!globals->data_hash) {
+			fprintf(stderr, "Failed to originator hash\n");
+			return;
+		}
+	}
+
 	list_for_each_entry(interface, &globals->interfaces, list) {
 		while (NULL != (hashit = hash_iterate(interface->server_hash,
 						      hashit))) {
 			struct server *server = hashit->bucket->data;
 
-			if (strcmp(globals->mesh_iface, "none") == 0) {
+			if (!orig_hash) {
 				server->tq = 255;
 				continue;
 			}
@@ -241,14 +250,16 @@ static void update_server_info(struct globals *globals)
 			macaddr = translate_mac(globals->mesh_iface,
 						&server->hwaddr);
 			if (macaddr)
-				server->tq = get_tq(globals->mesh_iface,
-						    macaddr);
+				server->tq = get_tq(orig_hash, macaddr);
 			else
 				server->tq = 0;
 		}
 	}
 
 	set_best_server(globals);
+
+	if (orig_hash)
+		orig_hash_free(orig_hash);
 }
 
 static void check_if_socket(struct interface *interface, struct globals *globals)
-- 
2.11.0

