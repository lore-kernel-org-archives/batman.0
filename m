Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri,  7 May 2010 21:47:29 +0200
Message-Id: <1273261651-21378-25-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
References: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 24/26] Staging: batman-adv: Fix whitespace
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
To: greg@kroah.com
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Sven Eckelmann <sven.eckelmann@gmx.de>

Trailing spaces at the end of a line or before a tab are against
Documentation/CodingStyle "3.1: Spaces" and should be avoided. It is
also common style to add a single space after commas unless it is
followed either by a newline or a tab.

Reported-by: Mikal Sande <mikal.sande@gmail.com>
Reported-by: Luis de Bethencourt <luisbg@ubuntu.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/main.h       |    2 +-
 drivers/staging/batman-adv/originator.c |    4 ++--
 drivers/staging/batman-adv/types.h      |    3 +--
 drivers/staging/batman-adv/vis.c        |    2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 6749ce0..8818e2b 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -70,7 +70,7 @@
 #define MODULE_DEACTIVATING 2
 
 #define BCAST_QUEUE_LEN 256
-#define BATMAN_QUEUE_LE	256
+#define BATMAN_QUEUE_LEN	256
 
 /*
  * Debug Messages
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 01d71d7..25a9e21 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -297,7 +297,7 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 	rcu_read_lock();
 	hdr_len = sprintf(buff,
-		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)] \n",
+		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
 		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
 		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
 		   bat_priv->primary_if->dev, bat_priv->primary_if->addr_str,
@@ -354,7 +354,7 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 	if ((batman_count == 0) && (off == 0))
 		bytes_written += sprintf(buff + bytes_written,
-					"No batman nodes in range ... \n");
+					"No batman nodes in range ...\n");
 
 	return bytes_written;
 }
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index c926219..0b1fe9e 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -59,8 +59,7 @@ struct orig_node {               /* structure for orig_list maintaining nodes of
 					    seqno window was reset. */
 	unsigned long batman_seqno_reset;/* time when the batman seqno
 					    window was reset. */
-/*	uint8_t  gwflags;      * flags related to gateway functions: gateway class */
-	uint8_t  flags;    		/* for now only VIS_SERVER flag. */
+	uint8_t  flags;			 /* for now only VIS_SERVER flag. */
 	unsigned char *hna_buff;
 	int16_t  hna_buff_len;
 	uint16_t last_real_seqno;   /* last and best known squence number */
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index b6ff031..1d3d954 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -40,7 +40,7 @@
     * when adding 128 - it is neither a predecessor nor a successor,
     * after adding more than 127 to the starting value - it is a successor */
 #define seq_before(x, y) ({typeof(x) _dummy = (x - y); \
-			  _dummy > smallest_signed_int(_dummy); })
+			_dummy > smallest_signed_int(_dummy); })
 #define seq_after(x, y) seq_before(y, x)
 
 struct hashtable_t *vis_hash;
-- 
1.7.1

