Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 15 Jun 2011 15:17:21 +0200
Message-Id: <1308143841-21713-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Keep interface_tx as local
	function
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

interface_tx is not used outside of soft-interface.c and thus doesn't
need to be declared inside soft-interface.h

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 soft-interface.c |    2 +-
 soft-interface.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 7aeed0d..7c554b4 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -554,7 +554,7 @@ static int interface_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
+static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
diff --git a/soft-interface.h b/soft-interface.h
index c24906d..001546f 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -25,7 +25,6 @@
 int my_skb_head_push(struct sk_buff *skb, unsigned int len);
 int softif_neigh_seq_print_text(struct seq_file *seq, void *offset);
 void softif_neigh_purge(struct bat_priv *bat_priv);
-int interface_tx(struct sk_buff *skb, struct net_device *soft_iface);
 void interface_rx(struct net_device *soft_iface,
 		  struct sk_buff *skb, struct hard_iface *recv_if,
 		  int hdr_size);
-- 
1.7.5.3

