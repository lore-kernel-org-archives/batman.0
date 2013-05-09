Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  9 May 2013 16:16:49 +0200
Message-Id: <1368109009-2100-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: fix VLAN Ethernet header
	access
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

In interface_rx() skb->data cannot be directly used to
access the Ethernet header because it point to the batman
one.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---

v2:
- use vlan_eth_hdr()

 soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/soft-interface.c b/soft-interface.c
index 6f20d33..114d10d 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -320,7 +320,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_8021Q:
-		vhdr = (struct vlan_ethhdr *)skb->data;
+		vhdr = vlan_eth_hdr(skb);
 		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
 
 		if (vhdr->h_vlan_encapsulated_proto != ethertype)
-- 
1.8.1.5

