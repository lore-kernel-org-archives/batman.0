Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [net-next v2 06/11] net: bridge: mcast: prepare expiry functions for mcast router split
Date: Sun,  9 May 2021 21:45:04 +0200
Message-Id: <20210509194509.10849-7-linus.luessing@c0d3.blue>
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

In preparation for the upcoming split of multicast router state into
their IPv4 and IPv6 variants move the protocol specific timer access to
an ip4 wrapper function.

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 048b5b9..6c844b2 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1354,16 +1354,16 @@ static int br_ip6_multicast_add_group(struct net_=
bridge *br,
 }
 #endif
=20
-static void br_multicast_router_expired(struct timer_list *t)
+static void br_multicast_router_expired(struct net_bridge_port *port,
+					struct timer_list *t,
+					struct hlist_node *rlist)
 {
-	struct net_bridge_port *port =3D
-			from_timer(port, t, ip4_mc_router_timer);
 	struct net_bridge *br =3D port->br;
=20
 	spin_lock(&br->multicast_lock);
 	if (port->multicast_router =3D=3D MDB_RTR_TYPE_DISABLED ||
 	    port->multicast_router =3D=3D MDB_RTR_TYPE_PERM ||
-	    timer_pending(&port->ip4_mc_router_timer))
+	    timer_pending(t))
 		goto out;
=20
 	__del_port_router(port);
@@ -1371,6 +1371,13 @@ out:
 	spin_unlock(&br->multicast_lock);
 }
=20
+static void br_ip4_multicast_router_expired(struct timer_list *t)
+{
+	struct net_bridge_port *port =3D from_timer(port, t, ip4_mc_router_time=
r);
+
+	br_multicast_router_expired(port, t, &port->ip4_rlist);
+}
+
 static void br_mc_router_state_change(struct net_bridge *p,
 				      bool is_mc_router)
 {
@@ -1384,10 +1391,9 @@ static void br_mc_router_state_change(struct net_b=
ridge *p,
 	switchdev_port_attr_set(p->dev, &attr, NULL);
 }
=20
-static void br_multicast_local_router_expired(struct timer_list *t)
+static void br_multicast_local_router_expired(struct net_bridge *br,
+					      struct timer_list *timer)
 {
-	struct net_bridge *br =3D from_timer(br, t, ip4_mc_router_timer);
-
 	spin_lock(&br->multicast_lock);
 	if (br->multicast_router =3D=3D MDB_RTR_TYPE_DISABLED ||
 	    br->multicast_router =3D=3D MDB_RTR_TYPE_PERM ||
@@ -1400,6 +1406,13 @@ out:
 	spin_unlock(&br->multicast_lock);
 }
=20
+static inline void br_ip4_multicast_local_router_expired(struct timer_li=
st *t)
+{
+	struct net_bridge *br =3D from_timer(br, t, ip4_mc_router_timer);
+
+	br_multicast_local_router_expired(br, t);
+}
+
 static void br_multicast_querier_expired(struct net_bridge *br,
 					 struct bridge_mcast_own_query *query)
 {
@@ -1615,7 +1628,7 @@ int br_multicast_add_port(struct net_bridge_port *p=
ort)
 	port->multicast_eht_hosts_limit =3D BR_MCAST_DEFAULT_EHT_HOSTS_LIMIT;
=20
 	timer_setup(&port->ip4_mc_router_timer,
-		    br_multicast_router_expired, 0);
+		    br_ip4_multicast_router_expired, 0);
 	timer_setup(&port->ip4_own_query.timer,
 		    br_ip4_multicast_port_query_expired, 0);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -3319,7 +3332,7 @@ void br_multicast_init(struct net_bridge *br)
=20
 	spin_lock_init(&br->multicast_lock);
 	timer_setup(&br->ip4_mc_router_timer,
-		    br_multicast_local_router_expired, 0);
+		    br_ip4_multicast_local_router_expired, 0);
 	timer_setup(&br->ip4_other_query.timer,
 		    br_ip4_multicast_querier_expired, 0);
 	timer_setup(&br->ip4_own_query.timer,
--=20
2.31.0
