Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 12 Dec 2012 00:05:05 +0100
Message-Id: <1355267105-18479-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: postpone sysfs removal when
	unregistering
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, sven@narfation.org

When processing the unregister notify for a hard interface, removing
the sysfs files may lead to a circular deadlock (rtnl mutex <->
s_active).

To overcome this problem, postpone the sysfs removal in a worker.

Reported-by: Sasha Levin <sasha.levin@oracle.com>
Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
Postponing the sysfs removal for the hardif unregister is easier than
other alternatives involving deferring. This should bring us to the
same level to the bridge code, which also messes with sysfs in the
notifier processing function, and uses rtnl_trylock when called
from within sysfs.

As far as I could understand the net/core code, only the unregister
case is the critical one, so the original bug should hopefully be
fixed.

Anyway, I might overlook something so I'm sending this as RFC.
---
 hard-interface.c |   18 ++++++++++++++++--
 types.h          |    1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index f1d37cd..075cb27 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -506,6 +506,19 @@ out:
 	return NULL;
 }
 
+static void batadv_hardif_remove_interface_finish(struct work_struct *work)
+{
+	struct delayed_work *delayed_work;
+	struct batadv_hard_iface *hard_iface;
+
+	delayed_work = container_of(work, struct delayed_work, work);
+	hard_iface = container_of(delayed_work, struct batadv_hard_iface,
+				  cleanup_work);
+
+	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
+	batadv_hardif_free_ref(hard_iface);
+}
+
 static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 {
 	ASSERT_RTNL();
@@ -518,8 +531,9 @@ static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 		return;
 
 	hard_iface->if_status = BATADV_IF_TO_BE_REMOVED;
-	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
-	batadv_hardif_free_ref(hard_iface);
+	INIT_DELAYED_WORK(&hard_iface->cleanup_work,
+			  batadv_hardif_remove_interface_finish);
+	queue_work(batadv_event_workqueue, &hard_iface->cleanup_work);
 }
 
 void batadv_hardif_remove_interfaces(void)
diff --git a/types.h b/types.h
index 030ce41..6e9746a 100644
--- a/types.h
+++ b/types.h
@@ -63,6 +63,7 @@ struct batadv_hard_iface {
 	struct net_device *soft_iface;
 	struct rcu_head rcu;
 	struct batadv_hard_iface_bat_iv bat_iv;
+	struct delayed_work cleanup_work;
 };
 
 /**
-- 
1.7.10.4

