Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 11:26:43 +0100
Message-Id: <1392114403-4069-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix memory access by setting
	mac_header in DAT
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

In the TX path we now have functions that rely on the
skb->mac_header field. DAT does not set such field when
creating its own ARP packets thus leading to wrong memory
access.

Fix it by always setting the mac_header after having forged
the ARP packet.

Reported-by: Russel Senior <russell@personaltelco.net>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Tested-by: Russel Senior <russell@personaltelco.net>
---
 distributed-arp-table.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 6da587a..0b69b61 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -1028,6 +1028,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (!skb_new)
 		goto out;
 
+	/* the rest of the TX path assumes that the mac_header offset pointing
+	 * to the inner Ethernet header has been set, therefore reset it now.
+	 */
+	skb_reset_mac_header(skb_new);
+
 	if (vid & BATADV_VLAN_HAS_TAG)
 		skb_new = vlan_insert_tag(skb_new, htons(ETH_P_8021Q),
 					  vid & VLAN_VID_MASK);
-- 
1.8.5.3

