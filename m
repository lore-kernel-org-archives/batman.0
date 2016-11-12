Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Nov 2016 10:25:22 +0100
Message-Id: <20161112092524.13170-5-sven@narfation.org>
In-Reply-To: <4404358.R7R4S15M79@sven-edge>
References: <4404358.R7R4S15M79@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 5/7] alfred: Use expected packet count to
	finished transactions
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

The TXEND packet will specify the number of PUSH_DATA packets are required
to finish a transaction. This number has therefore to be stored when a
TXEND packet is receiver to later be able to decide whether the
transaction can be finished or not.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h    |  8 +++++++-
 recv.c      | 11 +++++------
 unix_sock.c |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/alfred.h b/alfred.h
index 9d0f6a6..eb8200c 100644
--- a/alfred.h
+++ b/alfred.h
@@ -71,7 +71,7 @@ struct transaction_head {
 	struct ether_addr server_addr;
 	uint16_t id;
 	uint8_t requested_type;
-	uint16_t finished;
+	uint16_t txend_packets;
 	int num_packet;
 	int client_socket;
 	struct timespec last_rx_time;
@@ -161,6 +161,12 @@ struct transaction_head *
 transaction_add(struct globals *globals, struct ether_addr mac, uint16_t id);
 struct transaction_head *transaction_clean(struct globals *globals,
 					   struct transaction_head *head);
+
+static inline bool transaction_finished(struct transaction_head *head)
+{
+	return head->txend_packets == head->num_packet;
+}
+
 /* send.c */
 int push_data(struct globals *globals, struct interface *interface,
 	      struct in6_addr *destination, enum data_source max_source_level,
diff --git a/recv.c b/recv.c
index dd0b021..1f56016 100644
--- a/recv.c
+++ b/recv.c
@@ -131,7 +131,7 @@ transaction_add(struct globals *globals, struct ether_addr mac, uint16_t id)
 	head->server_addr = mac;
 	head->id = id;
 	head->requested_type = 0;
-	head->finished = 0;
+	head->txend_packets = 0;
 	head->num_packet = 0;
 	head->client_socket = -1;
 	clock_gettime(CLOCK_MONOTONIC, &head->last_rx_time);
@@ -162,16 +162,14 @@ struct transaction_head *transaction_clean(struct globals *globals,
 
 static int finish_alfred_transaction(struct globals *globals,
 				     struct transaction_head *head,
-				     struct ether_addr mac,
-				     uint16_t num_packets)
+				     struct ether_addr mac)
 {
 	struct transaction_packet *transaction_packet, *safe;
 
 	/* finish when all packets received */
-	if (head->num_packet != num_packets)
+	if (!transaction_finished(head))
 		return 0;
 
-	head->finished = 1;
 	list_for_each_entry_safe(transaction_packet, safe, &head->packet_list,
 				 list) {
 		finish_alfred_push_data(globals, mac, transaction_packet->push);
@@ -362,7 +360,8 @@ static int process_alfred_status_txend(struct globals *globals,
 	if (!head)
 		return -1;
 
-	finish_alfred_transaction(globals, head, mac, ntohs(request->tx.seqno));
+	head->txend_packets = ntohs(request->tx.seqno);
+	finish_alfred_transaction(globals, head, mac);
 
 	return 0;
 }
diff --git a/unix_sock.c b/unix_sock.c
index 150ad32..edc7e0b 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -276,7 +276,7 @@ int unix_sock_req_data_finish(struct globals *globals,
 	requested_type = head->requested_type;
 	id = head->id;
 	client_sock = head->client_socket;
-	if (head->finished != 1)
+	if (!transaction_finished(head))
 		send_data = 0;
 
 	free(head);
-- 
2.10.2

