Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jun 2012 22:19:15 +0200
Message-Id: <1338754762-28424-9-git-send-email-sven@narfation.org>
In-Reply-To: <1338754762-28424-1-git-send-email-sven@narfation.org>
References: <1338754762-28424-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 09/16] batman-adv: Prefix unicast defines
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
To: b.a.t.m.a.n@lists.open-mesh.org

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 originator.c |    2 +-
 unicast.c    |    2 +-
 unicast.h    |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/originator.c b/originator.c
index bf9ec39..1980696 100644
--- a/originator.c
+++ b/originator.c
@@ -370,7 +370,7 @@ static void _batadv_purge_orig(struct bat_priv *bat_priv)
 			}
 
 			if (batadv_has_timed_out(orig_node->last_frag_packet,
-						 FRAG_TIMEOUT))
+						 BATADV_FRAG_TIMEOUT))
 				batadv_frag_list_free(&orig_node->frag_list);
 		}
 		spin_unlock_bh(list_lock);
diff --git a/unicast.c b/unicast.c
index bafbbbf..39b4f10 100644
--- a/unicast.c
+++ b/unicast.c
@@ -98,7 +98,7 @@ static int batadv_frag_create_buffer(struct list_head *head)
 	int i;
 	struct frag_packet_list_entry *tfp;
 
-	for (i = 0; i < FRAG_BUFFER_SIZE; i++) {
+	for (i = 0; i < BATADV_FRAG_BUFFER_SIZE; i++) {
 		tfp = kmalloc(sizeof(*tfp), GFP_ATOMIC);
 		if (!tfp) {
 			batadv_frag_list_free(head);
diff --git a/unicast.h b/unicast.h
index 9257b83..936287f 100644
--- a/unicast.h
+++ b/unicast.h
@@ -22,8 +22,8 @@
 
 #include "packet.h"
 
-#define FRAG_TIMEOUT 10000	/* purge frag list entries after time in ms */
-#define FRAG_BUFFER_SIZE 6	/* number of list elements in buffer */
+#define BATADV_FRAG_TIMEOUT 10000 /* purge frag list entries after time in ms */
+#define BATADV_FRAG_BUFFER_SIZE 6 /* number of list elements in buffer */
 
 int batadv_frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 			       struct sk_buff **new_skb);
-- 
1.7.10

