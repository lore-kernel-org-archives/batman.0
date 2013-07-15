Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 15 Jul 2013 03:46:14 +0200
Message-Id: <1373852774-3802-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: prepare and schedule initial OGM
	without rtnl_lock()
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

There is no need to hold the rtnl-lock during the preparation of the
initial OGM of a hard interface.

Besides, it is a little uggly to have batadv_schedule_bat_ogm() executed
with an rtnl-lock on its first run but without an rtnl-lock in its
rearmed versions as it makes additions to batadv_schedule_bat_ogm() that
require an rtnl-lock difficult.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---

the compat code for the multicast-basic patchset needs an rtnl-lock
somewhere within batadv_schedule_bat_ogm()


 hard-interface.c |   21 ++++++++++++++++++++-
 types.h          |    2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hard-interface.c b/hard-interface.c
index c5f871f..c7ad8ae 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -470,7 +470,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 			   hard_iface->net_dev->name);
 
 	/* begin scheduling originator messages on that interface */
-	batadv_schedule_bat_ogm(hard_iface);
+	queue_work(batadv_event_workqueue, &hard_iface->init_ogm_work);
 
 out:
 	return 0;
@@ -554,6 +554,23 @@ static void batadv_hardif_remove_interface_finish(struct work_struct *work)
 	batadv_hardif_free_ref(hard_iface);
 }
 
+/**
+ * batadv_hardif_init_ogm - initialize the ogm scheduler
+ * @work: work queue item
+ *
+ * Prepare and queue the initial OGM on this hard interface to get its ogm
+ * scheduler into gear.
+ */
+static void batadv_hardif_init_ogm(struct work_struct *work)
+{
+	struct batadv_hard_iface *hard_iface;
+
+	hard_iface = container_of(work, struct batadv_hard_iface,
+				  init_ogm_work);
+
+	batadv_schedule_bat_ogm(hard_iface);
+}
+
 static struct batadv_hard_iface *
 batadv_hardif_add_interface(struct net_device *net_dev)
 {
@@ -583,6 +600,8 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	INIT_LIST_HEAD(&hard_iface->list);
 	INIT_WORK(&hard_iface->cleanup_work,
 		  batadv_hardif_remove_interface_finish);
+	INIT_WORK(&hard_iface->init_ogm_work,
+		  batadv_hardif_init_ogm);
 
 	hard_iface->num_bcasts = BATADV_NUM_BCASTS_DEFAULT;
 	if (batadv_is_wifi_netdev(net_dev))
diff --git a/types.h b/types.h
index 0d5b24b..a8b5725 100644
--- a/types.h
+++ b/types.h
@@ -62,6 +62,7 @@ struct batadv_hard_iface_bat_iv {
  * @rcu: struct used for freeing in an RCU-safe manner
  * @bat_iv: BATMAN IV specific per hard interface data
  * @cleanup_work: work queue callback item for hard interface deinit
+ * @init_ogm_work: work queue callback item for ogm scheduler initialization
  */
 struct batadv_hard_iface {
 	struct list_head list;
@@ -76,6 +77,7 @@ struct batadv_hard_iface {
 	struct rcu_head rcu;
 	struct batadv_hard_iface_bat_iv bat_iv;
 	struct work_struct cleanup_work;
+	struct work_struct init_ogm_work;
 };
 
 /**
-- 
1.7.10.4

