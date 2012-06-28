Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 28 Jun 2012 11:34:25 +0200
Message-Id: <1340876067-28333-17-git-send-email-ordex@autistici.org>
In-Reply-To: <1340876067-28333-1-git-send-email-ordex@autistici.org>
References: <1340876067-28333-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 16/18] batman-adv: Prefix unicast defines
	with BATADV_
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/originator.c |    2 +-
 net/batman-adv/unicast.c    |    2 +-
 net/batman-adv/unicast.h    |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index bf9ec39a..1980696 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -370,7 +370,7 @@ static void _batadv_purge_orig(struct bat_priv *bat_priv)
 			}
 
 			if (batadv_has_timed_out(orig_node->last_frag_packet,
-						 FRAG_TIMEOUT))
+						 BATADV_FRAG_TIMEOUT))
 				batadv_frag_list_free(&orig_node->frag_list);
 		}
 		spin_unlock_bh(list_lock);
diff --git a/net/batman-adv/unicast.c b/net/batman-adv/unicast.c
index c8da6b0..8098320 100644
--- a/net/batman-adv/unicast.c
+++ b/net/batman-adv/unicast.c
@@ -98,7 +98,7 @@ static int batadv_frag_create_buffer(struct list_head *head)
 	int i;
 	struct frag_packet_list_entry *tfp;
 
-	for (i = 0; i < FRAG_BUFFER_SIZE; i++) {
+	for (i = 0; i < BATADV_FRAG_BUFFER_SIZE; i++) {
 		tfp = kmalloc(sizeof(*tfp), GFP_ATOMIC);
 		if (!tfp) {
 			batadv_frag_list_free(head);
diff --git a/net/batman-adv/unicast.h b/net/batman-adv/unicast.h
index 9257b83..936287f 100644
--- a/net/batman-adv/unicast.h
+++ b/net/batman-adv/unicast.h
@@ -22,8 +22,8 @@
 
 #include "packet.h"
 
-#define FRAG_TIMEOUT 10000	/* purge frag list entries after time in ms */
-#define FRAG_BUFFER_SIZE 6	/* number of list elements in buffer */
+#define BATADV_FRAG_TIMEOUT 10000 /* purge frag list entries after time in ms */
+#define BATADV_FRAG_BUFFER_SIZE 6 /* number of list elements in buffer */
 
 int batadv_frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			       struct sk_buff **new_skb);
-- 
1.7.9.4

