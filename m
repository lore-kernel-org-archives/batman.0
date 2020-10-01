Return-Path: <sd@queasysnail.net>
From: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net 11/12] batman-adv: fix iflink detection in batadv_is_on_batman_iface
Date: Thu,  1 Oct 2020 09:59:35 +0200
Message-Id: <afa206858a88910691bdb917d0956cea3f32f667.1600770261.git.sd@queasysnail.net>
In-Reply-To: <cover.1600770261.git.sd@queasysnail.net>
References: <cover.1600770261.git.sd@queasysnail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

BATMAN compares ifindex with dev_get_iflink to detect devices that
don't have a parent, but that's wrong, since a device can have the
same index as its parent if it's created in a different network
namespace:

    ip netns add main
    ip netns add peer
    ip -net main link add dummy0 type dummy
    # keep ifindex in sync between the namespaces
    ip -net peer link add eatidx type dummy

    ip netns exec main batctl if add dummy0
    # macsec0 and bat0 have the same ifindex
    ip -net main link add link bat0 netns peer type macsec
    ip netns exec peer batctl if add macsec0

That last command would fail if we didn't keep the ifindex in sync
between the two namespaces, and should also fail when the macsec0
device has the same ifindex as its link. Let's use the presence of a
ndo_get_iflink operation, rather than the value it returns, to detect
a device without a link.

Fixes: b7eddd0b3950 ("batman-adv: prevent using any virtual device created =
on batman-adv as hard-interface")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/batman-adv/hard-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interfac=
e.c
index fa06b51c0144..0d87c5d56844 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -159,7 +159,7 @@ static bool batadv_is_on_batman_iface(const struct net_=
device *net_dev)
=20
 =09/* no more parents..stop recursion */
 =09if (dev_get_iflink(net_dev) =3D=3D 0 ||
-=09    dev_get_iflink(net_dev) =3D=3D net_dev->ifindex)
+=09    !(net_dev->netdev_ops && net_dev->netdev_ops->ndo_get_iflink))
 =09=09return false;
=20
 =09parent_net =3D batadv_getlink_net(net_dev, net);
--=20
2.28.0

