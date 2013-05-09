Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  9 May 2013 16:28:06 +0200
Message-Id: <1368109687-3780-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH next 1/2] batman-adv: use VLAN_VID_MASK
	instead of BATADV_VID_MASK
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

VLAN_VID_MASK is already diefined in linux/if_vlan.h and
therefore does not need to be privately re-defined

Introduced in 0b1da1765fdb00ca5d53bc95c9abc70dfc9aae5b
("batman-adv: change VID semantic in the BLA code")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bridge_loop_avoidance.c | 2 +-
 main.h                  | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index e95cf4b..e9d8e0b 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -344,7 +344,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 
 	if (vid & BATADV_VLAN_HAS_TAG)
 		skb = vlan_insert_tag(skb, htons(ETH_P_8021Q),
-				      vid & BATADV_VID_MASK);
+				      vid & VLAN_VID_MASK);
 
 	skb_reset_mac_header(skb);
 	skb->protocol = eth_type_trans(skb, soft_iface);
diff --git a/main.h b/main.h
index d575436..68c7ee0 100644
--- a/main.h
+++ b/main.h
@@ -172,8 +172,6 @@ enum batadv_vlan_flags {
 	BATADV_VLAN_HAS_TAG	= BIT(15),
 };
 
-/* mask needed to extract the vlan ID (12bits) from a 16bits variable */
-#define BATADV_VID_MASK	0x0FFF
 #define BATADV_PRINT_VID(vid) (vid & BATADV_VLAN_HAS_TAG ? \
 			       (int)(vid & BATADV_VID_MASK) : -1)
 
-- 
1.8.1.5

