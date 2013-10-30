Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 30 Oct 2013 15:01:49 +0100
Message-Id: <1383141713-15820-5-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1383141713-15820-1-git-send-email-sw@simonwunderlich.de>
References: <1383141713-15820-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 4/8] batman-adv: add WiFi penalty
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

If the same interface is used for sending and receiving, there might be
throughput degradation on half-duplex interfaces such as WiFi. Add a
penalty if the same interface is used to reflect this problem in the
metric. At the same time, change the hop penalty from 30 to 15 so there
will be no change for single wifi mesh network. the effective hop
penalty will stay at 30 due to the new wifi penalty for these networks.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
Changes to RFCv2:
 * various style changes

Changes to RFCv1:
 * use hop penalty for wifi penalty, and use half of the original hop
   penalty.
---
 bat_iv_ogm.c     |   26 ++++++++++++++++++++++----
 hard-interface.h |    1 +
 soft-interface.c |    2 +-
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 3ba2402..a7e9cac 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1090,6 +1090,7 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
 	int tq_asym_penalty, inv_asym_penalty, if_num, ret = 0;
 	unsigned int combined_tq;
+	int tq_iface_penalty;
 
 	/* find corresponding one hop neighbor */
 	rcu_read_lock();
@@ -1171,15 +1172,32 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	inv_asym_penalty /= neigh_rq_max_cube;
 	tq_asym_penalty = BATADV_TQ_MAX_VALUE - inv_asym_penalty;
 
-	combined_tq = batadv_ogm_packet->tq * tq_own * tq_asym_penalty;
-	combined_tq /= BATADV_TQ_MAX_VALUE * BATADV_TQ_MAX_VALUE;
+	/* penalize if the OGM is forwarded on the same interface. WiFi
+	 * interfaces and other half duplex devices suffer from throughput
+	 * drops as they can't send and receive at the same time.
+	 */
+	tq_iface_penalty = BATADV_TQ_MAX_VALUE;
+	if (if_outgoing && (if_incoming == if_outgoing) &&
+	    batadv_is_wifi_netdev(if_outgoing->net_dev))
+		tq_iface_penalty = batadv_hop_penalty(BATADV_TQ_MAX_VALUE,
+						      bat_priv);
+
+	combined_tq = batadv_ogm_packet->tq *
+		      tq_own *
+		      tq_asym_penalty *
+		      tq_iface_penalty;
+	combined_tq /= BATADV_TQ_MAX_VALUE *
+		       BATADV_TQ_MAX_VALUE *
+		       BATADV_TQ_MAX_VALUE;
 	batadv_ogm_packet->tq = combined_tq;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i\n",
+		   "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, iface_penalty: %3i, total tq: %3i, if_incoming = %s, if_outgoing = %s\n",
 		   orig_node->orig, orig_neigh_node->orig, total_count,
 		   neigh_rq_count, tq_own,
-		   tq_asym_penalty, batadv_ogm_packet->tq);
+		   tq_asym_penalty, tq_iface_penalty, batadv_ogm_packet->tq,
+		   if_incoming ? if_incoming->net_dev->name : "NULL",
+		   if_outgoing ? if_outgoing->net_dev->name : "DEFAULT");
 
 	/* if link has the minimum required transmission quality
 	 * consider it bidirectional
diff --git a/hard-interface.h b/hard-interface.h
index 6b609b0..82b7127 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -42,6 +42,7 @@ enum batadv_hard_if_cleanup {
 extern struct notifier_block batadv_hard_if_notifier;
 
 bool batadv_is_wifi_netdev(struct net_device *net_device);
+bool batadv_is_wifi_iface(int ifindex);
 struct batadv_hard_iface*
 batadv_hardif_get_by_netdev(const struct net_device *net_dev);
 int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
diff --git a/soft-interface.c b/soft-interface.c
index 36f0508..33a2df6 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -672,7 +672,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->gw.bandwidth_down, 100);
 	atomic_set(&bat_priv->gw.bandwidth_up, 20);
 	atomic_set(&bat_priv->orig_interval, 1000);
-	atomic_set(&bat_priv->hop_penalty, 30);
+	atomic_set(&bat_priv->hop_penalty, 15);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	atomic_set(&bat_priv->log_level, 0);
 #endif
-- 
1.7.10.4

