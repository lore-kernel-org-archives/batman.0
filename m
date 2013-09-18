Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 Sep 2013 08:27:38 +0200
Message-Id: <1379485658-2317-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1379485658-2317-1-git-send-email-ordex@autistici.org>
References: <1379485658-2317-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: set the TAG flag for the vid
	passed to BLA
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Antonio Quartulli <antonio@open-mesh.org>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

When receiving or sending a packet a packet on a VLAN, the
vid has to be marked with the TAG flag in order to make any
component in batman-adv understand that the packet is coming
from a really tagged network.

This fix the Bridge Loop Avoidance behaviour which was not
able to send announces over VLAN interfaces.

Introduced by 0b1da1765fdb00ca5d53bc95c9abc70dfc9aae5b
("batman-adv: change VID semantic in the BLA code")

Signed-off-by: Antonio Quartulli <antonio@open-mesh.org>
Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/soft-interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 4493913..813db4e 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -168,6 +168,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	case ETH_P_8021Q:
 		vhdr = (struct vlan_ethhdr *)skb->data;
 		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
+		vid |= BATADV_VLAN_HAS_TAG;
 
 		if (vhdr->h_vlan_encapsulated_proto != ethertype)
 			break;
@@ -331,6 +332,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	case ETH_P_8021Q:
 		vhdr = (struct vlan_ethhdr *)skb->data;
 		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
+		vid |= BATADV_VLAN_HAS_TAG;
 
 		if (vhdr->h_vlan_encapsulated_proto != ethertype)
 			break;
-- 
1.8.1.5

