Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  3 Dec 2015 21:12:33 +0100
Message-Id: <1449173553-23784-5-git-send-email-andrew@lunn.ch>
In-Reply-To: <1449173553-23784-1-git-send-email-andrew@lunn.ch>
References: <1449173553-23784-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH net-next 4/4] batman-adv: Act on
	NETDEV_*_TYPE_CHANGE events
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

A network interface can change type. It may change from a type which
batman does not support, e.g. hdlc, to one it does, e.g. hdlc-eth.
When an interface changes type, it sends two notifications. Handle
these notifications.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/batman-adv/hard-interface.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f11345e163d7..c7f00eeb735b 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -708,7 +708,8 @@ static int batadv_hard_if_event(struct notifier_block *this,
 	}
 
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
-	if (!hard_iface && event == NETDEV_REGISTER)
+	if (!hard_iface && (event == NETDEV_REGISTER ||
+			    event == NETDEV_POST_TYPE_CHANGE))
 		hard_iface = batadv_hardif_add_interface(net_dev);
 
 	if (!hard_iface)
@@ -723,6 +724,7 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		batadv_hardif_deactivate_interface(hard_iface);
 		break;
 	case NETDEV_UNREGISTER:
+	case NETDEV_PRE_TYPE_CHANGE:
 		list_del_rcu(&hard_iface->list);
 
 		batadv_hardif_remove_interface(hard_iface);
-- 
2.6.2

