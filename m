Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  9 Aug 2010 23:56:39 +0200
Message-Id: <1281391002-21577-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1281391002-21577-1-git-send-email-sven.eckelmann@gmx.de>
References: <1281391002-21577-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] Staging: batman-adv: unify
	orig_hash_lock spinlock handling to avoid deadlocks
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net, stable <stable@kernel.org>

From: Marek Lindner <lindner_marek@yahoo.de>

The orig_hash_lock spinlock always has to be locked with IRQs being
disabled to avoid deadlocks between code that is being executed in
IRQ context and code that is being executed in non-IRQ context.

Reported-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: stable <stable@kernel.org>
---
 drivers/staging/batman-adv/originator.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 28bb627..de5a8c1 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -391,11 +391,12 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 int orig_hash_add_if(struct batman_if *batman_if, int max_if_num)
 {
 	struct orig_node *orig_node;
+	unsigned long flags;
 	HASHIT(hashit);
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
-	spin_lock(&orig_hash_lock);
+	spin_lock_irqsave(&orig_hash_lock, flags);
 
 	while (hash_iterate(orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
@@ -404,11 +405,11 @@ int orig_hash_add_if(struct batman_if *batman_if, int max_if_num)
 			goto err;
 	}
 
-	spin_unlock(&orig_hash_lock);
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
 	return 0;
 
 err:
-	spin_unlock(&orig_hash_lock);
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
 	return -ENOMEM;
 }
 
@@ -468,12 +469,13 @@ int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 {
 	struct batman_if *batman_if_tmp;
 	struct orig_node *orig_node;
+	unsigned long flags;
 	HASHIT(hashit);
 	int ret;
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
-	spin_lock(&orig_hash_lock);
+	spin_lock_irqsave(&orig_hash_lock, flags);
 
 	while (hash_iterate(orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
@@ -500,10 +502,10 @@ int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 	rcu_read_unlock();
 
 	batman_if->if_num = -1;
-	spin_unlock(&orig_hash_lock);
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
 	return 0;
 
 err:
-	spin_unlock(&orig_hash_lock);
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
 	return -ENOMEM;
 }
-- 
1.7.1

