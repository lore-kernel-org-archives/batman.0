Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 21 Oct 2009 17:26:01 +0200
Message-Id: <1256138761-12940-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <200910211400.55696.sven.eckelmann@gmx.de>
References: <200910211400.55696.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Start to send originator messages when
	interface gets active
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

The module gets in a inactive state when all interfaces are down. This
stops the sending of new packets. When a interface gets activated again
it must reactivate the module and then start the sending of new
originator messages.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/hard-interface.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/batman-adv-kernelland/hard-interface.c b/batman-adv-kernelland/hard-interface.c
index f04d2db..f954f4e 100644
--- a/batman-adv-kernelland/hard-interface.c
+++ b/batman-adv-kernelland/hard-interface.c
@@ -425,6 +425,13 @@ static int hard_if_event(struct notifier_block *this,
 		break;
 	case NETDEV_UP:
 		hardif_activate_interface(batman_if);
+		if ((atomic_read(&module_state) == MODULE_INACTIVE) &&
+		    (hardif_get_active_if_num() > 0)) {
+			activate_module();
+
+			/* begin sending originator messages on that interface */
+			schedule_own_packet(batman_if);
+		}
 		break;
 	/* NETDEV_CHANGEADDR - mac address change - what are we doing here ? */
 	default:
-- 
1.6.5

