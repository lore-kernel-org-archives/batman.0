Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 22 Aug 2016 15:56:19 +0200
Message-Id: <20160822135620.15337-20-sw@simonwunderlich.de>
In-Reply-To: <20160822135620.15337-1-sw@simonwunderlich.de>
References: <20160822135620.15337-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 19/20] batman-adv: Keep batadv netdev when
	hardif disappears
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

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
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 9284c73..08ce361 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -725,7 +725,7 @@ static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 	/* first deactivate interface */
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		batadv_hardif_disable_interface(hard_iface,
-						BATADV_IF_CLEANUP_AUTO);
+						BATADV_IF_CLEANUP_KEEP);
 
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		return;
-- 
2.9.3

