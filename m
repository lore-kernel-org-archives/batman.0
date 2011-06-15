Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 15 Jun 2011 09:41:36 +0200
Message-Id: <1308123697-7893-2-git-send-email-sven@narfation.org>
In-Reply-To: <1308123697-7893-1-git-send-email-sven@narfation.org>
References: <1308123697-7893-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: count_real_packets() in
	batman-adv assumes char is signed
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
To: b.a.t.m.a.n@lists.open-mesh.org

From: David Howells <dhowells@redhat.com>

count_real_packets() in batman-adv assumes char is signed, and returns -1
through it:

net/batman-adv/routing.c: In function 'receive_bat_packet':
net/batman-adv/routing.c:739: warning: comparison is always false due to limited range of data type

Use int instead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marek Lindner <lindner_marek@yahoo.de>
cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
cc: Sven Eckelmann <sven@narfation.org>
cc: b.a.t.m.a.n@lists.open-mesh.org
cc: netdev@vger.kernel.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bitarray.c |    4 ++--
 bitarray.h |    2 +-
 routing.c  |    8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/bitarray.c b/bitarray.c
index 700ee4f..3659a25 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -26,8 +26,8 @@
 
 /* returns true if the corresponding bit in the given seq_bits indicates true
  * and curr_seqno is within range of last_seqno */
-uint8_t get_bit_status(const unsigned long *seq_bits, uint32_t last_seqno,
-		       uint32_t curr_seqno)
+int get_bit_status(const unsigned long *seq_bits, uint32_t last_seqno,
+		   uint32_t curr_seqno)
 {
 	int32_t diff, word_offset, word_num;
 
diff --git a/bitarray.h b/bitarray.h
index e32eb2d..9fcdbdf 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -26,7 +26,7 @@
 
 /* returns true if the corresponding bit in the given seq_bits indicates true
  * and curr_seqno is within range of last_seqno */
-uint8_t get_bit_status(const unsigned long *seq_bits, uint32_t last_seqno,
+int get_bit_status(const unsigned long *seq_bits, uint32_t last_seqno,
 		       uint32_t curr_seqno);
 
 /* turn corresponding bit on, so we can remember that we got the packet */
diff --git a/routing.c b/routing.c
index 7ca4b42..2e037e3 100644
--- a/routing.c
+++ b/routing.c
@@ -381,7 +381,7 @@ static void update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
 			const struct ethhdr *ethhdr,
 			const struct batman_packet *batman_packet,
 			struct hard_iface *if_incoming,
-			const unsigned char *tt_buff, char is_duplicate)
+			const unsigned char *tt_buff, int is_duplicate)
 {
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	struct neigh_node *router = NULL;
@@ -548,7 +548,7 @@ static int window_protected(struct bat_priv *bat_priv,
  *  -1 the packet is old and has been received while the seqno window
  *     was protected. Caller should drop it.
  */
-static char count_real_packets(const struct ethhdr *ethhdr,
+static int count_real_packets(const struct ethhdr *ethhdr,
 			       const struct batman_packet *batman_packet,
 			       const struct hard_iface *if_incoming)
 {
@@ -556,7 +556,7 @@ static char count_real_packets(const struct ethhdr *ethhdr,
 	struct orig_node *orig_node;
 	struct neigh_node *tmp_neigh_node;
 	struct hlist_node *node;
-	char is_duplicate = 0;
+	int is_duplicate = 0;
 	int32_t seq_diff;
 	int need_update = 0;
 	int set_mark, ret = -1;
@@ -625,7 +625,7 @@ void receive_bat_packet(const struct ethhdr *ethhdr,
 	char has_directlink_flag;
 	char is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
 	char is_broadcast = 0, is_bidirectional, is_single_hop_neigh;
-	char is_duplicate;
+	int is_duplicate;
 	uint32_t if_incoming_seqno;
 
 	/* Silently drop when the batman packet is actually not a
-- 
1.7.5.3

