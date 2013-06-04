Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  4 Jun 2013 12:11:42 +0200
Message-Id: <1370340711-1399-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1370340711-1399-1-git-send-email-ordex@autistici.org>
References: <1370340711-1399-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 04/13] batman-adv: make the GW module
	correctly talk to the new VLAN-TT
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
 gateway_client.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index d0491fe..278e8f6 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -691,6 +691,19 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 	return true;
 }
 
+/**
+ * batadv_gw_out_of_range - check if the dhcp request destination the best gw
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the outgoing packet
+ * @ethhdr: the inner Ethernet header
+ *
+ * Check if the skb is a DHCP request and if it is being sent to the current
+ * best GW server. Due to topology changes it may be the case that the
+ * GW server previously selected is not the best one anymore.
+ *
+ * Return true if the packet destination is unicast and it is not the best gw,
+ * false otherwise
+ */
 bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 			    struct sk_buff *skb, struct ethhdr *ethhdr)
 {
@@ -700,14 +713,16 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	bool ret, out_of_range = false;
 	unsigned int header_len = 0;
 	uint8_t curr_tq_avg;
+	unsigned short vid;
+
+	vid = batadv_get_vid(skb, 0);
 
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

