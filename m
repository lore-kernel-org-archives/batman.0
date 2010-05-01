Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  1 May 2010 15:10:09 +0200
Message-Id: <1272719410-406-4-git-send-email-andrew@lunn.ch>
In-Reply-To: <1272719410-406-1-git-send-email-andrew@lunn.ch>
References: <1272719410-406-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: whitespace fixes from
	mainline.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: lindner_marek@yahoo.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

The mainline driver has some whitespace patches which are not in
maint. This patch brings imports them.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 bitarray.c |    2 +-
 main.h     |    4 ++--
 routing.c  |    3 ++-
 send.c     |    3 ++-
 vis.c      |    6 +++---
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/bitarray.c b/bitarray.c
index 437cff8..2fef6e3 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -150,7 +150,7 @@ char bit_get_packet(TYPE_OF_WORD *seq_bits, int16_t seq_num_diff,
 
 	/* sequence number is much newer, probably missed a lot of packets */
 
-	if ((seq_num_diff >= TQ_LOCAL_WINDOW_SIZE) 
+	if ((seq_num_diff >= TQ_LOCAL_WINDOW_SIZE)
 		|| (seq_num_diff < EXPECTED_SEQNO_RANGE)) {
 		bat_dbg(DBG_BATMAN,
 			"We missed a lot of packets (%i) !\n",
diff --git a/main.h b/main.h
index 2ce3b45..55e2214 100644
--- a/main.h
+++ b/main.h
@@ -69,8 +69,8 @@
 #define MODULE_ACTIVE 1
 #define MODULE_DEACTIVATING 2
 
-#define BCAST_QUEUE_LEN		256
-#define BATMAN_QUEUE_LEN 	256
+#define BCAST_QUEUE_LEN 256
+#define BATMAN_QUEUE_LE	256
 
 /*
  * Debug Messages
diff --git a/routing.c b/routing.c
index 0ab8f89..cd2b4d6 100644
--- a/routing.c
+++ b/routing.c
@@ -875,7 +875,8 @@ int recv_unicast_packet(struct sk_buff *skb)
 
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
-		printk(KERN_WARNING "batman-adv:Warning - can't forward unicast packet from %pM to %pM: ttl exceeded\n", ethhdr->h_source, unicast_packet->dest);
+		printk(KERN_WARNING "batman-adv:Warning - can't forward unicast packet from %pM to %pM: ttl exceeded\n",
+		       ethhdr->h_source, unicast_packet->dest);
 		return NET_RX_DROP;
 	}
 
diff --git a/send.c b/send.c
index caec6ef..8413ddc 100644
--- a/send.c
+++ b/send.c
@@ -128,7 +128,8 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 	if (batman_if->if_status != IF_ACTIVE)
 		return;
 
-	packet_num = buff_pos = 0;
+	packet_num = 0;
+	buff_pos = 0;
 	batman_packet = (struct batman_packet *)
 		(forw_packet->packet_buff);
 
diff --git a/vis.c b/vis.c
index bac1401..ff511ca 100644
--- a/vis.c
+++ b/vis.c
@@ -40,9 +40,9 @@
     * before adding more than 127 to the starting value - it is a predecessor,
     * when adding 128 - it is neither a predecessor nor a successor,
     * after adding more than 127 to the starting value - it is a successor */
-#define seq_before(x,y) ({typeof(x) _dummy = (x - y); \
-                         _dummy > smallest_signed_int(_dummy); })
-#define seq_after(x,y) seq_before(y,x)
+#define seq_before(x, y) ({typeof(x) _dummy = (x - y); \
+			  _dummy > smallest_signed_int(_dummy); })
+#define seq_after(x, y) seq_before(y, x)
 
 struct hashtable_t *vis_hash;
 DEFINE_SPINLOCK(vis_hash_lock);
-- 
1.7.1

