Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/5] batman-adv: Use 'fallthrough' pseudo keyword
Date: Tue,  5 Nov 2019 10:35:30 +0100
Message-Id: <20191105093531.11398-5-sw@simonwunderlich.de>
In-Reply-To: <20191105093531.11398-1-sw@simonwunderlich.de>
References: <20191105093531.11398-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The usage of the '/* fall through */' comments in switches are no longer
marked as non-deprecated variant of implicit fall throughs for switch
statements. The commit 294f69e662d1 ("compiler_attributes.h: Add
'fallthrough' pseudo keyword for switch/case use") introduced a replacement
keyword which should be used instead.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c      | 2 +-
 net/batman-adv/soft-interface.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 1d5bdf3a4b65..f9ec8e7507b6 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1421,7 +1421,7 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		if (*orig)
 			return BATADV_FORW_SINGLE;
 
-		/* fall through */
+		fallthrough;
 	case 0:
 		return BATADV_FORW_NONE;
 	default:
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 5ee8e9a100f9..697f2da12487 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -230,7 +230,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 			break;
 		}
 
-		/* fall through */
+		fallthrough;
 	case ETH_P_BATMAN:
 		goto dropped;
 	}
@@ -455,7 +455,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 		if (vhdr->h_vlan_encapsulated_proto != htons(ETH_P_BATMAN))
 			break;
 
-		/* fall through */
+		fallthrough;
 	case ETH_P_BATMAN:
 		goto dropped;
 	}
-- 
2.20.1

