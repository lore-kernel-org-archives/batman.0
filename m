Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 26 Jun 2012 22:00:22 +0200
Message-Id: <1340740822-4516-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1340740822-4516-1-git-send-email-ordex@autistici.org>
References: <1340740822-4516-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: change interface_rx to get
	orig node
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

In order to understand  where a broadcast packet is coming from and use
this information to detect not yet announced clients, this patch modifies the
interface_rx() function by passing a new argument: the orig node
corresponding to the node that originated the received packet (if known).
This new argument if not NULL for broadcast packets only (other packets does not
have source field).

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c        |   10 ++++++----
 soft-interface.c |    6 +++++-
 soft-interface.h |    5 +++--
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/routing.c b/routing.c
index b3da42c..30fa89f 100644
--- a/routing.c
+++ b/routing.c
@@ -1026,8 +1026,9 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 
 	/* packet for me */
 	if (batadv_is_my_mac(unicast_packet->dest)) {
-		batadv_interface_rx(recv_if->soft_iface, skb, recv_if,
-				    hdr_size);
+		batadv_interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size,
+				    NULL);
+
 		return NET_RX_SUCCESS;
 	}
 
@@ -1064,7 +1065,7 @@ int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
 			return NET_RX_SUCCESS;
 
 		batadv_interface_rx(recv_if->soft_iface, new_skb, recv_if,
-				    sizeof(struct batadv_unicast_packet));
+				    sizeof(struct batadv_unicast_packet), NULL);
 		return NET_RX_SUCCESS;
 	}
 
@@ -1151,7 +1152,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 		goto out;
 
 	/* broadcast for me */
-	batadv_interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
+	batadv_interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size,
+			    orig_node);
 	ret = NET_RX_SUCCESS;
 	goto out;
 
diff --git a/soft-interface.c b/soft-interface.c
index c77473e..8606a5e 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -268,7 +268,7 @@ end:
 
 void batadv_interface_rx(struct net_device *soft_iface,
 			 struct sk_buff *skb, struct batadv_hard_iface *recv_if,
-			 int hdr_size)
+			 int hdr_size, struct batadv_orig_node *orig_node)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct ethhdr *ethhdr;
@@ -316,6 +316,10 @@ void batadv_interface_rx(struct net_device *soft_iface,
 
 	soft_iface->last_rx = jiffies;
 
+	if (orig_node)
+		batadv_tt_add_temporary_global_entry(bat_priv, orig_node,
+						     ethhdr->h_source);
+
 	if (batadv_is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest))
 		goto dropped;
 
diff --git a/soft-interface.h b/soft-interface.h
index 852c683..07a08fe 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -21,8 +21,9 @@
 #define _NET_BATMAN_ADV_SOFT_INTERFACE_H_
 
 int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
-void batadv_interface_rx(struct net_device *soft_iface, struct sk_buff *skb,
-			 struct batadv_hard_iface *recv_if, int hdr_size);
+void batadv_interface_rx(struct net_device *soft_iface,
+			 struct sk_buff *skb, struct batadv_hard_iface *recv_if,
+			 int hdr_size, struct batadv_orig_node *orig_node);
 struct net_device *batadv_softif_create(const char *name);
 void batadv_softif_destroy(struct net_device *soft_iface);
 int batadv_softif_is_valid(const struct net_device *net_dev);
-- 
1.7.9.4

