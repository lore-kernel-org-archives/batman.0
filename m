Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  3 Dec 2015 21:12:29 +0100
Message-Id: <1449173553-23784-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH net-next 0/4] Allow BATMAN to use hdlc-eth
	interfaces
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

BATMAN works over Ethernet like interfaces. hdlc-eth provides the need
requirements. However, hdlc devices are often created as raw hdlc
devices, which batman cannot use, and are then be transmuted into
other types using sethdlc(1). Have the HDLC code emit
NETDEV_*_TYPE_CHANGE events when the type changes, and have BATMAN
react on these events.

Andrew Lunn (4):
  WAN: HDLC: Detach protocol before unregistering device
  WAN: HDLC: Call notifiers before and after changing device type
  ipv6: Only act upon NETDEV_*_TYPE_CHANGE if we have ipv6 addresses
  batman-adv: Act on NETDEV_*_TYPE_CHANGE events

 drivers/net/wan/hdlc.c          | 21 ++++++++++++++++++---
 drivers/net/wan/hdlc_cisco.c    |  1 +
 drivers/net/wan/hdlc_fr.c       |  1 +
 drivers/net/wan/hdlc_ppp.c      |  1 +
 drivers/net/wan/hdlc_raw.c      |  1 +
 drivers/net/wan/hdlc_raw_eth.c  |  1 +
 drivers/net/wan/hdlc_x25.c      |  1 +
 include/linux/hdlc.h            |  2 +-
 net/batman-adv/hard-interface.c |  4 +++-
 net/ipv6/addrconf.c             |  3 ++-
 10 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.6.2

