Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed,  9 Oct 2013 15:05:35 +0200
Message-Id: <1381323938-26931-5-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/7] batman-adv: add WiFi penalty
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
 hard-interface.c |    2 +-
 hard-interface.h |    1 +
 soft-interface.c |    2 +-
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index a7aa7b9..2b21353 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1083,6 +1083,7 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
 	int tq_asym_penalty, inv_asym_penalty, if_num, ret = 0;
 	unsigned int combined_tq;
+	int tq_iface_penalty;
 
 	/* find corresponding one hop neighbor */
 	rcu_read_lock();
@@ -1166,15 +1167,32 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
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
+		   if_outgoing ? if_outgoing->net_dev->name : "NULL");
 
 	/* if link has the minimum required transmission quality
 	 * consider it bidirectional
diff --git a/hard-interface.c b/hard-interface.c
index 1ba8a55..a8f4caa 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -125,7 +125,7 @@ static int batadv_is_valid_iface(const struct net_device *net_dev)
  *
  * Returns true if the net device is a 802.11 wireless device, false otherwise.
  */
-static bool batadv_is_wifi_netdev(struct net_device *net_device)
+bool batadv_is_wifi_netdev(struct net_device *net_device)
 {
 #ifdef CONFIG_WIRELESS_EXT
 	/* pre-cfg80211 drivers have to implement WEXT, so it is possible to
diff --git a/hard-interface.h b/hard-interface.h
index 26e51ac..243b36c 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -52,6 +52,7 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface);
 void batadv_update_min_mtu(struct net_device *soft_iface);
 void batadv_hardif_free_rcu(struct rcu_head *rcu);
 bool batadv_is_wifi_iface(int ifindex);
+bool batadv_is_wifi_netdev(struct net_device *net_device);
 
 /**
  * batadv_hardif_free_ref - decrement the hard interface refcounter and
diff --git a/soft-interface.c b/soft-interface.c
index a1f00e8..81c608d 100644
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

