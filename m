Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Nov 2016 10:25:24 +0100
Message-Id: <20161112092524.13170-7-sven@narfation.org>
In-Reply-To: <4404358.R7R4S15M79@sven-edge>
References: <4404358.R7R4S15M79@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 7/7] alfred: Allow TXEND to start new
	transaction
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

A TXEND which comes before all other PUSH_DATA packets also has to create
its own transaction. Otherwise it cannot store the number of expected
packets for this transaction.

The PUSH_DATA packets can then trigger the finish of the transaction. Or
the transaction will timeout automatically.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 recv.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/recv.c b/recv.c
index 9fabfa4..bd208fd 100644
--- a/recv.c
+++ b/recv.c
@@ -359,13 +359,28 @@ static int process_alfred_status_txend(struct globals *globals,
 	search.id = ntohs(request->tx.id);
 
 	head = hash_find(globals->transaction_hash, &search);
-	if (!head)
-		return -1;
+	if (!head) {
+		/* slave must create the transactions to be able to correctly
+		 *  wait for it */
+		if (globals->opmode != OPMODE_MASTER)
+			goto err;
+
+		/* 0-packet txend for unknown transaction */
+		if (ntohs(request->tx.seqno) == 0)
+			goto err;
+
+		head = transaction_add(globals, mac, ntohs(request->tx.id));
+		if (!head)
+			goto err;
+	}
+	clock_gettime(CLOCK_MONOTONIC, &head->last_rx_time);
 
 	head->txend_packets = ntohs(request->tx.seqno);
 	finish_alfred_transaction(globals, head, mac);
 
 	return 0;
+err:
+	return -1;
 }
 
 int recv_alfred_packet(struct globals *globals, struct interface *interface,
-- 
2.10.2

