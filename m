Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [RFC PATCH] batman-adv: convert ifmcaddr6 to RCU
Date: Sat, 17 Apr 2021 09:32:09 +0200
Message-Id: <20210417073209.21651-1-sven@narfation.org>
MIME-Version: 1.0
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
---
This patch is already upstream. But the compat code is missing in
batman-adv. So we have to find a way to call the read_lock_bh/read_unlock=
_bh
without adding it in multicast.c and not to use rcu_dereference without=20
removing it from multicast.c... does anyone have an idea?

 net/batman-adv/multicast.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
2.30.2
