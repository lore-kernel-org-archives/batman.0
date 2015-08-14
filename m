Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 14 Aug 2015 22:57:14 +0200
Message-Id: <1439585834-26564-11-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1439585834-26564-1-git-send-email-antonio@meshcoding.com>
References: <1439585834-26564-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 10/10] batman-adv: Fix potentially broken skb
	network header access
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <mareklindner@neomailbox.ch>

From: Linus Lüssing <linus.luessing@c0d3.blue>

The two commits noted below added calls to ip_hdr() and ipv6_hdr(). They
need a correctly set skb network header.

Unfortunately we cannot rely on the device drivers to set it for us.
Therefore setting it in the beginning of the according ndo_start_xmit
handler.

Fixes: 1d8ab8d3c176 ("batman-adv: Modified forwarding behaviour for multicast packets")
Fixes: ab49886e3da7 ("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/soft-interface.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index c002961..926292d 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -202,6 +202,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	int gw_mode;
 	enum batadv_forw_mode forw_mode;
 	struct batadv_orig_node *mcast_single_orig = NULL;
+	int network_offset = ETH_HLEN;
 
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
@@ -214,14 +215,18 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	case ETH_P_8021Q:
 		vhdr = vlan_eth_hdr(skb);
 
-		if (vhdr->h_vlan_encapsulated_proto != ethertype)
+		if (vhdr->h_vlan_encapsulated_proto != ethertype) {
+			network_offset += VLAN_HLEN;
 			break;
+		}
 
 		/* fall through */
 	case ETH_P_BATMAN:
 		goto dropped;
 	}
 
+	skb_set_network_header(skb, network_offset);
+
 	if (batadv_bla_tx(bat_priv, skb, vid))
 		goto dropped;
 
-- 
2.5.0

