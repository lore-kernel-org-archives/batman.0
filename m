Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 16 Jun 2011 00:32:24 +0200
Message-Id: <1308177145-21191-1-git-send-email-ordex@autistici.org>
In-Reply-To: <201106152056.18072.lindner_marek@yahoo.de>
References: <201106152056.18072.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: the skb has not to be freed
	in recv_roam_adv()
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

In recv_roam_adv(), in case of error the skb is freed and then
NET_RX_DROP is returned. This makes the caller function wrongly invoke
kfree_skb() again. To avoid this double free recv_tt_query() has to
always return NET_RX_DROP and not to free the skb.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/routing.c b/routing.c
index 2222288..0ce090c 100644
--- a/routing.c
+++ b/routing.c
@@ -1259,7 +1259,6 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 	struct roam_adv_packet *roam_adv_packet;
 	struct orig_node *orig_node;
 	struct ethhdr *ethhdr;
-	int ret = NET_RX_DROP;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, sizeof(struct roam_adv_packet))))
@@ -1297,10 +1296,9 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 	bat_priv->tt_poss_change = true;
 
 	orig_node_free_ref(orig_node);
-	ret = NET_RX_SUCCESS;
 out:
-	kfree(skb);
-	return ret;
+	/* returning NET_RX_DROP will make the caller function kfree the skb */
+	return NET_RX_DROP;
 }
 
 /* find a suitable router for this originator, and use
-- 
1.7.3.4

