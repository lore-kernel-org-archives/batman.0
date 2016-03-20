Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 20 Mar 2016 18:39:56 +0800
Message-Id: <1458470396-12067-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: replace ethertype variable with
	ETH_P_BATMAN for readability
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/soft-interface.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 1c1ed5a..4667719 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -186,7 +186,6 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_bcast_packet *bcast_packet;
-	__be16 ethertype = htons(ETH_P_BATMAN);
 	static const u8 stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00,
 					      0x00, 0x00};
 	static const u8 ectp_addr[ETH_ALEN] = {0xCF, 0x00, 0x00, 0x00,
@@ -216,7 +215,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	case ETH_P_8021Q:
 		vhdr = vlan_eth_hdr(skb);
 
-		if (vhdr->h_vlan_encapsulated_proto != ethertype) {
+		/* drop batman-in-batman packets to prevent loops */
+		if (vhdr->h_vlan_encapsulated_proto != htons(ETH_P_BATMAN)) {
 			network_offset += VLAN_HLEN;
 			break;
 		}
@@ -404,7 +404,6 @@ void batadv_interface_rx(struct net_device *soft_iface,
 {
 	struct batadv_bcast_packet *batadv_bcast_packet;
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
-	__be16 ethertype = htons(ETH_P_BATMAN);
 	struct vlan_ethhdr *vhdr;
 	struct ethhdr *ethhdr;
 	unsigned short vid;
@@ -434,7 +433,8 @@ void batadv_interface_rx(struct net_device *soft_iface,
 
 		vhdr = (struct vlan_ethhdr *)skb->data;
 
-		if (vhdr->h_vlan_encapsulated_proto != ethertype)
+		/* drop batman-in-batman packets to prevent loops */
+		if (vhdr->h_vlan_encapsulated_proto != htons(ETH_P_BATMAN))
 			break;
 
 		/* fall through */
-- 
2.7.0

