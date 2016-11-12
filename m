Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Nov 2016 10:25:20 +0100
Message-Id: <20161112092524.13170-3-sven@narfation.org>
In-Reply-To: <4404358.R7R4S15M79@sven-edge>
References: <4404358.R7R4S15M79@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 3/7] alfred: Remove checks for
	committed/dropped transaction
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

Transactions will be removed from the transaction has when they were
committed. Thus is is not necessary to check in the push_data/txend packet
processing functions for committed/dropped transactions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 recv.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/recv.c b/recv.c
index 6878e5e..21ea539 100644
--- a/recv.c
+++ b/recv.c
@@ -167,10 +167,6 @@ static int finish_alfred_transaction(struct globals *globals,
 {
 	struct transaction_packet *transaction_packet, *safe;
 
-	/* this transaction was already finished/dropped */
-	if (head->finished != 0)
-		return -1;
-
 	/* missing packets -> cleanup everything */
 	if (head->num_packet == num_packets)
 		head->finished = -1;
@@ -233,10 +229,6 @@ static int process_alfred_push_data(struct globals *globals,
 	}
 	clock_gettime(CLOCK_MONOTONIC, &head->last_rx_time);
 
-	/* this transaction was already finished/dropped */
-	if (head->finished != 0)
-		return -1;
-
 	found = 0;
 	list_for_each_entry(transaction_packet, &head->packet_list, list) {
 		if (transaction_packet->push->tx.seqno == push->tx.seqno) {
-- 
2.10.2

