Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 14 Jun 2011 17:54:29 +0200
Message-Id: <1308066869-29254-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: the skb has not to be freed in
	recv_tt_query()
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

In recv_tt_query(), in case of error the skb is freed and then
NET_RX_DROP is returned. This makes the caller function wrongly invoke
kfree_skb() again. To avoid this double free recv_tt_query() has to
always return NET_RX_DROP and not to free the skb.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/routing.c b/routing.c
index 3a3cfb8..fc8eb87 100644
--- a/routing.c
+++ b/routing.c
@@ -1194,7 +1194,6 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct tt_query_packet *tt_query;
 	struct ethhdr *ethhdr;
-	int ret = NET_RX_DROP;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, sizeof(struct tt_query_packet))))
@@ -1248,11 +1247,11 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 		}
 		break;
 	}
-	ret = NET_RX_SUCCESS;
 
 out:
-	kfree_skb(skb);
-	return ret;
+	/* returning NET_RX_DROP will make the caller function to kfree the
+	 * skb */
+	return NET_RX_DROP;
 }
 
 int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
-- 
1.7.3.4

