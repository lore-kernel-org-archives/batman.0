Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Aug 2014 14:26:48 +0200
Message-Id: <1407932808-19570-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: experimental sysfs variable to
	always apply half duplex penalty
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

The half duplex interface penalty is currently only applied for wifi
interfaces. While this is intended, the bonding feature relies on
different next hop routers to be chosen for different interface tables,
which does not necessarily happen for Ethernet or virtual machine
networks when all links considered equally perfect and are not penalized.

This patch adds an option to always apply the half duplex interface
penalty, regardless of whether its an wifi interface or not. Then, the
Ethernet interfaces are also penalized and the bonding has enough
candidates to choose from.

I'm not yet sure if its a good idea to add that option, and it should
probably go into debugfs anyway, but adding it in sysfs for now was the
easiest option. :) In any way, I'd like to hear about your opinion
and/or test results!

Thanks,
    Simon

Reported-by: Ray Gibson <booray@gmail.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 bat_iv_ogm.c | 3 ++-
 sysfs.c      | 3 +++
 types.h      | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 73209f3..46ac297 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1227,7 +1227,8 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	 */
 	tq_iface_penalty = BATADV_TQ_MAX_VALUE;
 	if (if_outgoing && (if_incoming == if_outgoing) &&
-	    batadv_is_wifi_netdev(if_outgoing->net_dev))
+	    (batadv_is_wifi_netdev(if_outgoing->net_dev) ||
+	     atomic_read(&bat_priv->always_half_duplex_penalty)))
 		tq_iface_penalty = batadv_hop_penalty(BATADV_TQ_MAX_VALUE,
 						      bat_priv);
 
diff --git a/sysfs.c b/sysfs.c
index fc47baa..3fca470 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -545,6 +545,8 @@ BATADV_ATTR_SIF_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * BATADV_JITTER,
 		     INT_MAX, NULL);
 BATADV_ATTR_SIF_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, BATADV_TQ_MAX_VALUE,
 		     NULL);
+BATADV_ATTR_SIF_BOOL(always_half_duplex_penalty, S_IRUGO | S_IWUSR, NULL);
+
 BATADV_ATTR_SIF_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, BATADV_TQ_MAX_VALUE,
 		     batadv_post_gw_reselect);
 static BATADV_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, batadv_show_gw_bwidth,
@@ -579,6 +581,7 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 	&batadv_attr_gw_mode,
 	&batadv_attr_orig_interval,
 	&batadv_attr_hop_penalty,
+	&batadv_attr_always_half_duplex_penalty,
 	&batadv_attr_gw_sel_class,
 	&batadv_attr_gw_bandwidth,
 #ifdef CONFIG_BATMAN_ADV_DEBUG
diff --git a/types.h b/types.h
index 462a70c..cb75fac 100644
--- a/types.h
+++ b/types.h
@@ -727,6 +727,7 @@ struct batadv_softif_vlan {
  * @gw_sel_class: gateway selection class (applies if gw_mode client)
  * @orig_interval: OGM broadcast interval in milliseconds
  * @hop_penalty: penalty which will be applied to an OGM's tq-field on every hop
+ * @always_half_duplex_penalty: whether to always apply half duplex penalty
  * @log_level: configured log level (see batadv_dbg_level)
  * @bcast_seqno: last sent broadcast packet sequence number
  * @bcast_queue_left: number of remaining buffered broadcast packet slots
@@ -780,6 +781,7 @@ struct batadv_priv {
 	atomic_t gw_sel_class;
 	atomic_t orig_interval;
 	atomic_t hop_penalty;
+	atomic_t always_half_duplex_penalty;
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	atomic_t log_level;
 #endif
-- 
2.1.0.rc1

