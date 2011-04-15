Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri, 15 Apr 2011 20:24:42 +0200
Message-Id: <1302891882-11246-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix crash on module shutdown
	with multiple ifaces
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

hardif_remove_interfaces() removes all hard interfaces from the
hardif_list before freeing and cleaning up any device. However the clean
up procedures in orig_hash_del_if()
(hardif_remove_interface()->hardif_disable_interface()->
orig_hash_del_if())
need the other interfaces still to be present in the hardif_list.
Otherwise it won't renumber any preceding interfaces, which leads to an
unhandled kernel paging request in orig_node_del_if()'s "/* copy second
part */" due to wrong hard_if->if_num's.

With this commit the interface removal on module shutdown will be down
in the same way as removing single interfaces from batman only: One
interface will be removed and cleaned at a time.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 hard-interface.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index b3058e4..f039a3d 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -490,20 +490,13 @@ static void hardif_remove_interface(struct hard_iface *hard_iface)
 void hardif_remove_interfaces(void)
 {
 	struct hard_iface *hard_iface, *hard_iface_tmp;
-	struct list_head if_queue;
 
-	INIT_LIST_HEAD(&if_queue);
-
-	spin_lock(&hardif_list_lock);
-	list_for_each_entry_safe(hard_iface, hard_iface_tmp,
-				 &hardif_list, list) {
+	rtnl_lock();
+	list_for_each_entry_safe(hard_iface, hard_iface_tmp, &hardif_list, list) {
+		spin_lock(&hardif_list_lock);
 		list_del_rcu(&hard_iface->list);
-		list_add_tail(&hard_iface->list, &if_queue);
-	}
-	spin_unlock(&hardif_list_lock);
+		spin_unlock(&hardif_list_lock);
 
-	rtnl_lock();
-	list_for_each_entry_safe(hard_iface, hard_iface_tmp, &if_queue, list) {
 		hardif_remove_interface(hard_iface);
 	}
 	rtnl_unlock();
-- 
1.7.4.1

