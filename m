Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 23 Dec 2013 21:43:39 +0100
Message-Id: <1387831419-3848-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix vlan header access
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

When batadv_get_vid() is invoked in interface_rx() the
batman-adv header has already been removed, therefore
the header_len argument has to be 0.

Introduced by 580d7919f19e4f73ccd79e82a532af2bdc638042
("batman-adv: add the VLAN ID attribute to the TT entry")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/soft-interface.c b/soft-interface.c
index 74f4630..2a09294 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -346,7 +346,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	skb_pull_rcsum(skb, hdr_size);
 	skb_reset_mac_header(skb);
 
-	vid = batadv_get_vid(skb, hdr_size);
+	vid = batadv_get_vid(skb, 0);
 	ethhdr = eth_hdr(skb);
 
 	switch (ntohs(ethhdr->h_proto)) {
-- 
1.8.5.2

