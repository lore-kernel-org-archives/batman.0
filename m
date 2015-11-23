Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 Nov 2015 19:57:22 +0100
Message-Id: <1448305042-5806-4-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
References: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: add seqno maximum age and
	protection start flag parameters
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

To allow future use of the window protected function with different
maximum sequence numbers, add a parameter to set this value which
was previously hardcoded. Another parameter added for future use is a
flag to return whether the protection window has started.

While at it, also fix the kerneldoc.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 net/batman-adv/bat_iv_ogm.c |  3 ++-
 net/batman-adv/main.h       |  3 +++
 net/batman-adv/routing.c    | 13 ++++++++++---
 net/batman-adv/routing.h    |  3 ++-
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index a594496..12bdffa 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1313,7 +1313,8 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	/* signalize caller that the packet is to be dropped. */
 	if (!hlist_empty(&orig_node->neigh_list) &&
 	    batadv_window_protected(bat_priv, seq_diff,
-				    &orig_ifinfo->batman_seqno_reset)) {
+				    BATADV_TQ_LOCAL_WINDOW_SIZE,
+				    &orig_ifinfo->batman_seqno_reset, NULL)) {
 		ret = BATADV_PROTECTED;
 		goto out;
 	}
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 5b79814..cb53827 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -35,6 +35,9 @@
 /* Time To Live of broadcast messages */
 #define BATADV_TTL 50
 
+/* maximum sequence number age of broadcast messages */
+#define BATADV_BCAST_MAX_AGE 64
+
 /* purge originators after time in seconds if no valid packet comes in
  * -> TODO: check influence on BATADV_TQ_LOCAL_WINDOW_SIZE
  */
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 1fb1be3..0ba5993 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -146,23 +146,29 @@ out:
  * @bat_priv: the bat priv with all the soft interface information
  * @seq_num_diff: difference between the current/received sequence number and
  *  the last sequence number
+ * @seq_old_max_diff: maximum age of sequence number not considered as restart
  * @last_reset: jiffies timestamp of the last reset, will be updated when reset
  *  is detected
+ * @protection_started: is set to true if the protection window was started,
+ *   doesn't change otherwise.
  *
  * Return:
  *  0 if the packet is to be accepted.
  *  1 if the packet is to be ignored.
  */
 int batadv_window_protected(struct batadv_priv *bat_priv, s32 seq_num_diff,
-			    unsigned long *last_reset)
+			    s32 seq_old_max_diff, unsigned long *last_reset,
+			    bool *protection_started)
 {
-	if (seq_num_diff <= -BATADV_TQ_LOCAL_WINDOW_SIZE ||
+	if (seq_num_diff <= -seq_old_max_diff ||
 	    seq_num_diff >= BATADV_EXPECTED_SEQNO_RANGE) {
 		if (!batadv_has_timed_out(*last_reset,
 					  BATADV_RESET_PROTECTION_MS))
 			return 1;
 
 		*last_reset = jiffies;
+		if (protection_started)
+			*protection_started = true;
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "old packet received, start protection\n");
 	}
@@ -1073,7 +1079,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	/* check whether the packet is old and the host just restarted. */
 	if (batadv_window_protected(bat_priv, seq_diff,
-				    &orig_node->bcast_seqno_reset))
+				    BATADV_BCAST_MAX_AGE,
+				    &orig_node->bcast_seqno_reset, NULL))
 		goto spin_unlock;
 
 	/* mark broadcast in flood history, update window position
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 204bbe4..5315fb3 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -52,6 +52,7 @@ batadv_find_router(struct batadv_priv *bat_priv,
 		   struct batadv_orig_node *orig_node,
 		   struct batadv_hard_iface *recv_if);
 int batadv_window_protected(struct batadv_priv *bat_priv, s32 seq_num_diff,
-			    unsigned long *last_reset);
+			    s32 seq_old_max_diff, unsigned long *last_reset,
+			    bool *protection_started);
 
 #endif /* _NET_BATMAN_ADV_ROUTING_H_ */
-- 
2.6.2

