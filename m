Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Wed, 24 May 2017 12:32:11 +0200
Message-Id: <20170524103211.810-5-sven.eckelmann@openmesh.com>
In-Reply-To: <4690435.IOLn72U8Ez@bentobox>
References: <4690435.IOLn72U8Ez@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH 5/5] alfred: Cache the global translation
	table entries
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

There is a single loop which goes over all servers to find the originator
for each server. The originator usually doesn't change often because alfred
is usually started on the nodes which is already running batman-adv. It is
therefore not necessary to re-request the complete global translation table
from the kernel for each server in the server hash. Instead, the values can
be retrieved ones from the kernel during each sync interval, cached and
then retrieved from the cache again.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 batadv_query.c   | 117 +++++++++++++++++++++++++++++++++++++++++--------------
 batadv_query.h   |  11 +++++-
 batadv_querynl.c |  25 ++++--------
 batadv_querynl.h |   3 +-
 server.c         |  15 +++++--
 5 files changed, 118 insertions(+), 53 deletions(-)

diff --git a/batadv_query.c b/batadv_query.c
index 1123cf5..8580f1b 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -193,8 +193,7 @@ int batadv_interface_check(const char *mesh_iface)
 }
 
 static int translate_mac_debugfs(const char *mesh_iface,
-				 const struct ether_addr *mac,
-				 struct ether_addr *mac_out)
+				 struct hashtable_t *tg_hash)
 {
 	enum {
 		tg_start,
@@ -204,12 +203,12 @@ static int translate_mac_debugfs(const char *mesh_iface,
 	} pos;
 	char full_path[MAX_PATH+1];
 	struct ether_addr *mac_tmp;
+	struct ether_addr mac;
 	FILE *f = NULL;
 	size_t len = 0;
 	char *line = NULL;
 	char *input, *saveptr, *token;
 	int line_invalid;
-	bool found = false;
 
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_TRANSTABLE_GLOBAL,
 			  mesh_iface, full_path, sizeof(full_path));
@@ -235,11 +234,12 @@ static int translate_mac_debugfs(const char *mesh_iface,
 				break;
 			case tg_mac:
 				mac_tmp = ether_aton(token);
-				if (!mac_tmp || memcmp(mac_tmp, mac,
-						       ETH_ALEN) != 0)
+				if (!mac_tmp) {
 					line_invalid = 1;
-				else
+				} else {
+					memcpy(&mac, mac_tmp, sizeof(mac));
 					pos = tg_via;
+				}
 				break;
 			case tg_via:
 				if (strcmp(token, "via") == 0)
@@ -247,13 +247,10 @@ static int translate_mac_debugfs(const char *mesh_iface,
 				break;
 			case tg_originator:
 				mac_tmp = ether_aton(token);
-				if (!mac_tmp) {
+				if (!mac_tmp)
 					line_invalid = 1;
-				} else {
-					memcpy(mac_out, mac_tmp, ETH_ALEN);
-					found = true;
-					goto out;
-				}
+				else
+					tg_hash_add(tg_hash, &mac, mac_tmp);
 				break;
 			}
 
@@ -262,40 +259,100 @@ static int translate_mac_debugfs(const char *mesh_iface,
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
+static int tg_compare(void *d1, void *d2)
+{
+	struct tg_entry *s1 = d1, *s2 = d2;
+
+	if (memcmp(&s1->mac, &s2->mac, sizeof(s1->mac)) == 0)
+		return 1;
 	else
-		return -ENOENT;
+		return 0;
 }
 
-struct ether_addr *translate_mac(const char *mesh_iface,
-				 const struct ether_addr *mac)
+static int tg_choose(void *d1, int size)
 {
-	struct ether_addr in_mac;
-	static struct ether_addr out_mac;
-	struct ether_addr *mac_result;
+	struct tg_entry *s1 = d1;
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
+struct hashtable_t *tg_hash_new(const char *mesh_iface)
+{
+	struct hashtable_t *tg_hash;
 	int ret;
 
-	/* input mac has to be copied because it could be in the shared
-	 * ether_aton buffer
-	 */
-	memcpy(&in_mac, mac, sizeof(in_mac));
-	memcpy(&out_mac, mac, sizeof(out_mac));
-	mac_result = &out_mac;
+	tg_hash = hash_new(64, tg_compare, tg_choose);
+	if (!tg_hash)
+		return NULL;
 
 	enable_net_admin_capability(1);
-	ret = translate_mac_netlink(mesh_iface, &in_mac, mac_result);
+	ret = translate_mac_netlink(mesh_iface, tg_hash);
 	enable_net_admin_capability(0);
 
+	ret = -EOPNOTSUPP;
 	if (ret == -EOPNOTSUPP)
-		translate_mac_debugfs(mesh_iface, &in_mac, mac_result);
+		translate_mac_debugfs(mesh_iface, tg_hash);
+
+	return tg_hash;
+}
+
+void tg_hash_free(struct hashtable_t *tg_hash)
+{
+	hash_delete(tg_hash, free);
+}
+
+int tg_hash_add(struct hashtable_t *tg_hash, struct ether_addr *mac,
+		struct ether_addr *originator)
+{
+	struct tg_entry *n;
+
+	n = malloc(sizeof(*n));
+	if (!n)
+		return -ENOMEM;
+
+	n->mac = *mac;
+	n->originator = *originator;
+
+	if (hash_add(tg_hash, n)) {
+		free(n);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+struct ether_addr *translate_mac(struct hashtable_t *tg_hash,
+				 const struct ether_addr *mac)
+{
+	struct tg_entry search = {
+		.mac = *mac,
+	};
+	struct tg_entry *found;
+
+	found = hash_find(tg_hash, &search);
+	if (!found)
+		return 0;
 
-	return mac_result;
+	return &found->originator;
 }
 
 static int get_tq_debugfs(const char *mesh_iface, struct hashtable_t *orig_hash)
diff --git a/batadv_query.h b/batadv_query.h
index aa4d3f8..dc2b135 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -31,7 +31,16 @@ struct orig_entry {
 	uint8_t tq;
 };
 
-struct ether_addr *translate_mac(const char *mesh_iface,
+struct tg_entry {
+	struct ether_addr mac;
+	struct ether_addr originator;
+};
+
+struct hashtable_t *tg_hash_new(const char *mesh_iface);
+void tg_hash_free(struct hashtable_t *tg_hash);
+int tg_hash_add(struct hashtable_t *tg_hash, struct ether_addr *mac,
+		struct ether_addr *originator);
+struct ether_addr *translate_mac(struct hashtable_t *tg_hash,
 				 const struct ether_addr *mac);
 
 struct hashtable_t *orig_hash_new(const char *mesh_iface);
diff --git a/batadv_querynl.c b/batadv_querynl.c
index ba678ae..ca9ee2c 100644
--- a/batadv_querynl.c
+++ b/batadv_querynl.c
@@ -49,8 +49,7 @@ static const int translate_mac_netlink_mandatory[] = {
 };
 
 struct translate_mac_netlink_opts {
-	struct ether_addr mac;
-	bool found;
+	struct hashtable_t *tg_hash;
 	struct nlquery_opts query_opts;
 };
 
@@ -61,6 +60,8 @@ static int translate_mac_netlink_cb(struct nl_msg *msg, void *arg)
 	struct nlquery_opts *query_opts = arg;
 	struct translate_mac_netlink_opts *opts;
 	struct genlmsghdr *ghdr;
+	struct ether_addr mac_addr;
+	struct ether_addr mac_orig;
 	uint8_t *addr;
 	uint8_t *orig;
 
@@ -90,40 +91,30 @@ static int translate_mac_netlink_cb(struct nl_msg *msg, void *arg)
 	if (!attrs[BATADV_ATTR_FLAG_BEST])
 		return NL_OK;
 
-	if (memcmp(&opts->mac, addr, ETH_ALEN) != 0)
-		return NL_OK;
-
-	memcpy(&opts->mac, orig, ETH_ALEN);
-	opts->found = true;
+	memcpy(&mac_addr, addr, sizeof(mac_addr));
+	memcpy(&mac_orig, orig, sizeof(mac_orig));
+	tg_hash_add(opts->tg_hash, &mac_addr, &mac_orig);
 	opts->query_opts.err = 0;
 
 	return NL_STOP;
 }
 
-int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
-			  struct ether_addr *mac_out)
+int translate_mac_netlink(const char *mesh_iface, struct hashtable_t *tg_hash)
 {
 	struct translate_mac_netlink_opts opts = {
-		.found = false,
+		.tg_hash = tg_hash,
 		.query_opts = {
 			.err = 0,
 		},
 	};
 	int ret;
 
-	memcpy(&opts.mac, mac, ETH_ALEN);
-
 	ret = netlink_query_common(mesh_iface,
 				   BATADV_CMD_GET_TRANSTABLE_GLOBAL,
 				   translate_mac_netlink_cb, &opts.query_opts);
 	if (ret < 0)
 		return ret;
 
-	if (!opts.found)
-		return -ENOENT;
-
-	memcpy(mac_out, &opts.mac, ETH_ALEN);
-
 	return 0;
 }
 
diff --git a/batadv_querynl.h b/batadv_querynl.h
index f5c7e38..4b42ed5 100644
--- a/batadv_querynl.h
+++ b/batadv_querynl.h
@@ -27,8 +27,7 @@
 struct ether_addr;
 struct hashtable_t;
 
-int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
-			  struct ether_addr *mac_out);
+int translate_mac_netlink(const char *mesh_iface, struct hashtable_t *tg_hash);
 int get_tq_netlink(const char *mesh_iface, struct hashtable_t *orig_hash);
 int batadv_interface_check_netlink(const char *mesh_iface);
 
diff --git a/server.c b/server.c
index 91aa729..f28c89a 100644
--- a/server.c
+++ b/server.c
@@ -223,6 +223,7 @@ static void update_server_info(struct globals *globals)
 	struct hash_it_t *hashit = NULL;
 	struct interface *interface;
 	struct ether_addr *macaddr;
+	struct hashtable_t *tg_hash;
 	struct hashtable_t *orig_hash;
 
 	/* TQ is not used for master sync mode */
@@ -230,10 +231,16 @@ static void update_server_info(struct globals *globals)
 		return;
 
 	if (strcmp(globals->mesh_iface, "none") != 0) {
+		tg_hash = tg_hash_new(globals->mesh_iface);
+		if (!globals->data_hash) {
+			fprintf(stderr, "Failed to translation hash\n");
+			return;
+		}
+
 		orig_hash = orig_hash_new(globals->mesh_iface);
 		if (!globals->data_hash) {
 			fprintf(stderr, "Failed to originator hash\n");
-			return;
+			goto free_tg_hash;
 		}
 	}
 
@@ -247,8 +254,7 @@ static void update_server_info(struct globals *globals)
 				continue;
 			}
 
-			macaddr = translate_mac(globals->mesh_iface,
-						&server->hwaddr);
+			macaddr = translate_mac(tg_hash, &server->hwaddr);
 			if (macaddr)
 				server->tq = get_tq(orig_hash, macaddr);
 			else
@@ -260,6 +266,9 @@ static void update_server_info(struct globals *globals)
 
 	if (orig_hash)
 		orig_hash_free(orig_hash);
+free_tg_hash:
+	if (tg_hash)
+		tg_hash_free(tg_hash);
 }
 
 static void check_if_socket(struct interface *interface, struct globals *globals)
-- 
2.11.0

