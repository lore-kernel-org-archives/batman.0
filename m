Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [net-next v2 03/11] net: bridge: mcast: prepare mdb netlink for mcast router split
Date: Sun,  9 May 2021 21:45:01 +0200
Message-Id: <20210509194509.10849-4-linus.luessing@c0d3.blue>
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
their IPv4 and IPv6 variants and to avoid IPv6 #ifdef clutter later add
some inline functions for the protocol specific parts in the mdb router
netlink code. Also the we need iterate over the port instead of router
list to be able put one router port entry with both the IPv4 and IPv6
multicast router info later.

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_mdb.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index d61def8..6937d3b 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -16,29 +16,58 @@
=20
 #include "br_private.h"
=20
+static inline bool br_rports_have_mc_router(struct net_bridge *br)
+{
+	return !hlist_empty(&br->ip4_mc_router_list);
+}
+
+static inline bool
+br_ip4_rports_get_timer(struct net_bridge_port *port, unsigned long *tim=
er)
+{
+	*timer =3D br_timer_value(&port->ip4_mc_router_timer);
+	return !hlist_unhashed(&port->ip4_rlist);
+}
+
+static inline bool
+br_ip6_rports_get_timer(struct net_bridge_port *port, unsigned long *tim=
er)
+{
+	*timer =3D 0;
+	return false;
+}
+
 static int br_rports_fill_info(struct sk_buff *skb, struct netlink_callb=
ack *cb,
 			       struct net_device *dev)
 {
 	struct net_bridge *br =3D netdev_priv(dev);
-	struct net_bridge_port *p;
+	bool have_ip4_mc_rtr, have_ip6_mc_rtr;
+	unsigned long ip4_timer, ip6_timer;
 	struct nlattr *nest, *port_nest;
+	struct net_bridge_port *p;
=20
-	if (!br->multicast_router || hlist_empty(&br->ip4_mc_router_list))
+	if (!br->multicast_router)
+		return 0;
+
+	if (!br_rports_have_mc_router(br))
 		return 0;
=20
 	nest =3D nla_nest_start_noflag(skb, MDBA_ROUTER);
 	if (nest =3D=3D NULL)
 		return -EMSGSIZE;
=20
-	hlist_for_each_entry_rcu(p, &br->ip4_mc_router_list, ip4_rlist) {
-		if (!p)
+	list_for_each_entry_rcu(p, &br->port_list, list) {
+		have_ip4_mc_rtr =3D br_ip4_rports_get_timer(p, &ip4_timer);
+		have_ip6_mc_rtr =3D br_ip6_rports_get_timer(p, &ip6_timer);
+
+		if (!have_ip4_mc_rtr && !have_ip6_mc_rtr)
 			continue;
+
 		port_nest =3D nla_nest_start_noflag(skb, MDBA_ROUTER_PORT);
 		if (!port_nest)
 			goto fail;
+
 		if (nla_put_nohdr(skb, sizeof(u32), &p->dev->ifindex) ||
 		    nla_put_u32(skb, MDBA_ROUTER_PATTR_TIMER,
-				br_timer_value(&p->ip4_mc_router_timer)) ||
+				max(ip4_timer, ip6_timer)) ||
 		    nla_put_u8(skb, MDBA_ROUTER_PATTR_TYPE,
 			       p->multicast_router)) {
 			nla_nest_cancel(skb, port_nest);
--=20
2.31.0
