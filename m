Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Aug 2012 10:26:47 +0200
Message-Id: <1345451209-8898-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Remove extra check in
	batadv_bit_get_packet
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

batadv_bit_get_packet checks for all common situations before it decides that
the new received packet indicates that the host was restarted. This extra
condition check at the end of the function is not necessary because this
condition is always true.

This patch addresses Coverity #712296: Logically dead code

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bitarray.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/bitarray.c b/bitarray.c
index aea174c..5453b17 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -79,20 +79,17 @@ int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
 	 * or the old packet got delayed somewhere in the network. The
 	 * packet should be dropped without calling this function if the
 	 * seqno window is protected.
+	 *
+	 * seq_num_diff <= -BATADV_TQ_LOCAL_WINDOW_SIZE
+	 * or
+	 * seq_num_diff >= BATADV_EXPECTED_SEQNO_RANGE
 	 */
-	if (seq_num_diff <= -BATADV_TQ_LOCAL_WINDOW_SIZE ||
-	    seq_num_diff >= BATADV_EXPECTED_SEQNO_RANGE) {
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "Other host probably restarted!\n");
 
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Other host probably restarted!\n");
+	bitmap_zero(seq_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
+	if (set_mark)
+		batadv_set_bit(seq_bits, 0);
 
-		bitmap_zero(seq_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
-		if (set_mark)
-			batadv_set_bit(seq_bits, 0);
-
-		return 1;
-	}
-
-	/* never reached */
-	return 0;
+	return 1;
 }
-- 
1.7.10.4

