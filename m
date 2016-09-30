Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Fri, 30 Sep 2016 15:21:06 +0200
Message-Id: <20160930132106.5798-7-sven.eckelmann@open-mesh.com>
In-Reply-To: <2666783.nl87Kib46y@bentobox>
References: <2666783.nl87Kib46y@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v2 7/7] batman-adv: Update wifi flags on
	upper link change
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Things like VLANs don't have their link set when they are created. Thus
the wifi flags have to be evaluated later to fix their contents for the
link interface.

Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
v2:
 - new patch
---
 compat-include/linux/netdevice.h | 2 ++
 net/batman-adv/hard-interface.c  | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index fb5b519..e71e614 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -43,6 +43,8 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 11, 0)
 
+#define NETDEV_CHANGEUPPER	0x0015
+
 #define netdev_notifier_info_to_dev(ptr) ptr
 
 #endif /* < KERNEL_VERSION(3, 11, 0) */
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 7d336e1..400935f 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -954,6 +954,11 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		if (hard_iface == primary_if)
 			batadv_primary_if_update_addr(bat_priv, NULL);
 		break;
+	case NETDEV_CHANGEUPPER:
+		hard_iface->wifi_flags = batadv_wifi_flags_evaluate(net_dev);
+		if (batadv_is_wifi_hardif(hard_iface))
+			hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
+		break;
 	default:
 		break;
 	}
-- 
2.9.3

