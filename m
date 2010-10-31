Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 31 Oct 2010 22:07:37 +0100
Message-Id: <1288559257-30844-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <201010311712.07786.sven.eckelmann@gmx.de>
References: <201010311712.07786.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Don't call sysfs_del_hardif()
	in atomic context
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

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 hard-interface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 37f0f8b..a9b8367 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -41,7 +41,6 @@ static void hardif_free_rcu(struct rcu_head *rcu)
 	struct batman_if *batman_if;
 
 	batman_if = container_of(rcu, struct batman_if, rcu);
-	sysfs_del_hardif(&batman_if->hardif_obj);
 	dev_put(batman_if->net_dev);
 	kref_put(&batman_if->refcount, hardif_free_ref);
 }
@@ -470,6 +469,7 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 
 	/* caller must take if_list_lock */
 	list_del_rcu(&batman_if->list);
+	sysfs_del_hardif(&batman_if->hardif_obj);
 	call_rcu(&batman_if->rcu, hardif_free_rcu);
 }
 
-- 
1.7.1

