Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 31 Oct 2010 16:32:38 +0100
Message-Id: <1288539158-26976-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't call sysfs_del_hardif() in
	atomic context
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

sysfs_del_hardif invokes kobject_put, which might sleep. However, we
are not allowed to sleep during a call_rcu. There is also no need to
do the removal with an atomic call_rcu, as kobject_put only frees the
kobject when there is no more reference to it anyway.

This commit basically revokes 7f32f2e8d97150ba5b80410dda86b01b0879fe8d,
despite not reintroducing the synchronize_rcu, our rcu_barrier should
handle this.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 hard-interface.c |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 37f0f8b..5c6ce3f 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -36,16 +36,6 @@
 /* protect update critical side of if_list - but not the content */
 static DEFINE_SPINLOCK(if_list_lock);
 
-static void hardif_free_rcu(struct rcu_head *rcu)
-{
-	struct batman_if *batman_if;
-
-	batman_if = container_of(rcu, struct batman_if, rcu);
-	sysfs_del_hardif(&batman_if->hardif_obj);
-	dev_put(batman_if->net_dev);
-	kref_put(&batman_if->refcount, hardif_free_ref);
-}
-
 struct batman_if *get_batman_if_by_netdev(struct net_device *net_dev)
 {
 	struct batman_if *batman_if;
@@ -470,7 +460,9 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 
 	/* caller must take if_list_lock */
 	list_del_rcu(&batman_if->list);
-	call_rcu(&batman_if->rcu, hardif_free_rcu);
+	sysfs_del_hardif(&batman_if->hardif_obj);
+	dev_put(batman_if->net_dev);
+	kref_put(&batman_if->refcount, hardif_free_ref);
 }
 
 void hardif_remove_interfaces(void)
-- 
1.7.1

