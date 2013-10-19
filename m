Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 19 Oct 2013 16:14:49 +0200
Message-Id: <1382192089-2977-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix typ0 in kernel doc
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

Introduced by 9a40777e03bb2710a4f716867b2153257098972f
("batman-adv: make the GW module correctly talk to the new VLAN-TT")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 gateway_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gateway_client.c b/gateway_client.c
index 7299936..2449afa 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -722,7 +722,7 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 }
 
 /**
- * batadv_gw_out_of_range - check if the dhcp request destination the best gw
+ * batadv_gw_out_of_range - check if the dhcp request destination is the best gw
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the outgoing packet
  *
-- 
1.8.4

