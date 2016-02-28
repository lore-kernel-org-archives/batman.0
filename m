Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Feb 2016 11:38:51 +0100
Message-Id: <1456655932-22746-2-git-send-email-sven@narfation.org>
In-Reply-To: <3805562.RtX9XxSZnx@sven-edge>
References: <3805562.RtX9XxSZnx@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Remove unused parameter
	recv_if of batadv_interface_rx
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c        | 5 ++---
 net/batman-adv/soft-interface.c | 5 ++---
 net/batman-adv/soft-interface.h | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 45093c6..2008b8a 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -904,7 +904,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 							hdr_size))
 			goto rx_success;
 
-		batadv_interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size,
+		batadv_interface_rx(recv_if->soft_iface, skb, hdr_size,
 				    orig_node);
 
 rx_success:
@@ -1114,8 +1114,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 		goto rx_success;
 
 	/* broadcast for me */
-	batadv_interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size,
-			    orig_node);
+	batadv_interface_rx(recv_if->soft_iface, skb, hdr_size, orig_node);
 
 rx_success:
 	ret = NET_RX_SUCCESS;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d786dce..bdda984 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -385,7 +385,6 @@ end:
  * batadv_interface_rx - receive ethernet frame on local batman-adv interface
  * @soft_iface: local interface which will receive the ethernet frame
  * @skb: ethernet frame for @soft_iface
- * @recv_if: interface on which the batman-adv packet was received
  * @hdr_size: size of already parsed batman-adv header
  * @orig_node: originator from which the batman-adv packet was sent
  *
@@ -400,8 +399,8 @@ end:
  * isolated clients.
  */
 void batadv_interface_rx(struct net_device *soft_iface,
-			 struct sk_buff *skb, struct batadv_hard_iface *recv_if,
-			 int hdr_size, struct batadv_orig_node *orig_node)
+			 struct sk_buff *skb, int hdr_size,
+			 struct batadv_orig_node *orig_node)
 {
 	struct batadv_bcast_packet *batadv_bcast_packet;
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 417d30a..15c2884 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -27,8 +27,8 @@ struct sk_buff;
 
 int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
 void batadv_interface_rx(struct net_device *soft_iface,
-			 struct sk_buff *skb, struct batadv_hard_iface *recv_if,
-			 int hdr_size, struct batadv_orig_node *orig_node);
+			 struct sk_buff *skb, int hdr_size,
+			 struct batadv_orig_node *orig_node);
 struct net_device *batadv_softif_create(const char *name);
 void batadv_softif_destroy_sysfs(struct net_device *soft_iface);
 bool batadv_softif_is_valid(const struct net_device *net_dev);
-- 
2.7.0

