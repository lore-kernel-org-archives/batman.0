Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 29 Apr 2010 16:23:32 +0200
Message-Id: <1272551013-8606-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201004291621.08579.sven.eckelmann@gmx.de>
References: <201004291621.08579.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH-trunk 1/2] batman-adv: Fix whitespace
	problems criticized by checkpatch.pl
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

Trailing spaces at the end of a line or before a tab are against
Documentation/CodingStyle "3.1: Spaces" and should be avoided. It is
also common style to add a single space after commas unless it is
followed either by a newline or a tab.

Reported-by: Mikal Sande <mikal.sande@gmail.com>
Reported-by: Luis de Bethencourt <luisbg@ubuntu.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/bitarray.c   |    2 +-
 batman-adv-kernelland/main.h       |    2 +-
 batman-adv-kernelland/originator.c |    4 ++--
 batman-adv-kernelland/vis.c        |    6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/batman-adv-kernelland/bitarray.c b/batman-adv-kernelland/bitarray.c
index 1fe1aa9..a607827 100644
--- a/batman-adv-kernelland/bitarray.c
+++ b/batman-adv-kernelland/bitarray.c
@@ -150,7 +150,7 @@ char bit_get_packet(TYPE_OF_WORD *seq_bits, int32_t seq_num_diff,
 
 	/* sequence number is much newer, probably missed a lot of packets */
 
-	if ((seq_num_diff >= TQ_LOCAL_WINDOW_SIZE) 
+	if ((seq_num_diff >= TQ_LOCAL_WINDOW_SIZE)
 		|| (seq_num_diff < EXPECTED_SEQNO_RANGE)) {
 		bat_dbg(DBG_BATMAN,
 			"We missed a lot of packets (%i) !\n",
diff --git a/batman-adv-kernelland/main.h b/batman-adv-kernelland/main.h
index c00dcc4..2b47259 100644
--- a/batman-adv-kernelland/main.h
+++ b/batman-adv-kernelland/main.h
@@ -77,7 +77,7 @@
 #define MODULE_DEACTIVATING 2
 
 #define BCAST_QUEUE_LEN		256
-#define BATMAN_QUEUE_LEN 	256
+#define BATMAN_QUEUE_LEN	256
 
 /*
  * Debug Messages
diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/originator.c
index 896d8ce..e01459a 100644
--- a/batman-adv-kernelland/originator.c
+++ b/batman-adv-kernelland/originator.c
@@ -309,7 +309,7 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 	rcu_read_lock();
 	hdr_len = sprintf(buff,
-		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)] \n",
+		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
 		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
 		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
 		   bat_priv->primary_if->dev, bat_priv->primary_if->addr_str,
@@ -366,7 +366,7 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 	if ((batman_count == 0) && (off == 0))
 		bytes_written += sprintf(buff + bytes_written,
-					"No batman nodes in range ... \n");
+					"No batman nodes in range ...\n");
 
 	return bytes_written;
 }
diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index 936806c..ddef7df 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
@@ -40,9 +40,9 @@
     * before adding more than 127 to the starting value - it is a predecessor,
     * when adding 128 - it is neither a predecessor nor a successor,
     * after adding more than 127 to the starting value - it is a successor */
-#define seq_before(x,y) ({typeof(x) _dummy = (x - y); \
-                         _dummy > smallest_signed_int(_dummy); })
-#define seq_after(x,y) seq_before(y,x)
+#define seq_before(x, y) ({typeof(x) _dummy = (x - y); \
+			_dummy > smallest_signed_int(_dummy); })
+#define seq_after(x, y) seq_before(y, x)
 
 struct hashtable_t *vis_hash;
 DEFINE_SPINLOCK(vis_hash_lock);
-- 
1.7.1

