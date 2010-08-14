Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 14 Aug 2010 19:06:47 +0200
Message-Id: <1281805607-7494-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Create batman_if only on special
	events
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

We try to get all events for all net_devices to be able to add special
sysfs folders for the batman-adv configuration. This also includes such
events like NETDEV_POST_INIT which has no valid kobject according to
v2.6.32-rc3-13-g7ffbe3f. This would create an oops in that situation.

We also drop NETDEV_UNREGISTER as event which may register a new
batman_if because it would be destroyed after its initialisation.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: stable <stable@kernel.org>
---
 batman-adv/hard-interface.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 1a829be..09678a6 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
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

