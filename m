Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Tue, 28 May 2013 17:32:32 +0200
Message-Id: <179dd3afbd3ecdcd2144bd3016e1b01eaf0d5263.1369754967.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: wait for rtnl in
	batadv_store_mesh_iface instead of failing if it is taken
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

The rtnl_lock in batadv_store_mesh_iface has been converted to a rtnl_trylock
some time ago to avoid a possible deadlock between rtnl and s_active on removal
of the sysfs nodes.

The behaviour introduced by that was quite confusing as it could lead to the
sysfs store to fail, making batman-adv setup scripts unreliable. As recently the
sysfs removal was postponed to a worker not running with the rtnl taken, the
deadlock can't occur any more and it is safe to change the trylock back to a
lock to make the sysfs store reliable again.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 sysfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sysfs.c b/sysfs.c
index 15a22ef..929e304 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -582,10 +582,7 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 	    (strncmp(hard_iface->soft_iface->name, buff, IFNAMSIZ) == 0))
 		goto out;
 
-	if (!rtnl_trylock()) {
-		ret = -ERESTARTSYS;
-		goto out;
-	}
+	rtnl_lock();
 
 	if (status_tmp == BATADV_IF_NOT_IN_USE) {
 		batadv_hardif_disable_interface(hard_iface,
-- 
1.8.3

