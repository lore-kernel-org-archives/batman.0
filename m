Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH] batman-adv: mcast: add MRD + routable IPv4 multicast with bridges support
Date: Sat, 15 May 2021 17:22:08 +0200
Message-Id: <20210515152208.3969-1-linus.luessing@c0d3.blue>
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

This adds support for routable IPv4 multicast addresses
(224.0.0.0/4, excluding 224.0.0.0/24) in bridged setups.

This utilizes the Multicast Router Discovery (MRD, RFC4286) support
in the Linux bridge. batman-adv will now query the Linux bridge for
IPv4 multicast routers, which the bridge has previously learned about
via MRD.

This allows us to then safely send routable IPv4 multicast packets in
bridged setups to multicast listeners and multicast routers only. Before
we had to flood such packets to avoid potential multicast packet loss to
IPv4 multicast routers, which we were not able to detect before.

With the bridge MRD integration, we are now also able to perform more
fine-grained detection of IPv6 multicast routers in bridged setups:
Before we were "guessing" IPv6 multicast routers by looking up multicast
listeners for the link-local All Routers multicast address (ff02::2),
which every IPv6 multicast router is listening to. However this would
also include more nodes than necessary: For instance nodes which are
just a router for unicast, but not multicast would be included, too.

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---

Please double check the Linux version in
compat-include/linux/if_bridge.h.

Commit 3b85f9ba3480c1 ("net: bridge: mcast: export multicast router prese=
nce adjacent to a port")
was added to net-next just recently
(CommitDate: Thu May 13 14:04:31 2021 -0700).
So br_multicast_has_router_adjacent() should be part of >=3D 5.14?

 compat-include/linux/if_bridge.h | 42 ++++++++++++++++++++++++++++++++
 net/batman-adv/multicast.c       | 41 ++++---------------------------
 2 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/compat-include/linux/if_bridge.h b/compat-include/linux/if_b=
ridge.h
index da00c8b0..dfc4a092 100644
--- a/compat-include/linux/if_bridge.h
+++ b/compat-include/linux/if_bridge.h
@@ -53,4 +53,46 @@ inline void __batadv_br_ip_list_check(void)
=20
 #endif /* LINUX_VERSION_IS_LESS(5, 10, 0) */
=20
+#if LINUX_VERSION_IS_LESS(5, 14, 0)
+
+#include <net/addrconf.h>
+
+#if IS_ENABLED(CONFIG_IPV6)
+static inline bool
+br_multicast_has_router_adjacent(struct net_device *dev, int proto)
+{
+	struct list_head bridge_mcast_list =3D LIST_HEAD_INIT(bridge_mcast_list=
);
+	struct br_ip_list *br_ip_entry, *tmp;
+	int ret;
+
+	if (proto !=3D ETH_P_IPV6)
+		return true;
+
+	ret =3D br_multicast_list_adjacent(dev, &bridge_mcast_list);
+	if (ret < 0)
+		return true;
+
+	ret =3D false;
+
+	list_for_each_entry_safe(br_ip_entry, tmp, &bridge_mcast_list, list) {
+		if (br_ip_entry->addr.proto =3D=3D htons(ETH_P_IPV6) &&
+		    ipv6_addr_is_ll_all_routers(&br_ip_entry->addr.dst.ip6))
+			ret =3D true;
+
+		list_del(&br_ip_entry->list);
+		kfree(br_ip_entry);
+	}
+
+	return ret;
+}
+#else
+static inline bool
+br_multicast_has_router_adjacent(struct net_device *dev, int proto)
+{
+	return true;
+}
+#endif
+
+#endif /* LINUX_VERSION_IS_LESS(5, 14, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_ */
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 1d63c8cb..923e2197 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -193,53 +193,22 @@ static u8 batadv_mcast_mla_rtr_flags_softif_get(str=
uct batadv_priv *bat_priv,
  *	BATADV_MCAST_WANT_NO_RTR6: No IPv6 multicast router is present
  *	The former two OR'd: no multicast router is present
  */
-#if IS_ENABLED(CONFIG_IPV6)
 static u8 batadv_mcast_mla_rtr_flags_bridge_get(struct batadv_priv *bat_=
priv,
 						struct net_device *bridge)
 {
-	struct list_head bridge_mcast_list =3D LIST_HEAD_INIT(bridge_mcast_list=
);
 	struct net_device *dev =3D bat_priv->soft_iface;
-	struct br_ip_list *br_ip_entry, *tmp;
-	u8 flags =3D BATADV_MCAST_WANT_NO_RTR6;
-	int ret;
+	u8 flags =3D BATADV_NO_FLAGS;
=20
 	if (!bridge)
 		return BATADV_MCAST_WANT_NO_RTR4 | BATADV_MCAST_WANT_NO_RTR6;
=20
-	/* TODO: ask the bridge if a multicast router is present (the bridge
-	 * is capable of performing proper RFC4286 multicast router
-	 * discovery) instead of searching for a ff02::2 listener here
-	 */
-	ret =3D br_multicast_list_adjacent(dev, &bridge_mcast_list);
-	if (ret < 0)
-		return BATADV_NO_FLAGS;
-
-	list_for_each_entry_safe(br_ip_entry, tmp, &bridge_mcast_list, list) {
-		/* the bridge snooping does not maintain IPv4 link-local
-		 * addresses - therefore we won't find any IPv4 multicast router
-		 * address here, only IPv6 ones
-		 */
-		if (br_ip_entry->addr.proto =3D=3D htons(ETH_P_IPV6) &&
-		    ipv6_addr_is_ll_all_routers(&br_ip_entry->addr.dst.ip6))
-			flags &=3D ~BATADV_MCAST_WANT_NO_RTR6;
-
-		list_del(&br_ip_entry->list);
-		kfree(br_ip_entry);
-	}
+	if (!br_multicast_has_router_adjacent(dev, ETH_P_IP))
+		flags |=3D BATADV_MCAST_WANT_NO_RTR4;
+	if (!br_multicast_has_router_adjacent(dev, ETH_P_IPV6))
+		flags |=3D BATADV_MCAST_WANT_NO_RTR6;
=20
 	return flags;
 }
-#else
-static inline u8
-batadv_mcast_mla_rtr_flags_bridge_get(struct batadv_priv *bat_priv,
-				      struct net_device *bridge)
-{
-	if (bridge)
-		return BATADV_NO_FLAGS;
-	else
-		return BATADV_MCAST_WANT_NO_RTR4 | BATADV_MCAST_WANT_NO_RTR6;
-}
-#endif
=20
 /**
  * batadv_mcast_mla_rtr_flags_get() - get multicast router flags
--=20
2.31.0
