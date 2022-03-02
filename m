Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: make mc_forwarding atomic
Date: Wed,  2 Mar 2022 20:05:13 +0100
Message-Id: <20220302190513.417350-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

From: Eric Dumazet <edumazet@google.com>

This fixes minor data-races in ip6_mc_input() and
batadv_mcast_mla_rtr_flags_softif_get_ipv6()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: Add ugly hack to get it building with old kernels]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
net-next commit 145c7a793838 ("ipv6: make mc_forwarding atomic")

I didn't find a good way to handle this. So either we introduce the
auto-patch-before build stuff again or we allow minimal changes like this
which are not in sync with upstream.

I will try to have a look at ways how we can (with our build_tests):

* filter out everything with UGLY_HACK + everything between
  UGLY_HACK_OLD + UGLY_HACK_STOP before comparing it with upstream
* have some automatic warning in case someone adds code to linux-merge.gi=
t
  with UGLY_HACK in it

 net/batman-adv/multicast.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 1860de73..720c12c0 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -135,7 +135,11 @@ static u8 batadv_mcast_mla_rtr_flags_softif_get_ipv6=
(struct net_device *dev)
 {
 	struct inet6_dev *in6_dev =3D __in6_dev_get(dev);
=20
+#if LINUX_VERSION_IS_GEQ(5, 18, 0) // UGLY_HACK_NEW
+	if (in6_dev && atomic_read(&in6_dev->cnf.mc_forwarding))
+#else // UGLY_HACK_OLD
 	if (in6_dev && in6_dev->cnf.mc_forwarding)
+#endif // UGLY_HACK_STOP
 		return BATADV_NO_FLAGS;
 	else
 		return BATADV_MCAST_WANT_NO_RTR6;
--=20
2.30.2
