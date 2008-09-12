Date: Fri, 12 Sep 2008 16:59:45 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080912145945.GA27083@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Don't validate hardware address of batgat
	gate0 device
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

linux v2.6.24-rc1-1-gbada339 introduces a check for valid ethernet mac address.
We don't have such a valid one because it is just a virtual gateway device which
doesn't need such thing. To disable the eth_validate_addr check we can override
the function pointer inside the netdevice structure or just setting it to NULL
to disable it at all.
---
 batman/linux/modules/gateway.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index d7af197..11693e2 100644
--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -527,6 +527,9 @@ static void bat_netdev_setup( struct net_device *dev )
 #endif
 	dev->mtu = 1471;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
+#ifdef HAVE_VALIDATE_ADDR
+	dev->validate_addr = NULL;
+#endif
 
 	priv = netdev_priv( dev );
 	memset( priv, 0, sizeof( struct gate_priv ) );
-- 
1.6.0.1


