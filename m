Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 14 Aug 2010 23:08:03 +0200
Message-Id: <1281820085-13507-7-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
References: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 7/9] batman-adv: Don't use net_dev after
	dev_put
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

dev_put allows a device to be freed when all its references are dropped.
After that we are not allowed to access that information anymore. Access
to the data structure of a net_device must be surrounded a dev_hold
and ended using dev_put.

batman-adv adds a device to its own management structure in
hardif_add_interface and will release it in hardif_remove_interface.
Thus it must hold a reference all the time between those functions to
prevent any access to the already released net_device structure.

Reported-by: Tim Glaremin <Tim.Glaremin@web.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/hard-interface.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index a141ffb..2025ba1 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -213,7 +213,6 @@ static void hardif_activate_interface(struct batman_if *batman_if)
 		return;
 
 	bat_priv = netdev_priv(batman_if->soft_iface);
-	dev_hold(batman_if->net_dev);
 
 	update_mac_addresses(batman_if);
 	batman_if->if_status = IF_TO_BE_ACTIVATED;
@@ -238,8 +237,6 @@ static void hardif_deactivate_interface(struct batman_if *batman_if)
 	   (batman_if->if_status != IF_TO_BE_ACTIVATED))
 		return;
 
-	dev_put(batman_if->net_dev);
-
 	batman_if->if_status = IF_INACTIVE;
 
 	bat_info(batman_if->soft_iface, "Interface deactivated: %s\n",
@@ -385,11 +382,13 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	if (ret != 1)
 		goto out;
 
+	dev_hold(net_dev);
+
 	batman_if = kmalloc(sizeof(struct batman_if), GFP_ATOMIC);
 	if (!batman_if) {
 		pr_err("Can't add interface (%s): out of memory\n",
 		       net_dev->name);
-		goto out;
+		goto release_dev;
 	}
 
 	ret = sysfs_add_hardif(&batman_if->hardif_obj, net_dev);
@@ -408,6 +407,8 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 
 free_if:
 	kfree(batman_if);
+release_dev:
+	dev_put(net_dev);
 out:
 	return NULL;
 }
@@ -431,6 +432,7 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 	batman_if->if_status = IF_TO_BE_REMOVED;
 	list_del_rcu(&batman_if->list);
 	sysfs_del_hardif(&batman_if->hardif_obj);
+	dev_put(batman_if->net_dev);
 	call_rcu(&batman_if->rcu, hardif_free_interface);
 }
 
-- 
1.7.1

