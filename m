Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 14 Aug 2010 23:08:05 +0200
Message-Id: <1281820085-13507-9-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
References: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 9/9] batman-adv: Don't increase mtu of
	interface automatically
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

The user usually sets a mtu by hand and don't want to have software to
change it automatically. This is only needed when we must reduce the mtu
due to a low mtu of an active slave device, but we should not increase
it when any other action is made on the system related to the used
interfaces.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/hard-interface.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index ee02050..eb26026 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -201,7 +201,7 @@ void update_min_mtu(struct net_device *soft_iface)
 	int min_mtu;
 
 	min_mtu = hardif_min_mtu(soft_iface);
-	if (soft_iface->mtu != min_mtu)
+	if (soft_iface->mtu > min_mtu)
 		soft_iface->mtu = min_mtu;
 }
 
@@ -241,8 +241,6 @@ static void hardif_deactivate_interface(struct batman_if *batman_if)
 
 	bat_info(batman_if->soft_iface, "Interface deactivated: %s\n",
 		 batman_if->net_dev->name);
-
-	update_min_mtu(batman_if->soft_iface);
 }
 
 int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
-- 
1.7.1

