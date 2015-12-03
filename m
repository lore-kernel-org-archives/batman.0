Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  3 Dec 2015 21:12:32 +0100
Message-Id: <1449173553-23784-4-git-send-email-andrew@lunn.ch>
In-Reply-To: <1449173553-23784-1-git-send-email-andrew@lunn.ch>
References: <1449173553-23784-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH net-next 3/4] ipv6: Only act upon
	NETDEV_*_TYPE_CHANGE if we have ipv6 addresses
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

An interface changing type may not have IPv6 addresses. Don't
call the address configuration type change in this case.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/ipv6/addrconf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d84742f003a9..d2ab0f89a8d8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3287,7 +3287,8 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
 
 	case NETDEV_PRE_TYPE_CHANGE:
 	case NETDEV_POST_TYPE_CHANGE:
-		addrconf_type_change(dev, event);
+		if (idev)
+			addrconf_type_change(dev, event);
 		break;
 	}
 
-- 
2.6.2

