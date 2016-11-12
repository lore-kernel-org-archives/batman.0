Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Nov 2016 10:25:21 +0100
Message-Id: <20161112092524.13170-4-sven@narfation.org>
In-Reply-To: <4404358.R7R4S15M79@sven-edge>
References: <4404358.R7R4S15M79@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 4/7] alfred: Don't force cleanup of
	transaction on TXEND
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

A committed transaction has always to be cleaned up/removed when the TXEND
was received. But TXEND packets which are out-of-order may still be waiting
for PUSH_DATA packets which will be receive later. Thus TXEND packets which
don't trigger a commit of the PUSH_DATA should not automatically drop the
transaction.

A transaction which doesn't get all PUSH_DATA packets will be timeout
automatically and no extra handling is necessary.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h |  2 +-
 recv.c   | 13 +++++--------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/alfred.h b/alfred.h
index 7e7811b..9d0f6a6 100644
--- a/alfred.h
+++ b/alfred.h
@@ -71,7 +71,7 @@ struct transaction_head {
 	struct ether_addr server_addr;
 	uint16_t id;
 	uint8_t requested_type;
-	int finished;
+	uint16_t finished;
 	int num_packet;
 	int client_socket;
 	struct timespec last_rx_time;
diff --git a/recv.c b/recv.c
index 21ea539..dd0b021 100644
--- a/recv.c
+++ b/recv.c
@@ -167,17 +167,14 @@ static int finish_alfred_transaction(struct globals *globals,
 {
 	struct transaction_packet *transaction_packet, *safe;
 
-	/* missing packets -> cleanup everything */
-	if (head->num_packet == num_packets)
-		head->finished = -1;
-	else
-		head->finished = 1;
+	/* finish when all packets received */
+	if (head->num_packet != num_packets)
+		return 0;
 
+	head->finished = 1;
 	list_for_each_entry_safe(transaction_packet, safe, &head->packet_list,
 				 list) {
-		if (head->finished == 1)
-			finish_alfred_push_data(globals, mac,
-						transaction_packet->push);
+		finish_alfred_push_data(globals, mac, transaction_packet->push);
 
 		list_del(&transaction_packet->list);
 		free(transaction_packet->push);
-- 
2.10.2

