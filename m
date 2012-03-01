Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  1 Mar 2012 15:35:20 +0800
Message-Id: <1330587321-12177-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1330587321-12177-1-git-send-email-lindner_marek@yahoo.de>
References: <1330587321-12177-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: replace HZ calculations with
	jiffies_to_msecs()
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_debugfs.c |    4 ++--
 originator.c  |   15 ++++++++++-----
 send.c        |    2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index 916380c..3b588f8 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -83,8 +83,8 @@ int debug_log(struct bat_priv *bat_priv, const char *fmt, ...)
 
 	va_start(args, fmt);
 	vscnprintf(tmp_log_buf, sizeof(tmp_log_buf), fmt, args);
-	fdebug_log(bat_priv->debug_log, "[%10lu] %s",
-		   (jiffies / HZ), tmp_log_buf);
+	fdebug_log(bat_priv->debug_log, "[%10u] %s",
+		   jiffies_to_msecs(jiffies), tmp_log_buf);
 	va_end(args);
 
 	return 0;
diff --git a/originator.c b/originator.c
index aa33337..183a1fe 100644
--- a/originator.c
+++ b/originator.c
@@ -36,7 +36,8 @@ static void purge_orig(struct work_struct *work);
 static void start_purge_timer(struct bat_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->orig_work, purge_orig);
-	queue_delayed_work(bat_event_workqueue, &bat_priv->orig_work, 1 * HZ);
+	queue_delayed_work(bat_event_workqueue,
+			   &bat_priv->orig_work, msecs_to_jiffies(1000));
 }
 
 /* returns 1 if they are the same originator */
@@ -276,6 +277,7 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 	struct hlist_node *node, *node_tmp;
 	struct neigh_node *neigh_node;
 	bool neigh_purged = false;
+	unsigned long last_seen;
 
 	*best_neigh_node = NULL;
 
@@ -290,6 +292,8 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 		    (neigh_node->if_incoming->if_status == IF_NOT_IN_USE) ||
 		    (neigh_node->if_incoming->if_status == IF_TO_BE_REMOVED)) {
 
+			last_seen = neigh_node->last_seen;
+
 			if ((neigh_node->if_incoming->if_status ==
 								IF_INACTIVE) ||
 			    (neigh_node->if_incoming->if_status ==
@@ -304,9 +308,9 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 			else
 				bat_dbg(DBG_BATMAN, bat_priv,
 					"neighbor timeout: originator %pM, "
-					"neighbor: %pM, last_seen: %lu\n",
+					"neighbor: %pM, last_seen: %u\n",
 					orig_node->orig, neigh_node->addr,
-					(neigh_node->last_seen / HZ));
+					jiffies_to_msecs(last_seen));
 
 			neigh_purged = true;
 
@@ -331,8 +335,9 @@ static bool purge_orig_node(struct bat_priv *bat_priv,
 
 	if (has_timed_out(orig_node->last_seen, 2 * PURGE_TIMEOUT)) {
 		bat_dbg(DBG_BATMAN, bat_priv,
-			"Originator timeout: originator %pM, last_seen %lu\n",
-			orig_node->orig, (orig_node->last_seen / HZ));
+			"Originator timeout: originator %pM, last_seen %u\n",
+			orig_node->orig,
+			jiffies_to_msecs(orig_node->last_seen));
 		return true;
 	} else {
 		if (purge_orig_neighbors(bat_priv, orig_node,
diff --git a/send.c b/send.c
index f7f5e3a..0d01e2b 100644
--- a/send.c
+++ b/send.c
@@ -296,7 +296,7 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 	/* if we still have some more bcasts to send */
 	if (forw_packet->num_packets < 3) {
 		_add_bcast_packet_to_list(bat_priv, forw_packet,
-					  ((5 * HZ) / 1000));
+					  msecs_to_jiffies(5));
 		return;
 	}
 
-- 
1.7.9

