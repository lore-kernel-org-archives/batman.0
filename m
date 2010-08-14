Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 14 Aug 2010 23:08:04 +0200
Message-Id: <1281820085-13507-8-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
References: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv: Update mtu of bat device by
	changing mtu of slave device
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

We must reduce our own mtu when we reduce the mtu of any device we use
to transfer our packets. Otherwise we may accept to large packets which
gets dropped by the actual device.

Reported-by: Vasiliy Kulikov <segooon@gmail.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/hard-interface.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 2025ba1..ee02050 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -468,6 +468,10 @@ static int hard_if_event(struct notifier_block *this,
 	case NETDEV_UNREGISTER:
 		hardif_remove_interface(batman_if);
 		break;
+	case NETDEV_CHANGEMTU:
+		if (batman_if->soft_iface)
+			update_min_mtu(batman_if->soft_iface);
+		break;
 	case NETDEV_CHANGEADDR:
 		if (batman_if->if_status == IF_NOT_IN_USE)
 			goto out;
-- 
1.7.1

