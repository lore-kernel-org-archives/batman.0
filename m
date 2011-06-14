Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 14 Jun 2011 18:01:39 +0200
Message-Id: <1308067299-2282-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: skbs have to be freed using
	kfree_skb()
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

The skb structures have always to be freed using kfree_skb() and not the
simple kfree()

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c           |    2 +-
 translation-table.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/routing.c b/routing.c
index 30d0f73..41d065e 100644
--- a/routing.c
+++ b/routing.c
@@ -1299,7 +1299,7 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 	orig_node_free_ref(orig_node);
 	ret = NET_RX_SUCCESS;
 out:
-	kfree(skb);
+	kfree_skb(skb);
 	return ret;
 }
 
diff --git a/translation-table.c b/translation-table.c
index adecf1b..373ee81 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1199,7 +1199,7 @@ out:
 	if (primary_if)
 		hardif_free_ref(primary_if);
 	if (!ret)
-		kfree(skb);
+		kfree_skb(skb);
 	return ret;
 
 }
@@ -1312,7 +1312,7 @@ out:
 	if (primary_if)
 		hardif_free_ref(primary_if);
 	if (!ret)
-		kfree(skb);
+		kfree_skb(skb);
 	/* This packet was for me, so it doesn't need to be re-routed */
 	return true;
 }
-- 
1.7.3.4

