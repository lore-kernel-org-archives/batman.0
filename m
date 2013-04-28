Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 28 Apr 2013 11:58:03 +0200
Message-Id: <1367143083-7740-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: remove white spaces in
	indentation
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

Introduced during the merge of maint into next

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bridge_loop_avoidance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index cc530a7..e95cf4b 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -344,7 +344,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 
 	if (vid & BATADV_VLAN_HAS_TAG)
 		skb = vlan_insert_tag(skb, htons(ETH_P_8021Q),
-		                      vid & BATADV_VID_MASK);
+				      vid & BATADV_VID_MASK);
 
 	skb_reset_mac_header(skb);
 	skb->protocol = eth_type_trans(skb, soft_iface);
-- 
1.8.1.5

