Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Wed, 12 Nov 2014 14:54:30 +0100
Message-Id: <1415800470-10114-2-git-send-email-sven@open-mesh.com>
In-Reply-To: <1415800470-10114-1-git-send-email-sven@open-mesh.com>
References: <1415800470-10114-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] alfred: Synchronize data only over
	correct interfaces
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
Cc: Sven Eckelmann <sven@open-mesh.com>

The server announcements are received over a specific interface. It is enough
to synchronize data through the interface where an announcement was received.
It only increases the overhead by alfred when sending data over an interface to
an server without knowing that he is also reachable over it.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 alfred.h  |  3 ++-
 netsock.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
 recv.c    |  8 +++++---
 send.c    |  2 +-
 server.c  | 69 +++++++++++++++++++++------------------------------------------
 5 files changed, 77 insertions(+), 52 deletions(-)

diff --git a/alfred.h b/alfred.h
index cf94af4..05ac870 100644
--- a/alfred.h
+++ b/alfred.h
@@ -98,6 +98,8 @@ struct interface {
 	char *interface;
 	int netsock;
 
+	struct hashtable_t *server_hash;
+
 	struct list_head list;
 };
 
@@ -117,7 +119,6 @@ struct globals {
 
 	struct timespec if_check;
 
-	struct hashtable_t *server_hash;
 	struct hashtable_t *data_hash;
 	struct hashtable_t *transaction_hash;
 };
diff --git a/netsock.c b/netsock.c
index 703334f..45c03e9 100644
--- a/netsock.c
+++ b/netsock.c
@@ -28,20 +28,52 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/ioctl.h>
-#include <sys/socket.h>
 #include <unistd.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <sys/types.h>
 #include <stdlib.h>
 #include <sys/select.h>
 #include "alfred.h"
 #include "batadv_query.h"
 #include "packet.h"
 #include "list.h"
+#include "hash.h"
 
 const struct in6_addr in6addr_localmcast = {{{ 0xff, 0x02, 0x00, 0x00,
 					       0x00, 0x00, 0x00, 0x00,
 					       0x00, 0x00, 0x00, 0x00,
 					       0x00, 0x00, 0x00, 0x01 } } };
 
+static int server_compare(void *d1, void *d2)
+{
+	struct server *s1 = d1, *s2 = d2;
+	/* compare source and type */
+	if (memcmp(&s1->hwaddr, &s2->hwaddr, sizeof(s1->hwaddr)) == 0)
+		return 1;
+	else
+		return 0;
+}
+
+static int server_choose(void *d1, int size)
+{
+	struct server *s1 = d1;
+	uint32_t hash = 0;
+	size_t i;
+
+	for (i = 0; i < sizeof(s1->hwaddr); i++) {
+		hash += s1->hwaddr.ether_addr_octet[i];
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
 void netsock_close_all(struct globals *globals)
 {
 	struct interface *interface, *is;
@@ -50,9 +82,12 @@ void netsock_close_all(struct globals *globals)
 		if (interface->netsock >= 0)
 			close(interface->netsock);
 		list_del(&interface->list);
+		hash_delete(interface->server_hash, free);
 		free(interface->interface);
 		free(interface);
 	}
+
+	globals->best_server = NULL;
 }
 
 struct interface *netsock_first_interface(struct globals *globals)
@@ -106,6 +141,7 @@ int netsock_set_interfaces(struct globals *globals, char *interfaces)
 		interface->scope_id = 0;
 		interface->interface = NULL;
 		interface->netsock = -1;
+		interface->server_hash = NULL;
 
 		interface->interface = strdup(token);
 		if (!interface->interface) {
@@ -114,6 +150,15 @@ int netsock_set_interfaces(struct globals *globals, char *interfaces)
 			return -ENOMEM;
 		}
 
+		interface->server_hash = hash_new(64, server_compare,
+						  server_choose);
+		if (!interface->server_hash) {
+			free(interface->interface);
+			free(interface);
+			netsock_close_all(globals);
+			return -ENOMEM;
+		}
+
 		list_add(&interface->list, &globals->interfaces);
 	}
 
diff --git a/recv.c b/recv.c
index 6a257d7..90db0b3 100644
--- a/recv.c
+++ b/recv.c
@@ -231,6 +231,7 @@ err:
 
 static int
 process_alfred_announce_master(struct globals *globals,
+			       struct interface *interface,
 			       struct in6_addr *source,
 			       struct alfred_announce_master_v0 *announce)
 {
@@ -252,7 +253,7 @@ process_alfred_announce_master(struct globals *globals,
 	if (len != (sizeof(*announce) - sizeof(announce->header)))
 		return -1;
 
-	server = hash_find(globals->server_hash, &mac);
+	server = hash_find(interface->server_hash, &mac);
 	if (!server) {
 		server = malloc(sizeof(*server));
 		if (!server)
@@ -261,7 +262,7 @@ process_alfred_announce_master(struct globals *globals,
 		memcpy(&server->hwaddr, &mac, ETH_ALEN);
 		memcpy(&server->address, source, sizeof(*source));
 
-		if (hash_add(globals->server_hash, server)) {
+		if (hash_add(interface->server_hash, server)) {
 			free(server);
 			return -1;
 		}
@@ -414,7 +415,8 @@ int recv_alfred_packet(struct globals *globals, struct interface *interface)
 					 (struct alfred_push_data_v0 *)packet);
 		break;
 	case ALFRED_ANNOUNCE_MASTER:
-		process_alfred_announce_master(globals, &source.sin6_addr,
+		process_alfred_announce_master(globals, interface,
+					       &source.sin6_addr,
 					       (struct alfred_announce_master_v0 *)packet);
 		break;
 	case ALFRED_REQUEST:
diff --git a/send.c b/send.c
index c1379bd..19cc867 100644
--- a/send.c
+++ b/send.c
@@ -134,7 +134,7 @@ int sync_data(struct globals *globals)
 
 	/* send local data and data from our clients to (all) other servers */
 	list_for_each_entry(interface, &globals->interfaces, list) {
-		while (NULL != (hashit = hash_iterate(globals->server_hash,
+		while (NULL != (hashit = hash_iterate(interface->server_hash,
 						      hashit))) {
 			struct server *server = hashit->bucket->data;
 
diff --git a/server.c b/server.c
index e45bc8a..66809d9 100644
--- a/server.c
+++ b/server.c
@@ -40,35 +40,6 @@
 #include "hash.h"
 #include "list.h"
 
-static int server_compare(void *d1, void *d2)
-{
-	struct server *s1 = d1, *s2 = d2;
-	/* compare source and type */
-	if (memcmp(&s1->hwaddr, &s2->hwaddr, sizeof(s1->hwaddr)) == 0)
-		return 1;
-	else
-		return 0;
-}
-
-static int server_choose(void *d1, int size)
-{
-	struct server *s1 = d1;
-	uint32_t hash = 0;
-	size_t i;
-
-	for (i = 0; i < sizeof(s1->hwaddr); i++) {
-		hash += s1->hwaddr.ether_addr_octet[i];
-		hash += (hash << 10);
-		hash ^= (hash >> 6);
-	}
-
-	hash += (hash << 3);
-	hash ^= (hash >> 11);
-	hash += (hash << 15);
-
-	return hash % size;
-}
-
 static int data_compare(void *d1, void *d2)
 {
 	/* compare source and type */
@@ -135,11 +106,9 @@ static int tx_choose(void *d1, int size)
 
 static int create_hashes(struct globals *globals)
 {
-	globals->server_hash = hash_new(64, server_compare, server_choose);
 	globals->data_hash = hash_new(128, data_compare, data_choose);
 	globals->transaction_hash = hash_new(64, tx_compare, tx_choose);
-	if (!globals->server_hash || !globals->data_hash ||
-	    !globals->transaction_hash)
+	if (!globals->data_hash || !globals->transaction_hash)
 		return -1;
 
 	return 0;
@@ -150,13 +119,17 @@ int set_best_server(struct globals *globals)
 	struct hash_it_t *hashit = NULL;
 	struct server *best_server = NULL;
 	int best_tq = -1;
+	struct interface *interface;
 
-	while (NULL != (hashit = hash_iterate(globals->server_hash, hashit))) {
-		struct server *server = hashit->bucket->data;
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		while (NULL != (hashit = hash_iterate(interface->server_hash,
+						      hashit))) {
+			struct server *server = hashit->bucket->data;
 
-		if (server->tq > best_tq) {
-			best_tq = server->tq;
-			best_server = server;
+			if (server->tq > best_tq) {
+				best_tq = server->tq;
+				best_server = server;
+			}
 		}
 	}
 
@@ -169,6 +142,7 @@ static int purge_data(struct globals *globals)
 {
 	struct hash_it_t *hashit = NULL;
 	struct timespec now, diff;
+	struct interface *interface;
 
 	clock_gettime(CLOCK_MONOTONIC, &now);
 
@@ -184,18 +158,21 @@ static int purge_data(struct globals *globals)
 		free(dataset);
 	}
 
-	while (NULL != (hashit = hash_iterate(globals->server_hash, hashit))) {
-		struct server *server = hashit->bucket->data;
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		while (NULL != (hashit = hash_iterate(interface->server_hash,
+						      hashit))) {
+			struct server *server = hashit->bucket->data;
 
-		time_diff(&now, &server->last_seen, &diff);
-		if (diff.tv_sec < ALFRED_SERVER_TIMEOUT)
-			continue;
+			time_diff(&now, &server->last_seen, &diff);
+			if (diff.tv_sec < ALFRED_SERVER_TIMEOUT)
+				continue;
 
-		if (globals->best_server == server)
-			globals->best_server = NULL;
+			if (globals->best_server == server)
+				globals->best_server = NULL;
 
-		hash_remove_bucket(globals->server_hash, hashit);
-		free(server);
+			hash_remove_bucket(interface->server_hash, hashit);
+			free(server);
+		}
 	}
 
 	if (!globals->best_server)
-- 
2.1.3

