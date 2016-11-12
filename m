Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Nov 2016 10:25:23 +0100
Message-Id: <20161112092524.13170-6-sven@narfation.org>
In-Reply-To: <4404358.R7R4S15M79@sven-edge>
References: <4404358.R7R4S15M79@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 6/7] alfred: Allow PUSH_DATA to finish
	transactions
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

A TXEND packet which is received in the middle of a transaction cannot
finish this transaction. This can only be done by a PUSH_DATA when the rest
of the packets were received.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 recv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recv.c b/recv.c
index 1f56016..9fabfa4 100644
--- a/recv.c
+++ b/recv.c
@@ -250,6 +250,8 @@ static int process_alfred_push_data(struct globals *globals,
 	list_add_tail(&transaction_packet->list, &head->packet_list);
 	head->num_packet++;
 
+	finish_alfred_transaction(globals, head, mac);
+
 	return 0;
 err:
 	return -1;
-- 
2.10.2

