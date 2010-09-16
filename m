Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 16 Sep 2010 22:18:37 +0200
Message-Id: <1284668317-19890-5-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284668317-19890-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284668317-19890-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: Remove unneeded rcu_read_lock
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
To: b.a.t.m.a.n@lists.open-mesh.net

Regions which do not use rcu functions don't need to protected by
rcu_read_lock. If we want to protect data from being freed than it must
be covered by the same read-side critical section or otherwise the grace
period may already ended and freed the memory before we called
rcu_read_lock again.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/gateway_client.c |    4 ----
 batman-adv/originator.c     |    2 --
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index dd96d99..bfac0ff 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -342,9 +342,7 @@ int gw_client_seq_print_text(struct seq_file *seq, void *offset)
 	struct hlist_node *node;
 	int gw_count = 0;
 
-	rcu_read_lock();
 	if (!bat_priv->primary_if) {
-		rcu_read_unlock();
 
 		return seq_printf(seq, "BATMAN mesh %s disabled - please "
 				  "specify interfaces to enable it\n",
@@ -352,7 +350,6 @@ int gw_client_seq_print_text(struct seq_file *seq, void *offset)
 	}
 
 	if (bat_priv->primary_if->if_status != IF_ACTIVE) {
-		rcu_read_unlock();
 
 		return seq_printf(seq, "BATMAN mesh %s disabled - "
 				       "primary interface not active\n",
@@ -365,7 +362,6 @@ int gw_client_seq_print_text(struct seq_file *seq, void *offset)
 		   "outgoingIF", SOURCE_VERSION, REVISION_VERSION_STR,
 		   bat_priv->primary_if->net_dev->name,
 		   bat_priv->primary_if->addr_str, net_dev->name);
-	rcu_read_unlock();
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 2250266..3424ac2 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -335,7 +335,6 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 				  net_dev->name);
 	}
 
-	rcu_read_lock();
 	seq_printf(seq, "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
 		   SOURCE_VERSION, REVISION_VERSION_STR,
 		   bat_priv->primary_if->net_dev->name,
@@ -343,7 +342,6 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "  %-15s %s (%s/%i) %17s [%10s]: %20s ...\n",
 		   "Originator", "last-seen", "#", TQ_MAX_VALUE, "Nexthop",
 		   "outgoingIF", "Potential nexthops");
-	rcu_read_unlock();
 
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 
-- 
1.7.2.3

