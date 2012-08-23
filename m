Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 23 Aug 2012 15:10:17 +0200
Message-Id: <1345727427-20805-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1345727427-20805-1-git-send-email-ordex@autistici.org>
References: <1345727427-20805-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/18] batman-adv: fix typos in comments
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

the word millisecond is misspelled in several comments. This patch fixes it.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/main.h |    8 ++++----
 net/batman-adv/vis.h  |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 5d8fa07..4dfeae5 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -41,13 +41,13 @@
  * -> TODO: check influence on BATADV_TQ_LOCAL_WINDOW_SIZE
  */
 #define BATADV_PURGE_TIMEOUT 200000 /* 200 seconds */
-#define BATADV_TT_LOCAL_TIMEOUT 3600000 /* in miliseconds */
-#define BATADV_TT_CLIENT_ROAM_TIMEOUT 600000 /* in miliseconds */
+#define BATADV_TT_LOCAL_TIMEOUT 3600000 /* in milliseconds */
+#define BATADV_TT_CLIENT_ROAM_TIMEOUT 600000 /* in milliseconds */
 /* sliding packet range of received originator messages in sequence numbers
  * (should be a multiple of our word size)
  */
 #define BATADV_TQ_LOCAL_WINDOW_SIZE 64
-/* miliseconds we have to keep pending tt_req */
+/* milliseconds we have to keep pending tt_req */
 #define BATADV_TT_REQUEST_TIMEOUT 3000
 
 #define BATADV_TQ_GLOBAL_WINDOW_SIZE 5
@@ -59,7 +59,7 @@
 #define BATADV_TT_OGM_APPEND_MAX 3
 
 /* Time in which a client can roam at most ROAMING_MAX_COUNT times in
- * miliseconds
+ * milliseconds
  */
 #define BATADV_ROAMING_MAX_TIME 20000
 #define BATADV_ROAMING_MAX_COUNT 5
diff --git a/net/batman-adv/vis.h b/net/batman-adv/vis.h
index 84e716e..873282f 100644
--- a/net/batman-adv/vis.h
+++ b/net/batman-adv/vis.h
@@ -20,7 +20,7 @@
 #ifndef _NET_BATMAN_ADV_VIS_H_
 #define _NET_BATMAN_ADV_VIS_H_
 
-/* timeout of vis packets in miliseconds */
+/* timeout of vis packets in milliseconds */
 #define BATADV_VIS_TIMEOUT		200000
 
 int batadv_vis_seq_print_text(struct seq_file *seq, void *offset);
-- 
1.7.9.4

