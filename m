Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 11 Sep 2013 19:14:44 +0200
Message-Id: <1378919684-374-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: set the TAG flag for the
	vid passed to BLA
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.org>, Antonio Quartulli <antonio@open-mesh.com>

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
---
 soft-interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/soft-interface.c b/soft-interface.c
index 0f04e1c..33b6144 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -168,6 +168,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	case ETH_P_8021Q:
 		vhdr = (struct vlan_ethhdr *)skb->data;
 		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
+		vid |= BATADV_VLAN_HAS_TAG;
 
 		if (vhdr->h_vlan_encapsulated_proto != ethertype)
 			break;
@@ -329,6 +330,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	case ETH_P_8021Q:
 		vhdr = (struct vlan_ethhdr *)skb->data;
 		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
+		vid |= BATADV_VLAN_HAS_TAG;
 
 		if (vhdr->h_vlan_encapsulated_proto != ethertype)
 			break;
-- 
1.8.1.5

