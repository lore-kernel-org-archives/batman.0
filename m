Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 23 Apr 2013 16:34:32 +0200
Message-Id: <1366727676-23233-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1366727676-23233-1-git-send-email-ordex@autistici.org>
References: <1366727676-23233-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/7] batman-adv: make the GW component
	vlan-featured
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
 gateway_client.c | 6 +++---
 gateway_client.h | 3 ++-
 soft-interface.c | 3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 8812965..5862cff 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -635,7 +635,8 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 }
 
 bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
-			    struct sk_buff *skb, struct ethhdr *ethhdr)
+			    struct sk_buff *skb, struct ethhdr *ethhdr,
+			    unsigned short vid)
 {
 	struct batadv_neigh_node *neigh_curr = NULL, *neigh_old = NULL;
 	struct batadv_orig_node *orig_dst_node = NULL;
@@ -649,8 +650,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 		goto out;
 
 	orig_dst_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
-						 ethhdr->h_dest,
-						 BATADV_NO_FLAGS);
+						 ethhdr->h_dest, vid);
 	if (!orig_dst_node)
 		goto out;
 
diff --git a/gateway_client.h b/gateway_client.h
index 039902d..e276d70 100644
--- a/gateway_client.h
+++ b/gateway_client.h
@@ -35,6 +35,7 @@ void batadv_gw_node_purge(struct batadv_priv *bat_priv);
 int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset);
 bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len);
 bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
-			    struct sk_buff *skb, struct ethhdr *ethhdr);
+			    struct sk_buff *skb, struct ethhdr *ethhdr,
+			    unsigned short vid);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_CLIENT_H_ */
diff --git a/soft-interface.c b/soft-interface.c
index 8911fe5..1559854 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -267,7 +267,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	/* unicast packet */
 	} else {
 		if (atomic_read(&bat_priv->gw_mode) != BATADV_GW_MODE_OFF) {
-			ret = batadv_gw_out_of_range(bat_priv, skb, ethhdr);
+			ret = batadv_gw_out_of_range(bat_priv, skb, ethhdr,
+						     vid);
 			if (ret)
 				goto dropped;
 		}
-- 
1.8.1.5

