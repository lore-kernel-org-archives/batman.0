Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 30 Jun 2010 05:16:21 +0200
Message-Id: <1277867781-10472-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add last-seen in originator table
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

From: mesh-node <mesh-node@mesh-node1.(none)>

Right now, there is no easy/intuitive way to find out whether a node
might have vanished. This commit adds the time when a node was last seen
to the originator table output, so that a common user is able to tell
whether a node might have gone without having to wait PURGE_TIMEOUT
seconds until that node gets "garbe-collected".

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 originator.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/originator.c b/originator.c
index c28c4f5..5343ab2 100644
--- a/originator.c
+++ b/originator.c
@@ -296,6 +296,8 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 	struct orig_node *orig_node;
 	struct neigh_node *neigh_node;
 	int batman_count = 0;
+	int last_seen_secs;
+	int last_seen_msecs;
 	unsigned long flags;
 	char orig_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
 
@@ -312,12 +314,13 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 	}
 
 	rcu_read_lock();
-	seq_printf(seq, "  %-14s (%s/%i) %17s [%10s]: %20s "
-		   "... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
-		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
-		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
+	seq_printf(seq, "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
+		   SOURCE_VERSION, REVISION_VERSION_STR,
 		   bat_priv->primary_if->dev, bat_priv->primary_if->addr_str,
 		   net_dev->name);
+	seq_printf(seq, "  %-15s %s (%s/%i) %17s [%10s]: %20s ...\n",
+		   "Originator", "last-seen", "#", TQ_MAX_VALUE, "Nexthop",
+		   "outgoingIF", "Potential nexthops");
 	rcu_read_unlock();
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
@@ -334,9 +337,14 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 
 		addr_to_string(orig_str, orig_node->orig);
 		addr_to_string(router_str, orig_node->router->addr);
-
-		seq_printf(seq, "%-17s  (%3i) %17s [%10s]:",
-			   orig_str, orig_node->router->tq_avg, router_str,
+		last_seen_secs = jiffies_to_msecs(jiffies -
+						orig_node->last_valid) / 1000;
+		last_seen_msecs = jiffies_to_msecs(jiffies -
+						orig_node->last_valid) % 1000;
+
+		seq_printf(seq, "%-17s %4i.%03is   (%3i) %17s [%10s]:",
+			   orig_str, last_seen_secs, last_seen_msecs,
+			   orig_node->router->tq_avg, router_str,
 			   orig_node->router->if_incoming->dev);
 
 		list_for_each_entry(neigh_node, &orig_node->neigh_list, list) {
-- 
1.7.1

