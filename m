Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Wed, 24 May 2017 12:32:09 +0200
Message-Id: <20170524103211.810-3-sven.eckelmann@openmesh.com>
In-Reply-To: <4690435.IOLn72U8Ez@bentobox>
References: <4690435.IOLn72U8Ez@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] alfred: Check the TQ of master servers
	before pushing data
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

The TQ value of the server might have changed dramatically since we
received the last announcement of a master server. This can especially
happen when node (which was previously the best server) moves a lot and its
announcements are lost for a while.

Instead of querying the TQ values of each node when receiving an
announcement, just query the TQ value before new data should be pushed to a
master server.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 alfred.h |  1 -
 recv.c   | 21 +--------------------
 server.c | 36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/alfred.h b/alfred.h
index 5f7a98c..429953f 100644
--- a/alfred.h
+++ b/alfred.h
@@ -153,7 +153,6 @@ extern alfred_addr alfred_mcast;
 
 /* server.c */
 int alfred_server(struct globals *globals);
-int set_best_server(struct globals *globals);
 void changed_data_type(struct globals *globals, uint8_t arg);
 
 /* client.c */
diff --git a/recv.c b/recv.c
index 8aa512d..12bb3f1 100644
--- a/recv.c
+++ b/recv.c
@@ -268,7 +268,6 @@ process_alfred_announce_master(struct globals *globals,
 			       struct alfred_announce_master_v0 *announce)
 {
 	struct server *server;
-	struct ether_addr *macaddr;
 	struct ether_addr mac;
 	int ret;
 	int len;
@@ -296,6 +295,7 @@ process_alfred_announce_master(struct globals *globals,
 
 		memcpy(&server->hwaddr, &mac, ETH_ALEN);
 		memcpy(&server->address, source, sizeof(*source));
+		server->tq = 0;
 
 		if (hash_add(interface->server_hash, server)) {
 			free(server);
@@ -305,25 +305,6 @@ process_alfred_announce_master(struct globals *globals,
 
 	clock_gettime(CLOCK_MONOTONIC, &server->last_seen);
 
-	/* TQ is not used for master sync mode */
-	if (globals->opmode == OPMODE_MASTER) {
-		server->tq = 0;
-		return 0;
-	}
-
-	if (strcmp(globals->mesh_iface, "none") != 0) {
-		macaddr = translate_mac(globals->mesh_iface,
-					(struct ether_addr *)&server->hwaddr);
-		if (macaddr)
-			server->tq = get_tq(globals->mesh_iface, macaddr);
-		else
-			server->tq = 0;
-	} else {
-		server->tq = 255;
-	}
-
-	set_best_server(globals);
-
 	return 0;
 }
 
diff --git a/server.c b/server.c
index 2c4042a..09acb80 100644
--- a/server.c
+++ b/server.c
@@ -113,7 +113,7 @@ static int create_hashes(struct globals *globals)
 	return 0;
 }
 
-int set_best_server(struct globals *globals)
+static int set_best_server(struct globals *globals)
 {
 	struct hash_it_t *hashit = NULL;
 	struct server *best_server = NULL;
@@ -218,6 +218,39 @@ static int purge_data(struct globals *globals)
 	return 0;
 }
 
+static void update_server_info(struct globals *globals)
+{
+	struct hash_it_t *hashit = NULL;
+	struct interface *interface;
+	struct ether_addr *macaddr;
+
+	/* TQ is not used for master sync mode */
+	if (globals->opmode == OPMODE_MASTER)
+		return;
+
+	list_for_each_entry(interface, &globals->interfaces, list) {
+		while (NULL != (hashit = hash_iterate(interface->server_hash,
+						      hashit))) {
+			struct server *server = hashit->bucket->data;
+
+			if (strcmp(globals->mesh_iface, "none") == 0) {
+				server->tq = 255;
+				continue;
+			}
+
+			macaddr = translate_mac(globals->mesh_iface,
+						&server->hwaddr);
+			if (macaddr)
+				server->tq = get_tq(globals->mesh_iface,
+						    macaddr);
+			else
+				server->tq = 0;
+		}
+	}
+
+	set_best_server(globals);
+}
+
 static void check_if_socket(struct interface *interface, struct globals *globals)
 {
 	int sock;
@@ -422,6 +455,7 @@ int alfred_server(struct globals *globals)
 			sync_data(globals);
 		} else {
 			/* send local data to server */
+			update_server_info(globals);
 			push_local_data(globals);
 		}
 		purge_data(globals);
-- 
2.11.0

