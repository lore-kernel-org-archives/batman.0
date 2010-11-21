Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 21 Nov 2010 23:37:16 +0100
Message-Id: <1290379036-11460-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Rename if_list_queue to if_queue
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

The name "if_list_queue" would create lines longer than 80 chars which
can be avoided by shortened version "if_queue".

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/hard-interface.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index bf98b90..4f95777 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -476,19 +476,19 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 void hardif_remove_interfaces(void)
 {
 	struct batman_if *batman_if, *batman_if_tmp;
-	struct list_head if_list_queue;
+	struct list_head if_queue;
 
-	INIT_LIST_HEAD(&if_list_queue);
+	INIT_LIST_HEAD(&if_queue);
 
 	spin_lock(&if_list_lock);
 	list_for_each_entry_safe(batman_if, batman_if_tmp, &if_list, list) {
 		list_del_rcu(&batman_if->list);
-		list_add_tail(&batman_if->list, &if_list_queue);
+		list_add_tail(&batman_if->list, &if_queue);
 	}
 	spin_unlock(&if_list_lock);
 
 	rtnl_lock();
-	list_for_each_entry_safe(batman_if, batman_if_tmp, &if_list_queue, list) {
+	list_for_each_entry_safe(batman_if, batman_if_tmp, &if_queue, list) {
 		hardif_remove_interface(batman_if);
 	}
 	rtnl_unlock();
-- 
1.7.2.3

