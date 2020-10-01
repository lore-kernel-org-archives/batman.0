Return-Path: <sd@queasysnail.net>
From: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net 12/12] batman-adv: fix detection of lower link in batadv_get_real_netdevice
Date: Thu,  1 Oct 2020 09:59:36 +0200
Message-Id: <9599bc5738a16580aa5b87a6586110953918d622.1600770261.git.sd@queasysnail.net>
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

Currently, batadv_get_real_netdevice can return different results in
this situation:

    ip netns add main
    ip netns add peer
    ip -net main link add dummy1 type dummy
    ip -net main link add link dummy1 netns peer type macsec # same ifindex=
 as dummy1
    ip -net main link add link dummy1 netns peer type macsec port 2

Let's use the presence of a ndo_get_iflink operation, rather than the
value it returns, to detect a device without a link.

Fixes: 5ed4a460a1d3 ("batman-adv: additional checks for virtual interfaces =
on top of WiFi")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/batman-adv/hard-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interfac=
e.c
index 0d87c5d56844..8f7d2dd37321 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -223,7 +223,7 @@ static struct net_device *batadv_get_real_netdevice(str=
uct net_device *netdev)
 =09if (!netdev)
 =09=09return NULL;
=20
-=09if (netdev->ifindex =3D=3D dev_get_iflink(netdev)) {
+=09if (!(netdev->netdev_ops && netdev->netdev_ops->ndo_get_iflink)) {
 =09=09dev_hold(netdev);
 =09=09return netdev;
 =09}
--=20
2.28.0

