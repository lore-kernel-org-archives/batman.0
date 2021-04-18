Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [RFC PATCH] batman-adv: convert ifmcaddr6 to RCU
Date: Sun, 18 Apr 2021 22:14:22 +0200
Message-Id: <20210418201422.8415-1-linus.luessing@c0d3.blue>
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

From: Taehee Yoo <ap420073@gmail.com>

The ifmcaddr6 has been protected by inet6_dev->lock(rwlock) so that
the critical section is atomic context. In order to switch this context,
changing locking is needed. The ifmcaddr6 actually already protected by
RTNL So if it's converted to use RCU, its control path context can be
switched to sleepable.

Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[linus.luessing@c0d3.blue: Add compat code]
Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
@Sven: maybe something like this?

Seems to compile fine for me, without warnings and seems to run fine and
use the compat code for me.

I tried to create and add it to compat-include/net/if_inet6.h, as that
would fit better for the "struct ifmcaddr6", but couldn't get that
to work, lots of errors. And when adding it to compat.h the compat code
does not seem to be used at all.

Also let me know if the kernel version is correct or if it should be
5.14 instead?

 compat-include/net/addrconf.h | 85 +++++++++++++++++++++++++++++++++++
 net/batman-adv/multicast.c    |  6 +--
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/compat-include/net/addrconf.h b/compat-include/net/addrconf.=
h
index 30124124..080e1dda 100644
--- a/compat-include/net/addrconf.h
+++ b/compat-include/net/addrconf.h
@@ -25,4 +25,89 @@ static inline int batadv_ipv6_mc_check_mld(struct sk_b=
uff *skb)
=20
 #endif /* LINUX_VERSION_IS_LESS(5, 1, 0) */
=20
+#if LINUX_VERSION_IS_LESS(5, 13, 0)
+
+static bool batadv_mcast_mla_is_duplicate(u8 *mcast_addr,
+					  struct hlist_head *mcast_list);
+
+static inline int
+compat_batadv_mcast_mla_softif_get_ipv6(struct net_device *dev,
+				 struct hlist_head *mcast_list,
+				 struct batadv_mcast_mla_flags *flags,
+				 u8 *mcast_addr,
+				struct batadv_hw_addr *new,
+				struct inet6_dev *in6_dev)
+
+{
+	struct ifmcaddr6 *pmc6;
+	int ret =3D 0;
+
+	if (flags->tvlv_flags & BATADV_MCAST_WANT_ALL_IPV6)
+		return 0;
+
+	rcu_read_lock();
+
+	in6_dev =3D __in6_dev_get(dev);
+	if (!in6_dev) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	read_lock_bh(&in6_dev->lock);
+	for (pmc6 =3D in6_dev->mc_list; pmc6; pmc6 =3D pmc6->next) {
+		if (IPV6_ADDR_MC_SCOPE(&pmc6->mca_addr) <
+		    IPV6_ADDR_SCOPE_LINKLOCAL)
+			continue;
+
+		if (flags->tvlv_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
+		    ipv6_addr_is_ll_all_nodes(&pmc6->mca_addr))
+			continue;
+
+		if (!(flags->tvlv_flags & BATADV_MCAST_WANT_NO_RTR6) &&
+		    IPV6_ADDR_MC_SCOPE(&pmc6->mca_addr) >
+		    IPV6_ADDR_SCOPE_LINKLOCAL)
+			continue;
+
+		ipv6_eth_mc_map(&pmc6->mca_addr, mcast_addr);
+
+		if (batadv_mcast_mla_is_duplicate(mcast_addr, mcast_list))
+			continue;
+
+		new =3D kmalloc(sizeof(*new), GFP_ATOMIC);
+		if (!new) {
+			ret =3D -ENOMEM;
+			break;
+		}
+
+		ether_addr_copy(new->addr, mcast_addr);
+		hlist_add_head(&new->list, mcast_list);
+		ret++;
+	}
+	read_unlock_bh(&in6_dev->lock);
+	rcu_read_unlock();
+
+	return ret;
+}
+
+#define ifmcaddr6 \
+		net_device *orig_dev =3D dev; \
+		return compat_batadv_mcast_mla_softif_get_ipv6(orig_dev, \
+							       mcast_list, \
+							       flags, \
+							       mcast_addr, \
+							       new =3D NULL, \
+							       in6_dev =3D NULL); \
+	} \
+	static inline int \
+	__unused_batadv_mcast_mla_softif_get_ipv6(struct net_device *dev, \
+					     struct hlist_head *mcast_list, \
+					     struct batadv_mcast_mla_flags *flags) \
+	{ \
+		struct batadv_hw_addr *new; \
+		struct inet6_dev *in6_dev; \
+		u8 mcast_addr[ETH_ALEN]; \
+		struct ifmcaddr6
+
+#endif /* LINUX_VERSION_IS_LESS(5, 13, 0) */
+
 #endif	/* _NET_BATMAN_ADV_COMPAT_NET_ADDRCONF_H_ */
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 28166402..1d63c8cb 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -454,8 +454,9 @@ batadv_mcast_mla_softif_get_ipv6(struct net_device *d=
ev,
 		return 0;
 	}
=20
-	read_lock_bh(&in6_dev->lock);
-	for (pmc6 =3D in6_dev->mc_list; pmc6; pmc6 =3D pmc6->next) {
+	for (pmc6 =3D rcu_dereference(in6_dev->mc_list);
+	     pmc6;
+	     pmc6 =3D rcu_dereference(pmc6->next)) {
 		if (IPV6_ADDR_MC_SCOPE(&pmc6->mca_addr) <
 		    IPV6_ADDR_SCOPE_LINKLOCAL)
 			continue;
@@ -484,7 +485,6 @@ batadv_mcast_mla_softif_get_ipv6(struct net_device *d=
ev,
 		hlist_add_head(&new->list, mcast_list);
 		ret++;
 	}
-	read_unlock_bh(&in6_dev->lock);
 	rcu_read_unlock();
=20
 	return ret;
--=20
2.31.0
