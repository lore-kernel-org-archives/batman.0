Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  3 Dec 2015 21:12:30 +0100
Message-Id: <1449173553-23784-2-git-send-email-andrew@lunn.ch>
In-Reply-To: <1449173553-23784-1-git-send-email-andrew@lunn.ch>
References: <1449173553-23784-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH net-next 1/4] WAN: HDLC: Detach protocol
	before unregistering device
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>, Marek Lindner <mareklindner@neomailbox.ch>, Krzysztof Halasa <khc@pm.waw.pl>

The current code first unregisters the device, and then detaches the
protocol from it. This should be performed the other way around, since
the detach may try to use state which has been freed by the
unregister. Swap the order, so that we first detach and then remove the
netdev.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/wan/hdlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/hdlc.c b/drivers/net/wan/hdlc.c
index 51f6cee8aab2..2a6595b4ae15 100644
--- a/drivers/net/wan/hdlc.c
+++ b/drivers/net/wan/hdlc.c
@@ -266,8 +266,8 @@ struct net_device *alloc_hdlcdev(void *priv)
 void unregister_hdlc_device(struct net_device *dev)
 {
 	rtnl_lock();
-	unregister_netdevice(dev);
 	detach_hdlc_protocol(dev);
+	unregister_netdevice(dev);
 	rtnl_unlock();
 }
 
-- 
2.6.2

