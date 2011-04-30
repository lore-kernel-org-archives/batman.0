Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 30 Apr 2011 18:56:58 +0200
Message-Id: <1304182620-12637-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 1/3] batman-adv: Fix crash on module
	shutdown with multiple ifaces
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

From: Linus Lüssing <linus.luessing@web.de>

hardif_remove_interfaces() removes all hard interfaces from the
hardif_list before freeing and cleaning up any device. However the clean
up procedures in orig_hash_del_if()
(hardif_remove_interface()->hardif_disable_interface()->
orig_hash_del_if()) need the other interfaces still to be present in the
hardif_list. Otherwise it won't renumber any preceding interfaces, which
leads to an unhandled kernel paging request in orig_node_del_if()'s
"/* copy second part */" due to wrong hard_if->if_num's.

With this commit the interface removal on module shutdown will be down
in the same way as removing single interfaces from batman only: One
interface will be removed and cleaned at a time.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
[sven@narfation.org: Keep locking around list_for_each_entry_safe]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Splitted the first patch to keep Linus' fame. There should be no difference
(after all patches are applied) between the first and the second version.

 hard-interface.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index b3058e4..c6edf0a 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -490,22 +490,15 @@ static void hardif_remove_interface(struct hard_iface *hard_iface)
 void hardif_remove_interfaces(void)
 {
 	struct hard_iface *hard_iface, *hard_iface_tmp;
-	struct list_head if_queue;
-
-	INIT_LIST_HEAD(&if_queue);
 
+	rtnl_lock();
 	spin_lock(&hardif_list_lock);
 	list_for_each_entry_safe(hard_iface, hard_iface_tmp,
 				 &hardif_list, list) {
 		list_del_rcu(&hard_iface->list);
-		list_add_tail(&hard_iface->list, &if_queue);
-	}
-	spin_unlock(&hardif_list_lock);
-
-	rtnl_lock();
-	list_for_each_entry_safe(hard_iface, hard_iface_tmp, &if_queue, list) {
 		hardif_remove_interface(hard_iface);
 	}
+	spin_unlock(&hardif_list_lock);
 	rtnl_unlock();
 }
 
-- 
1.7.4.4

