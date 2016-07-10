Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 10 Jul 2016 15:47:57 +0200
Message-Id: <1468158477-10941-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Keep batadv netdev when hardif
	disappears
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

Switch-like virtual interfaces like bridge or openvswitch don't destroy
itself when all their attached netdevices dissappear. Instead they only
remove the link to the unregistered device and keep working until they get
removed manually.

This has the benefit that all configurations for this interfaces are kept
and daemons reacting to rtnl events can just add new slave interfaces
without going through the complete configuration of the switch-like
netdevice.

Handling unregister events of client devices similar in batman-adv allows
users to drop their current workaround of dummy netdevices attached to
batman-adv soft-interfaces.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 714af8e..c409534 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -691,7 +691,7 @@ static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 	/* first deactivate interface */
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		batadv_hardif_disable_interface(hard_iface,
-						BATADV_IF_CLEANUP_AUTO);
+						BATADV_IF_CLEANUP_KEEP);
 
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		return;
-- 
2.8.1

