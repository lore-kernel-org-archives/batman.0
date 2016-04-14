Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Thu, 14 Apr 2016 09:37:05 +0800
Message-Id: <1460597825-22660-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: B.A.T.M.A.N V - make sure
	iface is reactivated upon NETDEV_UP event
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
Cc: Antonio Quartulli <a@unstable.cc>

At the moment there is no explicit reactivation of an hard-interface
upon NETDEV_UP event. In case of B.A.T.M.A.N. IV the interface is
reactivated as soon as the next OGM is scheduled for sending, but this
mechanism does not work with B.A.T.M.A.N. V. The latter does not rely
on the same scheduling mechanism as its predecessor and for this reason
the hard-interface remains deactivated forever after being brought down
once.

This patch fixes the reactivation mechanism by adding a new routing API
which explicitly allows each algorithm to perform any needed operation
upon interface re-activation.

Such API is optional and is implemented by B.A.T.M.A.N. V only and it
just takes care of setting the iface status to ACTIVE

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---

Changes since v1:
- added kerneldoc for bat_iface_activate

 net/batman-adv/bat_v.c          | 12 ++++++++++++
 net/batman-adv/hard-interface.c |  3 +++
 net/batman-adv/types.h          |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 3315b9a..4026f19 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -32,10 +32,21 @@
 
 #include "bat_v_elp.h"
 #include "bat_v_ogm.h"
+#include "hard-interface.h"
 #include "hash.h"
 #include "originator.h"
 #include "packet.h"
 
+static void batadv_v_iface_activate(struct batadv_hard_iface *hard_iface)
+{
+	/* B.A.T.M.A.N. V does not use any queuing mechanism, therefore it can
+	 * set the interface as ACTIVE right away, without any risk of race
+	 * condition
+	 */
+	if (hard_iface->if_status == BATADV_IF_TO_BE_ACTIVATED)
+		hard_iface->if_status = BATADV_IF_ACTIVE;
+}
+
 static int batadv_v_iface_enable(struct batadv_hard_iface *hard_iface)
 {
 	int ret;
@@ -274,6 +285,7 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 
 static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.name = "BATMAN_V",
+	.bat_iface_activate = batadv_v_iface_activate,
 	.bat_iface_enable = batadv_v_iface_enable,
 	.bat_iface_disable = batadv_v_iface_disable,
 	.bat_iface_update_mac = batadv_v_iface_update_mac,
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index c61d5b0..0a7deaf 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -407,6 +407,9 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 
 	batadv_update_min_mtu(hard_iface->soft_iface);
 
+	if (bat_priv->bat_algo_ops->bat_iface_activate)
+		bat_priv->bat_algo_ops->bat_iface_activate(hard_iface);
+
 out:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9abfb3e..443e9b8 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1250,6 +1250,8 @@ struct batadv_forw_packet {
  * struct batadv_algo_ops - mesh algorithm callbacks
  * @list: list node for the batadv_algo_list
  * @name: name of the algorithm
+ * @bat_iface_activate: start routing mechanisms when hard-interface is brought
+ *  up
  * @bat_iface_enable: init routing info when hard-interface is enabled
  * @bat_iface_disable: de-init routing info when hard-interface is disabled
  * @bat_iface_update_mac: (re-)init mac addresses of the protocol information
@@ -1277,6 +1279,7 @@ struct batadv_forw_packet {
 struct batadv_algo_ops {
 	struct hlist_node list;
 	char *name;
+	void (*bat_iface_activate)(struct batadv_hard_iface *hard_iface);
 	int (*bat_iface_enable)(struct batadv_hard_iface *hard_iface);
 	void (*bat_iface_disable)(struct batadv_hard_iface *hard_iface);
 	void (*bat_iface_update_mac)(struct batadv_hard_iface *hard_iface);
-- 
2.8.1

