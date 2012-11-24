Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Nov 2012 01:02:09 +0100
Message-Id: <1353715332-4284-4-git-send-email-sven@narfation.org>
In-Reply-To: <1353715332-4284-1-git-send-email-sven@narfation.org>
References: <1353715332-4284-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/7] batman-adv: Remove slave interfaces
	before removing master interface
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: netdev@vger.kernel.org, davem@davemloft.net

The master (soft-interface) should remove the references to its soft-interfaces
before it gets destroyed. Otherwise the usage count of the interface will not be
zero and therefore the net_device cannot be removed. This leads to an endless
hang of the unregister call.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 8467b9f..5fd0560 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -546,6 +546,14 @@ struct net_device *batadv_softif_create(const char *name)
 
 void batadv_softif_destroy(struct net_device *soft_iface)
 {
+	struct batadv_hard_iface *hard_iface;
+
+	list_for_each_entry(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->soft_iface == soft_iface)
+			batadv_hardif_disable_interface(hard_iface,
+							BATADV_IF_CLEANUP_KEEP);
+	}
+
 	batadv_sysfs_del_meshif(soft_iface);
 	unregister_netdevice(soft_iface);
 }
-- 
1.7.10.4

