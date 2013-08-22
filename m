Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 22 Aug 2013 09:21:13 +0200
Message-Id: <1377156073-556-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1377156073-556-1-git-send-email-ordex@autistici.org>
References: <1377156073-556-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: tag locally generated ARP
	reply if needed
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
Cc: Antonio Quartulli <ordex@autistici.org>

When DAT replies to a client laying on a VLAN it has
to attach to the packet the proper VLAN tag.

Introduced by: 3e26722bc9f248ec4316749fc1957365c0fa5e4b
("batman-adv: make the Distributed ARP Table vlan aware")

Reported-by: Marco Dalla Torre <marco.dallato@gmail.com>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 distributed-arp-table.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 6eb1ce3..6c8c393 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -953,6 +953,10 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		if (!skb_new)
 			goto out;
 
+		if (vid & BATADV_VLAN_HAS_TAG)
+			skb_new = vlan_insert_tag(skb_new, htons(ETH_P_8021Q),
+						  vid & VLAN_VID_MASK);
+
 		skb_reset_mac_header(skb_new);
 		skb_new->protocol = eth_type_trans(skb_new,
 						   bat_priv->soft_iface);
@@ -1024,6 +1028,10 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (!skb_new)
 		goto out;
 
+	if (vid & BATADV_VLAN_HAS_TAG)
+		skb_new = vlan_insert_tag(skb_new, htons(ETH_P_8021Q),
+					  vid & VLAN_VID_MASK);
+
 	/* To preserve backwards compatibility, the node has choose the outgoing
 	 * format based on the incoming request packet type. The assumption is
 	 * that a node not using the 4addr packet format doesn't support it.
-- 
1.8.1.5

