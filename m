Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Tue,  3 May 2011 11:51:39 +0200
Message-Id: <1304416299-906-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1304416299-906-1-git-send-email-linus.luessing@web.de>
References: <1304363978-16164-1-git-send-email-sven@narfation.org>
	<1304416299-906-1-git-send-email-linus.luessing@web.de>
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Avoid deadlock between
	rtnl_lock and s_active
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

From: Sven Eckelmann <sven@narfation.org>

The hard_if_event is called by the notifier with rtnl_lock and tries to
remove sysfs entries when a NETDEV_UNREGISTER event is received. This
will automatically take the s_active lock.

The s_active lock is also used when a new interface is added to a meshif
through sysfs. In that situation we cannot wait for the rntl_lock before
creating the actual batman-adv interface to prevent a deadlock. It is
still possible to try to get the rtnl_lock and immediately abort the
current operation when the trylock call failed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_sysfs.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 85ba20d..497a070 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -488,24 +488,24 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	    (strncmp(hard_iface->soft_iface->name, buff, IFNAMSIZ) == 0))
 		goto out;
 
+	if (!rtnl_trylock()) {
+		ret = -ERESTARTSYS;
+		goto out;
+	}
+
 	if (status_tmp == IF_NOT_IN_USE) {
-		rtnl_lock();
 		hardif_disable_interface(hard_iface);
-		rtnl_unlock();
-		goto out;
+		goto unlock;
 	}
 
 	/* if the interface already is in use */
-	if (hard_iface->if_status != IF_NOT_IN_USE) {
-		rtnl_lock();
+	if (hard_iface->if_status != IF_NOT_IN_USE)
 		hardif_disable_interface(hard_iface);
-		rtnl_unlock();
-	}
 
-	rtnl_lock();
 	ret = hardif_enable_interface(hard_iface, buff);
-	rtnl_unlock();
 
+unlock:
+	rtnl_unlock();
 out:
 	hardif_free_ref(hard_iface);
 	return ret;
-- 
1.7.4.1

