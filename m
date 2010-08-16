Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 16 Aug 2010 18:51:42 +0200
References: <4C6437BF.9080909@web.de>
	<201008141926.57132.lindner_marek@yahoo.de>
In-Reply-To: <201008141926.57132.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fyWaMPk0kPgC32P"
Message-Id: <201008161851.43816.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--Boundary-00=_fyWaMPk0kPgC32P
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

On Saturday 14 August 2010 19:26:56 Marek Lindner wrote:
> Could you please copy the attached patch into your batman-advanced patches 
> folder and verify whether it fixes your problem ? This document explains
> the  location of that folder and how to rebuild the package:

Here is the updated notify patch plus another patch which might solve the 
issue. These are the patches posted by Sven but backported to 2000.0.0 and 
prepared for OpenWRT. Please try the notify patch first and if it does not work 
add the dev_hold patch and let us know how it goes.

Regards,
Marek

--Boundary-00=_fyWaMPk0kPgC32P
Content-Type: text/x-patch;
  charset="UTF-8";
  name="01-notify.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="01-notify.patch"

--- a/hard-interface.c
+++ b/hard-interface.c
@@ -457,15 +457,13 @@ static int hard_if_event(struct notifier_block *this,
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
 	struct bat_priv *bat_priv;
 
-	if (!batman_if)
-		batman_if = hardif_add_interface(net_dev);
+	if (!batman_if && event == NETDEV_REGISTER)
+			batman_if = hardif_add_interface(net_dev);
 
 	if (!batman_if)
 		goto out;
 
 	switch (event) {
-	case NETDEV_REGISTER:
-		break;
 	case NETDEV_UP:
 		hardif_activate_interface(batman_if);
 		break;


--Boundary-00=_fyWaMPk0kPgC32P
Content-Type: text/x-patch;
  charset="UTF-8";
  name="02-dev_hold.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="02-dev_hold.patch"

--- a/hard-interface.c
+++ b/hard-interface.c
@@ -213,7 +213,6 @@ static void hardif_activate_interface(struct batman_if *batman_if)
        if (batman_if->if_status != IF_INACTIVE)
 		return;
 
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
@@ -385,12 +382,14 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	if (ret != 1)
 		goto out;
 
+	dev_hold(net_dev);
+
 	batman_if = kmalloc(sizeof(struct batman_if), GFP_ATOMIC);
 	if (!batman_if) {
 		printk(KERN_ERR "batman-adv:"
 		       "Can't add interface (%s): out of memory\n",
 		       net_dev->name);
-		goto out;
+		goto release_dev;
 	}
 
 	batman_if->dev = kstrdup(net_dev->name, GFP_ATOMIC);
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
 


--Boundary-00=_fyWaMPk0kPgC32P--
