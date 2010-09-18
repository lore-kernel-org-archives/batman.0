Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 21:01:17 +0200
Message-Id: <1284836482-23431-8-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 07/12] Staging: batman-adv: Remove unneeded
	rcu_read_lock
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

Regions which do not use rcu functions don't need to protected by
rcu_read_lock. If we want to protect data from being freed than it must
be covered by the same read-side critical section or otherwise the grace
period may already ended and freed the memory before we called
rcu_read_lock again.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/originator.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index f25d7fd..c530df1 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -329,7 +329,6 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 				  net_dev->name);
 	}
 
-	rcu_read_lock();
 	seq_printf(seq, "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
 		   SOURCE_VERSION, REVISION_VERSION_STR,
 		   bat_priv->primary_if->net_dev->name,
@@ -337,7 +336,6 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "  %-15s %s (%s/%i) %17s [%10s]: %20s ...\n",
 		   "Originator", "last-seen", "#", TQ_MAX_VALUE, "Nexthop",
 		   "outgoingIF", "Potential nexthops");
-	rcu_read_unlock();
 
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 
-- 
1.7.2.3

