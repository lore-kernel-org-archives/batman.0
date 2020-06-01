Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH] batman-adv: Introduce a configurable per interface hop penalty
Date: Mon,  1 Jun 2020 22:35:22 +0200
Message-Id: <20200601203522.5266-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Maximilian Wilhelm <max@rfc2324.org>

In some setups multiple hard interfaces with similar link qualities
or throughput values are available. But people have expressed the desire
to consider one of them as a backup only.

Some creative solutions are currently in use: Such people are
configuring multiple batman-adv mesh/soft interfaces, wire them
together with some veth pairs and then tune the hop penalty to achieve
an effect similar to a tunable per interface hop penalty.

This patch introduces a new, configurable, per hard interface hop penalty
to simplify such setups.

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/batman_adv.h |  3 ++-
 net/batman-adv/bat_iv_ogm.c     | 17 +++++++++--------
 net/batman-adv/bat_v_ogm.c      | 13 ++++++++++---
 net/batman-adv/hard-interface.c |  2 ++
 net/batman-adv/netlink.c        | 14 ++++++++++++--
 net/batman-adv/types.h          |  6 ++++++
 6 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_=
adv.h
index 617c180f..dac57936 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -427,7 +427,8 @@ enum batadv_nl_attrs {
=20
 	/**
 	 * @BATADV_ATTR_HOP_PENALTY: defines the penalty which will be applied
-	 *  to an originator message's tq-field on every hop.
+	 *  to an originator message's tq-field on every hop and/or per
+	 *  hard interface
 	 */
 	BATADV_ATTR_HOP_PENALTY,
=20
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index e87f19c8..5f7a5c04 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1075,10 +1075,10 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_o=
rig_node *orig_node,
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
 	u8 total_count;
 	u8 orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
+	unsigned int tq_iface_hop_penalty =3D BATADV_TQ_MAX_VALUE;
 	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
 	unsigned int tq_asym_penalty, inv_asym_penalty;
 	unsigned int combined_tq;
-	unsigned int tq_iface_penalty;
 	bool ret =3D false;
=20
 	/* find corresponding one hop neighbor */
@@ -1157,31 +1157,32 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_o=
rig_node *orig_node,
 	inv_asym_penalty =3D BATADV_TQ_MAX_VALUE * neigh_rq_inv_cube;
 	inv_asym_penalty /=3D neigh_rq_max_cube;
 	tq_asym_penalty =3D BATADV_TQ_MAX_VALUE - inv_asym_penalty;
+	tq_iface_hop_penalty -=3D atomic_read(&if_incoming->hop_penalty);
=20
 	/* penalize if the OGM is forwarded on the same interface. WiFi
 	 * interfaces and other half duplex devices suffer from throughput
 	 * drops as they can't send and receive at the same time.
 	 */
-	tq_iface_penalty =3D BATADV_TQ_MAX_VALUE;
 	if (if_outgoing && if_incoming =3D=3D if_outgoing &&
 	    batadv_is_wifi_hardif(if_outgoing))
-		tq_iface_penalty =3D batadv_hop_penalty(BATADV_TQ_MAX_VALUE,
-						      bat_priv);
+		tq_iface_hop_penalty =3D batadv_hop_penalty(tq_iface_hop_penalty,
+							  bat_priv);
=20
 	combined_tq =3D batadv_ogm_packet->tq *
 		      tq_own *
 		      tq_asym_penalty *
-		      tq_iface_penalty;
+		      tq_iface_hop_penalty;
 	combined_tq /=3D BATADV_TQ_MAX_VALUE *
 		       BATADV_TQ_MAX_VALUE *
 		       BATADV_TQ_MAX_VALUE;
 	batadv_ogm_packet->tq =3D combined_tq;
=20
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "bidirectional: orig =3D %pM neigh =3D %pM =3D> own_bcast =3D %2i, =
real recv =3D %2i, local tq: %3i, asym_penalty: %3i, iface_penalty: %3i, =
total tq: %3i, if_incoming =3D %s, if_outgoing =3D %s\n",
+		   "bidirectional: orig =3D %pM neigh =3D %pM =3D> own_bcast =3D %2i, =
real recv =3D %2i, local tq: %3i, asym_penalty: %3i, iface_hop_penalty: %=
3i, total tq: %3i, if_incoming =3D %s, if_outgoing =3D %s\n",
 		   orig_node->orig, orig_neigh_node->orig, total_count,
-		   neigh_rq_count, tq_own, tq_asym_penalty, tq_iface_penalty,
-		   batadv_ogm_packet->tq, if_incoming->net_dev->name,
+		   neigh_rq_count, tq_own, tq_asym_penalty,
+		   tq_iface_hop_penalty, batadv_ogm_packet->tq,
+		   if_incoming->net_dev->name,
 		   if_outgoing ? if_outgoing->net_dev->name : "DEFAULT");
=20
 	/* if link has the minimum required transmission quality
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 18028b9f..1e84ab99 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -455,15 +455,17 @@ void batadv_v_ogm_primary_iface_set(struct batadv_h=
ard_iface *primary_iface)
  * @throughput: the current throughput
  *
  * Apply a penalty on the current throughput metric value based on the
- * characteristic of the interface where the OGM has been received. The =
return
- * value is computed as follows:
+ * characteristic of the interface where the OGM has been received.
+ *
+ * Initially the per hardif hop penalty is applied to the throughput. Af=
ter
+ * that the return value is then computed as follows:
  * - throughput * 50%          if the incoming and outgoing interface ar=
e the
  *                             same WiFi interface and the throughput is=
 above
  *                             1MBit/s
  * - throughput                if the outgoing interface is the default
  *                             interface (i.e. this OGM is processed for=
 the
  *                             internal table and not forwarded)
- * - throughput * hop penalty  otherwise
+ * - throughput * node hop penalty  otherwise
  *
  * Return: the penalised throughput metric.
  */
@@ -472,9 +474,14 @@ static u32 batadv_v_forward_penalty(struct batadv_pr=
iv *bat_priv,
 				    struct batadv_hard_iface *if_outgoing,
 				    u32 throughput)
 {
+	int if_hop_penalty =3D atomic_read(&if_incoming->hop_penalty);
 	int hop_penalty =3D atomic_read(&bat_priv->hop_penalty);
 	int hop_penalty_max =3D BATADV_TQ_MAX_VALUE;
=20
+	/* Apply per hardif hop penalty */
+	throughput =3D throughput * (hop_penalty_max - if_hop_penalty) /
+		     hop_penalty_max;
+
 	/* Don't apply hop penalty in default originator table. */
 	if (if_outgoing =3D=3D BATADV_IF_DEFAULT)
 		return throughput;
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interf=
ace.c
index 3a256af9..f8495ff2 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -939,6 +939,8 @@ batadv_hardif_add_interface(struct net_device *net_de=
v)
 	if (batadv_is_wifi_hardif(hard_iface))
 		hard_iface->num_bcasts =3D BATADV_NUM_BCASTS_WIRELESS;
=20
+	atomic_set(&hard_iface->hop_penalty, 0);
+
 	batadv_v_hardif_init(hard_iface);
=20
 	batadv_check_known_mac_addr(hard_iface->net_dev);
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 02ed073f..d4bfc4c5 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -826,6 +826,10 @@ static int batadv_netlink_hardif_fill(struct sk_buff=
 *msg,
 			goto nla_put_failure;
 	}
=20
+	if (nla_put_u8(msg, BATADV_ATTR_HOP_PENALTY,
+		       atomic_read(&hard_iface->hop_penalty)))
+		goto nla_put_failure;
+
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	if (nla_put_u32(msg, BATADV_ATTR_ELP_INTERVAL,
 			atomic_read(&hard_iface->bat_v.elp_interval)))
@@ -920,10 +924,16 @@ static int batadv_netlink_set_hardif(struct sk_buff=
 *skb,
 {
 	struct batadv_hard_iface *hard_iface =3D info->user_ptr[1];
 	struct batadv_priv *bat_priv =3D info->user_ptr[0];
-
-#ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	struct nlattr *attr;
=20
+	if (info->attrs[BATADV_ATTR_HOP_PENALTY]) {
+		attr =3D info->attrs[BATADV_ATTR_HOP_PENALTY];
+
+		atomic_set(&hard_iface->hop_penalty, nla_get_u8(attr));
+	}
+
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+
 	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
 		attr =3D info->attrs[BATADV_ATTR_ELP_INTERVAL];
=20
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d152b8e8..f7b52426 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -208,6 +208,12 @@ struct batadv_hard_iface {
 	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
=20
+	/**
+	 * @hop_penalty: penalty which will be applied to the tq-field
+	 * of an OGM received via this interface
+	 */
+	atomic_t hop_penalty;
+
 	/** @bat_iv: per hard-interface B.A.T.M.A.N. IV data */
 	struct batadv_hard_iface_bat_iv bat_iv;
=20
--=20
2.27.0.rc2
