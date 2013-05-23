Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 23 May 2013 23:21:10 +0200
Message-Id: <1369344072-23916-6-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1369344072-23916-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1369344072-23916-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFC 5/7] batman-adv: add WiFi penalty
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
metric.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 bat_iv_ogm.c     |   26 ++++++++++++++++++++++----
 hard-interface.c |    2 +-
 hard-interface.h |    1 +
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index f0b16d6..324bf5f 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -901,6 +901,7 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	uint8_t orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
 	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
 	int tq_asym_penalty, inv_asym_penalty, ret = 0;
+	int tq_iface_penalty;
 	unsigned int combined_tq;
 
 	/* find corresponding one hop neighbor */
@@ -983,15 +984,32 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
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
+		tq_iface_penalty = BATADV_TQ_MAX_VALUE / 2;
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
+		   tq_asym_penalty, tq_iface_penalty,
+		   batadv_ogm_packet->tq,
+		   if_incoming ? if_incoming->net_dev->name : "NULL",
+		   if_outgoing ? if_outgoing->net_dev->name : "NULL");
 
 	/* if link has the minimum required transmission quality
 	 * consider it bidirectional
diff --git a/hard-interface.c b/hard-interface.c
index c343aa8..dbcd446 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -124,7 +124,7 @@ static int batadv_is_valid_iface(const struct net_device *net_dev)
  *
  * Returns true if the net device is a 802.11 wireless device, false otherwise.
  */
-static bool batadv_is_wifi_netdev(struct net_device *net_device)
+bool batadv_is_wifi_netdev(struct net_device *net_device)
 {
 #ifdef CONFIG_WIRELESS_EXT
 	/* pre-cfg80211 drivers have to implement WEXT, so it is possible to
diff --git a/hard-interface.h b/hard-interface.h
index 4989288..1a90ea5 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -52,6 +52,7 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface);
 void batadv_update_min_mtu(struct net_device *soft_iface);
 void batadv_hardif_free_rcu(struct rcu_head *rcu);
 bool batadv_is_wifi_iface(int ifindex);
+bool batadv_is_wifi_netdev(struct net_device *net_device);
 
 static inline void
 batadv_hardif_free_ref(struct batadv_hard_iface *hard_iface)
-- 
1.7.10.4

