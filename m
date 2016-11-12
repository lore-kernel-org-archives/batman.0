Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Nov 2016 10:25:18 +0100
Message-Id: <20161112092524.13170-1-sven@narfation.org>
In-Reply-To: <4404358.R7R4S15M79@sven-edge>
References: <4404358.R7R4S15M79@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 1/7] alfred: Avoid hash search for
	transaction cleanup
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

A transaction can either be cleaned up on timeout or on TXEND. alfred has
in both situations already the head of the transaction list. An extra
search in the transaction hash is therefore not needed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h |  3 ---
 recv.c   | 16 +---------------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/alfred.h b/alfred.h
index b2b08b0..7e7811b 100644
--- a/alfred.h
+++ b/alfred.h
@@ -159,9 +159,6 @@ int recv_alfred_packet(struct globals *globals, struct interface *interface,
 		       int recv_sock);
 struct transaction_head *
 transaction_add(struct globals *globals, struct ether_addr mac, uint16_t id);
-struct transaction_head *
-transaction_clean_hash(struct globals *globals,
-		       struct transaction_head *search);
 struct transaction_head *transaction_clean(struct globals *globals,
 					   struct transaction_head *head);
 /* send.c */
diff --git a/recv.c b/recv.c
index 98539cb..b6b6eab 100644
--- a/recv.c
+++ b/recv.c
@@ -160,18 +160,6 @@ struct transaction_head *transaction_clean(struct globals *globals,
 	return head;
 }
 
-struct transaction_head *
-transaction_clean_hash(struct globals *globals, struct transaction_head *search)
-{
-	struct transaction_head *head;
-
-	head = hash_find(globals->transaction_hash, search);
-	if (!head)
-		return head;
-
-	return transaction_clean(globals, head);
-}
-
 static int process_alfred_push_data(struct globals *globals,
 				    struct in6_addr *source,
 				    struct alfred_push_data_v0 *push)
@@ -369,9 +357,7 @@ static int process_alfred_status_txend(struct globals *globals,
 		free(transaction_packet);
 	}
 
-	head = transaction_clean_hash(globals, &search);
-	if (!head)
-		return -1;
+	transaction_clean(globals, head);
 
 	if (head->client_socket < 0)
 		free(head);
-- 
2.10.2

