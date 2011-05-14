Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 May 2011 23:14:53 +0200
Message-Id: <1305407694-16789-8-git-send-email-sven@narfation.org>
In-Reply-To: <1305407694-16789-1-git-send-email-sven@narfation.org>
References: <1305407694-16789-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv: Remove casts from type x to
	type x
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

Casting from pointer like 'struct orig_node*' to 'struct orig_node *'
doesn't provide any additional functionality and can be savely removed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 unicast.c |    2 +-
 vis.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/unicast.c b/unicast.c
index e2deb44..82717fd 100644
--- a/unicast.c
+++ b/unicast.c
@@ -295,7 +295,7 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 
 	/* get routing information */
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
-		orig_node = (struct orig_node *)gw_get_selected_orig(bat_priv);
+		orig_node = gw_get_selected_orig(bat_priv);
 		if (orig_node)
 			goto find_router;
 	}
diff --git a/vis.c b/vis.c
index adb0327..b48954c 100644
--- a/vis.c
+++ b/vis.c
@@ -621,7 +621,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	struct hlist_head *head;
 	struct orig_node *orig_node;
 	struct neigh_node *router;
-	struct vis_info *info = (struct vis_info *)bat_priv->my_vis_info;
+	struct vis_info *info = bat_priv->my_vis_info;
 	struct vis_packet *packet = (struct vis_packet *)info->skb_packet->data;
 	struct vis_info_entry *entry;
 	struct tt_local_entry *tt_local_entry;
-- 
1.7.5.1

