Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  8 Nov 2016 18:59:05 +0100
Message-Id: <20161108175905.29961-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Consume dropped packets with
	kfree_skb
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

The dropped skbs were previously free'd using kfree_skb in
batadv_batman_skb_recv with kfree_skb. This has to be done again directly
in the functions which also consume the skb on success.

Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Fixes: 83fef820ecdb ("batman-adv: Consume skb in receive handlers")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 5 ++++-
 net/batman-adv/bat_v_elp.c  | 7 +++++--
 net/batman-adv/bat_v_ogm.c  | 5 ++++-
 net/batman-adv/routing.c    | 2 +-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 36a1b3d..f00f666 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1851,7 +1851,10 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 	ret = NET_RX_SUCCESS;
 
 free_skb:
-	consume_skb(skb);
+	if (ret == NET_RX_SUCCESS)
+		consume_skb(skb);
+	else
+		kfree_skb(skb);
 
 	return ret;
 }
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 6376240..f2fb2f0 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -498,7 +498,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	struct batadv_hard_iface *primary_if;
 	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
 	bool res;
-	int ret;
+	int ret = NET_RX_DROP;
 
 	res = batadv_check_management_packet(skb, if_incoming, BATADV_ELP_HLEN);
 	if (!res)
@@ -531,7 +531,10 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	batadv_hardif_put(primary_if);
 
 free_skb:
-	consume_skb(skb);
+	if (ret == NET_RX_SUCCESS)
+		consume_skb(skb);
+	else
+		kfree_skb(skb);
 
 	return ret;
 }
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index ef3a88d..38b9aab 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -844,7 +844,10 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 	ret = NET_RX_SUCCESS;
 
 free_skb:
-	consume_skb(skb);
+	if (ret == NET_RX_SUCCESS)
+		consume_skb(skb);
+	else
+		kfree_skb(skb);
 
 	return ret;
 }
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 7d9ae4b..6713bdf 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1066,7 +1066,7 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 	}
 
 free_skb:
-	consume_skb(skb);
+	kfree_skb(skb);
 
 	return ret;
 }
-- 
2.10.2

