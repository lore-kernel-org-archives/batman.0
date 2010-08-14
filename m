Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 14 Aug 2010 19:26:56 +0200
References: <4C6437BF.9080909@web.de>
In-Reply-To: <4C6437BF.9080909@web.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gHtZM3RO1KGBfeO"
Message-Id: <201008141926.57132.lindner_marek@yahoo.de>
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

--Boundary-00=_gHtZM3RO1KGBfeO
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Thursday 12 August 2010 20:04:47 Tim Glaremin wrote:
> Hope it helps.... The part Marek quoted at least did change :)

Yes, it did.

Could you please copy the attached patch into your batman-advanced patches 
folder and verify whether it fixes your problem ? This document explains the 
location of that folder and how to rebuild the package:
http://www.open-mesh.org/wiki/building-batman-adv-with-openwrt

Regards,
Marek

--Boundary-00=_gHtZM3RO1KGBfeO
Content-Type: text/x-patch;
  charset="UTF-8";
  name="01-notify.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="01-notify.patch"

--- a/hard-interface.c
+++ b/hard-interface.c
@@ -457,15 +457,24 @@ static int hard_if_event(struct notifier_block *this,
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
 	struct bat_priv *bat_priv;
 
-	if (!batman_if)
-		batman_if = hardif_add_interface(net_dev);
+	if (!batman_if) {
+		switch (event) {
+		case NETDEV_REGISTER:
+		case NETDEV_UP:
+		case NETDEV_GOING_DOWN:
+		case NETDEV_DOWN:
+		case NETDEV_CHANGENAME:
+		case NETDEV_CHANGEADDR:
+			batman_if = hardif_add_interface(net_dev);
+		default:
+				break;
+		}
+	}
 
 	if (!batman_if)
 		goto out;
 
 	switch (event) {
-	case NETDEV_REGISTER:
-		break;
 	case NETDEV_UP:
 		hardif_activate_interface(batman_if);
 		break;
@@ -476,8 +485,6 @@ static int hard_if_event(struct notifier_block *this,
 	case NETDEV_UNREGISTER:
 		hardif_remove_interface(batman_if);
 		break;
-	case NETDEV_CHANGENAME:
-		break;
 	case NETDEV_CHANGEADDR:
 		if (batman_if->if_status == IF_NOT_IN_USE)
 			goto out;
-- 
1.7.1


--Boundary-00=_gHtZM3RO1KGBfeO--
