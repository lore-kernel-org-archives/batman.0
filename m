Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue,  6 Jul 2010 21:05:18 +0200
Message-Id: <1278443118-19528-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1278443118-19528-1-git-send-email-sven.eckelmann@gmx.de>
References: <1278443118-19528-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/3] Staging: batman-adv: Add last-seen in
	originator table
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

From: Linus Lüssing <linus.luessing@web.de>

Right now, there is no easy/intuitive way to find out whether a node
might have vanished. This commit adds the time when a node was last seen
to the originator table output, so that a common user is able to tell
whether a node might have gone without having to wait PURGE_TIMEOUT
seconds until that node gets "garbe-collected".
It also puts the the versioning information in an extra line, as
the first one of this debug output would otherwise get too long.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/originator.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index d2a5f20..28bb627 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -289,6 +289,8 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 	struct orig_node *orig_node;
 	struct neigh_node *neigh_node;
 	int batman_count = 0;
+	int last_seen_secs;
+	int last_seen_msecs;
 	unsigned long flags;
 	char orig_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
 
@@ -305,12 +307,13 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
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
@@ -327,9 +330,14 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 
 		addr_to_string(orig_str, orig_node->orig);
 		addr_to_string(router_str, orig_node->router->addr);
+		last_seen_secs = jiffies_to_msecs(jiffies -
+						orig_node->last_valid) / 1000;
+		last_seen_msecs = jiffies_to_msecs(jiffies -
+						orig_node->last_valid) % 1000;
 
-		seq_printf(seq, "%-17s  (%3i) %17s [%10s]:",
-			   orig_str, orig_node->router->tq_avg, router_str,
+		seq_printf(seq, "%-17s %4i.%03is   (%3i) %17s [%10s]:",
+			   orig_str, last_seen_secs, last_seen_msecs,
+			   orig_node->router->tq_avg, router_str,
 			   orig_node->router->if_incoming->dev);
 
 		list_for_each_entry(neigh_node, &orig_node->neigh_list, list) {
-- 
1.7.1

