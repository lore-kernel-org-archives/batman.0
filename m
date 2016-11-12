Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Nov 2016 10:25:19 +0100
Message-Id: <20161112092524.13170-2-sven@narfation.org>
In-Reply-To: <4404358.R7R4S15M79@sven-edge>
References: <4404358.R7R4S15M79@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 2/7] alfred: Move tx finish functionality in
	extra function
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

The process_alfred_status_txend has two main functionalities. It first
tries to find a transaction to be able to get its status. When it was found
then it either commits the data or just cleans it up.

The latter will be used by later by process_alfred_push_data to implement
out-of-order txend packets. Thus split process_alfred_status_txend now into
two functions to avoid code duplication.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 recv.c | 67 ++++++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/recv.c b/recv.c
index b6b6eab..6878e5e 100644
--- a/recv.c
+++ b/recv.c
@@ -160,6 +160,44 @@ struct transaction_head *transaction_clean(struct globals *globals,
 	return head;
 }
 
+static int finish_alfred_transaction(struct globals *globals,
+				     struct transaction_head *head,
+				     struct ether_addr mac,
+				     uint16_t num_packets)
+{
+	struct transaction_packet *transaction_packet, *safe;
+
+	/* this transaction was already finished/dropped */
+	if (head->finished != 0)
+		return -1;
+
+	/* missing packets -> cleanup everything */
+	if (head->num_packet == num_packets)
+		head->finished = -1;
+	else
+		head->finished = 1;
+
+	list_for_each_entry_safe(transaction_packet, safe, &head->packet_list,
+				 list) {
+		if (head->finished == 1)
+			finish_alfred_push_data(globals, mac,
+						transaction_packet->push);
+
+		list_del(&transaction_packet->list);
+		free(transaction_packet->push);
+		free(transaction_packet);
+	}
+
+	transaction_clean(globals, head);
+
+	if (head->client_socket < 0)
+		free(head);
+	else
+		unix_sock_req_data_finish(globals, head);
+
+	return 1;
+}
+
 static int process_alfred_push_data(struct globals *globals,
 				    struct in6_addr *source,
 				    struct alfred_push_data_v0 *push)
@@ -313,7 +351,6 @@ static int process_alfred_status_txend(struct globals *globals,
 				       struct alfred_status_v0 *request)
 {
 	struct transaction_head search, *head;
-	struct transaction_packet *transaction_packet, *safe;
 	struct ether_addr mac;
 	int len, ret;
 
@@ -336,33 +373,7 @@ static int process_alfred_status_txend(struct globals *globals,
 	if (!head)
 		return -1;
 
-	/* this transaction was already finished/dropped */
-	if (head->finished != 0)
-		return -1;
-
-	/* missing packets -> cleanup everything */
-	if (head->num_packet != ntohs(request->tx.seqno))
-		head->finished = -1;
-	else
-		head->finished = 1;
-
-	list_for_each_entry_safe(transaction_packet, safe, &head->packet_list,
-				 list) {
-		if (head->finished == 1)
-			finish_alfred_push_data(globals, mac,
-						transaction_packet->push);
-
-		list_del(&transaction_packet->list);
-		free(transaction_packet->push);
-		free(transaction_packet);
-	}
-
-	transaction_clean(globals, head);
-
-	if (head->client_socket < 0)
-		free(head);
-	else
-		unix_sock_req_data_finish(globals, head);
+	finish_alfred_transaction(globals, head, mac, ntohs(request->tx.seqno));
 
 	return 0;
 }
-- 
2.10.2

