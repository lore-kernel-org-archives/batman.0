Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [net-next v2 09/11] net: bridge: mcast: split multicast router state for IPv4 and IPv6
Date: Sun,  9 May 2021 21:45:07 +0200
Message-Id: <20210509194509.10849-10-linus.luessing@c0d3.blue>
In-Reply-To: <20210509194509.10849-1-linus.luessing@c0d3.blue>
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
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
To: netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org

A multicast router for IPv4 does not imply that the same host also is a
multicast router for IPv6 and vice versa.

To reduce multicast traffic when a host is only a multicast router for
one of these two protocol families, keep router state for IPv4 and IPv6
separately. Similar to how querier state is kept separately.

For backwards compatibility for netlink and switchdev notifications
these two will still only notify if a port switched from either no
IPv4/IPv6 multicast router to any IPv4/IPv6 multicast router or the
other way round. However a full netlink MDB router dump will now also
include a multicast router timeout for both IPv4 and IPv6.

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_forward.c   |   8 ++
 net/bridge/br_mdb.c       |  10 ++
 net/bridge/br_multicast.c | 197 ++++++++++++++++++++++++++++++++++----
 net/bridge/br_private.h   |   6 +-
 4 files changed, 201 insertions(+), 20 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index b5ec4f9..31a02c5 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -266,11 +266,19 @@ static void maybe_deliver_addr(struct net_bridge_po=
rt *p, struct sk_buff *skb,
=20
 static inline struct hlist_node *
 br_multicast_get_first_rport_node(struct net_bridge *b, struct sk_buff *=
skb) {
+#if IS_ENABLED(CONFIG_IPV6)
+	if (skb->protocol =3D=3D htons(ETH_P_IPV6))
+		return rcu_dereference(hlist_first_rcu(&b->ip6_mc_router_list));
+#endif
 	return rcu_dereference(hlist_first_rcu(&b->ip4_mc_router_list));
 }
=20
 static inline struct net_bridge_port *
 br_multicast_rport_from_node(struct hlist_node *rp, struct sk_buff *skb)=
 {
+#if IS_ENABLED(CONFIG_IPV6)
+	if (skb->protocol =3D=3D htons(ETH_P_IPV6))
+		return hlist_entry_safe(rp, struct net_bridge_port, ip6_rlist);
+#endif
 	return hlist_entry_safe(rp, struct net_bridge_port, ip4_rlist);
 }
=20
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 6937d3b..3c608da 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -18,7 +18,12 @@
=20
 static inline bool br_rports_have_mc_router(struct net_bridge *br)
 {
+#if IS_ENABLED(CONFIG_IPV6)
+	return !hlist_empty(&br->ip4_mc_router_list) ||
+	       !hlist_empty(&br->ip6_mc_router_list);
+#else
 	return !hlist_empty(&br->ip4_mc_router_list);
+#endif
 }
=20
 static inline bool
@@ -31,8 +36,13 @@ br_ip4_rports_get_timer(struct net_bridge_port *port, =
unsigned long *timer)
 static inline bool
 br_ip6_rports_get_timer(struct net_bridge_port *port, unsigned long *tim=
er)
 {
+#if IS_ENABLED(CONFIG_IPV6)
+	*timer =3D br_timer_value(&port->ip6_mc_router_timer);
+	return !hlist_unhashed(&port->ip6_rlist);
+#else
 	*timer =3D 0;
 	return false;
+#endif
 }
=20
 static int br_rports_fill_info(struct sk_buff *skb, struct netlink_callb=
ack *cb,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 39854d5..b625fd6 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -63,6 +63,8 @@ static void br_multicast_port_group_rexmit(struct timer=
_list *t);
 static void
 br_multicast_rport_del_notify(struct net_bridge_port *p, bool deleted);
 #if IS_ENABLED(CONFIG_IPV6)
+static void br_ip6_multicast_add_router(struct net_bridge *br,
+					struct net_bridge_port *port);
 static void br_ip6_multicast_leave_group(struct net_bridge *br,
 					 struct net_bridge_port *port,
 					 const struct in6_addr *group,
@@ -1369,6 +1371,15 @@ static inline bool br_ip4_multicast_rport_del(stru=
ct net_bridge_port *p)
 	return br_multicast_rport_del(&p->ip4_rlist);
 }
=20
+static inline bool br_ip6_multicast_rport_del(struct net_bridge_port *p)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	return br_multicast_rport_del(&p->ip6_rlist);
+#else
+	return false;
+#endif
+}
+
 static void br_multicast_router_expired(struct net_bridge_port *port,
 					struct timer_list *t,
 					struct hlist_node *rlist)
@@ -1395,6 +1406,15 @@ static void br_ip4_multicast_router_expired(struct=
 timer_list *t)
 	br_multicast_router_expired(port, t, &port->ip4_rlist);
 }
=20
+#if IS_ENABLED(CONFIG_IPV6)
+static void br_ip6_multicast_router_expired(struct timer_list *t)
+{
+	struct net_bridge_port *port =3D from_timer(port, t, ip6_mc_router_time=
r);
+
+	br_multicast_router_expired(port, t, &port->ip6_rlist);
+}
+#endif
+
 static void br_mc_router_state_change(struct net_bridge *p,
 				      bool is_mc_router)
 {
@@ -1430,6 +1450,15 @@ static inline void br_ip4_multicast_local_router_e=
xpired(struct timer_list *t)
 	br_multicast_local_router_expired(br, t);
 }
=20
+#if IS_ENABLED(CONFIG_IPV6)
+static inline void br_ip6_multicast_local_router_expired(struct timer_li=
st *t)
+{
+	struct net_bridge *br =3D from_timer(br, t, ip6_mc_router_timer);
+
+	br_multicast_local_router_expired(br, t);
+}
+#endif
+
 static void br_multicast_querier_expired(struct net_bridge *br,
 					 struct bridge_mcast_own_query *query)
 {
@@ -1649,6 +1678,8 @@ int br_multicast_add_port(struct net_bridge_port *p=
ort)
 	timer_setup(&port->ip4_own_query.timer,
 		    br_ip4_multicast_port_query_expired, 0);
 #if IS_ENABLED(CONFIG_IPV6)
+	timer_setup(&port->ip6_mc_router_timer,
+		    br_ip6_multicast_router_expired, 0);
 	timer_setup(&port->ip6_own_query.timer,
 		    br_ip6_multicast_port_query_expired, 0);
 #endif
@@ -1681,6 +1712,9 @@ void br_multicast_del_port(struct net_bridge_port *=
port)
 	spin_unlock_bh(&br->multicast_lock);
 	br_multicast_gc(&deleted_head);
 	del_timer_sync(&port->ip4_mc_router_timer);
+#if IS_ENABLED(CONFIG_IPV6)
+	del_timer_sync(&port->ip6_mc_router_timer);
+#endif
 	free_percpu(port->mcast_stats);
 }
=20
@@ -1704,9 +1738,14 @@ static void __br_multicast_enable_port(struct net_=
bridge_port *port)
 #if IS_ENABLED(CONFIG_IPV6)
 	br_multicast_enable(&port->ip6_own_query);
 #endif
-	if (port->multicast_router =3D=3D MDB_RTR_TYPE_PERM &&
-	    hlist_unhashed(&port->ip4_rlist))
-		br_ip4_multicast_add_router(br, port);
+	if (port->multicast_router =3D=3D MDB_RTR_TYPE_PERM) {
+		if (hlist_unhashed(&port->ip4_rlist))
+			br_ip4_multicast_add_router(br, port);
+#if IS_ENABLED(CONFIG_IPV6)
+		if (hlist_unhashed(&port->ip6_rlist))
+			br_ip6_multicast_add_router(br, port);
+#endif
+	}
 }
=20
 void br_multicast_enable_port(struct net_bridge_port *port)
@@ -1733,7 +1772,9 @@ void br_multicast_disable_port(struct net_bridge_po=
rt *port)
 	del |=3D br_ip4_multicast_rport_del(port);
 	del_timer(&port->ip4_mc_router_timer);
 	del_timer(&port->ip4_own_query.timer);
+	del |=3D br_ip6_multicast_rport_del(port);
 #if IS_ENABLED(CONFIG_IPV6)
+	del_timer(&port->ip6_mc_router_timer);
 	del_timer(&port->ip6_own_query.timer);
 #endif
 	br_multicast_rport_del_notify(port, del);
@@ -2671,11 +2712,19 @@ static void br_port_mc_router_state_change(struct=
 net_bridge_port *p,
 	switchdev_port_attr_set(p->dev, &attr, NULL);
 }
=20
-/*
- * Add port to router_list
- *  list is maintained ordered by pointer value
- *  and locked by br->multicast_lock and RCU
- */
+static bool br_multicast_no_router_otherpf(struct net_bridge_port *port,
+					   struct hlist_node *rnode)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (rnode !=3D &port->ip6_rlist)
+		return hlist_unhashed(&port->ip6_rlist);
+	else
+		return hlist_unhashed(&port->ip4_rlist);
+#else
+	return true;
+#endif
+}
+
 static void br_multicast_add_router(struct net_bridge *br,
 				    struct net_bridge_port *port,
 				    struct hlist_node *slot,
@@ -2690,8 +2739,14 @@ static void br_multicast_add_router(struct net_bri=
dge *br,
 	else
 		hlist_add_head_rcu(rlist, mc_router_list);
=20
-	br_rtr_notify(br->dev, port, RTM_NEWMDB);
-	br_port_mc_router_state_change(port, true);
+	/* For backwards compatibility for now, only notify if we
+	 * switched from no IPv4/IPv6 multicast router to a new
+	 * IPv4 or IPv6 multicast router.
+	 */
+	if (br_multicast_no_router_otherpf(port, rlist)) {
+		br_rtr_notify(br->dev, port, RTM_NEWMDB);
+		br_port_mc_router_state_change(port, true);
+	}
 }
=20
 struct hlist_node *
@@ -2722,14 +2777,54 @@ static void br_ip4_multicast_add_router(struct ne=
t_bridge *br,
 				&br->ip4_mc_router_list);
 }
=20
-static void br_multicast_mark_router(struct net_bridge *br,
-				     struct net_bridge_port *port)
+#if IS_ENABLED(CONFIG_IPV6)
+struct hlist_node *
+br_ip6_multicast_get_rport_slot(struct net_bridge *br, struct net_bridge=
_port *port)
+{
+	struct hlist_node *slot =3D NULL;
+	struct net_bridge_port *p;
+
+	hlist_for_each_entry(p, &br->ip6_mc_router_list, ip6_rlist) {
+		if ((unsigned long)port >=3D (unsigned long)p)
+			break;
+		slot =3D &p->ip6_rlist;
+	}
+
+	return slot;
+}
+
+/* Add port to router_list
+ *  list is maintained ordered by pointer value
+ *  and locked by br->multicast_lock and RCU
+ */
+static void br_ip6_multicast_add_router(struct net_bridge *br,
+					struct net_bridge_port *port)
+{
+	struct hlist_node *slot =3D br_ip6_multicast_get_rport_slot(br, port);
+
+	br_multicast_add_router(br, port, slot, &port->ip6_rlist,
+				&br->ip6_mc_router_list);
+}
+#else
+static inline void br_ip6_multicast_add_router(struct net_bridge *br,
+					       struct net_bridge_port *port)
+{
+}
+#endif
+
+static void br_ip4_multicast_mark_router(struct net_bridge *br,
+					 struct net_bridge_port *port)
 {
 	unsigned long now =3D jiffies;
=20
 	if (!port) {
 		if (br->multicast_router =3D=3D MDB_RTR_TYPE_TEMP_QUERY) {
+#if IS_ENABLED(CONFIG_IPV6)
+			if (!timer_pending(&br->ip4_mc_router_timer) &&
+			    !timer_pending(&br->ip6_mc_router_timer))
+#else
 			if (!timer_pending(&br->ip4_mc_router_timer))
+#endif
 				br_mc_router_state_change(br, true);
 			mod_timer(&br->ip4_mc_router_timer,
 				  now + br->multicast_querier_interval);
@@ -2747,6 +2842,39 @@ static void br_multicast_mark_router(struct net_br=
idge *br,
 		  now + br->multicast_querier_interval);
 }
=20
+#if IS_ENABLED(CONFIG_IPV6)
+static void br_ip6_multicast_mark_router(struct net_bridge *br,
+					 struct net_bridge_port *port)
+{
+	unsigned long now =3D jiffies;
+
+	if (!port) {
+		if (br->multicast_router =3D=3D MDB_RTR_TYPE_TEMP_QUERY) {
+			if (!timer_pending(&br->ip4_mc_router_timer) &&
+			    !timer_pending(&br->ip6_mc_router_timer))
+				br_mc_router_state_change(br, true);
+			mod_timer(&br->ip6_mc_router_timer,
+				  now + br->multicast_querier_interval);
+		}
+		return;
+	}
+
+	if (port->multicast_router =3D=3D MDB_RTR_TYPE_DISABLED ||
+	    port->multicast_router =3D=3D MDB_RTR_TYPE_PERM)
+		return;
+
+	br_ip6_multicast_add_router(br, port);
+
+	mod_timer(&port->ip6_mc_router_timer,
+		  now + br->multicast_querier_interval);
+}
+#else
+static inline void br_ip6_multicast_mark_router(struct net_bridge *br,
+						struct net_bridge_port *port)
+{
+}
+#endif
+
 static void
 br_ip4_multicast_query_received(struct net_bridge *br,
 				struct net_bridge_port *port,
@@ -2758,7 +2886,7 @@ br_ip4_multicast_query_received(struct net_bridge *=
br,
 		return;
=20
 	br_multicast_update_query_timer(br, query, max_delay);
-	br_multicast_mark_router(br, port);
+	br_ip4_multicast_mark_router(br, port);
 }
=20
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2773,7 +2901,7 @@ br_ip6_multicast_query_received(struct net_bridge *=
br,
 		return;
=20
 	br_multicast_update_query_timer(br, query, max_delay);
-	br_multicast_mark_router(br, port);
+	br_ip6_multicast_mark_router(br, port);
 }
 #endif
=20
@@ -3143,7 +3271,7 @@ static void br_multicast_pim(struct net_bridge *br,
 	    pim_hdr_type(pimhdr) !=3D PIM_TYPE_HELLO)
 		return;
=20
-	br_multicast_mark_router(br, port);
+	br_ip4_multicast_mark_router(br, port);
 }
=20
 static int br_ip4_multicast_mrd_rcv(struct net_bridge *br,
@@ -3154,7 +3282,7 @@ static int br_ip4_multicast_mrd_rcv(struct net_brid=
ge *br,
 	    igmp_hdr(skb)->type !=3D IGMP_MRDISC_ADV)
 		return -ENOMSG;
=20
-	br_multicast_mark_router(br, port);
+	br_ip4_multicast_mark_router(br, port);
=20
 	return 0;
 }
@@ -3222,7 +3350,7 @@ static void br_ip6_multicast_mrd_rcv(struct net_bri=
dge *br,
 	if (icmp6_hdr(skb)->icmp6_type !=3D ICMPV6_MRDISC_ADV)
 		return;
=20
-	br_multicast_mark_router(br, port);
+	br_ip6_multicast_mark_router(br, port);
 }
=20
 static int br_multicast_ipv6_rcv(struct net_bridge *br,
@@ -3379,6 +3507,8 @@ void br_multicast_init(struct net_bridge *br)
 	timer_setup(&br->ip4_own_query.timer,
 		    br_ip4_multicast_query_expired, 0);
 #if IS_ENABLED(CONFIG_IPV6)
+	timer_setup(&br->ip6_mc_router_timer,
+		    br_ip6_multicast_local_router_expired, 0);
 	timer_setup(&br->ip6_other_query.timer,
 		    br_ip6_multicast_querier_expired, 0);
 	timer_setup(&br->ip6_own_query.timer,
@@ -3476,6 +3606,7 @@ void br_multicast_stop(struct net_bridge *br)
 	del_timer_sync(&br->ip4_other_query.timer);
 	del_timer_sync(&br->ip4_own_query.timer);
 #if IS_ENABLED(CONFIG_IPV6)
+	del_timer_sync(&br->ip6_mc_router_timer);
 	del_timer_sync(&br->ip6_other_query.timer);
 	del_timer_sync(&br->ip6_own_query.timer);
 #endif
@@ -3510,6 +3641,9 @@ int br_multicast_set_router(struct net_bridge *br, =
unsigned long val)
 	case MDB_RTR_TYPE_PERM:
 		br_mc_router_state_change(br, val =3D=3D MDB_RTR_TYPE_PERM);
 		del_timer(&br->ip4_mc_router_timer);
+#if IS_ENABLED(CONFIG_IPV6)
+		del_timer(&br->ip6_mc_router_timer);
+#endif
 		br->multicast_router =3D val;
 		err =3D 0;
 		break;
@@ -3532,6 +3666,16 @@ br_multicast_rport_del_notify(struct net_bridge_po=
rt *p, bool deleted)
 	if (!deleted)
 		return;
=20
+	/* For backwards compatibility for now, only notify if there is
+	 * no multicast router anymore for both IPv4 and IPv6.
+	 */
+	if (!hlist_unhashed(&p->ip4_rlist))
+		return;
+#if IS_ENABLED(CONFIG_IPV6)
+	if (!hlist_unhashed(&p->ip6_rlist))
+		return;
+#endif
+
 	br_rtr_notify(p->br->dev, p, RTM_DELMDB);
 	br_port_mc_router_state_change(p, false);
=20
@@ -3550,9 +3694,14 @@ int br_multicast_set_port_router(struct net_bridge=
_port *p, unsigned long val)
 	spin_lock(&br->multicast_lock);
 	if (p->multicast_router =3D=3D val) {
 		/* Refresh the temp router port timer */
-		if (p->multicast_router =3D=3D MDB_RTR_TYPE_TEMP)
+		if (p->multicast_router =3D=3D MDB_RTR_TYPE_TEMP) {
 			mod_timer(&p->ip4_mc_router_timer,
 				  now + br->multicast_querier_interval);
+#if IS_ENABLED(CONFIG_IPV6)
+			mod_timer(&p->ip6_mc_router_timer,
+				  now + br->multicast_querier_interval);
+#endif
+		}
 		err =3D 0;
 		goto unlock;
 	}
@@ -3561,21 +3710,31 @@ int br_multicast_set_port_router(struct net_bridg=
e_port *p, unsigned long val)
 		p->multicast_router =3D MDB_RTR_TYPE_DISABLED;
 		del |=3D br_ip4_multicast_rport_del(p);
 		del_timer(&p->ip4_mc_router_timer);
+		del |=3D br_ip6_multicast_rport_del(p);
+#if IS_ENABLED(CONFIG_IPV6)
+		del_timer(&p->ip6_mc_router_timer);
+#endif
 		br_multicast_rport_del_notify(p, del);
 		break;
 	case MDB_RTR_TYPE_TEMP_QUERY:
 		p->multicast_router =3D MDB_RTR_TYPE_TEMP_QUERY;
 		del |=3D br_ip4_multicast_rport_del(p);
+		del |=3D br_ip6_multicast_rport_del(p);
 		br_multicast_rport_del_notify(p, del);
 		break;
 	case MDB_RTR_TYPE_PERM:
 		p->multicast_router =3D MDB_RTR_TYPE_PERM;
 		del_timer(&p->ip4_mc_router_timer);
 		br_ip4_multicast_add_router(br, p);
+#if IS_ENABLED(CONFIG_IPV6)
+		del_timer(&p->ip6_mc_router_timer);
+#endif
+		br_ip6_multicast_add_router(br, p);
 		break;
 	case MDB_RTR_TYPE_TEMP:
 		p->multicast_router =3D MDB_RTR_TYPE_TEMP;
-		br_multicast_mark_router(br, p);
+		br_ip4_multicast_mark_router(br, p);
+		br_ip6_multicast_mark_router(br, p);
 		break;
 	default:
 		goto unlock;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index ac5ca5b..5194210 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -311,6 +311,8 @@ struct net_bridge_port {
 	struct hlist_node		ip4_rlist;
 #if IS_ENABLED(CONFIG_IPV6)
 	struct bridge_mcast_own_query	ip6_own_query;
+	struct timer_list		ip6_mc_router_timer;
+	struct hlist_node		ip6_rlist;
 #endif /* IS_ENABLED(CONFIG_IPV6) */
 	u32				multicast_eht_hosts_limit;
 	u32				multicast_eht_hosts_cnt;
@@ -457,6 +459,8 @@ struct net_bridge {
 	struct bridge_mcast_querier	ip4_querier;
 	struct bridge_mcast_stats	__percpu *mcast_stats;
 #if IS_ENABLED(CONFIG_IPV6)
+	struct hlist_head		ip6_mc_router_list;
+	struct timer_list		ip6_mc_router_timer;
 	struct bridge_mcast_other_query	ip6_other_query;
 	struct bridge_mcast_own_query	ip6_own_query;
 	struct bridge_mcast_querier	ip6_querier;
@@ -872,7 +876,7 @@ static inline bool br_ip4_multicast_is_router(struct =
net_bridge *br)
 static inline bool br_ip6_multicast_is_router(struct net_bridge *br)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	return timer_pending(&br->ip4_mc_router_timer);
+	return timer_pending(&br->ip6_mc_router_timer);
 #else
 	return false;
 #endif
--=20
2.31.0
