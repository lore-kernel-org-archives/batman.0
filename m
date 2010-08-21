Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 21 Aug 2010 14:18:09 +0200
Message-Id: <1282393090-27411-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1282393090-27411-1-git-send-email-sven.eckelmann@gmx.de>
References: <1282393090-27411-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] Staging: batman-adv: Don't use net_dev
	after dev_put
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net, stable <stable@kernel.org>

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
Cc: stable <stable@kernel.org>
---
 drivers/staging/batman-adv/hard-interface.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index 892166b..d08491e 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -194,8 +194,6 @@ static void hardif_activate_interface(struct net_device *net_dev,
 	if (batman_if->if_status != IF_INACTIVE)
 		return;
 
-	dev_hold(batman_if->net_dev);
-
 	update_mac_addresses(batman_if);
 	batman_if->if_status = IF_TO_BE_ACTIVATED;
 
@@ -222,8 +220,6 @@ static void hardif_deactivate_interface(struct net_device *net_dev,
 	   (batman_if->if_status != IF_TO_BE_ACTIVATED))
 		return;
 
-	dev_put(batman_if->net_dev);
-
 	batman_if->if_status = IF_INACTIVE;
 
 	bat_info(net_dev, "Interface deactivated: %s\n", batman_if->dev);
@@ -318,11 +314,13 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
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
 
 	batman_if->dev = kstrdup(net_dev->name, GFP_ATOMIC);
@@ -346,6 +344,8 @@ free_dev:
 	kfree(batman_if->dev);
 free_if:
 	kfree(batman_if);
+release_dev:
+	dev_put(net_dev);
 out:
 	return NULL;
 }
@@ -374,6 +374,7 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 	batman_if->if_status = IF_TO_BE_REMOVED;
 	list_del_rcu(&batman_if->list);
 	sysfs_del_hardif(&batman_if->hardif_obj);
+	dev_put(batman_if->net_dev);
 	call_rcu(&batman_if->rcu, hardif_free_interface);
 }
 
-- 
1.7.1

