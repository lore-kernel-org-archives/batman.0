Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Mar 2015 12:42:53 +0100
Message-Id: <1426333379-17777-9-git-send-email-sven@narfation.org>
In-Reply-To: <1426333379-17777-1-git-send-email-sven@narfation.org>
References: <1426333379-17777-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/14] alfred: Remove multiple blank lines
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
 hash.c      | 1 -
 hash.h      | 2 --
 packet.h    | 1 -
 recv.c      | 4 ----
 send.c      | 1 -
 server.c    | 4 ----
 unix_sock.c | 2 --
 7 files changed, 15 deletions(-)

diff --git a/hash.c b/hash.c
index 87588cd..20034d6 100644
--- a/hash.c
+++ b/hash.c
@@ -19,7 +19,6 @@
  *
  */
 
-
 #include "hash.h"
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/hash.h b/hash.h
index c7259c1..ee01c0f 100644
--- a/hash.h
+++ b/hash.h
@@ -21,8 +21,6 @@
 #ifndef _BATMAN_HASH_H
 #define _BATMAN_HASH_H
 
-
-
 typedef int (*hashdata_compare_cb)(void *, void *);
 typedef int (*hashdata_choose_cb)(void *, int);
 typedef void (*hashdata_free_cb)(void *);
diff --git a/packet.h b/packet.h
index 27ee6e5..ceb6c79 100644
--- a/packet.h
+++ b/packet.h
@@ -158,7 +158,6 @@ struct alfred_change_interface_v0 {
 	char ifaces[IFNAMSIZ * 16];
 } __packed;
 
-
 /**
  * struct alfred_status_v0 - Status info of a transaction
  * @header: TLV header describing the complete packet
diff --git a/recv.c b/recv.c
index e0252eb..02d96c9 100644
--- a/recv.c
+++ b/recv.c
@@ -287,7 +287,6 @@ process_alfred_announce_master(struct globals *globals,
 	return 0;
 }
 
-
 static int process_alfred_request(struct globals *globals,
 				  struct interface *interface,
 				  struct in6_addr *source,
@@ -309,12 +308,10 @@ static int process_alfred_request(struct globals *globals,
 	return 0;
 }
 
-
 static int process_alfred_status_txend(struct globals *globals,
 				       struct in6_addr *source,
 				       struct alfred_status_v0 *request)
 {
-
 	struct transaction_head search, *head;
 	struct transaction_packet *transaction_packet, *safe;
 	struct ether_addr mac;
@@ -372,7 +369,6 @@ static int process_alfred_status_txend(struct globals *globals,
 	return 0;
 }
 
-
 int recv_alfred_packet(struct globals *globals, struct interface *interface)
 {
 	uint8_t buf[MAX_PAYLOAD];
diff --git a/send.c b/send.c
index 7e0f416..3228d5c 100644
--- a/send.c
+++ b/send.c
@@ -126,7 +126,6 @@ int push_data(struct globals *globals, struct interface *interface,
 	return 0;
 }
 
-
 int sync_data(struct globals *globals)
 {
 	struct hash_it_t *hashit = NULL;
diff --git a/server.c b/server.c
index 1a3d876..ab6f4ec 100644
--- a/server.c
+++ b/server.c
@@ -102,8 +102,6 @@ static int tx_choose(void *d1, int size)
 	return hash % size;
 }
 
-
-
 static int create_hashes(struct globals *globals)
 {
 	globals->data_hash = hash_new(128, data_compare, data_choose);
@@ -351,5 +349,3 @@ int alfred_server(struct globals *globals)
 	unix_sock_close(globals);
 	return 0;
 }
-
-
diff --git a/unix_sock.c b/unix_sock.c
index 0707252..a3affdc 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -93,7 +93,6 @@ int unix_sock_open_client(struct globals *globals)
 	return 0;
 }
 
-
 static int unix_sock_add_data(struct globals *globals,
 			      struct alfred_push_data_v0 *push,
 			      int client_sock)
@@ -160,7 +159,6 @@ err:
 	return ret;
 }
 
-
 static int unix_sock_req_data_reply(struct globals *globals, int client_sock,
 				    uint16_t id, uint8_t requested_type)
 {
-- 
2.1.4

