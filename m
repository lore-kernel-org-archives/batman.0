Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 23 Apr 2013 16:34:33 +0200
Message-Id: <1366727676-23233-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1366727676-23233-1-git-send-email-ordex@autistici.org>
References: <1366727676-23233-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/7] batman-adv: make the GW module correctly
	talk to the new VLAN-TT
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

The gateway code is now adapted in order to correctly
interact with the Translation Table component by using the
vlan ID

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 gateway_client.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 8812965..a2cd2df 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -640,17 +640,24 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *neigh_curr = NULL, *neigh_old = NULL;
 	struct batadv_orig_node *orig_dst_node = NULL;
 	struct batadv_gw_node *curr_gw = NULL;
+	struct vlan_ethhdr *vhdr;
 	bool ret, out_of_range = false;
 	unsigned int header_len = 0;
+	unsigned short vid = BATADV_NO_FLAGS;
 	uint8_t curr_tq_avg;
 
+	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
+		vhdr = (struct vlan_ethhdr *)ethhdr;
+		vid = ntohs(vhdr->h_vlan_TCI);
+		vid |= BATADV_VLAN_HAS_TAG;
+	}
+
 	ret = batadv_gw_is_dhcp_target(skb, &header_len);
 	if (!ret)
 		goto out;
 
 	orig_dst_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
-						 ethhdr->h_dest,
-						 BATADV_NO_FLAGS);
+						 ethhdr->h_dest, vid);
 	if (!orig_dst_node)
 		goto out;
 
-- 
1.8.1.5

