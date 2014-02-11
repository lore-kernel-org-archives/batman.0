Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:18 +0100
Message-Id: <1392122903-805-19-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 18/23] batman-adv: ELP - use phydev to
	determine link characteristics
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

The phydev member of a net_device can be used to get
information about an ethernet link like HALF/FULL_DUPLEX
and advertised bandwidth (e.g. 100/10Mbps).

This information are then stored in the hard_iface object
to be used during the metric computation routine.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v_elp.c      |  8 ++++++++
 bat_v_ogm.c      |  4 ++--
 hard-interface.c | 19 +++++++++++++++++++
 types.h          | 12 ++++++++++++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/bat_v_elp.c b/bat_v_elp.c
index 763113e..958843c 100644
--- a/bat_v_elp.c
+++ b/bat_v_elp.c
@@ -78,6 +78,14 @@ batadv_v_elp_get_throughput(struct batadv_elp_neigh_node *neigh)
 	if (throughput != 0)
 		return throughput;
 
+	/* In case of Ethernet interface, the throughput has already been
+	 * obtained from the phydev object in the net_device struct (see
+	 * batadv_hardif_activate_interface()). So return this value.
+	 */
+	throughput = hard_iface->bat_v.eth_throughput;
+	if (throughput != 0)
+		return throughput;
+
 	/* if this is a wireless device, then ask its throughput through
 	 * cfg80211 API
 	 */
diff --git a/bat_v_ogm.c b/bat_v_ogm.c
index fa3d1a1..060ce80 100644
--- a/bat_v_ogm.c
+++ b/bat_v_ogm.c
@@ -393,8 +393,8 @@ static uint32_t batadv_v_penalty(struct batadv_priv *bat_priv,
 	/* proportion to use the same value used in batman iv (x * 128 / 256) */
 	hop_penalty = hop_penalty * 100 / 255;
 
-	if (batadv_is_wifi_netdev(if_incoming->net_dev) &&
-	    metric > link_metric / 10)
+	if ((if_incoming->bat_v.flags & BATADV_FULL_DUPLEX) &&
+	    (metric > link_metric / 10))
 		return metric / 2;
 
 	return metric * (100 - hop_penalty) / 100;
diff --git a/hard-interface.c b/hard-interface.c
index 2a04130..58c8669 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -31,6 +31,8 @@
 
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
+#include <linux/netdevice.h>
+#include <linux/phy.h>
 
 void batadv_hardif_free_rcu(struct rcu_head *rcu)
 {
@@ -297,6 +299,7 @@ void batadv_update_min_mtu(struct net_device *soft_iface)
 static void
 batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 {
+	struct net_device *dev = hard_iface->net_dev;
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 
@@ -315,6 +318,22 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 	if (!primary_if)
 		batadv_primary_if_select(bat_priv, hard_iface);
 
+	/* set the default values */
+	hard_iface->bat_v.flags &= ~BATADV_FULL_DUPLEX;
+	hard_iface->bat_v.eth_throughput = 0;
+	if (dev->phydev) {
+		if (dev->phydev->duplex == DUPLEX_FULL)
+			hard_iface->bat_v.flags |= BATADV_FULL_DUPLEX;
+
+		/* set the speed according to the phydev setting. Store the
+		 * value in Kbps (as done for the other throughput variables)
+		 */
+		if (dev->phydev->speed != SPEED_UNKNOWN) {
+			hard_iface->bat_v.eth_throughput = dev->phydev->speed;
+			hard_iface->bat_v.eth_throughput *= 10;
+		}
+	}
+
 	batadv_info(hard_iface->soft_iface, "Interface activated: %s\n",
 		    hard_iface->net_dev->name);
 
diff --git a/types.h b/types.h
index 2ba27ab..a51921e 100644
--- a/types.h
+++ b/types.h
@@ -70,6 +70,14 @@ struct batadv_hard_iface_bat_iv {
 };
 
 /**
+ * enum batadv_v_hard_iface_flags - interface flags useful to B.A.T.M.A.N. V
+ * @BATADV_FULL_DUPLEX: tells if the connection over this link is full-duplex
+ */
+enum batadv_v_hard_iface_flags {
+	BATADV_FULL_DUPLEX	= BIT(0),
+};
+
+/**
  * struct batadv_hard_iface_bat_v - per hard interface B.A.T.M.A.N. V data
  * @elp_interval: time interval between two ELP transmissions
  * @elp_seqno: current ELP sequence number
@@ -79,6 +87,8 @@ struct batadv_hard_iface_bat_iv {
  * @elp_skb: base skb containing the ELP message to send
  * @elp_wq: workqueue used to schedule ELP transmissions
  * @user_throughput: user specified throughput
+ * @eth_throughput: throughput for wired interfaces (obtained from phydev)
+ * @flags: interface specific flags
  */
 struct batadv_hard_iface_bat_v {
 	atomic_t elp_interval;
@@ -89,6 +99,8 @@ struct batadv_hard_iface_bat_v {
 	struct sk_buff *elp_skb;
 	struct delayed_work elp_wq;
 	atomic_t user_throughput;
+	uint32_t eth_throughput;
+	uint8_t flags;
 };
 
 /**
-- 
1.8.5.3

