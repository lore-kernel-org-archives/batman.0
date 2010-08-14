Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 14 Aug 2010 23:07:57 +0200
Message-Id: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/9] batman-adv: Create batman_if only on
	register event
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

It is enough to create the batman_if only on NETDEV_REGISTER events
because we will also receive those events for devices which already
existed when we registered the notifier call.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: stable <stable@kernel.org>
---
 batman-adv/hard-interface.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 1a829be..f481cbb 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
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
-- 
1.7.1

