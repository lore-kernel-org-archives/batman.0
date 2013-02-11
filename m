Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 11 Feb 2013 17:10:25 +0800
Message-Id: <1360573828-24399-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1360573828-24399-1-git-send-email-lindner_marek@yahoo.de>
References: <201302111710.04911.lindner_marek@yahoo.de>
 <1360573828-24399-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv3 4/6] batman-adv: rename
	batadv_softif_destroy to reflect sysfs use case
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, Sven Eckelmann <sven@narfation.org>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
CC: Sven Eckelmann <sven@narfation.org>
---
 hard-interface.c |    2 +-
 soft-interface.c |    6 +++++-
 soft-interface.h |    2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 74e3ec2..6c32607 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -448,7 +448,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 
 	/* nobody uses this interface anymore */
 	if (!bat_priv->num_ifaces && autodel == BATADV_IF_CLEANUP_AUTO)
-		batadv_softif_destroy(hard_iface->soft_iface);
+		batadv_softif_destroy_sysfs(hard_iface->soft_iface);
 
 	hard_iface->soft_iface = NULL;
 	batadv_hardif_free_ref(hard_iface);
diff --git a/soft-interface.c b/soft-interface.c
index e889bfb..bc77a5b 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -581,7 +581,11 @@ struct net_device *batadv_softif_create(const char *name)
 	return soft_iface;
 }
 
-void batadv_softif_destroy(struct net_device *soft_iface)
+/**
+ * batadv_softif_destroy_sysfs - deletion of batadv_soft_interface via sysfs
+ * @soft_iface: the to-be-removed batman-adv interface
+ */
+void batadv_softif_destroy_sysfs(struct net_device *soft_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 
diff --git a/soft-interface.h b/soft-interface.h
index 43182e5..49bc66b 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -25,7 +25,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 			 struct sk_buff *skb, struct batadv_hard_iface *recv_if,
 			 int hdr_size, struct batadv_orig_node *orig_node);
 struct net_device *batadv_softif_create(const char *name);
-void batadv_softif_destroy(struct net_device *soft_iface);
+void batadv_softif_destroy_sysfs(struct net_device *soft_iface);
 int batadv_softif_is_valid(const struct net_device *net_dev);
 
 #endif /* _NET_BATMAN_ADV_SOFT_INTERFACE_H_ */
-- 
1.7.10.4

